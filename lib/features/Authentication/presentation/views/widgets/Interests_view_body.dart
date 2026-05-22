import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/interestsRiverpod/interests_notifier_riverpod.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/location_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/widgets/interests_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class InterestsViewBody extends ConsumerStatefulWidget {
  const InterestsViewBody({super.key});

  @override
  ConsumerState<InterestsViewBody> createState() => _InterestsViewBodyState();
}

class _InterestsViewBodyState extends ConsumerState<InterestsViewBody> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(interestsNotifierProvider);
    final notifier = ref.watch(interestsNotifierProvider.notifier);

    return Stack(
      children: [
        // Image.asset(AssetsData.pageBg),
        state.isPageLoading
            ? Center(
                child: CustomLoadingIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHeader(
                      title: AppLocalizations.of(context)!.selectInterests,
                      optionalPrefixIcon: null,
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: notifier.interests.length + 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            if (index == notifier.interests.length) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: kGrey2Color,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context)!.others,
                                    style: Styles.textStyle14,
                                  ),
                                ],
                              );
                            }
                            final interest = notifier.interests[index];
                            return InterestsCard(
                              name: interest["name"],
                              isSelected: state.selectedInterests
                                  .contains(interest["id"]),
                              image: interest["image"],
                              id: interest["id"],
                              onTap: () {
                                if (state.selectedInterests.length < 3 ||
                                    state.selectedInterests
                                        .contains(interest["id"])) {
                                  notifier.toggleInterest(interest["id"]);
                                }
                              },
                            );
                          },
                        )),
                    const SizedBox(height: 24),
                    state.isInterestsButtonLoading == true
                        ? Center(child: CustomLoadingIndicator())
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: CustomButton(
                              isDisabled: state.selectedInterests.length != 3,
                              text: AppLocalizations.of(context)!.next,
                              itemCallBack: () async {
                                if (state.selectedInterests.length == 3) {
                                  globals.navigatorKey.currentState!
                                      .pushReplacementNamed(LocationView.id);
                                }
                              },
                            ),
                          ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
      ],
    );
  }
}
