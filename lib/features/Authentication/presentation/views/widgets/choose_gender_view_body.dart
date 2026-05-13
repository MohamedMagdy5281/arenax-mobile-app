import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_data_cubit/assign_user_data_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_data_cubit/assign_user_data_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/determine_age_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_register_stepper.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_title_with_description.dart';

class ChooseGenderViewBody extends StatefulWidget {
  const ChooseGenderViewBody(
      {super.key});

  @override
  State<ChooseGenderViewBody> createState() => _ChooseGenderViewBodyState();
}

class _ChooseGenderViewBodyState extends State<ChooseGenderViewBody> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    List<SelectButtonModel> genderItems = [
      SelectButtonModel(
          text: AppLocalizations.of(context)!.male,
          id: 'male',
          selectedLeading: Icon(Iconsax.man, color: kWhiteColor),
          unselectedLeading: Icon(Iconsax.man)),
      SelectButtonModel(
          text: AppLocalizations.of(context)!.female,
          id: 'female',
          selectedLeading: Icon(Iconsax.woman, color: kWhiteColor),
          unselectedLeading: Icon(Iconsax.woman)),
    ];
    return BlocConsumer<AssignUserDataCubit, AssignUserDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          final assignUserDataCubit = AssignUserDataCubit.get(context);
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: AppLocalizations.of(context)!.choosingGender,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CustomRegisterStepper(
                        firstStepColor: kBorderColor,
                      ),
                      CustomTitleWithDescription(
                        title: AppLocalizations.of(context)!.chooseYourGender,
                        description:
                            AppLocalizations.of(context)!.specifyYourGender,
                      ),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: genderItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: CustomSelectedButton(
                              text: genderItems[index].text!,
                              isSelected: selectedItem == genderItems[index].id,
                              itemCallBack: () {
                                setState(() {
                                  selectedItem = genderItems[index].id!;
                                });
                              },
                              unselectedLeading:
                                  genderItems[index].unselectedLeading,
                              selectedLeading:
                                  genderItems[index].selectedLeading,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    text: AppLocalizations.of(context)!.continueLabel,
                    isDisabled: selectedItem == null ? true : false,
                    itemCallBack: () {
                      globals.navigatorKey.currentState!
                          .pushNamed(DetermineAgeView.id,arguments: {
                            'gender' : selectedItem,
                      });
                    },
                    icon: globals.appLang == 'en'
                        ? Iconsax.arrow_right_14
                        : Iconsax.arrow_left4,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        });
  }
}

class SelectButtonModel {
  final String? text;
  final String? id;
  final Widget? selectedLeading;
  final Widget? unselectedLeading;

  SelectButtonModel(
      {this.selectedLeading, this.unselectedLeading, this.text, this.id});
}
