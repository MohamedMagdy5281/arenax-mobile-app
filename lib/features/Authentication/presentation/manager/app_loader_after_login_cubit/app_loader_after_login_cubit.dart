import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/features/Authentication/presentation/manager/app_loader_after_login_cubit/app_loader_after_login_state.dart';

class AppLoaderAfterLoginCubit extends Cubit<AppLoaderAfterLoginState> {
  AppLoaderAfterLoginCubit() : super(AppLoaderAfterLoginInitial()) {
    _initialize();
  }

  static AppLoaderAfterLoginCubit get(context) => BlocProvider.of(context);

  api_client.GetCurrentUserDetailsResponse? _currentUser;
  // Core IAP components
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;
  final MethodChannel _channel = MethodChannel('audio_route');

  // Product management
  final Set<String> _productIds = {};
  List<ProductDetails> _availableProducts = [];
  List<api_client.ReceiptItem> receiptItems = [];
  // Purchase tracking

  // UI state
  int? _chosenBundleIndex;
  int _errorCount = 0;
  bool _couldntGetProducts = false;

  // API responses
  List<api_client.GetAllProductsResponse>? _allProducts = [];
  api_client.GetAllProductsResponse? _userProduct;
  api_client.CreateSubscriptionResponse? _createSubscriptionResponse;

  Future<void> _initialize() async {
    await subscriptionInit();
  }

  Future<void> subscriptionInit() async {
    try {
      emit(StartLoadingGettingProducts());

      // Get all products first
      // await getAllProducts();

      // await _listenToPurchaseUpdates();

      // await initialize();

      await getCurrentUser();

      //await restorePurchases();

      emit(StopLoadingGettingProducts());

      // Refresh user data

      debugPrint("✅ Subscription initialization completed");
    } catch (e) {
      debugPrint("❌ Subscription init failed: $e");
      emit(GeneralLoadingPurchaseFailure(globals.appLang == 'ar'
          ? "فشل في تهيئة النظام. يرجى المحاولة مرة أخرى"
          : "Initialization failed. Please try again"));
    } finally {}
  }

  /// Initialize IAP products
  Future<void> initialize() async {
    try {
      final bool available = await _inAppPurchase.isAvailable();
      if (!available) {
        emit(InAppPurchaseAvailabilityFailure(globals.appLang == 'ar'
            ? "عمليات الشراء داخل التطبيق غير متاحة على هذا الجهاز."
            : "In-app purchases are not available on this device."));
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
      // emit(StopLoadingGettingProducts());
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
                break;
              case PurchaseStatus.error:
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

  /// Restore previous purchases
  Future<void> restorePurchases() async {
    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      debugPrint("❌ Failed to restore purchases: $e");
      emit(CompletingPurchaseFailure(globals.appLang == 'ar'
          ? "لم نتمكن من استعادة المشتريات. يُرجى المحاولة لاحقًا."
          : "We couldn't restore your purchases. Please try again later."));
    }
  }

  Future<void> _processRestore(PurchaseDetails purchase) async {
    try {
      // Get receipt data
      emit(StartLoadingCompletingPurchase());
      String? receiptData = await _getReceiptData(purchase);
      if (receiptData == null || receiptData.isEmpty) {
        throw Exception("Failed to get receipt data");
      }
      await _createSubscription(purchase);
    } catch (e) {
      debugPrint("❌ Failed to process restore: $e");
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
              product.inAppProductId == lastSubscription.inAppProductId &&
              lastSubscription.subscriptionEndDate!.isAfter(DateTime.now()),
        );
      }

      emit(GettingProductsSuccess());
    } catch (e) {
      debugPrint("❌ Failed to get products: $e");
      emit(GettingProductsFailure(globals.appLang == 'en'
          ? "Something went wrong, please try later"
          : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
      emit(StopLoadingGettingProducts());
    }
  }

  Future<void> _createSubscription(PurchaseDetails purchase) async {
    try {
      Map<String, String>? currentPurchase =
          _getProductDetails(purchase.productID);
      final model = api_client.CreateSubscriptionRequest()
        ..descriptionAr = currentPurchase!['descAr']!
        ..descriptionEn = currentPurchase!['descEn']!
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

      emit(StopLoadingCompletingPurchase());
    } on api_client.ApiException catch (e) {
      emit(CompletingPurchaseFailure(globals.appLang == 'ar'
          ? "فشل في معالجة عملية الشراء. يرجى المحاولة مرة أخرى"
          : "Failed to process purchase. Please try again"));
      emit(StopLoadingCompletingPurchase());
    } catch (e) {
      emit(CompletingPurchaseFailure(globals.appLang == 'ar'
          ? "فشل في معالجة عملية الشراء. يرجى المحاولة مرة أخرى"
          : "Failed to process purchase. Please try again"));
      emit(StopLoadingCompletingPurchase());

      rethrow;
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
        globals.freeChatPrompt = _currentUser!.freeChatPrompt;

        // Calculate subscription remaining days
        if (_currentUser!.user!.subscriptions != null &&
            _currentUser!.user!.subscriptions!.isNotEmpty) {
          for (var subsription in _currentUser!.user!.subscriptions!) {
            if (subsription.isActive == true &&
                !globals.activeProductIds.contains(subsription.productId)) {
              globals.activeProductIds.add(subsription.inAppProductId!);
            }
          }
          final lastSubscription = _currentUser!.user!.subscriptions!.last;
          int subscriptionRemainingDays = lastSubscription.subscriptionEndDate!
              .difference(DateTime.now().toUtc())
              .inDays;
          if (subscriptionRemainingDays >= 0) {
            globals.isSubscriptionActive = true;
            globals.subscriptionRemainingDays =
                subscriptionRemainingDays.toString();
          }
        } else if (_currentUser!.user!.freeTrial != null) {
          int freeTrialRemainingDays = _currentUser!.user!.freeTrial!.endDate!
              .difference(DateTime.now().toUtc())
              .inDays;
          if (freeTrialRemainingDays >= 0) {
            globals.isFreeTrialActive = true;
            globals.isSubscriptionActive = false;
            globals.activeProductIds.clear();
            globals.freeRemainingDays = freeTrialRemainingDays.toString();
          }
        } else {
          globals.isSubscriptionActive = false;
          globals.isFreeTrialActive = false;
          globals.activeProductIds.clear();
        }
      }
      emit(GetCurrentUserSuccess());
    } catch (e) {
      debugPrint("❌ Failed to get current user: $e");
      emit(GetCurrentUserFailure());
    }
  }

  @override
  Future<void> close() async {
    await _purchaseSubscription?.cancel();
    return super.close();
  }
}
