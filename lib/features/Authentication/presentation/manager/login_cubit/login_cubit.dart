import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:praktika_clone_app/core/classes/channel_token_helper.dart';
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/login_cubit/login_state.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:uuid/uuid.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData loginPasswordVisible = Iconsax.eye_slash;
  bool isLoginPasswordShown = true;

  void changeLoginPasswordVisibility() {
    isLoginPasswordShown = !isLoginPasswordShown;
    loginPasswordVisible =
        isLoginPasswordShown ? Iconsax.eye_slash : Iconsax.eye;
    emit(ChangeLoginPasswordVisibility());
  }

  bool rememberCheckBox = false;
  Future<void> changeRememberCheckBox(
    bool value,
  ) async {
    rememberCheckBox = value;

    emit(ChangeRememberCheckBox(rememberCheckBox));
  }

  Future<void> loginInit() async {
    emit(StartLoadingLoginPage());
    String? isRemeberCheckBox = await CasheHelper.getStringFromSS('isChecked');
    rememberCheckBox = isRemeberCheckBox == "true" ? true : false;
    emit(ChangeRememberCheckBox(rememberCheckBox));
    if (isRemeberCheckBox == "true") {
      final mobile = await CasheHelper.getStringFromSS('mobile');

      emit(GetMobileNumberAndPass(mobile));
    }
    emit(StopLoadingLoginPage());
  }

  //**************************************************/
// Get Current User Data
  api_client.GetCurrentUserDetailsResponse? response;
  Future<void> getCurrentUser() async {
    api_client.GetCurrentUserDetailsRequest model =
        api_client.GetCurrentUserDetailsRequest();
    api_client.AuthenticationApi api = api_client.AuthenticationApi();
    try {
      emit(StartLoadingCurrentUserDataState());
      response = await api.apiAuthenticationCurrentUserPost(body: model);
      if (response != null) {
        CasheHelper.user = api_client.UserModel();
        CasheHelper.user = response!.user;
        CasheHelper.firstName = response!.user!.firstName;
        CasheHelper.lastName = response!.user!.lastName;
        CasheHelper.dateOfBirth = response!.user!.dateOfBirth;
        CasheHelper.accentCode = response!.user!.accent!.code;
        CasheHelper.accentId = response!.user!.accentId;
        CasheHelper.languageId = response!.user!.nativeLanagaugeId;
        CasheHelper.mainGoalId = response!.user!.mainGoalId;
        globals.freeChatPrompt = response!.freeChatPrompt;

        if (globals.validatedSubscriptionItems.isNotEmpty) {
          final lastSubscription = globals.validatedSubscriptionItems.last;
          globals.subscriptionRemainingDays =
              DateTime.parse(lastSubscription.endDateUTC!)
                  .difference(DateTime.now())
                  .inDays
                  .toString();
        } else if (response!.user!.freeTrial != null) {
          globals.freeRemainingDays = response!.user!.freeTrial!.endDate!
              .difference(DateTime.now())
              .inDays
              .toString();
          debugPrint("⚠️ Only free trial found, no subscription");
        } else {
          debugPrint("❌ No subscription or free trial found");
        }
        CasheHelper.freeTrialPeriod = response!.freeTrialPeriod;

        emit(CurrentUserDataSuccessState());
        emit(StopLoadingCurrentUserDataState());
      }
    } on api_client.ApiException catch (e) {
      // if (e.code == 401) {
      //   await getCurrentUser();
      // } else {
      emit(CurrentUserDataFailureState());
      emit(StopLoadingCurrentUserDataState());
      // }

      if (kDebugMode) {
        print(e);
      }
    }
  }

  // login user
  api_client.LoginResponse? loginResponse;
  Future<void> loginUser(
      {required String mobileNumber, required String password}) async {
    api_client.LoginRequest model = api_client.LoginRequest();
    model.userName = mobileNumber;
    model.password = password;
    model.version = globals.version;
    // model.version = "string";
    model.os = globals.os;
    // model.os = "string";

    api_client.AuthenticationApi api = api_client.AuthenticationApi();
    try {
      emit(StartLoadingLoginState());
      loginResponse = await api.apiAuthenticationLoginUserPost(body: model);
      if (loginResponse != null) {
        if (loginResponse!.needUpate == true) {
          emit(ShowUpdateNeededDialog(loginResponse!.updateUrl));
          emit(StopLoadingLoginState());
        } else {
          if (loginResponse!.errorMessage == null ||
              loginResponse!.errorMessage == "") {
            CasheHelper.user = loginResponse!.user;
            // CasheHelper.authenticationResult =
            //     loginResponse!.authenticationResult;
            CasheHelper.userId = loginResponse!.user?.id;
            CasheHelper.token = loginResponse!.token;
            CasheHelper.refreshToken = loginResponse!.refreshToken;
            if (kDebugMode) {
              print(CasheHelper.token);
            }
            await CasheHelper.addStringToSS("userId", loginResponse!.user?.id);
            await CasheHelper.addStringToSS("token", loginResponse!.token);
            await CasheHelper.addStringToSS(
                "refreshToken", loginResponse!.refreshToken);

            if (rememberCheckBox == true) {
              await CasheHelper.addStringToSS(
                  "isChecked", rememberCheckBox.toString());

              await CasheHelper.addStringToSS("mobile", mobileNumber);
              // await CasheHelper.addStringToSS("password", password);
            } else {
              await CasheHelper.removeStringFromSS("isChecked");
              await CasheHelper.removeStringFromSS("mobile");
              // await CasheHelper.removeStringFromSS("password");
            }

            await getCurrentUser();
            emit(StopLoadingLoginState());
            emit(LoginSuccessState());
          } else {
            emit(StopLoadingLoginState());
            emit(LoginFailureState(errorMessage: loginResponse!.errorMessage!));
          }
        }
      }
    } on api_client.ApiException catch (e) {
      emit(StopLoadingLoginState());
      emit(LoginFailureState(
          errorMessage: jsonDecode(e.message!)['errorMessage']));
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(StopLoadingLoginState());
      emit(LoginFailureState(
          errorMessage: globals.appLang == 'en'
              ? "Something went wrong, please try later"
              : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
    }
  }

  api_client.CompleteRegisterUserResponse? savePasswordResponse;
  Future<void> completeLogin(
      {required String loginRequestId, required String otp}) async {
    api_client.CompleteRegisterUserRequest model =
        api_client.CompleteRegisterUserRequest();
    model.requestId = loginRequestId;
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

        await getCurrentUser();

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
      emit(StopLoadingValidateOTPState());
      emit(ValidateOTPFailureState(
          resultCode: -1,
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
  }
}
