import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/manager/profileRiverpod/profile_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/widgets/user_details_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileViewBody extends ConsumerStatefulWidget {
  const ProfileViewBody({super.key});

  @override
  ConsumerState<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends ConsumerState<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    final state = ref.watch(profileNotifierProvider);
    final notifier = ref.read(profileNotifierProvider.notifier);
    return Stack(
      children: [
        // Image.asset(AssetsData.pageBg),
        state.isPageLoading
            ? Container(
                color: colors.kBackGroundColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: CustomLoadingIndicator(),
                  ),
                ))
            : Container(
                color: colors.kBackGroundColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 52,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.profile,
                                    style: Styles.textStyle24(context)
                                        .copyWith(color: colors.kTextColor),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                          color: colors.kSurfaceColor,
                                          border: Border.all(
                                              color:
                                                  colors.kDisabledButtonColor,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Icon(
                                        Icons.settings,
                                        size: 20,
                                        color: colors.kTextColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              UserDetailsContainer(),
                            ],
                          ),
                        ),
                      ),

                      // 🔥 THIS PUSHES BUTTON TO BOTTOM
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
