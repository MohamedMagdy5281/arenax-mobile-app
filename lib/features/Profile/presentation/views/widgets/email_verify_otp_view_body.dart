import 'dart:io';

import 'package:arenax_mobile_app/core/utils/cashe_helper.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/otpVerificationRiverpod/otp_verification_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/create_password_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/register_view.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/manager/emailVerifyOtpRiverpod/email_verify_otp_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';

class EmailVerifyOtpViewBody extends ConsumerStatefulWidget {
  const EmailVerifyOtpViewBody(
      {super.key,
      required this.phoneNumber,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.profilePic});

  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final File? profilePic;

  @override
  ConsumerState<EmailVerifyOtpViewBody> createState() =>
      _EmailVerifyOtpViewBodyState();
}

class _EmailVerifyOtpViewBodyState
    extends ConsumerState<EmailVerifyOtpViewBody> {
  final GlobalKey<FormState> otpFormKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(emailVerifyOtpNotifierProvider.notifier).startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    final state = ref.watch(emailVerifyOtpNotifierProvider);
    final notifier = ref.read(emailVerifyOtpNotifierProvider.notifier);

    final isFinished = state.otpRemainingTime == 0;

    return Column(
      children: [
        // ================= TOP CONTENT =================
        Expanded(
          child: state.isPageLoading
              ? const Center(child: CustomLoadingIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomHeader(
                            title:
                                AppLocalizations.of(context)!.verifyYourEmail,
                            onPrefixIconTap: () {
                              globals.navigatorKey.currentState!.pop();
                            },
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
                            )),
                      ),
                      const SizedBox(height: 28),
                      Center(
                        child: Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                              color: colors.kPrimaryDarkColor,
                              borderRadius: BorderRadius.circular(24)),
                          child: Icon(
                            Icons.mail_outline,
                            color: colors.kPrimaryColor,
                            size: 32,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            AppLocalizations.of(context)!.enterCode,
                            style: Styles.textStyle22(context).copyWith(
                              fontWeight: FontWeight.w900,
                              color: colors.kTextColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.sentTo,
                              style: Styles.textStyle14(context).copyWith(
                                color: colors.kTextMutedColor,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${widget.email}.",
                              style: Styles.textStyle16(context).copyWith(
                                color: colors.kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: otpFormKey,
                          child: Center(
                            child: Pinput(
                              autofocus: true,
                              length: 6,
                              defaultPinTheme: PinTheme(
                                width: 35,
                                height: 50,
                                textStyle: Styles.textStyle18(context)
                                    .copyWith(color: colors.kTextColor),
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: colors.kDisabledButtonColor),
                                ),
                              ),
                              submittedPinTheme: PinTheme(
                                width: 35,
                                height: 50,
                                textStyle: Styles.textStyle18(context)
                                    .copyWith(color: colors.kTextColor),
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: colors.kPrimaryColor),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 40,
                                height: 50,
                                textStyle: Styles.textStyle18(context)
                                    .copyWith(color: colors.kTextColor),
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: colors.kHintColor),
                                ),
                              ),
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 0,
                                    height: 0,
                                    color: colors.kHintColor,
                                  ),
                                ],
                              ),
                              errorPinTheme: PinTheme(
                                width: 35,
                                height: 50,
                                textStyle: Styles.textStyle18(context)
                                    .copyWith(color: colors.kPrimaryColor),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.red),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 6) {
                                  notifier.setOtpCode(value);
                                }
                              },
                              onSubmitted: (value) {
                                if (value.length == 6) {
                                  notifier.setOtpCode(value);
                                  CasheHelper.selectedImage = widget.profilePic;
                                  globals.userDetails.firstName =
                                      widget.firstName;
                                  globals.userDetails.lastName =
                                      widget.lastName;
                                  globals.userDetails.email = widget.email;
                                  globals.userEmailVerified = true;
                                  globals.navigatorKey.currentState!
                                      .pushNamed(ProfileView.id);
                                }
                              },
                              onCompleted: (value) {
                                notifier.setOtpCode(value);

                                CasheHelper.selectedImage = widget.profilePic;
                                globals.userDetails.firstName =
                                    widget.firstName;
                                globals.userDetails.lastName = widget.lastName;
                                globals.userDetails.email = widget.email;
                                globals.userEmailVerified = true;

                                globals.navigatorKey.currentState!
                                    .pushNamed(ProfileView.id);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                            child: state.isVerifyButtonLoading
                                ? const CustomLoadingIndicator()
                                : isFinished
                                    ? GestureDetector(
                                        onTap: () {
                                          notifier.startTimer();
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .resendCode,
                                          style: Styles.textStyle16(context)
                                              .copyWith(
                                            color: colors.kTextColor,
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .resendCodeIn,
                                            style: Styles.textStyle14(context)
                                                .copyWith(
                                              color: colors.kTextMutedColor,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            notifier.formatTime(
                                                state.otpRemainingTime),
                                            style: Styles.textStyle16(context)
                                                .copyWith(
                                              color: colors.kTextColor,
                                            ),
                                          ),
                                        ],
                                      )),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
        ),

        // ================= BOTTOM BUTTON =================
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: state.isVerifyButtonLoading
                ? const CustomLoadingIndicator()
                : CustomButton(
                    text: AppLocalizations.of(context)!.verifyEmail,
                    itemCallBack: () {
                      if (otpFormKey.currentState!.validate()) {
                        CasheHelper.selectedImage = widget.profilePic;
                        globals.userDetails.firstName = widget.firstName;
                        globals.userDetails.lastName = widget.lastName;
                        globals.userDetails.email = widget.email;
                        globals.userEmailVerified = true;
                        globals.navigatorKey.currentState!
                            .pushNamed(ProfileView.id);
                      }
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Widget _arrowLeft(AppColors colors) => Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: colors.kSurfaceColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Iconsax.arrow_left_2,
          color: colors.kTextColor,
          size: 12,
        ),
      );

  Widget _arrowRight(AppColors colors) => Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: colors.kSurfaceColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Iconsax.arrow_right_3,
          color: colors.kTextColor,
          size: 12,
        ),
      );
}
