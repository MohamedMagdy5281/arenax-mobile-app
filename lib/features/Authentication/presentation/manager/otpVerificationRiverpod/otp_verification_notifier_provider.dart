import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'otp_verification_notifier_provider.g.dart';

class OtpVerificationState {
  final bool isPageLoading;
  final bool isVerifyButtonLoading;
  final bool isResendButtonLoading;
  final String? otpCode;
  final int otpRemainingTime;
  const OtpVerificationState({
    this.isPageLoading = false,
    this.isVerifyButtonLoading = false,
    this.isResendButtonLoading = false,
    this.otpCode,
    this.otpRemainingTime = 180,
  });

  OtpVerificationState copyWith({
    bool? isPageLoading,
    bool? isVerifyButtonLoading,
    bool? isResendButtonLoading,
    String? otpCode,
    int? otpRemainingTime,
  }) {
    return OtpVerificationState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isVerifyButtonLoading:
          isVerifyButtonLoading ?? this.isVerifyButtonLoading,
      isResendButtonLoading:
          isResendButtonLoading ?? this.isResendButtonLoading,
      otpCode: otpCode ?? this.otpCode,
      otpRemainingTime: otpRemainingTime ?? this.otpRemainingTime,
    );
  }
}

@riverpod
class OtpVerificationNotifier extends _$OtpVerificationNotifier {
  Timer? _otpTimer;

  @override
  OtpVerificationState build() {
    ref.onDispose(() {
      _otpTimer?.cancel();
    });
    return const OtpVerificationState();
  }

  void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }

  void setVerifyButtonLoading(bool isLoading) {
    state = state.copyWith(isVerifyButtonLoading: isLoading);
  }

  void setResendButtonLoading(bool isLoading) {
    state = state.copyWith(isResendButtonLoading: isLoading);
  }

  void setOtpCode(String otpCode) {
    state = state.copyWith(otpCode: otpCode);
  }

  // -----------------------
  // OTP TIMER ONLY
  // -----------------------

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  void startTimer() {
    _otpTimer?.cancel();

    state = state.copyWith(otpRemainingTime: 180);

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = state.otpRemainingTime;

      if (current <= 1) {
        state = state.copyWith(otpRemainingTime: 0);
        timer.cancel();
      } else {
        state = state.copyWith(otpRemainingTime: current - 1);
      }
    });
  }

  void resetTimer() {
    _otpTimer?.cancel();
    state = state.copyWith(otpRemainingTime: 180);
  }
}
