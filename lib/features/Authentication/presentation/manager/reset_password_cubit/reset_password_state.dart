abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class StartLoadingInitForgetPassword extends ResetPasswordState {}

class StopLoadingInitForgetPassword extends ResetPasswordState {}

class InitForgetPasswordSuccess extends ResetPasswordState {
  final String requestId;

  InitForgetPasswordSuccess({required this.requestId});
}

class InitForgetPasswordFailures extends ResetPasswordState {
  final String? errorMessage;
  InitForgetPasswordFailures({required this.errorMessage});
}

class ChangeCreatePasswordButtonDisabled extends ResetPasswordState {}

class ChangeForgetPasswordVisibility extends ResetPasswordState {}

class StartLoadingConfirmForgetPassword extends ResetPasswordState {}

class StopLoadingConfirmForgetPassword extends ResetPasswordState {}

class ConfirmForgetPasswordSuccess extends ResetPasswordState {}

class ConfirmForgetPasswordFailures extends ResetPasswordState {
  final int? resultCode;
  final String? errorMessage;
  ConfirmForgetPasswordFailures(
      {required this.resultCode, required this.errorMessage});
}

class OTPTimerState extends ResetPasswordState {
  final int otpRemainingTime;
  final bool isResendOTPButtonDisabled;

  OTPTimerState(
      {required this.otpRemainingTime,
      required this.isResendOTPButtonDisabled});
}

class ChangeOTPButtonDisabled extends ResetPasswordState {}

// resend otp states
class StartLoadingResendOtpState extends ResetPasswordState {}

class StopLoadingResendOtpState extends ResetPasswordState {}

class ResendOtpSuccessState extends ResetPasswordState {}

class ResendOtpFailureState extends ResetPasswordState {
  int? resultCode;
  String? errorMessage;
  ResendOtpFailureState(this.resultCode, this.errorMessage);
}
