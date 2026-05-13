import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:path_provider/path_provider.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/app_loader_after_login_cubit/app_loader_after_login_state.dart';

class AppLoaderAfterLoginCubit extends Cubit<AppLoaderAfterLoginState> {
  AppLoaderAfterLoginCubit() : super(AppLoaderAfterLoginInitial()) {
    _initialize();
  }

  static AppLoaderAfterLoginCubit get(context) => BlocProvider.of(context);
// Core IAP components
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;
  final MethodChannel _channel = MethodChannel('audio_route');

  // Product management
  final Set<String> _productIds = {};
  final Set<String> _activeProductIds = {};
  List<ProductDetails> _availableProducts = [];
  List<api_client.ReceiptItem> receiptItems = [];
  // Purchase tracking
  final Set<String> _processedPurchaseIds = {};

  // UI state
  int? _chosenBundleIndex;
  int _errorCount = 0;
  bool _couldntGetProducts = false;
  bool _isInitializing = false;

  // API responses
  List<api_client.GetAllProductsResponse>? _allProducts = [];
  api_client.GetAllProductsResponse? _userProduct;
  api_client.GetCurrentUserDetailsResponse? _currentUser;
  api_client.CreateSubscriptionResponse? _createSubscriptionResponse;
  api_client.CreateFreeTrialResponse? _createFreeTrialResponse;

  // Getters for external access
  List<ProductDetails> get availableProducts => _availableProducts;
  int? get chosenBundleIndex => _chosenBundleIndex;
  List<api_client.GetAllProductsResponse>? get allProducts => _allProducts;
  api_client.GetAllProductsResponse? get userProduct => _userProduct;
  bool get couldntGetProducts => _couldntGetProducts;
  int get errorCount => _errorCount;

  // Setters for external access
  void setCouldntGetProducts(bool value) => _couldntGetProducts = value;

  /// Create subscription with backend
  Future<void> _createSubscription(PurchaseDetails purchase) async {
    try {
      Map<String, String>? currentPurchase =
          _getProductDetails(purchase.productID);
      final model = api_client.CreateSubscriptionRequest()
        ..descriptionAr = currentPurchase!['descriptionAr']!
        ..descriptionEn = currentPurchase!['descriptionEn']!
        ..inAppProductId = purchase.productID
        ..nameAr = currentPurchase!['nameAr']!
        ..nameEn = currentPurchase!['nameEn']!
        ..subscriptionStartDate = DateTime.now().toIso8601String()
        ..receiptData = await _getReceiptData(purchase)
        ..purchaseId = purchase.purchaseID
        ..platform =
            Platform.isIOS ? 'ios' : 'android'; // Backend expects lowercase

      debugPrint("📤 Creating subscription with backend");
      debugPrint("📱 Platform: ${Platform.isIOS ? 'ios' : 'android'}");

      final api = api_client.SubscriptionApi();
      _createSubscriptionResponse =
          await api.apiSubscriptionApiCreateSubscriptionPost(body: model);

      // Check backend response
      if (_createSubscriptionResponse?.resultCode != 0) {
        final errorMsg = _createSubscriptionResponse?.errorMessage ??
            "Failed to create subscription";
        debugPrint(
            "❌ Backend error: $errorMsg (Code: ${_createSubscriptionResponse?.resultCode})");
        throw Exception(errorMsg);
      }

      if (_createSubscriptionResponse != null) {
        api_client.ValidatedSubscriptionItem newItem =
            api_client.ValidatedSubscriptionItem()
              ..productId = _createSubscriptionResponse!.inAppProductId
              ..originalTransactionId = _createSubscriptionResponse!.id
              ..endDateUTC = _createSubscriptionResponse!.subscriptionEndDate
                  ?.toUtc()
                  .toIso8601String()
              ..isActive =
                  _createSubscriptionResponse!.subscriptionEndDate != null &&
                      _createSubscriptionResponse!.subscriptionEndDate!
                          .isAfter(DateTime.now()) &&
                      (_createSubscriptionResponse!.deleted != true)
              ..environment = 'Production';

        globals.validatedSubscriptionItems.add(newItem);
        debugPrint("✅ Subscription created successfully");
        debugPrint("   Subscription ID: ${_createSubscriptionResponse!.id}");
        debugPrint(
            "   End Date: ${_createSubscriptionResponse!.subscriptionEndDate}");
        debugPrint("   Active: ${newItem.isActive}");
      } else {
        throw Exception("Backend returned null response");
      }
    } catch (e) {
      debugPrint("❌ Failed to create subscription: $e");
      rethrow;
    }
  }

