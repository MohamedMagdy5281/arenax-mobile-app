import 'package:arenax_mobile_app/features/Authentication/presentation/manager/loginRiverpod/login_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/registerRiverpod/register_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/login_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/otp_verification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/core/widgets/text_form_field_with_title.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class RegisterViewBody extends ConsumerStatefulWidget {
  const RegisterViewBody({super.key});

  @override
  ConsumerState<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends ConsumerState<RegisterViewBody> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  String? countryCodeChoose;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerNotifierProvider);
    final notifier = ref.read(registerNotifierProvider.notifier);
    return Stack(
      children: [
        // Image.asset(AssetsData.pageBg),
        state.isPageLoading
            ? Center(
                child: CustomLoadingIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHeader(
                      title: AppLocalizations.of(context)!.signIn,
                      optionalPrefixIcon: globals.appLang == "en"
                          ? Iconsax.arrow_left_2
                          : Iconsax.arrow_right_2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                        AppLocalizations.of(context)!.giveCreadential,
                        style: Styles.textStyle14.copyWith(
                            fontWeight: FontWeight.w500, color: kGrey3Color),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: loginFormKey,
                        child: Column(
                          children: [
                            TextFormFieldWithNoTitle(
                              inputType: TextInputType.text,
                              controller: fullNameController,
                              placeholder:
                                  AppLocalizations.of(context)!.enterFullNamme,
                              // prefixWidget: MobilePrefixField(),
                              prefix: Icon(
                                Icons.person_outline,
                                size: 24,
                                color: kGrey3Color,
                              ),
                              validator: (data) {
                                if (data!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .cantBeEmpty;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormFieldWithNoTitle(
                              inputType: TextInputType.emailAddress,
                              controller: emailController,
                              placeholder:
                                  AppLocalizations.of(context)!.enterEmail,
                              // prefixWidget: MobilePrefixField(),
                              prefix: Icon(
                                Icons.email_outlined,
                                size: 24,
                                color: kGrey3Color,
                              ),
                              validator: (data) {
                                if (data!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .cantBeEmpty;
                                } else {
                                  return null;
                                }
                              },
                              // validator: (data) {
                              // if (data == null || data.isEmpty) {
                              //   return AppLocalizations.of(context)!
                              //       .cantBeEmpty;
                              // }
                              // final englishNumberRegex = RegExp(r'^[0-9]+$');
                              // if (!englishNumberRegex.hasMatch(data)) {
                              //   return AppLocalizations.of(context)!
                              //       .mobileValidateMsg;
                              // }
                              // if (data.length == 10) {
                              //   if (!(data.startsWith("051") ||
                              //       data.startsWith("052") ||
                              //       data.startsWith("05"))) {
                              //     return AppLocalizations.of(context)!
                              //         .mobileValidateMsg;
                              //   }
                              // } else if (data.length == 9) {
                              //   if (!(data.startsWith("51") ||
                              //       data.startsWith("52") ||
                              //       data.startsWith("5"))) {
                              //     return AppLocalizations.of(context)!
                              //         .mobileValidateMsg;
                              //   }
                              // } else {
                              //   return AppLocalizations.of(context)!
                              //       .mobileValidateMsg;
                              // }
                              // return null;
                              // },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormFieldWithNoTitle(
                              validator: (data) {
                                if (data!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .cantBeEmpty;
                                } else {
                                  return null;
                                }
                              },
                              controller: passwordController,
                              placeholder:
                                  AppLocalizations.of(context)!.enterPassword,
                              obscureText: state.isPasswordVisible,
                              prefix: Icon(
                                Iconsax.lock,
                                size: 24,
                                color: kGrey3Color,
                              ),
                              suffix: GestureDetector(
                                onTap: () {
                                  notifier.togglePasswordVisibility();
                                },
                                child: Icon(
                                  state.isPasswordVisible
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye,
                                  color: kGrey3Color,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormFieldWithNoTitle(
                              validator: (data) {
                                if (data!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .cantBeEmpty;
                                } else {
                                  return null;
                                }
                              },
                              controller: confirmPasswordController,
                              placeholder: AppLocalizations.of(context)!
                                  .enterConfirmPassword,
                              obscureText: state.isConfirmPasswordVisible,
                              prefix: Icon(
                                Iconsax.lock,
                                size: 24,
                                color: kGrey3Color,
                              ),
                              suffix: GestureDetector(
                                onTap: () {
                                  notifier.toggleConfirmPasswordVisibility();
                                },
                                child: Icon(
                                  state.isConfirmPasswordVisible
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye,
                                  color: kGrey3Color,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const SizedBox(
                              height: 52,
                            ),
                            state.isRegisterButtonLoading == true
                                ? Center(child: CustomLoadingIndicator())
                                : Column(
                                    children: [
                                      CustomButton(
                                        text: AppLocalizations.of(context)!
                                            .signUp,
                                        itemCallBack: () async {
                                          if (loginFormKey.currentState!
                                              .validate()) {
                                            globals.navigatorKey.currentState!
                                                .pushNamed(
                                                    OtpVerificationView.id);
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .alreadyHaveAccount,
                                            style: Styles.textStyle14,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              ref.invalidate(
                                                  loginNotifierProvider);
                                              globals.navigatorKey.currentState!
                                                  .pushNamed(LoginView.id);
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .signIn,
                                              style: Styles.textStyle14
                                                  .copyWith(
                                                      color: kPrimaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 55),
                  ],
                ),
              ),
      ],
    );
  }
}
