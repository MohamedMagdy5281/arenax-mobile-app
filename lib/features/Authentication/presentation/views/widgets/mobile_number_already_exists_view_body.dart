import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class MobileNumberAlreadyExistsViewBody extends StatelessWidget {
  const MobileNumberAlreadyExistsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return Stack(
      children: [
        // Image.asset(AssetsData.pageBg),
        Container(
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
                          AssetsData.warnningIcon,
                          width: 84,
                          height: 84,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          AppLocalizations.of(context)!.numberAlreadyRegistered,
                          style: Styles.textStyle22(context)
                              .copyWith(color: colors.kTextColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          AppLocalizations.of(context)!.youAlreadyHaveAccount,
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
                      child: CustomButton(
                        text: AppLocalizations.of(context)!.loginInstead,
                        itemCallBack: () {
                          globals.navigatorKey.currentState!
                              .pushNamed(LoginView.id);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 16, right: 16),
                      child: CustomButtonWithNoBG(
                        text: AppLocalizations.of(context)!.useDiffMobileNum,
                        itemCallBack: () {
                          globals.navigatorKey.currentState!.pop();
                        },
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
