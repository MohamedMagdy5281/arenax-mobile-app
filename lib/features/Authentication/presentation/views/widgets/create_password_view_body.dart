import 'package:arenax_mobile_app/core/utils/functions/password_validator.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/core/widgets/text_form_field_with_title.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/createPasswordRiverpod/create_password_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/enable_face_id_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:iconsax/iconsax.dart';

class CreatePasswordViewBody extends ConsumerStatefulWidget {
  const CreatePasswordViewBody({super.key});

  @override
  ConsumerState<CreatePasswordViewBody> createState() =>
      _CreatePasswordViewBodyState();
}

class _CreatePasswordViewBodyState
    extends ConsumerState<CreatePasswordViewBody> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> createPasswordFormKey = GlobalKey();

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

    return "$strength —  ${AppLocalizations.of(context)!.strong}";
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    passwordController.addListener(() {
      setState(() {
        password = passwordController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createPasswordNotifierProvider);
    final notifier = ref.read(createPasswordNotifierProvider.notifier);
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    final validation = validatePassword(password);
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
                                        : Iconsax.arrow_right_2,
                                    color: colors.kTextColor,
                                    size: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                AppLocalizations.of(context)!.createPassword,
                                style: Styles.textStyle22(context).copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: colors.kTextColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                AppLocalizations.of(context)!
                                    .charactersWithLettersAndNumbers,
                                style: Styles.textStyle14(context).copyWith(
                                  color: colors.kTextMutedColor,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Form(
                                key: createPasswordFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormFieldWithTitle(
                                      controller: passwordController,
                                      title: AppLocalizations.of(context)!
                                          .password,
                                      placeholder: AppLocalizations.of(context)!
                                          .enterPassword,
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
                                      style:
                                          Styles.textStyle12(context).copyWith(
                                        color: _getPasswordHint(
                                                        context, validation) ==
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

                                        if (value != passwordController.text) {
                                          return AppLocalizations.of(context)!
                                              .confirmPassNotMatchingPass;
                                        }

                                        return null;
                                      },
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
                        child: state.isCreatePasswordButtonLoading
                            ? const CustomLoadingIndicator()
                            : CustomButton(
                                text: AppLocalizations.of(context)!.sendCode,
                                itemCallBack: () {
                                  if (createPasswordFormKey.currentState!
                                      .validate()) {
                                    globals.navigatorKey.currentState!
                                        .pushNamed(EnableFaceIdView.id);
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
