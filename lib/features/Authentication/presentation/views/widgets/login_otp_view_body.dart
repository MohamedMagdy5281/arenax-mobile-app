import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';
import 'package:praktika_clone_app/core/utils/assets.dart';
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/functions/custom_toast.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/utils/styles.dart';
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/login_cubit/login_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/app_loader_after_login_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/choose_gender_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/create_password_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/first_last_name_assign_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/login_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/home_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/supscriptioin_view.dart';

class LoginOtpViewBody extends StatefulWidget {
  final String loginId;
  const LoginOtpViewBody({super.key, required this.loginId});

  @override
  State<LoginOtpViewBody> createState() => _LoginOtpViewBodyState();
}

class _LoginOtpViewBodyState extends State<LoginOtpViewBody> {
  GlobalKey<FormState> otpFormKey = GlobalKey();
  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  bool isLoading = false;
  bool isResendingOtp = false;
  String? buttonText;
  FToast fToast = FToast();

  @override
  void initState() {
    fToast.init(context);
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is StartLoadingValidateOTPState) {
        isLoading = true;
      } else if (state is StopLoadingValidateOTPState) {
        isLoading = false;
      }

      if (state is StartLoadingCurrentUserDataState) {
        if (CasheHelper.firstName == null || CasheHelper.lastName == null) {
          globals.navigatorKey.currentState!
              .pushReplacementNamed(FirstLastNameAssignView.id);
        } else {
          globals.navigatorKey.currentState!
              .pushReplacementNamed(AppLoaderAfterLoginView.id);
        }
      } else if (state is ValidateOTPFailureState) {
        otpController.text = "";
        if (state.resultCode == -3) {
          LoginCubit.get(context).otpTimer?.cancel();
          Navigator.of(context).pop();
          showCustomToast(
            fToast,
            isError: true,
            toastMessage: state.errorMessage,
            icon: Iconsax.info_circle,
            width: MediaQuery.of(context).size.width - 32,
          );
        } else {
          successFailureAlert(context,
              isError: true, message: state.errorMessage, onOkPresses: () {
            Navigator.pop(context);
            otpFocusNode.requestFocus();
          }, onDismiss: () {
            otpFocusNode.requestFocus();
          });
        }
      }

      if (state is StartLoadingResendOtpState) {
        isResendingOtp = true;
      } else {
        isResendingOtp = false;
      }

      if (state is ResendOtpFailureState) {
        LoginCubit.get(context).otpTimer?.cancel();
        Navigator.of(context).pop();
        showCustomToast(
          fToast,
          isError: true,
          toastMessage: state.errorMessage != null
              ? state.errorMessage!
              : globals.appLang == 'ar'
                  ? "حدث خطأ ما, برجاء المحاولة مرة أخري."
                  : "Something went wronge, please try again.",
          icon: Iconsax.info_circle,
          width: MediaQuery.of(context).size.width - 32,
        );
      } else if (state is ResendOtpSuccessState) {
        showCustomToast(
          fToast,
          isError: false,
          toastMessage: globals.appLang == 'ar'
              ? ".تم ارسال رسالة برمز التأكيد إلى جوالك"
              : "A confirmation code has been sent to your mobile phone.",
          icon: Iconsax.info_circle,
          bgColor: kSuccessColor,
          width: MediaQuery.of(context).size.width - 32,
        );
      }
    }, builder: (context, state) {
      final loginCubit = LoginCubit.get(context);

      if (state is OTPTimerState) {
        final minutes =
            (state.otpRemainingTime ~/ 60).toString().padLeft(2, '0');
        final seconds =
            (state.otpRemainingTime % 60).toString().padLeft(2, '0');

        buttonText = state.otpRemainingTime > 0
            ? '${AppLocalizations.of(context)!.resendCodeIn} ($minutes:$seconds)'
            : AppLocalizations.of(context)!.resendCode;
      }
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (!didPop) {
            LoginCubit.get(context).otpTimer?.cancel();
            Navigator.of(context)
              ..pop()
              ..pop();
          }
        },
        child: Stack(
          children: [
            Image.asset(AssetsData.pageBg),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      title: AppLocalizations.of(context)!.loginVerification,
                      onPressed: () {
                        loginCubit.otpTimer?.cancel();
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: otpFormKey,
                        child: Column(
                          children: [
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Pinput(
                                focusNode: otpFocusNode,
                                controller: otpController,
                                defaultPinTheme: PinTheme(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                kLightBlueColor.withOpacity(.3),
                                            spreadRadius: 0,
                                            blurRadius: 12,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: kSideBG,
                                        border: Border.all(
                                            width: 1, color: kBorderColor)),
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 54,
                                    textStyle: Styles.textStyle16
                                        .copyWith(fontWeight: FontWeight.w400)),
                                autofocus: true,
                                focusedPinTheme: PinTheme(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                kLightBlueColor.withOpacity(.3),
                                            spreadRadius: 0,
                                            blurRadius: 12,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: kSideBG,
                                        border: Border.all(
                                            width: 1, color: kBorderColor)),
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 54,
                                    textStyle: Styles.textStyle16
                                        .copyWith(fontWeight: FontWeight.w400)),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                pinputAutovalidateMode:
                                    PinputAutovalidateMode.onSubmit,
                                onCompleted: (value) async {
                                  FocusNode().unfocus();
                                  loginCubit.completeLogin(
                                    loginRequestId: widget.loginId,
                                    otp: otpController.text,
                                  );
                                },
                                onChanged: (value) {
                                  loginCubit.onChangeOTPButtonDisable(value);
                                },
                                onSubmitted: (value) async {
                                  FocusNode().unfocus();
                                  loginCubit.completeLogin(
                                    loginRequestId: widget.loginId,
                                    otp: otpController.text,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            isLoading == true
                                ? Center(child: CustomLoadingIndicator())
                                : CustomButton(
                                    isDisabled: loginCubit.isOTPButtonDisabled,
                                    text: AppLocalizations.of(context)!.confirm,
                                    itemCallBack: () {
                                      FocusNode().unfocus();
                                      loginCubit.completeLogin(
                                        loginRequestId: widget.loginId,
                                        otp: otpController.text,
                                      );
                                    },
                                    icon: globals.appLang == 'en'
                                        ? Iconsax.arrow_right_14
                                        : Iconsax.arrow_left4,
                                  ),
                            const SizedBox(
                              height: 16,
                            ),
                            isResendingOtp == true
                                ? Center(child: CustomLoadingIndicator())
                                : CustomButton(
                                    disabledButtonColor: kSideBG,
                                    disabledBorderColor: Colors.transparent,
                                    disabledTextColor: kTextFieldHintColor,
                                    backgroundColor: kSideBG,
                                    borderColor: Colors.transparent,
                                    textColor: kDarkBlackColor,
                                    itemCallBack: state is OTPTimerState &&
                                            !state.isResendOTPButtonDisabled
                                        ? () {
                                            loginCubit
                                                .resendOtp(widget.loginId);
                                          }
                                        : () {},
                                    text: buttonText!,
                                    isDisabled:
                                        loginCubit.isResendOTPButtonDisabled,
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
