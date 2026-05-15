import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_notifier_provider.g.dart';

class LoginState {
  final bool isPageLoading;
  final bool isLoginButtonLoading;
  final bool isPasswordVisible;
  final bool isRememberMeChecked;
  const LoginState({
    this.isPageLoading = false,
    this.isLoginButtonLoading = false,
    this.isPasswordVisible = false,
    this.isRememberMeChecked = false,
  });

  LoginState copyWith({
    bool? isPageLoading,
    bool? isLoginButtonLoading,
    bool? isPasswordVisible,
    bool? isRememberMeChecked,
  }) {
    return LoginState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isLoginButtonLoading: isLoginButtonLoading ?? this.isLoginButtonLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isRememberMeChecked: isRememberMeChecked ?? this.isRememberMeChecked,
    );
  }
}

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() {
    return const LoginState();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleRememberMe() {
    state = state.copyWith(isRememberMeChecked: !state.isRememberMeChecked);
  }

  void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }

  void setLoginButtonLoading(bool isLoading) {
    state = state.copyWith(isLoginButtonLoading: isLoading);
  }
}
