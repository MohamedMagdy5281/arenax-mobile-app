import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/utils/assets.dart';
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/styles.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/core/widgets/language_drop_down.dart';
import 'package:praktika_clone_app/core/widgets/mobile_prefix_field.dart';
import 'package:praktika_clone_app/core/widgets/text_form_field_with_title.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/login_cubit/login_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/features/Authentication/presentation/views/app_loader_after_login_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/forget_password_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/register_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/check_box_with_text.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/home_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/supscriptioin_view.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController mobileNumberController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  bool isLoading = false;
  bool isPageLoading = true;
  String? countryCodeChoose;

  @override
  void dispose() {
    mobileNumberController.dispose();
    // passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is ShowUpdateNeededDialog) {
        globals.showUpdateDialog(context, state.updateUrl!);
      }
      if (state is StartLoadingLoginPage) {
        isPageLoading = true;
      } else if (state is StopLoadingLoginPage) {
        isPageLoading = false;
      }

      if (state is StartLoadingLoginState) {
        isLoading = true;
      } else if (state is StopLoadingLoginState) {
        isLoading = false;
      }
      if (state is LoginSuccessState) {
        globals.navigatorKey.currentState!.pushNamed(
          AppLoaderAfterLoginView.id,
        );
      } else if (state is LoginFailureState) {
        successFailureAlert(
          context,
          isError: true,
          message: state.errorMessage,
        );
      }

      if (state is GetMobileNumberAndPass) {
        mobileNumberController.text = state.mobile ?? "";
      }
    }, builder: (context, state) {
      final loginCubit = LoginCubit.get(context);
      return Stack(
        children: [
          Image.asset(AssetsData.pageBg),
          isPageLoading
              ? Center(
                  child: CustomLoadingIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 48,
                          bottom: 48,
                        ),
                        child: LanguageDropDown(),
                      ),
                      Center(
                        child: SvgPicture.asset(
                          AssetsData.appLogo,
                          width: 228,
                          height: 180,
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: loginFormKey,
                          child: Column(
                            children: [
                              TextFormFieldWithFloatingTitle(
                                inputType: TextInputType.number,
                                controller: mobileNumberController,
                                title:
                                    AppLocalizations.of(context)!.phoneNumber,
                                placeholder:
                                    AppLocalizations.of(context)!.enterPhone,
                                prefixWidget: MobilePrefixField(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                validator: (data) {
                                  if (data == null || data.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .cantBeEmpty;
                                  }
                                  final englishNumberRegex =
                                      RegExp(r'^[0-9]+$');
                                  if (!englishNumberRegex.hasMatch(data)) {
                                    return AppLocalizations.of(context)!
                                        .mobileValidateMsg;
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
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // TextFormFieldWithFloatingTitle(
                              //   validator: (data) {
                              //     if (data!.isEmpty) {
                              //       return AppLocalizations.of(context)!
                              //           .cantBeEmpty;
                              //     } else {
                              //       return null;
                              //     }
                              //   },
                              //   controller: passwordController,
                              //   title: AppLocalizations.of(context)!.password,
                              //   placeholder:
                              //       AppLocalizations.of(context)!.enterPassword,
                              //   obscureText: loginCubit.isLoginPasswordShown,
                              //   prefix: Icon(
                              //     Iconsax.lock,
                              //     size: 24,
                              //   ),
                              //   suffix: GestureDetector(
                              //     onTap: () {
                              //       loginCubit.changeLoginPasswordVisibility();
                              //     },
                              //     child: Icon(
                              //       loginCubit.loginPasswordVisible,
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Expanded(
                                    child: CustomCheckboxWithText(
                                      initialValue: loginCubit.rememberCheckBox,
                                      onChanged: (bool? value) {
                                        loginCubit
                                            .changeRememberCheckBox(value!);
                                      },
                                      text: AppLocalizations.of(context)!
                                          .rememberMe,
                                    ),
                                  ),
                                  // InkWell(
                                  //   borderRadius: BorderRadius.circular(20),
                                  //   onTap: () {
                                  //     globals.navigatorKey.currentState!
                                  //         .pushNamed(ForgetPasswordView.id);
                                  //   },
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(4),
                                  //     child: Text(
                                  //       AppLocalizations.of(context)!
                                  //           .forgotPassword,
                                  //       style: Styles.textStyle14,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              isLoading == true
                                  ? Center(child: CustomLoadingIndicator())
                                  : CustomButton(
                                      text: AppLocalizations.of(context)!.login,
                                      itemCallBack: () async {
                                        if (loginFormKey.currentState!
                                            .validate()) {
                                          await loginCubit.loginUser(
                                              mobileNumber: mobileNumberController
                                                          .text.length ==
                                                      10
                                                  ? mobileNumberController.text
                                                  : "0${mobileNumberController.text}",
                                              password: ""
                                              // password: passwordController.text,
                                              );
                                        }
                                      },
                                      icon: Iconsax.login,
                                    ),
                              // SizedBox(
                              //   height: 16,
                              // ),
                              // CustomButton(
                              //   text:
                              //       AppLocalizations.of(context)!.signForNewAcc,
                              //   backgroundColor: kSideBG,
                              //   textColor: kDarkBlackColor,
                              //   borderColor: Colors.transparent,
                              //   itemCallBack: () {
                              //     globals.navigatorKey.currentState!
                              //         .pushNamed(RegisterView.id);
                              //   },
                              //   icon: Iconsax.login,
                              //   iconColor: kDarkBlackColor,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 12),
                              //   child: Text(
                              //     AppLocalizations.of(context)!.or,
                              //     style: Styles.textStyle16,
                              //   ),
                              // ),
                              // CustomButton(
                              //   text: AppLocalizations.of(context)!.loginWithGmail,
                              //   backgroundColor: kSideBG,
                              //   textColor: kDarkBlackColor,
                              //   borderColor: Colors.transparent,
                              //   itemCallBack: () {},
                              //   previousIcon: SvgPicture.asset(
                              //     AssetsData.googleIcon,
                              //     height: 25,
                              //     width: 25,
                              //   ),
                              // ),
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
    });
  }
}
