import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:praktika_clone_app/core/classes/channel_token_helper.dart';
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/register_cubit/register_state.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:uuid/uuid.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  /// *******RegisterUserData*******
  // register user
  api_client.RegisterUserResponse? registerUserDataResponse;
  Future<void> registerUserData(
      {required String firstName,
      required String lastName,
      required String email,
      required String phoneNumber,
      required String password}) async {
    api_client.RegisterUserRequest model = api_client.RegisterUserRequest();
    model.firstName = firstName;
    model.lastName = lastName;
    model.email = email;
    model.mobileNumber = phoneNumber;
    model.password = password;
    model.langCode = globals.appLang;
    model.profilePictureId = null;

    final uuid = Uuid();
    final generatedGuid = uuid.v4();
    const sharedSecret = "goat";
    final encryptedGuid =
        ChannelTokenHelper.encryptToken(generatedGuid, sharedSecret);

    model.channel_Token = encryptedGuid;

    api_client.UserAuthenticationApi api = api_client.UserAuthenticationApi();
    try {
      emit(StartLoadingRegisterState());
      registerUserDataResponse = await api
          .apiUserAuthenticationApiInitialRegisterationPost(body: model);
      if (registerUserDataResponse != null) {
        emit(StopLoadingRegisterState());
        emit(RegisterSuccessState(
            registerationId: registerUserDataResponse!.id!));
      } else {
        emit(StopLoadingRegisterState());
        emit(RegisterFailureState(
            errorMessage: globals.appLang == 'en'
                ? "Something went wrong, please try later"
                : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
      }
    } on api_client.ApiException catch (e) {
      emit(StopLoadingRegisterState());
      emit(RegisterFailureState(
          errorMessage: jsonDecode(e.message!)['errorMessage']));
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(StopLoadingRegisterState());
      emit(RegisterFailureState(
          errorMessage: globals.appLang == 'en'
              ? "Something went wrong, please try later"
              : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
    }
  }

  /// *******CreatePassword*******
  // password eye visibility
  IconData registerPasswordVisible = Iconsax.eye_slash;
  bool isRegisterPasswordShown = true;
  void changeRegisterPasswordVisibility() {
    isRegisterPasswordShown = !isRegisterPasswordShown;
    registerPasswordVisible =
        isRegisterPasswordShown ? Iconsax.eye_slash : Iconsax.eye;
    emit(ChangeRegisterPasswordVisibility());
  }

  IconData registerConfirmPasswordVisible = Iconsax.eye_slash;
  bool isRegisterConfirmPasswordShown = true;
  void changeRegisterConfirmPasswordVisibility() {
    isRegisterConfirmPasswordShown = !isRegisterConfirmPasswordShown;
    registerConfirmPasswordVisible =
        isRegisterConfirmPasswordShown ? Iconsax.eye_slash : Iconsax.eye;
    emit(ChangeRegisterPasswordVisibility());
  }

  // change create password button disable
  bool isCreatePasswordButtonDisabled = true;
  void onChangeCreatePasswordButtonDisable(
      String? password, String? confirmPassword) {
    isCreatePasswordButtonDisabled = password != confirmPassword;
    emit(ChangeCreatePasswordButtonDisabled());
  }

  api_client.CompleteRegisterUserResponse? savePasswordResponse;
  Future<void> completeRegistration(
      {required String registerationId, required String otp}) async {
    api_client.CompleteRegisterUserRequest model =
        api_client.CompleteRegisterUserRequest();
    model.requestId = registerationId;
    model.otp = otp;

    api_client.UserAuthenticationApi api = api_client.UserAuthenticationApi();
    try {
      emit(StartLoadingValidateOTPState());
      savePasswordResponse = await api
          .apiUserAuthenticationApiCompleteRegisterationPost(body: model);
      if (savePasswordResponse != null) {
        // if (savePasswordResponse!.errors!.isEmpty) {
        CasheHelper.user = savePasswordResponse!.user;
        // CasheHelper.authenticationResult =
        //     validateOTPResponse!.authenticationResult;
        CasheHelper.userId = savePasswordResponse!.user?.id;
        CasheHelper.token = savePasswordResponse!.accessToken;
        CasheHelper.refreshToken = savePasswordResponse!.refreshToken;

        // await CasheHelper.addStringToSS(
        //     "token", savePasswordResponse!.accessToken);
        // await CasheHelper.addStringToSS(
        //     "refreshToken", savePasswordResponse!.refreshToken);
        emit(StopLoadingValidateOTPState());
        emit(ValidateOTPSuccessState());
      }
      // }
    } on api_client.ApiException catch (e) {
      emit(StopLoadingValidateOTPState());
      emit(ValidateOTPFailureState(
        resultCode: jsonDecode(e.message!)['resultCode'],
        errorMessage: jsonDecode(e.message!)['errorMessage'],
      ));
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(StopLoadingSavePasswordState());
      emit(SavePasswordFailureState(
          errorMessage: globals.appLang == 'en'
              ? "Something went wrong, please try later"
              : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
    }
  }

  /// *******OTP*******
  // otp button disable
  bool isOTPButtonDisabled = true;
  void onChangeOTPButtonDisable(String? otp) {
    isOTPButtonDisabled = otp == null || otp.length != 4;
    emit(ChangeOTPButtonDisabled());
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

  // resend otp
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
        print(e.message);
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
}

