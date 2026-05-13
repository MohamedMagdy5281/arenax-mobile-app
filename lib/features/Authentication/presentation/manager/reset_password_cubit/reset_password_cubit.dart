import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/classes/channel_token_helper.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/reset_password_cubit/reset_password_state.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:uuid/uuid.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  static ResetPasswordCubit get(context) => BlocProvider.of(context);

  bool isCreatePasswordButtonDisabled = true;
  void onChangeCreatePasswordButtonDisable(
      String? password, String? confirmPassword) {
    isCreatePasswordButtonDisabled = password != confirmPassword;
    emit(ChangeCreatePasswordButtonDisabled());
  }

  /// *******CreatePassword*******
  // password eye visibility
  IconData registerPasswordVisible = Iconsax.eye_slash;
  bool isForgetPasswordShown = true;
  void changeRegisterPasswordVisibility() {
    isForgetPasswordShown = !isForgetPasswordShown;
    registerPasswordVisible =
        isForgetPasswordShown ? Iconsax.eye_slash : Iconsax.eye;
    emit(ChangeForgetPasswordVisibility());
  }

  IconData registerConfirmPasswordVisible = Iconsax.eye_slash;
  bool isForgetConfirmPasswordShown = true;
  void changeRegisterConfirmPasswordVisibility() {
    isForgetConfirmPasswordShown = !isForgetConfirmPasswordShown;
    registerConfirmPasswordVisible =
        isForgetConfirmPasswordShown ? Iconsax.eye_slash : Iconsax.eye;
    emit(ChangeForgetPasswordVisibility());
  }

  api_client.ForgetPasswordResponse? initForgetPassResponse;
  Future<void> initializeForgetPassword(
      {required String phoneNumber, required String newPassword}) async {
    api_client.ForgetPasswordRequest model = api_client.ForgetPasswordRequest();
    model.userName = phoneNumber;
    model.newPassword = newPassword;
    final uuid = Uuid();
    final generatedGuid = uuid.v4();
    const sharedSecret = "goat";
    final encryptedGuid =
        ChannelTokenHelper.encryptToken(generatedGuid, sharedSecret);

    model.channel_Token = encryptedGuid;

    api_client.AuthenticationApi api = api_client.AuthenticationApi();
    try {
      emit(StartLoadingInitForgetPassword());
      initForgetPassResponse =
          await api.apiAuthenticationForgetPasswordPost(body: model);
      if (initForgetPassResponse != null) {
        if (initForgetPassResponse!.requestId ==
            "00000000-0000-0000-0000-000000000000") {
          emit(StopLoadingInitForgetPassword());
          emit(InitForgetPasswordFailures(
              errorMessage: globals.appLang == 'en'
                  ? "Phone number is not correct"
                  : "رقم الهاتف غير صحيح"));
          globals.navigatorKey.currentState!.pop();
        } else {
          emit(StopLoadingInitForgetPassword());
          emit(InitForgetPasswordSuccess(
              requestId: initForgetPassResponse!.requestId!));
        }
      } else {
        emit(StopLoadingInitForgetPassword());
        emit(InitForgetPasswordFailures(
            errorMessage: globals.appLang == 'en'
                ? "Something went wrong, please try later"
                : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
      }
      // }
    } on api_client.ApiException catch (e) {
      emit(StopLoadingInitForgetPassword());
      emit(InitForgetPasswordFailures(
          errorMessage: jsonDecode(e.message!)['errorMessage']));
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(StopLoadingInitForgetPassword());
      emit(InitForgetPasswordFailures(
          errorMessage: globals.appLang == 'en'
              ? "Something went wrong, please try later"
              : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
    }
  }

  api_client.ConfirmForgetPasswordResponse? confirmForgetPasswordsResponse;
  Future<void> confirmForgetPassword(
      {required String requestId, required String otp}) async {
    api_client.ConfirmForgetPasswordRequest model =
        api_client.ConfirmForgetPasswordRequest();
    model.requestId = requestId;
    model.otp = otp;

    api_client.AuthenticationApi api = api_client.AuthenticationApi();
    try {
      emit(StartLoadingConfirmForgetPassword());
      confirmForgetPasswordsResponse =
          await api.apiAuthenticationConfirmForgetPasswordPost(body: model);
      if (confirmForgetPasswordsResponse != null) {
        emit(StopLoadingConfirmForgetPassword());
        emit(ConfirmForgetPasswordSuccess());
      } else {
        emit(StopLoadingConfirmForgetPassword());
        emit(ConfirmForgetPasswordFailures(
            resultCode: -1,
            errorMessage: globals.appLang == 'en'
                ? "Something went wrong, please try later"
                : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
      }
      // }
    } on api_client.ApiException catch (e) {
      emit(StopLoadingConfirmForgetPassword());
      emit(ConfirmForgetPasswordFailures(
        resultCode: jsonDecode(e.message!)['resultCode'],
        errorMessage: jsonDecode(e.message!)['errorMessage'],
      ));
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(StopLoadingConfirmForgetPassword());
      emit(ConfirmForgetPasswordFailures(
          resultCode: -1,
          errorMessage: globals.appLang == 'en'
              ? "Something went wrong, please try later"
              : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
    }
  }

  // OTP timer setup
  Timer? otpTimer;
  int otpRemainingTime = 180; // 3 minutes
  bool isResendOTPButtonDisabled = true;

  void startTimer() {
    otpRemainingTime = 180; // Reset to 3 minutes
    isResendOTPButtonDisabled = true;

    emit(OTPTimerState(
      otpRemainingTime: otpRemainingTime,
      isResendOTPButtonDisabled: true,
    ));

    otpTimer?.cancel();
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpRemainingTime <= 0) {
        isResendOTPButtonDisabled = false;
        emit(OTPTimerState(
          otpRemainingTime: otpRemainingTime,
          isResendOTPButtonDisabled: false,
        ));
        timer.cancel();
      } else {
        otpRemainingTime--;
        emit(OTPTimerState(
          otpRemainingTime: otpRemainingTime,
          isResendOTPButtonDisabled: true,
        ));
      }
    });
  }

  api_client.ResendRegistrationOtpResponse? resendOtpResponse;
  Future<void> resendOtp(String requestId) async {
    api_client.ResendRegistrationOtpRequest model =
        api_client.ResendRegistrationOtpRequest();

    model.requestId = requestId;
    model.isCorporate = false;
    model.langCode = globals.appLang;
    final uuid = Uuid();
    final generatedGuid = uuid.v4();
    const sharedSecret = "goat";
    final encryptedGuid =
        ChannelTokenHelper.encryptToken(generatedGuid, sharedSecret);

    model.channel_Token = encryptedGuid;

    api_client.AuthenticationApi api = api_client.AuthenticationApi();
    try {
      emit(StartLoadingResendOtpState());
      resendOtpResponse = await api.apiAuthenticationResendOtpPost(body: model);
      // here check if login success or not
      if (resendOtpResponse != null) {
        emit(ResendOtpSuccessState());
        emit(StopLoadingResendOtpState());
        // otpTimer?.cancel();
      }
      startTimer();
    } on api_client.ApiException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(ResendOtpFailureState(
        (jsonDecode(
                e.message!.substring(e.message!.indexOf('{')))['resultCode'] ??
            -1),
        (jsonDecode(e.message!.substring(e.message!.indexOf('{')))[
                'errorMessage'] ??
            'حدث خطأ أثناء إعادة إرسال رمز التحقق'),
      ));
      emit(StopLoadingResendOtpState());
      startTimer();
    }

    // try {
    //   await analytics.logEvent(
    //     name: "Confirm_Registration_Otp",
    //     parameters: {
    //       "user_id": CasheHelper.userModel?.id ?? "No_Token_Found",
    //       "corporate_id": CasheHelper.corporateModel.isNotEmpty
    //           ? CasheHelper.corporateModel[0].id ?? "No_Corporate_Found"
    //           : "No_Corporate_Found",
    //     },
    //   );
    //   if (kDebugMode) {
    //     print("Event logged successfully");
    //   }
    // } catch (e) {
    //   if (kDebugMode) {
    //     print("Failed to log event: $e");
    //   }
    // }
  }

  /// *******OTP*******
  // otp button disable
  bool isOTPButtonDisabled = true;
  void onChangeOTPButtonDisable(String? otp) {
    isOTPButtonDisabled = otp == null || otp.length != 4;
    emit(ChangeOTPButtonDisabled());
  }
}