  /// Initialize the cubit
  Future<void> _initialize() async {
    await subscriptionInit();
  }

  Future<void> subscriptionInit() async {
    try {
      _isInitializing = true;
      emit(StartLoadingGettingProducts());

      // Clear previous state
      globals.validatedSubscriptionItems.clear();

      // Get all products first
      await getAllProducts();

      // Initialize IAP
      await initialize();

      await _listenToPurchaseUpdates();
      // Refresh user data

      debugPrint("✅ Subscription initialization completed");

      emit(GettingRestoredFinished());
    } catch (e) {
      debugPrint("❌ Subscription init failed: $e");
      emit(GeneralLoadingPurchaseFailure(globals.appLang == 'ar'
          ? "فشل في تهيئة النظام. يرجى المحاولة مرة أخرى"
          : "Initialization failed. Please try again"));
    } finally {
      _isInitializing = false;
    }
  }

  /// Initialize IAP products
  Future<void> initialize() async {
    try {
      emit(StartLoadingGettingProducts());
      final bool available = await _inAppPurchase.isAvailable();
      if (!available) {
        emit(InAppPurchaseAvailabilityFailure(globals.appLang == 'ar'
            ? "عمليات الشراء داخل التطبيق غير متاحة على هذا الجهاز."
            : "In-app purchases are not available on this device."));
        return;
      }

      if (_productIds.isEmpty) {
        debugPrint("⚠️ No product IDs available");
        emit(StopLoadingGettingProducts());
        return;
      }
      final ProductDetailsResponse response =
          await _inAppPurchase.queryProductDetails(_productIds);
      if (response.notFoundIDs.isNotEmpty) {
        if (_errorCount >= 5) {
          _errorCount = 0;
          emit(GettingProductsFailure(
            globals.appLang == 'ar'
                ? "حدث خطأ غير متوقع أثناء محاولة تحميل خطط الاشتراك، يرجى المحاولة مرة أخرى"
                : "Unexpected error occurred while trying to load subscription plans, please try again",
          ));
        } else {
          _errorCount++;
          _couldntGetProducts = true;
          emit(LoadProductsFailed(_couldntGetProducts));
        }
        emit(StopLoadingGettingProducts());
        return;
      }
      _availableProducts = response.productDetails;
      emit(StopLoadingGettingProducts());
    } catch (e) {
      debugPrint("❌ Initialize failed: $e");
      emit(InAppPurchaseAvailabilityFailure(globals.appLang == 'ar'
          ? "فشل في تحميل المنتجات. يرجى المحاولة مرة أخرى"
          : "Failed to load products. Please try again"));
      emit(StopLoadingGettingProducts());
    }
  }

