import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/otpVerificationRiverpod/otp_verification_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationViewBody extends ConsumerStatefulWidget {
  const OtpVerificationViewBody({super.key});

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
                          ? Iconsax.arrow_left_2
                          : Iconsax.arrow_right_2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .weSentConfirmationCode,
                            style: Styles.textStyle14.copyWith(
                                fontWeight: FontWeight.w500,
                                color: kGrey3Color),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "+20 1234567890",
                            style: Styles.textStyle14.copyWith(
                                fontWeight: FontWeight.w500,
                                color: kSoftDarkishColor),
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
                                textStyle: Styles.textStyle18
                                    .copyWith(color: kSoftDarkishColor),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: kGreyColor),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 54,
                                height: 54,
                                textStyle: Styles.textStyle18
                                    .copyWith(color: kSoftDarkishColor),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: kPrimaryColor),
                                ),
                              ),
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 22,
                                    height: 2,
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                              errorPinTheme: PinTheme(
                                width: 54,
                                height: 54,
                                textStyle: Styles.textStyle18
                                    .copyWith(color: kPrimaryColor),
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
                                              .validate()) {}
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
                                                style: Styles.textStyle14
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: kPrimaryColor),
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
                                                  style: Styles.textStyle14
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: kGrey3Color),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                    notifier.formatTime(
                                                        state.otpRemainingTime),
                                                    style: Styles.textStyle14
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                kPrimaryColor)),
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
