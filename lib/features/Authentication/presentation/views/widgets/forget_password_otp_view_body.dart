import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';
import 'package:praktika_clone_app/core/utils/assets.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/functions/custom_toast.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/utils/styles.dart';
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/reset_password_cubit/reset_password_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/choose_gender_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/create_password_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/login_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/home_view.dart';

class ForgetPasswordOtpViewBody extends StatefulWidget {
  final String requestId;
  const ForgetPasswordOtpViewBody({super.key, required this.requestId});

  @override
  State<ForgetPasswordOtpViewBody> createState() => _OtpViewBodyState();
}

class _OtpViewBodyState extends State<ForgetPasswordOtpViewBody> {
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
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
      if (state is StartLoadingConfirmForgetPassword) {
        isLoading = true;
      } else if (state is StopLoadingConfirmForgetPassword) {
        isLoading = false;
      }

      if (state is ConfirmForgetPasswordSuccess) {
        showCustomToast(
          fToast,
          bgColor: kSuccessColor,
          isError: false,
          toastMessage: globals.appLang == "ar"
              ? "تم إعادة تعيين كلمة المرور الخاصة بك بنجاح"
              : "Your password has been reset successfully.",
          width: globals.appLang == 'ar' ? 220 : 250,
        );
        globals.navigatorKey.currentState!.pushNamed(
          LoginView.id,
        );
      } else if (state is ConfirmForgetPasswordFailures) {
        otpController.text = "";
        if (state.resultCode == -3) {
          ResetPasswordCubit.get(context).otpTimer?.cancel();
          Navigator.of(context)
            ..pop()
            ..pop();
          showCustomToast(
            fToast,
            isError: true,
            toastMessage: state.errorMessage!,
            icon: Iconsax.info_circle,
            width: MediaQuery.of(context).size.width - 32,
          );
        } else {
          successFailureAlert(context,
              isError: true, message: state.errorMessage!, onOkPresses: () {
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
        ResetPasswordCubit.get(context).otpTimer?.cancel();
        Navigator.of(context)
          ..pop()
          ..pop();
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
      final resetCubit = ResetPasswordCubit.get(context);

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
            ResetPasswordCubit.get(context).otpTimer?.cancel();
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
                      title: AppLocalizations.of(context)!.accountVerification,
                      onPressed: () {
                        resetCubit.otpTimer?.cancel();
                        Navigator.of(context)
                          ..pop()
                          ..pop();
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
                                  resetCubit.confirmForgetPassword(
                                    requestId: widget.requestId,
                                    otp: otpController.text,
                                  );
                                },
                                onChanged: (value) {
                                  resetCubit.onChangeOTPButtonDisable(value);
                                },
                                onSubmitted: (value) async {
                                  FocusNode().unfocus();
                                  resetCubit.confirmForgetPassword(
                                    requestId: widget.requestId,
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
                                    isDisabled: resetCubit.isOTPButtonDisabled,
                                    text: AppLocalizations.of(context)!.confirm,
                                    itemCallBack: () {
                                      FocusNode().unfocus();
                                      resetCubit.confirmForgetPassword(
                                        requestId: widget.requestId,
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
                                            resetCubit
                                                .resendOtp(widget.requestId);
                                          }
                                        : () {},
                                    text: buttonText!,
                                    isDisabled:
                                        resetCubit.isResendOTPButtonDisabled,
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
