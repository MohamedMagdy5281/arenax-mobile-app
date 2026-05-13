abstract class LoginState {}

class LoginInitial extends LoginState {}

// password visibility
class ChangeLoginPasswordVisibility extends LoginState {}

class ChangeRememberCheckBox extends LoginState {
  bool? rememberCheckBox;
  ChangeRememberCheckBox(this.rememberCheckBox);
}

// login
class StartLoadingLoginState extends LoginState {}

class StopLoadingLoginState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String errorMessage;

  LoginFailureState({required this.errorMessage});
}

class LoginCountryCodeChanged extends LoginState {
  String? countryCode;
  String? countryDialCode;
  LoginCountryCodeChanged(this.countryCode, this.countryDialCode);
}

// forget password
class StartLoadingForgetPasswordState extends LoginState {}

class StopLoadingForgetPasswordState extends LoginState {}

class ForgetPasswordSuccessState extends LoginState {}

class ForgetPasswordFailureState extends LoginState {
  final String errorMessage;

  ForgetPasswordFailureState({required this.errorMessage});
}

//**************************************************/
// Get Current User Data
class StartLoadingCurrentUserDataState extends LoginState {}

class StopLoadingCurrentUserDataState extends LoginState {}

class CurrentUserDataSuccessState extends LoginState {}

class CurrentUserDataFailureState extends LoginState {}

//**************************************************/
// Display saved mobile number and password
class GetMobileNumberAndPass extends LoginState {
  String? mobile;
  GetMobileNumberAndPass(
    this.mobile,
  );
}

//Loading login page
class StartLoadingLoginPage extends LoginState {}

class StopLoadingLoginPage extends LoginState {}

class ShowUpdateNeededDialog extends LoginState {
  String? updateUrl;
  ShowUpdateNeededDialog(this.updateUrl);
}

// otp button disable
class ChangeOTPButtonDisabled extends LoginState {}

// validate OTP
class StartLoadingValidateOTPState extends LoginState {}

class StopLoadingValidateOTPState extends LoginState {}

class ValidateOTPSuccessState extends LoginState {}

class ValidateOTPFailureState extends LoginState {
  final int? resultCode;
  final String errorMessage;

  ValidateOTPFailureState(
      {required this.resultCode, required this.errorMessage});
}

// resend otp states
class StartLoadingResendOtpState extends LoginState {}

class StopLoadingResendOtpState extends LoginState {}

class ResendOtpSuccessState extends LoginState {}

class ResendOtpFailureState extends LoginState {
  int? resultCode;
  String? errorMessage;
  ResendOtpFailureState(this.resultCode, this.errorMessage);
}

class OTPTimerState extends LoginState {
  final int otpRemainingTime;
  final bool isResendOTPButtonDisabled;

  OTPTimerState(
      {required this.otpRemainingTime,
      required this.isResendOTPButtonDisabled});
}
