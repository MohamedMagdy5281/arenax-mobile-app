import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/enableFaceIdRiverpod/enable_face_id_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnableFaceIdViewBody extends ConsumerStatefulWidget {
  const EnableFaceIdViewBody({super.key});

  @override
  ConsumerState<EnableFaceIdViewBody> createState() =>
      _EnableFaceIdViewBodyState();
}

class _EnableFaceIdViewBodyState extends ConsumerState<EnableFaceIdViewBody> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(enableFaceIdNotifierProvider);
    final notifier = ref.read(enableFaceIdNotifierProvider.notifier);
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return Stack(
      children: [
        // Image.asset(AssetsData.pageBg),
        state.isPageLoading
            ? Container(
                color: colors.kInfoTextColor,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 52,
                              ),
                              Image.asset(
                                AssetsData.faceIdIcon,
                                width: 42,
                                height: 42,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                AppLocalizations.of(context)!.signInFaster,
                                style: Styles.textStyle22(context)
                                    .copyWith(color: colors.kTextColor),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .useFaceIdOrTouchId,
                                style: Styles.textStyle14(context)
                                    .copyWith(color: colors.kTextMutedColor),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 🔥 THIS PUSHES BUTTON TO BOTTOM
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: state.isEnableFaceIdButtonLoading
                                ? const CustomLoadingIndicator()
                                : CustomButton(
                                    text: AppLocalizations.of(context)!
                                        .enableFaceId,
                                    itemCallBack: () {},
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 16, left: 16, right: 16),
                            child: state.isNotNowButtonLoading
                                ? const CustomLoadingIndicator()
                                : CustomButtonWithNoBG(
                                    text: AppLocalizations.of(context)!.notNow,
                                    itemCallBack: () {},
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
