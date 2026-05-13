import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/core/widgets/error_paging_items.dart';
import 'package:praktika_clone_app/core/widgets/hobbies_elements_details.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/select_main_goal_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_register_stepper.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_title_with_description.dart';
import '../../manager/assign_user_interest_cubit/assign_user_interest_cubit.dart';
import '../../manager/assign_user_interest_cubit/assign_user_interest_state.dart';

class ChooseHobbiesViewBody extends StatefulWidget {
  const ChooseHobbiesViewBody(
      {super.key});

  @override
  State<ChooseHobbiesViewBody> createState() => _ChooseHobbiesViewBodyState();
}

class _ChooseHobbiesViewBodyState extends State<ChooseHobbiesViewBody> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssignUserInterestCubit, AssignUserInterestState>(
        listener: (context, state) {
          if(state is StartLoadingAssignUserInterest){
            isLoading = true;
          }else{
            isLoading = false;
          }

          if(state is AssignUserInterestSuccessState){
            globals.navigatorKey.currentState!
                .pushNamed(SelectMainGoalView.id);
          }
          else if(state is AssignUserInterestFailureState){
            successFailureAlert(
              context,
              isError: true,
              message: state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          final assignUserInterestCubit = AssignUserInterestCubit.get(context);
          return Container(
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
                  title: AppLocalizations.of(context)!.choosingHobbies,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomRegisterStepper(
                    firstStepColor: kBorderColor,
                    secondStepColor: kBorderColor,
                    thirdStepColor: kBorderColor,
                    fourthStepColor: kBorderColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTitleWithDescription(
                    title: AppLocalizations.of(context)!.whatHobbies,
                    description:
                    AppLocalizations.of(context)!.hobbiesDesc,
                  ),
                ),
                const SizedBox(height: 0),
                Expanded(
                  child: PagedGridView<int, api_client.GetPaginatedInterestResponse?>(
                    pagingController: assignUserInterestCubit.getInterestPagingController,
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<
                        api_client.GetPaginatedInterestResponse?>(
                      firstPageErrorIndicatorBuilder: (context) {
                        return ErrorLoadingItem(
                          onTap: () {
                            assignUserInterestCubit.getInterestPagingController.refresh();
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
                        return HobbiesElementsDetails(
                          imageUrl: item?.iconId != null
                              ? '${CasheHelper.openAttachmentUrl}${item!.iconId}'
                              : 'https://media.istockphoto.com/id/901634176/vector/vector-target-and-arrow.jpg?s=612x612&w=0&k=20&c=PkNvEyMPZ9-p39U4IZfbzOgIF9lb6A-YnG-USGrrER8=',
                          id: item!.id!,
                          label: globals.appLang == 'ar' ? item.nameAr! : item.nameEn!,
                          onTap: () => assignUserInterestCubit.changeHobbyChoice(item.id!),
                          isSelected: assignUserInterestCubit.selectedHobbies.contains(item.id!),
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
                    isDisabled: assignUserInterestCubit.selectedHobbies.isEmpty,
                    text: AppLocalizations.of(context)!.continueLabel,
                    itemCallBack: () {
                      assignUserInterestCubit.assignUserInterest(interests: assignUserInterestCubit.selectedHobbies);
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
