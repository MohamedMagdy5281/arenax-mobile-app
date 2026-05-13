abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

// register user data
class StartLoadingRegisterState extends RegisterState {}

class StopLoadingRegisterState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String registerationId;

  RegisterSuccessState({required this.registerationId});
}

class RegisterFailureState extends RegisterState {
  final String errorMessage;

  RegisterFailureState({required this.errorMessage});
}

// create password
class StartLoadingSavePasswordState extends RegisterState {}

class StopLoadingSavePasswordState extends RegisterState {}

class SavePasswordSuccessState extends RegisterState {}

class SavePasswordFailureState extends RegisterState {
  final String errorMessage;

  SavePasswordFailureState({required this.errorMessage});
}

// password visibility
class ChangeRegisterPasswordVisibility extends RegisterState {}

// create password button disable
class ChangeCreatePasswordButtonDisabled extends RegisterState {}

// otp button disable
class ChangeOTPButtonDisabled extends RegisterState {}

// validate OTP
class StartLoadingValidateOTPState extends RegisterState {}

class StopLoadingValidateOTPState extends RegisterState {}

class ValidateOTPSuccessState extends RegisterState {}

class ValidateOTPFailureState extends RegisterState {
  final int? resultCode;
  final String errorMessage;

  ValidateOTPFailureState(
      {required this.resultCode, required this.errorMessage});
}

// resend otp states
class StartLoadingResendOtpState extends RegisterState {}

class StopLoadingResendOtpState extends RegisterState {}

class ResendOtpSuccessState extends RegisterState {}

class ResendOtpFailureState extends RegisterState {
  int? resultCode;
  String? errorMessage;
  ResendOtpFailureState(this.resultCode, this.errorMessage);
}

class OTPTimerState extends RegisterState {
  final int otpRemainingTime;
  final bool isResendOTPButtonDisabled;

  OTPTimerState(
      {required this.otpRemainingTime,
      required this.isResendOTPButtonDisabled});
}

// //check email exists in firebase
// class StartLoadingIsEmailRegisteredCheck extends RegisterState {}
// class StopLoadingIsEmailRegisteredCheck extends RegisterState {}
// class IsEmailRegisteredCheckSuccess extends RegisterState {}
// class IsEmailRegisteredCheckFailure extends RegisterState {}
//
// //register new user in firebase
// class StartLoadingRegisterUser extends RegisterState {}
// class StopLoadingRegisterUser extends RegisterState {}
// class RegisterUserSuccess extends RegisterState {}
// class RegisterUserFailure extends RegisterState {}
