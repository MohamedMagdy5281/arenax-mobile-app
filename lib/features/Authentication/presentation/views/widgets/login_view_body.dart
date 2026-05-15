import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:arenax_mobile_app/core/widgets/custom_radio_button.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/loginRiverpod/login_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/cashe_helper.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/functions/success_failure_alert.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/core/widgets/language_drop_down.dart';
import 'package:arenax_mobile_app/core/widgets/mobile_prefix_field.dart';
import 'package:arenax_mobile_app/core/widgets/text_form_field_with_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class LoginViewBody extends ConsumerStatefulWidget {
  const LoginViewBody({super.key});

  @override
  ConsumerState<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends ConsumerState<LoginViewBody> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  String? countryCodeChoose;

  @override
  void dispose() {
    mobileNumberController.dispose();
    // passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginNotifierProvider);
    final notifier = ref.read(loginNotifierProvider.notifier);
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
                      title: "Sign In",
                      optionalPrefixIcon: globals.appLang == "en"
                          ? Iconsax.arrow_left_2
                          : Iconsax.arrow_right_2,
                      onPrefixIconTap: () {},
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                        "Give creadential to sign in your account",
                        style: Styles.textStyle14.copyWith(
                            fontWeight: FontWeight.w500, color: kGrey2Color),
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
                              inputType: TextInputType.emailAddress,
                              controller: mobileNumberController,
                              placeholder:
                                  AppLocalizations.of(context)!.enterEmail,
                              // prefixWidget: MobilePrefixField(),
                              prefix: Icon(
                                Icons.email_outlined,
                                size: 24,
                              ),
                              validator: (data) {
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
                              },
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
                              ),
                              suffix: GestureDetector(
                                onTap: () {
                                  notifier.togglePasswordVisibility();
                                },
                                child: Icon(
                                  state.isPasswordVisible
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Switch(
                                          value: state.isRememberMeChecked,
                                          onChanged: (value) {
                                            notifier.toggleRememberMe();
                                          },
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .rememberMe,
                                        style: Styles.textStyle12,
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // globals.navigatorKey.currentState!
                                    //     .pushNamed(ForgetPasswordView.id);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .forgotPassword,
                                        style: Styles.textStyle14.copyWith(
                                          color: kPrimaryColor,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            state.isLoginButtonLoading == true
                                ? Center(child: CustomLoadingIndicator())
                                : CustomButton(
                                    text: AppLocalizations.of(context)!.login,
                                    itemCallBack: () async {
                                      if (loginFormKey.currentState!
                                          .validate()) {}
                                    },
                                    icon: Iconsax.login,
                                  ),
                            // SizedBox(
                            //   height: 16,
                            // ),
                            // CustomButton(
                            //   text:
                            //       AppLocalizations.of(context)!.signForNewAcc,
                            //   backgroundColor: kSideBG,
                            //   textColor: kDarkBlackColor,
                            //   borderColor: Colors.transparent,
                            //   itemCallBack: () {
                            //     globals.navigatorKey.currentState!
                            //         .pushNamed(RegisterView.id);
                            //   },
                            //   icon: Iconsax.login,
                            //   iconColor: kDarkBlackColor,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 12),
                            //   child: Text(
                            //     AppLocalizations.of(context)!.or,
                            //     style: Styles.textStyle16,
                            //   ),
                            // ),
                            // CustomButton(
                            //   text: AppLocalizations.of(context)!.loginWithGmail,
                            //   backgroundColor: kSideBG,
                            //   textColor: kDarkBlackColor,
                            //   borderColor: Colors.transparent,
                            //   itemCallBack: () {},
                            //   previousIcon: SvgPicture.asset(
                            //     AssetsData.googleIcon,
                            //     height: 25,
                            //     width: 25,
                            //   ),
                            // ),
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