  Future<void> _listenToPurchaseUpdates() async {
    _purchaseSubscription = _inAppPurchase.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) async {
        for (final purchase in purchaseDetailsList) {
          try {
            switch (purchase.status) {
              case PurchaseStatus.restored:
                await _processRestore(purchase);
                break;
              case PurchaseStatus.pending:
                await _completePurchaseIfNeeded(purchase);
                break;
              case PurchaseStatus.error:
                await _completePurchaseIfNeeded(purchase);
                break;
              case PurchaseStatus.purchased:
                break;
              case PurchaseStatus.canceled:
                break;
            }
          } catch (e) {
            debugPrint("❌ Failed to process purchase update: $e");
          }
        }
      },
      onError: (error) {
        debugPrint("❌ Purchase stream error: $error");
        // emit(CompletingPurchaseFailure("Purchase stream error: $error"));
      },
    );
  }

  Future<void> _processRestore(PurchaseDetails purchase) async {
    try {
      // Get receipt data
      String? receiptData = await _getReceiptData(purchase);
      if (receiptData == null || receiptData.isEmpty) {
        throw Exception("Failed to get receipt data");
      }

      // For restored purchases, use validateSubscription API (not createSubscription)
      api_client.ReceiptItem purchaseObject = api_client.ReceiptItem()
        ..receiptData =
            receiptData // Use the proper receipt data, not serverVerificationData
        ..productId = purchase.productID
        ..purchaseId = purchase.purchaseID;

      receiptItems.add(purchaseObject);

      await validateSubscription(receiptItems);

      // Complete the purchase
      await _completePurchaseIfNeeded(purchase);
    } catch (e) {
      debugPrint("❌ Failed to process restore: $e");
    }
  }

  /// Get receipt data for validation
  Future<String?> _getReceiptData(PurchaseDetails purchase) async {
    try {
      if (Platform.isIOS) {
        // Try to get App Store receipt first
        try {
          final receiptData = await _channel.invokeMethod('getAppStoreReceipt');
          if (receiptData != null && receiptData.isNotEmpty) {
            debugPrint("📝 Using iOS App Store Receipt");
            return receiptData;
          }
        } catch (e) {
          debugPrint("⚠️ Failed to get App Store receipt: $e");
        }

        // Fallback to transaction receipt
        debugPrint("📝 Using iOS transaction receipt");
        return purchase.verificationData.serverVerificationData;
      } else if (Platform.isAndroid) {
        debugPrint("📝 Using Android receipt");
        return purchase.verificationData.serverVerificationData;
      }

      return null;
    } catch (e) {
      debugPrint("❌ Failed to get receipt data: $e");
      return null;
    }
  }

  /// Get product details for subscription creation
  Map<String, String>? _getProductDetails(String productId) {
    if (productId == 'com.hamad.befluent.quarterly') {
      return {
        'nameEn': 'Quarterly (3 months)',
        'nameAr': 'ربع سنوي (3 أشهر)',
        'descEn': 'Unlock all features for 3 months',
        'descAr': 'فتح جميع الميزات لمدة 3 أشهر',
      };
    } else if (productId == 'com.hamad.befluent.annual') {
      return {
        'nameEn': 'Annual',
        'nameAr': 'سنوي',
        'descEn': 'Unlock all features for 1 year',
        'descAr': 'فتح جميع الميزات لمدة عام',
      };
    }
    return null;
  }

  /// Complete purchase if needed
  Future<void> _completePurchaseIfNeeded(PurchaseDetails purchase) async {
    if (purchase.pendingCompletePurchase) {
      try {
        await _inAppPurchase.completePurchase(purchase);

        await _createSubscription(purchase);
        debugPrint("✅ Purchase completed: ${purchase.productID}");
      } catch (e) {
        debugPrint("❌ Failed to complete purchase: $e");
      }
    }
  }

  /// Get all products from backend
  Future<void> getAllProducts() async {
    try {
      emit(StartLoadingGettingProducts());

      final api = api_client.ProductApi();

      _allProducts = await api.apiProductApiGetAllProductsGet();

      if (_allProducts != null && _allProducts!.isNotEmpty) {
        _productIds.clear();
        for (var product in _allProducts!) {
          if (product.inAppProductId != null) {
            _productIds.add(product.inAppProductId!);
          }
        }
        debugPrint("✅ Loaded ${_productIds.length} product IDs from backend");
      }

      // Find user's current product
      if (CasheHelper.user?.subscriptions != null &&
          CasheHelper.user!.subscriptions!.isNotEmpty) {
        final lastSubscription = CasheHelper.user!.subscriptions!.last;
        _userProduct = _allProducts?.firstWhere(
          (product) =>
              product.inAppProductId == lastSubscription.inAppProductId,
        );
      }

      emit(GettingProductsSuccess());
      emit(StopLoadingGettingProducts());
    } catch (e) {
      debugPrint("❌ Failed to get products: $e");
      emit(GettingProductsFailure(globals.appLang == 'en'
          ? "Something went wrong, please try later"
          : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
      emit(StopLoadingGettingProducts());
    }
  }

  /// Get current user details
  Future<void> getCurrentUser() async {
    try {
      final api = api_client.AuthenticationApi();
      final model = api_client.GetCurrentUserDetailsRequest();

      _currentUser = await api.apiAuthenticationCurrentUserPost(body: model);

      if (_currentUser != null) {
        // Update cache helper
        CasheHelper.user = _currentUser!.user;
        CasheHelper.firstName = _currentUser!.user!.firstName;
        CasheHelper.lastName = _currentUser!.user!.lastName;
        CasheHelper.dateOfBirth = _currentUser!.user!.dateOfBirth;
        CasheHelper.accentCode = _currentUser!.user!.accent!.code;
        CasheHelper.accentId = _currentUser!.user!.accentId;
        CasheHelper.languageId = _currentUser!.user!.nativeLanagaugeId;
        CasheHelper.mainGoalId = _currentUser!.user!.mainGoalId;
        CasheHelper.freeTrialPeriod = _currentUser!.freeTrialPeriod;

        // Calculate subscription remaining days
        if (globals.validatedSubscriptionItems.isNotEmpty) {
          final lastSubscription = globals.validatedSubscriptionItems.last;
          globals.subscriptionRemainingDays =
              DateTime.parse(lastSubscription.endDateUTC!)
                  .difference(DateTime.now().toUtc())
                  .inDays
                  .toString();
        } else if (_currentUser!.user!.freeTrial != null) {
          int freeTrialRemainingDays = _currentUser!.user!.freeTrial!.endDate!
              .difference(DateTime.now())
              .inDays;
          if (freeTrialRemainingDays >= 0) {
            globals.isFreeTrialActive = true;
            globals.freeRemainingDays = freeTrialRemainingDays.toString();
          }
        }
      }
    } catch (e) {
      debugPrint("❌ Failed to get current user: $e");
    }
  }

  /// Clean up resources
  @override
  Future<void> close() {
    _purchaseSubscription?.cancel();
    return super.close();
  }

  // DEBUG METHODS (only in debug mode)
  /// Clear all subscription data for testing
  Future<void> clearSubscriptionData() async {
    if (kDebugMode) {
      _processedPurchaseIds.clear();
      _activeProductIds.clear();
      _availableProducts.clear();

      globals.subscriptionRemainingDays = null;
      globals.freeRemainingDays = null;

      debugPrint("🧪 DEBUG: Subscription data cleared");
    }
  }

  api_client.ValidateSubscriptionResponse? validateSubscriptionResponse;
  Future<void> validateSubscription(receiptItems) async {
    if (receiptItems.isEmpty) {
      debugPrint("⚠️ No receipt items to validate");
      return;
    }

    api_client.ValidateSubscriptionRequest model =
        api_client.ValidateSubscriptionRequest();

    model.platform =
        Platform.isIOS ? 'ios' : 'android'; // Backend expects lowercase
    model.receipts = receiptItems;

    api_client.SubscriptionApi api = api_client.SubscriptionApi();

    try {
      debugPrint(
          "📤 Validating ${receiptItems.length} receipt items with backend");
      debugPrint("   Platform: ${Platform.isIOS ? 'iOS' : 'Android'}");

      validateSubscriptionResponse =
          await api.apiSubscriptionApiValidateSubscriptionsPost(body: model);

      // Check backend response
      if (validateSubscriptionResponse?.resultCode != 0) {
        final errorMsg = validateSubscriptionResponse?.errorMessage ??
            "Failed to validate subscriptions";
        debugPrint(
            "❌ Backend error: $errorMsg (Code: ${validateSubscriptionResponse?.resultCode})");
        throw Exception(errorMsg);
      }

      debugPrint("📊 Backend validation complete:");
      debugPrint(
          "   Total validated: ${validateSubscriptionResponse?.totalValidated ?? 0}");
      debugPrint(
          "   Valid count: ${validateSubscriptionResponse?.validCount ?? 0}");
      debugPrint(
          "   Invalid count: ${validateSubscriptionResponse?.invalidCount ?? 0}");

      // Clear old validated items
      globals.validatedSubscriptionItems.clear();

      if (validateSubscriptionResponse!.validSubscriptions != null &&
          validateSubscriptionResponse!.validSubscriptions!.isNotEmpty) {
        for (var item in validateSubscriptionResponse!.validSubscriptions!) {
          if (item.isActive == true) {
            globals.validatedSubscriptionItems.add(item);
            debugPrint(
                "✅ Validated active subscription: ${item.productId} (End: ${item.endDateUTC})");
          } else {
            debugPrint(
                "⚠️ Found inactive subscription: ${item.productId} (End: ${item.endDateUTC})");
          }
        }
        if (!isClosed) emit(ValidateSubscriptionSuccess());
      } else {
        debugPrint("⚠️ No valid subscriptions found in backend response");
        debugPrint(
            "   Invalid receipts: ${validateSubscriptionResponse?.invalidReceipts?.length ?? 0}");

        // Log invalid receipt reasons for debugging
        if (validateSubscriptionResponse?.invalidReceipts != null &&
            validateSubscriptionResponse!.invalidReceipts!.isNotEmpty) {
          for (final invalid
              in validateSubscriptionResponse!.invalidReceipts!) {
            debugPrint("   Invalid reason: ${invalid.reason}");
          }
        }

        if (!isClosed)
          emit(ValidateSubscriptionFailure("No valid subscriptions found"));
        // Throw exception to prevent marking as processed
        throw Exception("No valid subscriptions found - subscription expired");
      }
    } on api_client.ApiException catch (e) {
      debugPrint("❌ API Exception: ${e.code} - ${e.message}");
      if (!isClosed)
        emit(ValidateSubscriptionFailure("API Error: ${e.message}"));
      rethrow;
    } catch (e) {
      debugPrint("❌ Validation failed: $e");
      if (!isClosed) emit(ValidateSubscriptionFailure("Validation failed: $e"));
      rethrow;
    }
  }
}
