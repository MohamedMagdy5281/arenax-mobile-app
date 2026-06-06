import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_password_otp_verification_notifier_provider.g.dart';

class ResetPasswordOtpVerificationState {
  final bool isPageLoading;
  final bool isResetPasswordButtonLoading;
  final String? otpCode;
  final bool showPassword;
  final bool showConfirmPassword;
  const ResetPasswordOtpVerificationState({
    this.isPageLoading = false,
    this.isResetPasswordButtonLoading = false,
    this.otpCode,
    this.showPassword = false,
    this.showConfirmPassword = false,
  });

  ResetPasswordOtpVerificationState copyWith({
    bool? isPageLoading,
    bool? isResetPasswordButtonLoading,
    String? otpCode,
    bool? showPassword,
    bool? showConfirmPassword,
  }) {
    return ResetPasswordOtpVerificationState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isResetPasswordButtonLoading:
          isResetPasswordButtonLoading ?? this.isResetPasswordButtonLoading,
      otpCode: otpCode ?? this.otpCode,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }
}

@riverpod
class ResetPasswordOtpVerificationNotifier
    extends _$ResetPasswordOtpVerificationNotifier {
  Timer? _otpTimer;

  @override
  ResetPasswordOtpVerificationState build() {
    ref.onDispose(() {
      _otpTimer?.cancel();
    });
    return const ResetPasswordOtpVerificationState();
  }

  void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }

  void seResetPasswordButtonLoading() {
    state = state.copyWith(
        isResetPasswordButtonLoading: !state.isResetPasswordButtonLoading);
  }

  void setOtpCode(String otpCode) {
    state = state.copyWith(otpCode: otpCode);
  }

  Future<void> toggleShowPassword() async {
    state = state.copyWith(showPassword: !state.showPassword);
  }

  Future<void> toggleConfirmShowPassword() async {
    state = state.copyWith(showConfirmPassword: !state.showConfirmPassword);
  }
}
