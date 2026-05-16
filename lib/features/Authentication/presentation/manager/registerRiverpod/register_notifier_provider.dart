import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_notifier_provider.g.dart';

class RegisterState {
  final bool isPageLoading;
  final bool isRegisterButtonLoading;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const RegisterState({
    this.isPageLoading = false,
    this.isRegisterButtonLoading = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  RegisterState copyWith({
    bool? isPageLoading,
    bool? isRegisterButtonLoading,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return RegisterState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isRegisterButtonLoading:
          isRegisterButtonLoading ?? this.isRegisterButtonLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }
}

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    return const RegisterState();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible);
  }

  void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }

  void setRegisterButtonLoading(bool isLoading) {
    state = state.copyWith(isRegisterButtonLoading: isLoading);
  }
}
