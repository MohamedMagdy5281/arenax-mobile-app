import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/onboardingRiverpod/onboarding_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingViewBody extends ConsumerStatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  ConsumerState<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends ConsumerState<OnboardingViewBody> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    final state = ref.watch(onboardingNotifierProvider);
    final notifier = ref.read(onboardingNotifierProvider.notifier);

    return Container(
        color: colors.kBackGroundColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              notifier.skipOnboarding();
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Text(
                                AppLocalizations.of(context)!.skip,
                                style: Styles.textStyle18(context).copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: colors.kHintColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          state.currentPage == 0
                              ? Image.asset(AssetsData.locationIcon,
                                  width: 180, height: 140)
                              : state.currentPage == 1
                                  ? Image.asset(AssetsData.locationIcon,
                                      width: 180, height: 140)
                                  : Image.asset(AssetsData.locationIcon,
                                      width: 180, height: 140),
                          SizedBox(height: 16),
                          state.currentPage == 0
                              ? Text(
                                  AppLocalizations.of(context)!
                                      .findYourPlaceToPlay,
                                  textAlign: TextAlign.center,
                                  style: Styles.textStyle24(context).copyWith(
                                    color: colors.kTextColor,
                                  ),
                                )
                              : state.currentPage == 1
                                  ? Text(
                                      AppLocalizations.of(context)!
                                          .findYourPlaceToPlay,
                                      textAlign: TextAlign.center,
                                      style:
                                          Styles.textStyle24(context).copyWith(
                                        color: colors.kTextColor,
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!
                                          .findYourPlaceToPlay,
                                      textAlign: TextAlign.center,
                                      style:
                                          Styles.textStyle24(context).copyWith(
                                        color: colors.kTextColor,
                                      ),
                                    ),
                          SizedBox(height: 16),
                          state.currentPage == 0
                              ? Text(
                                  AppLocalizations.of(context)!.discoverThings,
                                  textAlign: TextAlign.center,
                                  style: Styles.textStyle16(context).copyWith(
                                    color: colors.kTextMutedColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : state.currentPage == 1
                                  ? Text(
                                      AppLocalizations.of(context)!
                                          .discoverThings,
                                      textAlign: TextAlign.center,
                                      style:
                                          Styles.textStyle16(context).copyWith(
                                        color: colors.kTextMutedColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!
                                          .discoverThings,
                                      textAlign: TextAlign.center,
                                      style:
                                          Styles.textStyle16(context).copyWith(
                                        color: colors.kTextMutedColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => GestureDetector(
                                onTap: () {
                                  notifier.changeCurrentPageOnTap(index);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  width: state.currentPage == index ? 24 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: state.currentPage == index
                                        ? colors.kPrimaryColor
                                        : colors.kBorderRoundColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          state.currentPage < 2
                              ? CustomButton(
                                  text: AppLocalizations.of(context)!.next,
                                  itemCallBack: () {
                                    notifier.nextCurrentPage();
                                  },
                                )
                              : CustomButton(
                                  text: AppLocalizations.of(context)!
                                      .continueLabel,
                                  itemCallBack: () {
                                    notifier.nextCurrentPage();
                                  },
                                ),
                          SizedBox(height: 32),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
        ));
  }
}
