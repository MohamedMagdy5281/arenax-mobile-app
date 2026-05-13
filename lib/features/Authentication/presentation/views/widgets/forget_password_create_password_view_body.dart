import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/utils/assets.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/utils/styles.dart';
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/core/widgets/password_info_bottom_sheet.dart';
import 'package:praktika_clone_app/core/widgets/text_form_field_with_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/reset_password_cubit/reset_password_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/forget_password_otp_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/otp_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/home_view.dart';

class ForgetPasswordCreatePasswordViewBody extends StatefulWidget {
  final String phoneNumber;

  const ForgetPasswordCreatePasswordViewBody({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<ForgetPasswordCreatePasswordViewBody> createState() =>
      _ForgetPasswordCreatePasswordViewBodyState();
}

class _ForgetPasswordCreatePasswordViewBodyState
    extends State<ForgetPasswordCreatePasswordViewBody> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> createPasswordFormKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
      if (state is StartLoadingInitForgetPassword) {
        isLoading = true;
      } else if (state is StopLoadingInitForgetPassword) {
        isLoading = false;
      }

      if (state is InitForgetPasswordSuccess) {
        globals.navigatorKey.currentState!
            .pushNamed(ForgetPasswordOtpView.id, arguments: {
          'requestId': state.requestId,
        });
      } else if (state is InitForgetPasswordFailures) {
        successFailureAlert(
          context,
          isError: true,
          message: state.errorMessage ?? "",
        );
      }
    }, builder: (context, state) {
      final resetPasswordCubit = ResetPasswordCubit.get(context);
      return Stack(
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
                    title: AppLocalizations.of(context)!.createPassword,
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: createPasswordFormKey,
                      child: Column(
                        children: [
                          TextFormFieldWithFloatingTitle(
                            onChanged: (String? password) {
                              resetPasswordCubit
                                  .onChangeCreatePasswordButtonDisable(
                                      password, confirmPasswordController.text);

                              // change arabic numbers to english
                              final converted = globals
                                  .convertArabicNumbersToEnglish(password!);
                              if (password != converted) {
                                final cursorPosition =
                                    passwordController.selection;
                                passwordController.value = TextEditingValue(
                                  text: converted,
                                  selection: cursorPosition,
                                );
                              }
                            },
                            validator: (data) {
                              if (data!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .cantBeEmpty;
                              } else if (RegExp(r'[\u0600-\u06FF]')
                                  .hasMatch(data)) {
                                return AppLocalizations.of(context)!
                                    .passwordNoArabic;
                              } else if (data.length < 6) {
                                return AppLocalizations.of(context)!
                                    .passwordLengthShort;
                              } else if (!data.contains(RegExp(r'[^\w\s]'))) {
                                return AppLocalizations.of(context)!
                                    .passwordMustHaveNonAlphanumeric;
                              } else if (!data.contains(RegExp(r'\d'))) {
                                return AppLocalizations.of(context)!
                                    .passwordMustHaveDigit;
                              } else if (!data.contains(RegExp(r'[A-Z]'))) {
                                return AppLocalizations.of(context)!
                                    .passwordMustHaveUppercase;
                              } else if (!data.contains(RegExp(r'[a-z]'))) {
                                return AppLocalizations.of(context)!
                                    .passwordMustHaveLowercase;
                              }
                              return null;
                            },
                            controller: passwordController,
                            title: AppLocalizations.of(context)!.password,
                            placeholder:
                                AppLocalizations.of(context)!.enterPassword,
                            prefix: Icon(Iconsax.lock),
                            obscureText:
                                resetPasswordCubit.isForgetPasswordShown,
                            suffix: GestureDetector(
                              onTap: () {
                                resetPasswordCubit
                                    .changeRegisterPasswordVisibility();
                              },
                              child: Icon(
                                resetPasswordCubit.registerPasswordVisible,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormFieldWithFloatingTitle(
                            onChanged: (String? confirmPassword) {
                              resetPasswordCubit
                                  .onChangeCreatePasswordButtonDisable(
                                      passwordController.text, confirmPassword);

                              // change arabic numbers to english
                              final converted =
                                  globals.convertArabicNumbersToEnglish(
                                      confirmPassword!);
                              if (confirmPassword != converted) {
                                final cursorPosition =
                                    confirmPasswordController.selection;
                                confirmPasswordController.value =
                                    TextEditingValue(
                                  text: converted,
                                  selection: cursorPosition,
                                );
                              }
                            },
                            validator: (data) {
                              if (data == null || data.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .cantBeEmpty;
                              } else if (RegExp(r'[\u0600-\u06FF]')
                                  .hasMatch(data)) {
                                return AppLocalizations.of(context)!
                                    .passwordNoArabic;
                              } else if (data.length < 6) {
                                return AppLocalizations.of(context)!
                                    .passwordLengthShort;
                              } else if (!data.contains(RegExp(r'[^\w\s]'))) {
                                return AppLocalizations.of(context)!
                                    .passwordMustHaveNonAlphanumeric;
                              } else if (!data.contains(RegExp(r'\d'))) {
                                return AppLocalizations.of(context)!
                                    .passwordMustHaveDigit;
                              } else if (!data.contains(RegExp(r'[A-Z]'))) {
                                return AppLocalizations.of(context)!
                                    .passwordMustHaveUppercase;
                              } else if (!data.contains(RegExp(r'[a-z]'))) {
                                return AppLocalizations.of(context)!
                                    .passwordMustHaveLowercase;
                              }
                              return null;
                            },
                            controller: confirmPasswordController,
                            title:
                                AppLocalizations.of(context)!.confirmPassword,
                            placeholder: AppLocalizations.of(context)!
                                .enterConfirmPassword,
                            prefix: Icon(Iconsax.lock),
                            obscureText:
                                resetPasswordCubit.isForgetConfirmPasswordShown,
                            suffix: GestureDetector(
                              onTap: () {
                                resetPasswordCubit
                                    .changeRegisterConfirmPasswordVisibility();
                              },
                              child: Icon(
                                resetPasswordCubit
                                    .registerConfirmPasswordVisible,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return const PasswordInfoBottomSheet();
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Iconsax.info_circle,
                                  color: kHintColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  AppLocalizations.of(context)!
                                      .passwordRulesInfo,
                                  style: Styles.textStyle14.copyWith(
                                    color: kHintColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          isLoading == true
                              ? Center(child: CustomLoadingIndicator())
                              : CustomButton(
                                  text: AppLocalizations.of(context)!.confirm,
                                  isDisabled: resetPasswordCubit
                                      .isCreatePasswordButtonDisabled,
                                  itemCallBack: () {
                                    if (createPasswordFormKey.currentState!
                                        .validate()) {
                                      resetPasswordCubit
                                          .initializeForgetPassword(
                                        phoneNumber: widget.phoneNumber,
                                        newPassword: passwordController.text,
                                      );
                                    }
                                  },
                                  icon: globals.appLang == 'en'
                                      ? Iconsax.arrow_right_14
                                      : Iconsax.arrow_left4,
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
      );
    });
  }
}
