import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/utils/assets.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/core/widgets/mobile_prefix_field.dart';
import 'package:praktika_clone_app/core/widgets/text_form_field_with_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/register_cubit/register_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/register_cubit/register_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/create_password_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/login_view.dart';
import 'dart:io';

import 'package:praktika_clone_app/features/Authentication/presentation/views/otp_view.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey();
  bool isLoading = false;

  String? domainErrorMessage;

  Future<void> _checkEmailDomain(String email) async {
    final domain = email.split('@').last;
    if (!await isValidDomain(domain)) {
      setState(() {
        domainErrorMessage = AppLocalizations.of(context)!.enterValidEmail;
      });
    } else {
      setState(() {
        domainErrorMessage = null; // Clear the error if the domain is valid
      });
    }
    // Trigger form validation manually after domain validation
    registerFormKey.currentState!.validate();
  }

  Future<bool> isValidDomain(String domain) async {
    try {
      // Perform a DNS lookup to check if the domain resolves to an IP address
      final result = await InternetAddress.lookup(domain);
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
      if (state is StartLoadingRegisterState) {
        isLoading = true;
      } else if (state is StopLoadingRegisterState) {
        isLoading = false;
      }

      if (state is RegisterSuccessState) {
        globals.navigatorKey.currentState!
            .pushNamed(CreatePasswordView.id, arguments: {
          'firstName': firstNameController.text,
          "lastName": lastNameController.text,
          "email": emailController.text,
          "phone": phoneController.text
        });
      } else if (state is RegisterFailureState) {
        successFailureAlert(
          context,
          isError: true,
          message: state.errorMessage,
        );
      }
    }, builder: (context, state) {
      final registerCubit = RegisterCubit.get(context);
      return Stack(
        children: [
          Image.asset(AssetsData.pageBg),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: AppLocalizations.of(context)!.signForNewAcc,
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: registerFormKey,
                    child: Column(
                      children: [
                        TextFormFieldWithFloatingTitle(
                          inputType: TextInputType.number,
                          controller: phoneController,
                          title: AppLocalizations.of(context)!.phoneNumber,
                          placeholder: AppLocalizations.of(context)!.enterPhone,
                          prefixWidget: MobilePrefixField(),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (data) {
                            if (data!.isEmpty) {
                              return AppLocalizations.of(context)!.cantBeEmpty;
                            }
                            final englishNumberRegex = RegExp(r'^[0-9]+$');
                            if (!englishNumberRegex.hasMatch(data)) {
                              return AppLocalizations.of(context)!
                                  .mobileValidateMsg;
                            }
                            if (!RegExp(r'^\d+$').hasMatch(data.trim())) {
                              return AppLocalizations.of(context)!
                                  .mobileValidation;
                            }
                            if (data.length == 10) {
                              if (!(data.startsWith("051") ||
                                  data.startsWith("052") ||
                                  data.startsWith("05"))) {
                                return AppLocalizations.of(context)!
                                    .mobileValidateMsg;
                              }
                            } else if (data.length == 9) {
                              if (!(data.startsWith("51") ||
                                  data.startsWith("52") ||
                                  data.startsWith("5"))) {
                                return AppLocalizations.of(context)!
                                    .mobileValidateMsg;
                              }
                            } else {
                              return AppLocalizations.of(context)!
                                  .mobileValidateMsg;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormFieldWithFloatingTitle(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return AppLocalizations.of(context)!.cantBeEmpty;
                            }
                            final emailRegex = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (!emailRegex.hasMatch(data)) {
                              return AppLocalizations.of(context)!
                                  .enterValidEmail;
                            }
                            return null;
                            // return domainErrorMessage;
                          },
                          controller: emailController,
                          title: AppLocalizations.of(context)!.email,
                          placeholder: AppLocalizations.of(context)!.enterEmail,
                          prefix: Icon(Iconsax.sms),
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormFieldWithFloatingTitle(
                          validator: (data) {
                            if (data == null || data.trim().isEmpty) {
                              return AppLocalizations.of(context)!.cantBeEmpty;
                            } else if (data.trim().length < 2) {
                              return AppLocalizations.of(context)!
                                  .nameValidation;
                            } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(data)) {
                              return AppLocalizations.of(context)!
                                  .onlyLettersAllowed;
                            }
                            return null;
                          },
                          controller: firstNameController,
                          title: AppLocalizations.of(context)!.firstName,
                          placeholder:
                              AppLocalizations.of(context)!.enterFirstName,
                          prefix: Icon(Iconsax.user),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormFieldWithFloatingTitle(
                          validator: (data) {
                            if (data == null || data.trim().isEmpty) {
                              return AppLocalizations.of(context)!.cantBeEmpty;
                            } else if (data.trim().length < 2) {
                              return AppLocalizations.of(context)!
                                  .nameValidation;
                            } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(data)) {
                              return AppLocalizations.of(context)!
                                  .onlyLettersAllowed;
                            }
                            return null;
                          },
                          controller: lastNameController,
                          title: AppLocalizations.of(context)!.lastName,
                          placeholder:
                              AppLocalizations.of(context)!.enterLastName,
                          prefix: Icon(Iconsax.user),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        isLoading == true
                            ? Center(child: CustomLoadingIndicator())
                            : CustomButton(
                                text:
                                    AppLocalizations.of(context)!.continueLabel,
                                itemCallBack: () async {
                                  // await _checkEmailDomain(emailController.text);
                                  if (registerFormKey.currentState!
                                      .validate()) {
                                    globals.navigatorKey.currentState!
                                        .pushNamed(CreatePasswordView.id,
                                            arguments: {
                                          'firstName': firstNameController.text,
                                          "lastName": lastNameController.text,
                                          "email": emailController.text,
                                          "phone":
                                              phoneController.text.length == 9
                                                  ? "0${phoneController.text}"
                                                  : phoneController.text
                                        });
                                  }
                                },
                                icon: globals.appLang == 'en'
                                    ? Iconsax.arrow_right_14
                                    : Iconsax.arrow_left4,
                              ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomButtonWithShadow(
                          text: AppLocalizations.of(context)!.login,
                          backgroundColor: kWhiteColor,
                          textColor: kDarkBlackColor,
                          borderColor: Colors.transparent,
                          itemCallBack: () {
                            globals.navigatorKey.currentState!
                                .pushReplacementNamed(LoginView.id);
                          },
                          icon: Iconsax.login,
                          iconColor: kDarkBlackColor,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
