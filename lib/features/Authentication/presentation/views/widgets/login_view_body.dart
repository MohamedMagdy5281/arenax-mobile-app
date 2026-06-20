import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/functions/password_validator.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:arenax_mobile_app/core/widgets/custom_mobile_text_field_with_country.dart';
import 'package:arenax_mobile_app/core/widgets/custom_phone_text_field_with_no_country_change.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/loginRiverpod/login_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/forget_password_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/register_view.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/core/widgets/text_form_field_with_title.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class LoginViewBody extends ConsumerStatefulWidget {
  const LoginViewBody({super.key});

  @override
  ConsumerState<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends ConsumerState<LoginViewBody> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  String? countryCodeChoose;
  String password = "";

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    final validation = validatePassword(password);
    final state = ref.watch(loginNotifierProvider);
    final notifier = ref.read(loginNotifierProvider.notifier);
    return Stack(
      children: [
        // Image.asset(AssetsData.pageBg),
        state.isPageLoading
            ? Container(
                color: colors.kBackGroundColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: CustomLoadingIndicator(),
                  ),
                ))
            : Container(
                color: colors.kBackGroundColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 52,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    AssetsData.logo,
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Arena",
                                    style: Styles.textStyle20(context)
                                        .copyWith(color: colors.kTextColor),
                                  ),
                                  Text("X",
                                      style: Styles.textStyle20(context)
                                          .copyWith(color: colors.kAccentColor))
                                ],
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  AppLocalizations.of(context)!.welcomeBack,
                                  style: Styles.textStyle22(context).copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: colors.kTextColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .signInToContinue,
                                  style: Styles.textStyle14(context).copyWith(
                                    color: colors.kTextMutedColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Form(
                                key: loginFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child:
                                          CustomPhoneTextFieldWithNoCountryChange(
                                        controller: phoneNumberController,
                                        title: AppLocalizations.of(context)!
                                            .phoneNumber,
                                        placeholder:
                                            AppLocalizations.of(context)!
                                                .enterPhone,
                                      ),
                                    ),

                                    const SizedBox(height: 14),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: TextFormFieldWithTitle(
                                        controller: passwordController,
                                        title: AppLocalizations.of(context)!
                                            .password,
                                        placeholder:
                                            AppLocalizations.of(context)!
                                                .enterPassword,
                                        obscureText: !state.showPassword,
                                        optionalLabelButtonOnTap: () {
                                          globals.navigatorKey.currentState!
                                              .pushNamed(ForgetPasswordView.id);
                                        },
                                        optionalLabelButton: Text(
                                            AppLocalizations.of(context)!
                                                .forgot,
                                            style: Styles.textStyle12(context)
                                                .copyWith(
                                                    color:
                                                        colors.kPrimaryColor)),
                                        suffix: GestureDetector(
                                          onTap: () {
                                            notifier.toggleShowPassword();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Center(
                                              child: Text(
                                                globals.appLang == "ar"
                                                    ? state.showPassword
                                                        ? "إخفاء"
                                                        : "إظهار"
                                                    : state.showPassword
                                                        ? "HIDE"
                                                        : "SHOW",
                                                style:
                                                    Styles.textStyle14(context)
                                                        .copyWith(
                                                  color: colors.kTextMutedColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        validator: (String? pass) {
                                          final value = pass?.trim() ?? "";

                                          if (value.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .cantBeEmpty;
                                          }

                                          if (value.contains(" ")) {
                                            return AppLocalizations.of(context)!
                                                .thisFieldCantContainSpaces;
                                          }

                                          final validation =
                                              validatePassword(value);

                                          if (!validation.isValid) {
                                            return getPasswordHint(validation);
                                          }

                                          return null;
                                        },
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    // checkbox here (same as before)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 🔥 THIS PUSHES BUTTON TO BOTTOM
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: state.isLoginButtonLoading
                            ? const CustomLoadingIndicator()
                            : CustomButton(
                                text: AppLocalizations.of(context)!.login,
                                itemCallBack: () {
                                  if (loginFormKey.currentState!.validate()) {
                                    globals.navigatorKey.currentState!
                                        .pushNamed(ProfileView.id);
                                  }
                                },
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: colors.kDisabledButtonColor,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                AppLocalizations.of(context)!.or,
                                style: Styles.textStyle12(context).copyWith(
                                  color: colors.kTextMutedColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: colors.kDisabledButtonColor,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomButtonWithNoBG(
                            previousIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Image.asset(
                                AssetsData.faceIdIcon,
                                width: 25,
                                height: 25,
                              ),
                            ),
                            text: AppLocalizations.of(context)!.useFaceId,
                            itemCallBack: () {}),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dontHaveAcc,
                            style: Styles.textStyle12(context)
                                .copyWith(color: colors.kTextMutedColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              globals.navigatorKey.currentState!
                                  .pushNamed(RegisterView.id);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signUp,
                              style: Styles.textStyle12(context)
                                  .copyWith(color: colors.kPrimaryColor),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 82,
                      )
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
