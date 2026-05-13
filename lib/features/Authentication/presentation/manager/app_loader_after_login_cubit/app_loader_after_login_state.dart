abstract class AppLoaderAfterLoginState {}

class AppLoaderAfterLoginInitial extends AppLoaderAfterLoginState {}

class StartLoadingGettingProducts extends AppLoaderAfterLoginState {}

class StopLoadingGettingProducts extends AppLoaderAfterLoginState {}

class GettingProductsSuccess extends AppLoaderAfterLoginState {}

class GettingProductsFailure extends AppLoaderAfterLoginState {
  String errorMessage;
  GettingProductsFailure(this.errorMessage);
}

class LoadProductsFailed extends AppLoaderAfterLoginState {
  bool? isFailed;

  LoadProductsFailed(this.isFailed);
}

class StartLoadingGetCurrentUser extends AppLoaderAfterLoginState {}

class StopLoadingGetCurrentUser extends AppLoaderAfterLoginState {}

class GetCurrentUserSuccess extends AppLoaderAfterLoginState {}

class GetCurrentUserFailure extends AppLoaderAfterLoginState {}

class StartLoadingValidateSubscription extends AppLoaderAfterLoginState {}

class StopLoadingValidateSubscription extends AppLoaderAfterLoginState {}

class ValidateSubscriptionSuccess extends AppLoaderAfterLoginState {}

class ValidateSubscriptionFailure extends AppLoaderAfterLoginState {
  String errorMessage;
  ValidateSubscriptionFailure(this.errorMessage);
}

class GettingRestoredFinished extends AppLoaderAfterLoginState {}

class InAppPurchaseAvailabilityFailure extends AppLoaderAfterLoginState {
  String errorMessage;
  InAppPurchaseAvailabilityFailure(this.errorMessage);
}

class GeneralLoadingPurchaseFailure extends AppLoaderAfterLoginState {
  String errorMessage;
  GeneralLoadingPurchaseFailure(this.errorMessage);
}

class StartLoadingCompletingPurchase extends AppLoaderAfterLoginState {}

class StopLoadingCompletingPurchase extends AppLoaderAfterLoginState {}

class CompletingPurchaseSuccess extends AppLoaderAfterLoginState {}

class CompletingPurchaseFailure extends AppLoaderAfterLoginState {
  String errorMessage;
  CompletingPurchaseFailure(this.errorMessage);
}
