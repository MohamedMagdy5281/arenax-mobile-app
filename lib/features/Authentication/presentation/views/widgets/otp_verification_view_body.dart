import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/otpVerificationRiverpod/otp_verification_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/interests_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationViewBody extends ConsumerStatefulWidget {
  const OtpVerificationViewBody({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  ConsumerState<OtpVerificationViewBody> createState() =>
      _OtpVerificationViewBodyState();
}

class _OtpVerificationViewBodyState
    extends ConsumerState<OtpVerificationViewBody> {
  GlobalKey<FormState> otpFormKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(otpVerificationNotifierProvider.notifier).startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    final state = ref.watch(otpVerificationNotifierProvider);
    final notifier = ref.read(otpVerificationNotifierProvider.notifier);

    final isFinished = state.otpRemainingTime == 0;

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
                      title: AppLocalizations.of(context)!.verification,
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        AppLocalizations.of(context)!.sendCode,
                        style: Styles.textStyle22(context).copyWith(
                          fontWeight: FontWeight.w900,
                          color: colors.kTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.weSentItToYou,
                            style: Styles.textStyle14(context).copyWith(
                              color: colors.kTextMutedColor,
                            ),
                          ),
                          Text(
                            "${widget.phoneNumber}.",
                            style: Styles.textStyle16(context).copyWith(
                              color: colors.kTextColor,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              globals.navigatorKey.currentState!.pop();
                              globals.navigatorKey.currentState!
                                  .pushReplacementNamed(RegisterView.id);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.changeNumber,
                              style: Styles.textStyle16(context).copyWith(
                                color: colors.kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: otpFormKey,
                        child: Column(
                          children: [
                            Pinput(
                              autofocus: true,
                              length: 4,
                              defaultPinTheme: PinTheme(
                                width: 54,
                                height: 54,
                                textStyle: Styles.textStyle18(context)
                                    .copyWith(color: colors.kTextColor),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: colors.kDisabledButtonColor),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 54,
                                height: 54,
                                textStyle: Styles.textStyle18(context)
                                    .copyWith(color: colors.kTextColor),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: colors.kPrimaryColor),
                                ),
                              ),
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 22,
                                    height: 2,
                                    color: colors.kPrimaryColor,
                                  ),
                                ],
                              ),
                              errorPinTheme: PinTheme(
                                width: 54,
                                height: 54,
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
                                if (value.length == 4) {
                                  notifier.setOtpCode(value);
                                }
                              },
                              onSubmitted: (value) {
                                if (value.length == 4) {
                                  notifier.setOtpCode(value);
                                }
                              },
                            ),
                            const SizedBox(
                              height: 52,
                            ),
                            state.isVerifyButtonLoading == true
                                ? Center(child: CustomLoadingIndicator())
                                : Column(
                                    children: [
                                      CustomButton(
                                        text: AppLocalizations.of(context)!
                                            .continueText,
                                        itemCallBack: () async {
                                          if (otpFormKey.currentState!
                                              .validate()) {
                                            globals.navigatorKey.currentState!
                                                .pushNamed(InterestsView.id);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      isFinished
                                          ? GestureDetector(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .resendCode,
                                                style:
                                                    Styles.textStyle14(context)
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: colors
                                                                .kPrimaryColor),
                                              ),
                                              onTap: () {
                                                notifier.setResendButtonLoading(
                                                    true);
                                                notifier.setResendButtonLoading(
                                                    false);
                                                notifier.startTimer();
                                              },
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .resendCodeIn,
                                                  style: Styles.textStyle14(
                                                          context)
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: colors
                                                              .kTextMutedColor),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                    notifier.formatTime(
                                                        state.otpRemainingTime),
                                                    style: Styles.textStyle14(
                                                            context)
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: colors
                                                                .kPrimaryColor)),
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
