import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_phone_text_field_with_no_country_change.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/forgetPasswordRiverpod/forget_password_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/reset_password_otp_verification_view.dart';
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

class ForgetPasswordViewBody extends ConsumerStatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  ConsumerState<ForgetPasswordViewBody> createState() =>
      _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState
    extends ConsumerState<ForgetPasswordViewBody> {
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    final state = ref.watch(forgetPasswordNotifierProvider);
    final notifier = ref.read(forgetPasswordNotifierProvider.notifier);
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
                              Text(
                                AppLocalizations.of(context)!
                                    .forgotYourPassword,
                                style: Styles.textStyle22(context).copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: colors.kTextColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                AppLocalizations.of(context)!
                                    .enterYourPhoneAndWeSendCode,
                                style: Styles.textStyle14(context).copyWith(
                                  color: colors.kTextMutedColor,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Form(
                                key: forgetPasswordFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomPhoneTextFieldWithNoCountryChange(
                                      controller: phoneController,
                                      title: AppLocalizations.of(context)!
                                          .phoneNumber,
                                      placeholder: AppLocalizations.of(context)!
                                          .enterPhone,
                                    ),

                                    // checkbox here (same as before)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 🔥 THIS PUSHES BUTTON TO BOTTOM
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16,
                            ),
                            child: state.isSendButtonLoading
                                ? const CustomLoadingIndicator()
                                : CustomButton(
                                    text:
                                        AppLocalizations.of(context)!.sendCode,
                                    itemCallBack: () {
                                      if (forgetPasswordFormKey.currentState!
                                          .validate()) {
                                        globals.navigatorKey.currentState!
                                            .pushNamed(
                                                ResetPasswordOtpVerificationView
                                                    .id,
                                                arguments: {
                                              "phoneNumber":
                                                  "+20${phoneController.text.trim()}"
                                            });
                                      }
                                    },
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16,
                            ),
                            child: state.isSendButtonLoading
                                ? const CustomLoadingIndicator()
                                : CustomButtonWithNoBG(
                                    text: AppLocalizations.of(context)!.cancel,
                                    itemCallBack: () {
                                      globals.navigatorKey.currentState!.pop();
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
