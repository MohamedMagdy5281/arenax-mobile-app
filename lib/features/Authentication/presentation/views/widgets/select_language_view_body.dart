import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_auto_complete_drop_down.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_data_cubit/assign_user_data_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_data_cubit/assign_user_data_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/choose_hobbies_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_register_stepper.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_title_with_description.dart';

class SelectLanguageViewBody extends StatefulWidget {
  final String gender;
  final DateTime dateOfBirth;
  const SelectLanguageViewBody(
      {super.key, required this.gender, required this.dateOfBirth});

  @override
  State<SelectLanguageViewBody> createState() => _SelectLanguageViewBodyState();
}

class _SelectLanguageViewBodyState extends State<SelectLanguageViewBody> {
  GlobalKey<FormState> selectLanguageFormKey = GlobalKey();
  bool isLoading = false;
  bool isLanguageLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssignUserDataCubit, AssignUserDataState>(
        listener: (context, state) {
      if (state is StartLoadingAssignUserDetailsState) {
        isLoading = true;
      } else {
        isLoading = false;
      }

      if (state is StartLoadingGetLanguagesState) {
        isLanguageLoading = true;
      } else {
        isLanguageLoading = false;
      }

      if (state is AssignUserDetailsSuccessState) {
        globals.navigatorKey.currentState!.pushNamed(ChooseHobbiesView.id);
      } else if (state is AssignUserDetailsFailureState) {
        successFailureAlert(
          context,
          isError: true,
          message: state.errorMessage,
        );
      }
    }, builder: (context, state) {
      final assignUserDataCubit = AssignUserDataCubit.get(context);
      return isLanguageLoading == true
          ? Center(child: CustomLoadingIndicator())
          : Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: AppLocalizations.of(context)!.determineNativeLang,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Form(
                          key: selectLanguageFormKey,
                          child: Column(
                            children: [
                              CustomRegisterStepper(
                                firstStepColor: kBorderColor,
                                secondStepColor: kBorderColor,
                                thirdStepColor: kBorderColor,
                              ),
                              CustomTitleWithDescription(
                                title: AppLocalizations.of(context)!
                                    .whatNativeLang,
                                description: AppLocalizations.of(context)!
                                    .nativeLangDesc,
                              ),
                              // LanguageAutoCompleteDropDown(
                              //   validator: (data) {
                              //     if (data == "" ||
                              //         assignUserDataCubit
                              //                 .languagesSelectedIndex ==
                              //             null) {
                              //       return AppLocalizations.of(context)!
                              //           .pleaseSelectLang;
                              //     } else {
                              //       return null;
                              //     }
                              //   },
                              //   options: assignUserDataCubit.languages,
                              //   selectedValue: assignUserDataCubit.languageTag,
                              //   onChanged: (val) async {
                              //     assignUserDataCubit.updateLanguageTag(val);
                              //     // assignUserDataCubit.onChangeLanguageButtonDisable(assignUserDataCubit.languageController.text);
                              //   },
                              //   textFieldOnChanged: (p0) {
                              //     assignUserDataCubit.languagesSelectedIndex =
                              //         null;
                              //   },
                              //   title: AppLocalizations.of(context)!.language,
                              //   controller:
                              //       assignUserDataCubit.languageController,
                              //   focusNode:
                              //       assignUserDataCubit.languagesFocusNode,
                              //   selectedIndex:
                              //       assignUserDataCubit.languagesSelectedIndex,
                              //   showOptions:
                              //       assignUserDataCubit.languagesShowOptions,
                              //   onSelected:
                              //       assignUserDataCubit.onNewLanguageSelect,
                              //   toggleList: () => assignUserDataCubit
                              //       .languageToggleAutoCompleteList(),
                              //   setShowOptions: (bool value) =>
                              //       assignUserDataCubit
                              //           .setLanguagesShowOptions(value),
                              //   onTap: () => assignUserDataCubit
                              //       .languageToggleAutoCompleteList(),
                              //   clearField: () {
                              //     assignUserDataCubit.languageController.text =
                              //         "";
                              //     assignUserDataCubit.languagesSelectedIndex =
                              //         null;
                              //     // assignUserDataCubit.onChangeLanguageButtonDisable(assignUserDataCubit.languageController.text);
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  isLoading == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(child: CustomLoadingIndicator()),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 32),
                          child: CustomButton(
                            // isDisabled: assignUserDataCubit.isLanguageButtonDisabled,
                            text: AppLocalizations.of(context)!.continueLabel,
                            itemCallBack: () {
                              if (selectLanguageFormKey.currentState!
                                  .validate()) {
                                /***AssignUserData***/
                                assignUserDataCubit.assignUserDetails(
                                  langaugeId: assignUserDataCubit
                                      .languages[assignUserDataCubit
                                          .languagesSelectedIndex!]
                                      .id
                                      .toString(),
                                  genderType: widget.gender == 'male' ? 1 : 2,
                                  dateOfBirth: widget.dateOfBirth,
                                );
                              }
                              // print(assignUserDataCubit.languages[assignUserDataCubit.languagesSelectedIndex!].name);
                            },
                            icon: globals.appLang == 'en'
                                ? Iconsax.arrow_right_14
                                : Iconsax.arrow_left4,
                          ),
                        ),
                ],
              ),
            );
    });
  }
}
