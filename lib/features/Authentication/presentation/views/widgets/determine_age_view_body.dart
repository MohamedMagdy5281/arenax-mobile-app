import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/widgets/date_time_picker_text_field.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_data_cubit/assign_user_data_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_data_cubit/assign_user_data_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/select_language_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_register_stepper.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_title_with_description.dart';

class DetermineAgeViewBody extends StatefulWidget {
  final String gender;
  const DetermineAgeViewBody(
      {super.key, required this.gender});

  @override
  State<DetermineAgeViewBody> createState() => _DetermineAgeViewBodyState();
}

class _DetermineAgeViewBodyState extends State<DetermineAgeViewBody> {
  TextEditingController dateOfBirthController = TextEditingController();
  GlobalKey<FormState> ageFormKey = GlobalKey();

  @override
  void dispose() {
    dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssignUserDataCubit, AssignUserDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Form(
              key: ageFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: AppLocalizations.of(context)!.determineAge,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        CustomRegisterStepper(
                          firstStepColor: kBorderColor,
                          secondStepColor: kBorderColor,
                        ),
                        CustomTitleWithDescription(
                          title: AppLocalizations.of(context)!.howOldQues,
                          description:
                              AppLocalizations.of(context)!.specifyYourAge,
                        ),
                        DateTimePickerTextField(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .cantBeEmpty;
                            } else {
                              return null;
                            }
                          },
                          controller: dateOfBirthController,
                          placeholder:
                          AppLocalizations.of(context)!.enterDateOfBirth,
                          title: AppLocalizations.of(context)!.dateOfBirth,
                          prefix: Icon(
                            Iconsax.user,
                            size: 20,
                          ),
                          suffix: Icon(Iconsax.calendar_1),
                          focusNode: FocusNode(),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomButton(
                      text: AppLocalizations.of(context)!.continueLabel,
                      itemCallBack: () {
                        if (ageFormKey.currentState!.validate()) {
                          globals.navigatorKey.currentState!
                              .pushNamed(SelectLanguageView.id,arguments: {
                                'gender':widget.gender,
                                'dateOfBirth': DateFormat('dd MMM yyyy').parse(dateOfBirthController.text),
                          });
                        }
                      },
                      icon: globals.appLang == 'en'
                          ? Iconsax.arrow_right_14
                          : Iconsax.arrow_left4,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        });
  }
}
