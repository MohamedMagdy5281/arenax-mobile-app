import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/utils/assets.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:praktika_clone_app/core/widgets/custom_header.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/core/widgets/text_form_field_with_title.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/first_last_name_assign_cubit/first_last_name_assign_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/first_last_name_assign_cubit/first_last_name_assign_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/app_loader_after_login_view.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstLastNameAssignViewBody extends StatefulWidget {
  const FirstLastNameAssignViewBody({super.key});

  @override
  State<FirstLastNameAssignViewBody> createState() =>
      _FirstLastNameAssignViewBodyState();
}

class _FirstLastNameAssignViewBodyState
    extends State<FirstLastNameAssignViewBody> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final _editProfileKey = GlobalKey<FormState>();
  bool isLoading = true;
  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FirstLastNameAssignCubit, FirstLastNameAssignState>(
        listener: (context, state) {
      if (state is StartLoadingUpdateUserData) {
        isUpdating = true;
      } else if (state is StopLoadingUpdateUserData) {
        isUpdating = false;
      }

      if (state is UpdateUserDataSuccess) {
        globals.navigatorKey.currentState!.pushNamedAndRemoveUntil(
          AppLoaderAfterLoginView.id,
          (route) => false,
        );
      } else if (state is UpdateUserDataFailure) {
        successFailureAlert(
          context,
          isError: true,
          message: AppLocalizations.of(context)!.unexpectedErrorOccured,
        );
      }
    }, builder: (context, state) {
      final firstLastNameAssignCubit = FirstLastNameAssignCubit.get(context);
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomHeader(title: AppLocalizations.of(context)!.editProfile),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              top: 0,
                              child: Image.asset(
                                AssetsData.pageBg,
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                              ),
                            ),
                            isLoading
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .35,
                                      ),
                                      Center(
                                        child: CustomLoadingIndicator(),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      children: [
                                        Form(
                                          key: _editProfileKey,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 52,
                                              ),
                                              TextFormFieldWithFloatingTitle(
                                                validator: (data) {
                                                  if (data == null ||
                                                      data.trim().isEmpty) {
                                                    return AppLocalizations.of(
                                                            context)!
                                                        .cantBeEmpty;
                                                  } else if (data
                                                          .trim()
                                                          .length <
                                                      2) {
                                                    return AppLocalizations.of(
                                                            context)!
                                                        .nameValidation;
                                                  } else if (!RegExp(
                                                          r'^[a-zA-Z]+$')
                                                      .hasMatch(data)) {
                                                    return AppLocalizations.of(
                                                            context)!
                                                        .onlyLettersAllowed;
                                                  }
                                                  return null;
                                                },
                                                prefix: Icon(
                                                  Iconsax.user,
                                                  size: 20,
                                                ),
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .firstname,
                                                controller:
                                                    _firstNameController,
                                                disabled:
                                                    true, // This disables focusing on tap
                                                suffix: Icon(Iconsax.edit),
                                                focusNode: FocusNode(),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              TextFormFieldWithFloatingTitle(
                                                validator: (data) {
                                                  if (data == null ||
                                                      data.trim().isEmpty) {
                                                    return AppLocalizations.of(
                                                            context)!
                                                        .cantBeEmpty;
                                                  } else if (data
                                                          .trim()
                                                          .length <
                                                      2) {
                                                    return AppLocalizations.of(
                                                            context)!
                                                        .nameValidation;
                                                  } else if (!RegExp(
                                                          r'^[a-zA-Z]+$')
                                                      .hasMatch(data)) {
                                                    return AppLocalizations.of(
                                                            context)!
                                                        .onlyLettersAllowed;
                                                  }
                                                  return null;
                                                },
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .lastName,
                                                prefix: Icon(
                                                  Iconsax.user,
                                                  size: 20,
                                                ),
                                                controller: _lastNameController,
                                                disabled:
                                                    true, // This disables focusing on tap
                                                suffix: Icon(Iconsax.edit),
                                                focusNode: FocusNode(),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Fixed Bottom Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      isUpdating
                          ? Center(
                              child: CustomLoadingIndicator(),
                            )
                          : CustomButton(
                              text: AppLocalizations.of(context)!.save,
                              itemCallBack: () async {
                                if (_editProfileKey.currentState!.validate()) {
                                  // await editProfileCubit.updateUserData(
                                  //   _firstNameController.text,
                                  //   _lastNameController.text,
                                  //   DateFormat('d-M-yyyy')
                                  //       .parse(_dateOfBirthController.text),
                                  // );
                                }
                              },
                              isDisabled: false,
                            ),
                      const SizedBox(height: 55),
                    ],
                  ),
                ),
              ]));
    });
  }
}
