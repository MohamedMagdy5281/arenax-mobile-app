import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/functions/success_failure_alert.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/widgets/custom_app_bar.dart';
import 'package:praktika_clone_app/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/core/widgets/error_paging_items.dart';
import 'package:praktika_clone_app/core/widgets/preferred_accent_elements.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_target_accent_cubit/assign_target_accent_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_target_accent_cubit/assign_target_accent_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_register_stepper.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/custom_title_with_description.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/features/Home/presentaion/views/home_view.dart';

class ChooseAccentViewBody extends StatefulWidget {
  const ChooseAccentViewBody({super.key});

  @override
  State<ChooseAccentViewBody> createState() => _ChooseAccentViewBodyState();
}

class _ChooseAccentViewBodyState extends State<ChooseAccentViewBody> {
  bool isLoading = false;
  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssignTargetAccentCubit, AssignTargetAccentState>(
        listener: (context, state) {
      if (state is StartLoadingAssignTargetAccentState) {
        isLoading = true;
      } else {
        isLoading = false;
      }

      if (state is AssignTargetAccentSuccessState) {
        globals.navigatorKey.currentState!.pushNamed(HomeView.id);
      } else if (state is AssignTargetAccentFailureState) {
        successFailureAlert(
          context,
          isError: true,
          message: state.errorMessage,
        );
      }
    }, builder: (context, state) {
      final assignTargetAccentCubit = AssignTargetAccentCubit.get(context);
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
              title: AppLocalizations.of(context)!.chooseAccent,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomRegisterStepper(
                firstStepColor: kBorderColor,
                secondStepColor: kBorderColor,
                thirdStepColor: kBorderColor,
                fourthStepColor: kBorderColor,
                fifthStepColor: kBorderColor,
                sixthStepColor: kBorderColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTitleWithDescription(
                title: AppLocalizations.of(context)!.whichAccent,
                description: AppLocalizations.of(context)!.accentDesc,
              ),
            ),
            Expanded(
              child: PagedListView<int, api_client.GetPaginatedAccentResponse?>(
                pagingController:
                    assignTargetAccentCubit.getAccentPagingController,
                builderDelegate: PagedChildBuilderDelegate<
                    api_client.GetPaginatedAccentResponse?>(
                  firstPageErrorIndicatorBuilder: (context) {
                    return ErrorLoadingItem(
                      onTap: () {
                        assignTargetAccentCubit.getAccentPagingController
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: PreferredAccentElement(
                        onIconTap: () async {
                          final voices = await flutterTts.getVoices;
                          dynamic indianVoice;

                          if (item.code == "en-GB") {
                            indianVoice = voices.lastWhere(
                              (voice) =>
                                  voice['locale'] == (item.code ?? 'en-US'),
                              orElse: () => null,
                            );
                          } else {
                            indianVoice = voices.firstWhere(
                              (voice) =>
                                  voice['locale'] == (item.code ?? 'en-US'),
                              orElse: () => null,
                            );
                          }

                          if (indianVoice != null) {
                            await flutterTts.setVoice({
                              'name': indianVoice['name'],
                              'locale': indianVoice['locale'],
                            });
                          } else {
                            await flutterTts.setLanguage(item.code ?? 'en-US');
                          }

                          flutterTts.setCompletionHandler(() async {});
                          await flutterTts.setIosAudioCategory(
                            IosTextToSpeechAudioCategory.playback,
                            [
                              IosTextToSpeechAudioCategoryOptions.duckOthers,
                              IosTextToSpeechAudioCategoryOptions
                                  .defaultToSpeaker
                            ],
                          );
                          await flutterTts.setSpeechRate(0.5); // for clarity
                          await flutterTts.setPitch(1.0);
                          await flutterTts
                              .speak("Hi, how can i help you today?");
                        },
                        id: item!.id!,
                        label: globals.appLang == 'ar'
                            ? item.nameAr!
                            : item.nameEn!,
                        onTap: () => assignTargetAccentCubit
                            .changeAccentChoice(item.id!),
                        selectedIndex: assignTargetAccentCubit.currentAccent,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: isLoading == true
                  ? Center(
                      child: CustomLoadingIndicator(),
                    )
                  : CustomButton(
                      isDisabled: assignTargetAccentCubit.currentAccent == null
                          ? true
                          : false,
                      text: AppLocalizations.of(context)!.continueLabel,
                      itemCallBack: () async {
                        assignTargetAccentCubit.assignTargetAccent(
                          accentId:
                              assignTargetAccentCubit.currentAccent.toString(),
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
