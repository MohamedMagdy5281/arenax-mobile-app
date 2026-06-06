import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:arenax_mobile_app/core/widgets/custom_mobile_text_field_with_country.dart';
import 'package:arenax_mobile_app/core/widgets/custom_phone_text_field_with_no_country_change.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/loginRiverpod/login_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/forget_password_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/register_view.dart';
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
  // TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  String? countryCodeChoose;

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
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
                              CustomHeader(
                                title: "",
                                optionalPrefixIcon: Container(
                                  decoration: BoxDecoration(
                                    color: colors.kSurfaceColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 38,
                                  height: 38,
                                  child: Icon(
                                    globals.appLang == "en"
                                        ? Iconsax.arrow_left_2
                                        : Iconsax.arrow_right_2,
                                    color: colors.kTextColor,
                                    size: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  AppLocalizations.of(context)!.enterPhone,
                                  style: Styles.textStyle22(context).copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: colors.kTextColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .weWillSendDigits,
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
                                          horizontal: 16.0),
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

                                    const SizedBox(height: 8),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .egyptionsOnly,
                                        style: Styles.textStyle12(context)
                                            .copyWith(
                                          color: colors.kTextMutedColor,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    // checkbox here (same as before)
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: state.termsAndPrivacyChecked,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          side: BorderSide(
                                            color: colors.kHintColor,
                                            width: 1.5,
                                          ),
                                          onChanged: (_) {
                                            ref
                                                .read(loginNotifierProvider
                                                    .notifier)
                                                .toggleTermsAndPrivacyChecked();
                                          },
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              style: Styles.textStyle14(context)
                                                  .copyWith(
                                                color: colors.kTextMutedColor,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: globals.appLang == "en"
                                                      ? "I Agree on ArenaX's "
                                                      : "أوافق على ",
                                                ),
                                                TextSpan(
                                                  text: globals.appLang == "en"
                                                      ? "Terms "
                                                      : "شروط وأحكام ",
                                                  style: TextStyle(
                                                    color: colors.kPrimaryColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: globals.appLang == "en"
                                                      ? "and "
                                                      : "و",
                                                ),
                                                TextSpan(
                                                  text: globals.appLang == "en"
                                                      ? "Privacy Policy"
                                                      : "سياسة الخصوصية",
                                                  style: TextStyle(
                                                    color: colors.kPrimaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 🔥 THIS PUSHES BUTTON TO BOTTOM
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
                        child: state.isLoginButtonLoading
                            ? const CustomLoadingIndicator()
                            : CustomButton(
                                text: AppLocalizations.of(context)!.sendCode,
                                itemCallBack: () {
                                  if (loginFormKey.currentState!.validate()) {}
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
