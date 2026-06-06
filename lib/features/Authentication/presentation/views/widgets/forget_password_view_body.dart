import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/forgetPasswordRiverpod/forget_password_notifier_provider.dart';
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
  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey();

  @override
  void dispose() {
    emailController.dispose();
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
            ? Center(
                child: CustomLoadingIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHeader(
                      title: AppLocalizations.of(context)!.resetPassword,
                      optionalPrefixIcon: globals.appLang == "en"
                          ? Container(
                              decoration: BoxDecoration(
                                color: colors.kSurfaceColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 38,
                              height: 38,
                              child: Icon(
                                Iconsax.arrow_left_2,
                                color: colors.kTextColor,
                                size: 12,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: colors.kSurfaceColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 38,
                              height: 38,
                              child: Icon(
                                Iconsax.arrow_right_2,
                                color: colors.kTextColor,
                                size: 12,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                        AppLocalizations.of(context)!.enterEmailToResetPassword,
                        style: Styles.textStyle14(context).copyWith(
                            fontWeight: FontWeight.w500,
                            color: colors.kTextMutedColor),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: forgetPasswordFormKey,
                        child: Column(
                          children: [
                            // TextFormFieldWithNoTitle(
                            //   inputType: TextInputType.emailAddress,
                            //   controller: emailController,
                            //   placeholder:
                            //       AppLocalizations.of(context)!.enterEmail,
                            //   // prefixWidget: MobilePrefixField(),
                            //   suffix: Icon(
                            //     Icons.email_outlined,
                            //     size: 24,
                            //     color: kGrey3Color,
                            //   ),
                            //   validator: (data) {
                            //     if (data!.isEmpty) {
                            //       return AppLocalizations.of(context)!
                            //           .cantBeEmpty;
                            //     } else {
                            //       return null;
                            //     }
                            //   },
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
                            // ),
                            const SizedBox(
                              height: 72,
                            ),
                            state.isSendButtonLoading == true
                                ? Center(child: CustomLoadingIndicator())
                                : Column(
                                    children: [
                                      CustomButton(
                                        text:
                                            AppLocalizations.of(context)!.send,
                                        itemCallBack: () async {
                                          if (forgetPasswordFormKey
                                              .currentState!
                                              .validate()) {}
                                        },
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
