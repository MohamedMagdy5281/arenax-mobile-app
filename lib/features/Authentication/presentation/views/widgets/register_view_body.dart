import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_phone_text_field_with_no_country_change.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/registerRiverpod/register_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/mobile_number_already_exists_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/otp_verification_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class RegisterViewBody extends ConsumerStatefulWidget {
  const RegisterViewBody({super.key});

  @override
  ConsumerState<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends ConsumerState<RegisterViewBody> {
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
    final state = ref.watch(registerNotifierProvider);
    final notifier = ref.read(registerNotifierProvider.notifier);
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return Stack(
      children: [
        // Image.asset(AssetsData.pageBg),
        state.isPageLoading
            ? Container(
                color: colors.kInfoTextColor,
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
                                        : Iconsax.arrow_right_3,
                                    color: colors.kTextColor,
                                    size: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                AppLocalizations.of(context)!.enterPhone,
                                style: Styles.textStyle22(context).copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: colors.kTextColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                AppLocalizations.of(context)!.weWillSendDigits,
                                style: Styles.textStyle14(context).copyWith(
                                  color: colors.kTextMutedColor,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Form(
                                key: loginFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomPhoneTextFieldWithNoCountryChange(
                                      controller: phoneNumberController,
                                      title: AppLocalizations.of(context)!
                                          .phoneNumber,
                                      placeholder: AppLocalizations.of(context)!
                                          .enterPhone,
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      AppLocalizations.of(context)!
                                          .egyptionsOnly,
                                      style:
                                          Styles.textStyle12(context).copyWith(
                                        color: colors.kTextMutedColor,
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    // checkbox here (same as before)
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Transform.translate(
                                          offset: const Offset(-4,
                                              0), // aligns checkbox with text field edge
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                value: state
                                                    .termsAndPrivacyChecked,
                                                checkColor: colors.kTextColor,
                                                activeColor:
                                                    colors.kPrimaryColor,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                visualDensity:
                                                    const VisualDensity(
                                                  horizontal: VisualDensity
                                                      .minimumDensity,
                                                  vertical: VisualDensity
                                                      .minimumDensity,
                                                ),
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
                                                      .read(
                                                          registerNotifierProvider
                                                              .notifier)
                                                      .toggleTermsAndPrivacyChecked();
                                                },
                                              ),
                                              state.checkBoxError
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 12.0),
                                                      child: Text("*",
                                                          style: Styles
                                                                  .textStyle12(
                                                                      context)
                                                              .copyWith(
                                                                  color: colors
                                                                      .kErrorColor)),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 4),
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
                          bottom: 16,
                        ),
                        child: state.isLoginButtonLoading
                            ? const CustomLoadingIndicator()
                            : CustomButton(
                                text: AppLocalizations.of(context)!.sendCode,
                                itemCallBack: () {
                                  if (loginFormKey.currentState!.validate() &&
                                      state.termsAndPrivacyChecked == true) {
                                    // globals.navigatorKey.currentState!
                                    //     .pushNamed(
                                    //   MobileNumberAlreadyExistsView.id,
                                    // );
                                    globals.navigatorKey.currentState!
                                        .pushNamed(OtpVerificationView.id,
                                            arguments: {
                                          "phoneNumber":
                                              "+20${phoneNumberController.text.trim()}",
                                        });
                                  } else if (state.termsAndPrivacyChecked ==
                                      false) {
                                    notifier.showCheckBoxError();
                                  } else if (state.termsAndPrivacyChecked ==
                                      true) {
                                    notifier.hideCheckBoxError();
                                  }
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
