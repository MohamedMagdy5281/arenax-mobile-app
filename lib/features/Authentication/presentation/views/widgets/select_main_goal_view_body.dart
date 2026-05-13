import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/utils/styles.dart';
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/core/widgets/error_paging_items.dart';
import 'package:praktika_clone_app/core/widgets/main_goals_element.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_main_goal_cubit/assign_main_goal_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_main_goal_cubit/assign_main_goal_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/choose_accent_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_register_stepper.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;

class SelectMainGoalViewBody extends StatefulWidget {
  const SelectMainGoalViewBody(
      {super.key});


  @override
  State<SelectMainGoalViewBody> createState() => _SelectMainGoalViewBodyState();
}

class _SelectMainGoalViewBodyState extends State<SelectMainGoalViewBody> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssignMainGoalCubit, AssignMainGoalState>(
        listener: (context, state) {
          if(state is StartLoadingAssignMainGoalState){
            isLoading = true;
          }else{
            isLoading = false;
          }

          if(state is AssignMainGoalSuccessState){
            globals.navigatorKey.currentState!
                .pushNamed(ChooseAccentView.id);
          }
          else if(state is AssignMainGoalFailureState){
            successFailureAlert(
              context,
              isError: true,
              message: state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          final assignMainGoalCubit = AssignMainGoalCubit.get(context);
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                  title: AppLocalizations.of(context)!.determineGoal,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomRegisterStepper(
                    firstStepColor: kBorderColor,
                    secondStepColor: kBorderColor,
                    thirdStepColor: kBorderColor,
                    fourthStepColor: kBorderColor,
                    fifthStepColor: kBorderColor,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.whatYourGoalDesc,
                  textAlign: TextAlign.center,
                  style: Styles.textStyle24,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: PagedListView<int, api_client.GetPaginatedMainGoalResponse?>(
                    pagingController: assignMainGoalCubit.getMainGoalPagingController,
                    builderDelegate: PagedChildBuilderDelegate<
                        api_client.GetPaginatedMainGoalResponse?>(
                      firstPageErrorIndicatorBuilder: (context) {
                        return ErrorLoadingItem(
                          onTap: () {
                            assignMainGoalCubit.getMainGoalPagingController
                                .refresh();
                          },
                          failedText: AppLocalizations.of(context)!.failedToLoad,
                        );
                      },
                      noItemsFoundIndicatorBuilder: (context) {
                        return NoItemsWidget(
                          text: AppLocalizations.of(context)!.noThingToDisplay,
                        );
                      },
                      itemBuilder: (context, item, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                          child: MainGoalsElement(
                            imageUrl: item?.iconId != null
                                ? '${CasheHelper.openAttachmentUrl}${item!.iconId}'
                                : 'https://media.istockphoto.com/id/901634176/vector/vector-target-and-arrow.jpg?s=612x612&w=0&k=20&c=PkNvEyMPZ9-p39U4IZfbzOgIF9lb6A-YnG-USGrrER8=',
                            index: item!.id!,
                            label: globals.appLang == 'ar' ? item.nameAr! : item.nameEn!,
                            onTap: () => assignMainGoalCubit.changeGoalChoice(item.id!),
                            selectedIndex: assignMainGoalCubit.currentGoal,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                isLoading == true
                    ? Center(child: CustomLoadingIndicator())
                    : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: CustomButton(
                    isDisabled:
                        assignMainGoalCubit.currentGoal == null ? true : false,
                    text: AppLocalizations.of(context)!.continueLabel,
                    itemCallBack: () {
                      assignMainGoalCubit.assignMainGoal(
                        mainGoalId: assignMainGoalCubit.currentGoal.toString(),
                      );
                    },
                    icon: globals.appLang == 'en'
                        ? Iconsax.arrow_right_14
                        : Iconsax.arrow_left4,
                  ),
                ),
                const SizedBox(height: 55),
              ],
            ),
          );
        });
  }
}
