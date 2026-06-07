import 'package:arenax_mobile_app/core/utils/functions/password_validator.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/core/widgets/text_form_field_with_title.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/resetPasswordOtpVerificationRiverpod/reset_password_otp_verification_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';

class ResetPasswordOtpVerificationViewBody extends ConsumerStatefulWidget {
  const ResetPasswordOtpVerificationViewBody(
      {super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  ConsumerState<ResetPasswordOtpVerificationViewBody> createState() =>
      _ResetPasswordOtpVerificationViewBodyState();
}

class _ResetPasswordOtpVerificationViewBodyState
    extends ConsumerState<ResetPasswordOtpVerificationViewBody> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> otpFormKey = GlobalKey();

  String password = "";

  Color _getStrengthColor(int index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.amber;
      case 3:
        return Colors.lightGreen;
      case 4:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getPasswordHint(
    BuildContext context,
    PasswordValidation validation,
  ) {
    final strength = validation.score <= 2
        ? AppLocalizations.of(context)!.weak
        : validation.score <= 4
            ? AppLocalizations.of(context)!.medium
            : AppLocalizations.of(context)!.strong;

    if (!validation.hasMinLength) {
      return "$strength — ${AppLocalizations.of(context)!.addMoreChar}";
    }

    if (!validation.hasUppercase) {
      return "$strength — ${AppLocalizations.of(context)!.addCapitalLetter}";
    }

    if (!validation.hasLowercase) {
      return "$strength — ${AppLocalizations.of(context)!.addLowercaseLetter}";
    }

    if (!validation.hasNumber) {
      return "$strength — ${AppLocalizations.of(context)!.addNumber}";
    }

    if (!validation.hasSpecialChar) {
      return "$strength —  ${AppLocalizations.of(context)!.addSpecialChar}";
    }

    return AppLocalizations.of(context)!.strong;
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    newPasswordController.addListener(() {
      setState(() {
        password = newPasswordController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    final state = ref.watch(resetPasswordOtpVerificationNotifierProvider);
    final notifier =
        ref.read(resetPasswordOtpVerificationNotifierProvider.notifier);

    final validation = validatePassword(password);

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
                      CustomHeader(
                        title: "",
                        optionalPrefixIcon: globals.appLang == "en"
                            ? _arrowLeft(colors)
                            : _arrowRight(colors),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          AppLocalizations.of(context)!.resetYourPassword,
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
                              AppLocalizations.of(context)!.codeSentTo,
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: otpFormKey,
                          child: Column(
                            children: [
                              Center(
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
                                      border: Border.all(
                                          color: colors.kPrimaryColor),
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
                                      border:
                                          Border.all(color: colors.kHintColor),
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                              ),
                              const SizedBox(height: 30),
                              TextFormFieldWithTitle(
                                controller: newPasswordController,
                                title:
                                    AppLocalizations.of(context)!.newPassword,
                                placeholder: AppLocalizations.of(context)!
                                    .enterNewPassword,
                                obscureText: !state.showPassword,
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
                                        style: Styles.textStyle14(context)
                                            .copyWith(
                                          color: colors.kTextMutedColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                validator: (String? pass) {
                                  final value = pass ?? "";

                                  if (value.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .cantBeEmpty;
                                  }

                                  if (value.contains(" ")) {
                                    return AppLocalizations.of(context)!
                                        .thisFieldCantContainSpaces;
                                  }

                                  if (!validation.isValid) {
                                    return AppLocalizations.of(context)!
                                        .fieldIsNotValid;
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      height: 4,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: index < validation.score
                                            ? _getStrengthColor(index)
                                            : colors.kDisabledButtonColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _getPasswordHint(context, validation),
                                style: Styles.textStyle12(context).copyWith(
                                  color:
                                      _getPasswordHint(context, validation) ==
                                                  "Strong" ||
                                              _getPasswordHint(
                                                      context, validation) ==
                                                  "قوي"
                                          ? Colors.green
                                          : colors.kTextMutedColor,
                                ),
                              ),
                              const SizedBox(height: 18),
                              TextFormFieldWithTitle(
                                controller: confirmPasswordController,
                                title: AppLocalizations.of(context)!
                                    .confirmPassword,
                                placeholder: AppLocalizations.of(context)!
                                    .enterConfirmPassword,
                                obscureText: !state.showConfirmPassword,
                                suffix: GestureDetector(
                                  onTap: () {
                                    notifier.toggleConfirmShowPassword();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Center(
                                      child: Text(
                                        globals.appLang == "ar"
                                            ? state.showConfirmPassword
                                                ? "إخفاء"
                                                : "إظهار"
                                            : state.showConfirmPassword
                                                ? "HIDE"
                                                : "SHOW",
                                        style: Styles.textStyle14(context)
                                            .copyWith(
                                          color: colors.kTextMutedColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                validator: (String? pass) {
                                  final value = pass ?? "";

                                  if (value.contains(" ")) {
                                    return AppLocalizations.of(context)!
                                        .thisFieldCantContainSpaces;
                                  }

                                  if (value.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .confirmPassNotMatchingPass;
                                  }

                                  if (value != newPasswordController.text) {
                                    return AppLocalizations.of(context)!
                                        .confirmPassNotMatchingPass;
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),

        // ================= BOTTOM BUTTON =================
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: state.isResetPasswordButtonLoading
                ? const CustomLoadingIndicator()
                : CustomButton(
                    text: AppLocalizations.of(context)!.saveAndSignIn,
                    itemCallBack: () {
                      if (otpFormKey.currentState!.validate()) {}
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
          Iconsax.arrow_right_2,
          color: colors.kTextColor,
          size: 12,
        ),
      );
}
