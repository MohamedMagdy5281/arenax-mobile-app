import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_notifier_provider.g.dart';

class LoginState {
  final bool isPageLoading;
  final bool isLoginButtonLoading;
  final bool showPassword;
  const LoginState({
    this.isPageLoading = false,
    this.isLoginButtonLoading = false,
    this.showPassword = false,
  });

  LoginState copyWith(
      {bool? isPageLoading,
      bool? isLoginButtonLoading,
      bool? termsAndPrivacyChecked,
      bool? showPassword}) {
    return LoginState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isLoginButtonLoading: isLoginButtonLoading ?? this.isLoginButtonLoading,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() {
    return const LoginState();
  }

  void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }

  void setLoginButtonLoading(bool isLoading) {
    state = state.copyWith(isLoginButtonLoading: isLoading);
  }

  void toggleShowPassword() {
    state = state.copyWith(showPassword: !state.showPassword);
  }
}
