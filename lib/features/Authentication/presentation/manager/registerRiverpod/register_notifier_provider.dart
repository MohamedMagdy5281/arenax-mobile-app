import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_notifier_provider.g.dart';

class RegisterState {
  final bool isPageLoading;
  final bool isLoginButtonLoading;
  final bool termsAndPrivacyChecked;
  final bool checkBoxError;

  const RegisterState({
    this.isPageLoading = false,
    this.isLoginButtonLoading = false,
    this.termsAndPrivacyChecked = false,
    this.checkBoxError = false,
  });

  RegisterState copyWith({
    bool? isPageLoading,
    bool? isLoginButtonLoading,
    bool? termsAndPrivacyChecked,
    bool? checkBoxError,
  }) {
    return RegisterState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isLoginButtonLoading: isLoginButtonLoading ?? this.isLoginButtonLoading,
      termsAndPrivacyChecked:
          termsAndPrivacyChecked ?? this.termsAndPrivacyChecked,
      checkBoxError:
          checkBoxError ?? this.checkBoxError,
    );
  }
}

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    return const RegisterState();
  }

  void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }

  void setLoginButtonLoading(bool isLoading) {
    state = state.copyWith(isLoginButtonLoading: isLoading);
  }

  void toggleTermsAndPrivacyChecked() {
    state =
        state.copyWith(termsAndPrivacyChecked: !state.termsAndPrivacyChecked);

      if(state.termsAndPrivacyChecked == true){
        if(state.checkBoxError == true){
          state = state.copyWith(checkBoxError: false);
        }
      }
  }

  void showCheckBoxError() {
    state = state.copyWith(checkBoxError: true);
  }

  void hideCheckBoxError() {
    state = state.copyWith(checkBoxError: false);
  }
}
