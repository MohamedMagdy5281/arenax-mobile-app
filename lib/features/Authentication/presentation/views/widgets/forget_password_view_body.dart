import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/utils/assets.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/styles.dart';
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/core/widgets/mobile_prefix_field.dart';
import 'package:praktika_clone_app/core/widgets/text_form_field_with_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/features/Authentication/presentation/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/reset_password_cubit/reset_password_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/forget_password_create_password_view.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey();
  TextEditingController userNameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {},
      builder: (context, state) {
        final resetPasswordCubit = ResetPasswordCubit.get(context);
        return Stack(
          children: [
            Image.asset(AssetsData.pageBg),
            SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    title: AppLocalizations.of(context)!.resetPassword,
                  ),
                  InfoItem(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: forgetPasswordFormKey,
                      child: Column(
                        children: [
                          TextFormFieldWithFloatingTitle(
                            validator: (data) {
                              if (data == null || data.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .cantBeEmpty;
                              }
                              final englishNumberRegex = RegExp(r'^[0-9]+$');
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            controller: userNameController,
                            title: AppLocalizations.of(context)!.phoneNumber,
                            placeholder:
                                AppLocalizations.of(context)!.enterPhone,
                            prefixWidget: MobilePrefixField(),
                            inputType: TextInputType.number,
                          ),
                          const SizedBox(height: 32),
                          isLoading == true
                              ? Center(child: CustomLoadingIndicator())
                              : CustomButton(
                                  text: AppLocalizations.of(context)!
                                      .continueLabel,
                                  itemCallBack: () {
                                    if (forgetPasswordFormKey.currentState!
                                        .validate()) {
                                      globals.navigatorKey.currentState!
                                          .pushNamed(
                                              ForgetPasswordCreatePasswordView
                                                  .id,
                                              arguments: {
                                            'phoneNumber': userNameController
                                                        .text.length ==
                                                    9
                                                ? "0${userNameController.text}"
                                                : userNameController.text
                                          });
                                      //  resetPasswordCubit.forgetPassword(
                                      //    email: userNameController.text,
                                      //  );
                                    }
                                  },
                                  icon: globals.appLang == 'en'
                                      ? Iconsax.arrow_right_14
                                      : Iconsax.arrow_left4,
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
      },
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kLightBlueColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: kDarkBlackColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.enterPhoneToResetPassword,
              style: Styles.textStyle16,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
