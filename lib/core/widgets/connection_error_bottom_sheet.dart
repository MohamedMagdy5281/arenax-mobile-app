import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ConnectionErrorBottomSheet extends StatelessWidget {
  final VoidCallback onRetryPressed;
  final VoidCallback onDismiss;

  const ConnectionErrorBottomSheet({
    super.key,
    required this.onRetryPressed,
    required this.onDismiss,
  });

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onRetryPressed,
    required VoidCallback onDismiss,
  }) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      showDragHandle: false,
      backgroundColor: colors.kSurfaceColor, // Your desired color
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) => SizedBox(
        width: double.infinity,
        child: ConnectionErrorBottomSheet(
          onRetryPressed: onRetryPressed,
          onDismiss: onDismiss,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 46,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: colors.kBorderRoundColor),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AssetsData.errorIcon,
                width: 42,
                height: 42,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.somethingWentWrong,
                      style: Styles.textStyle18(context).copyWith(
                        color: colors.kTextColor,
                      ),
                      softWrap: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      AppLocalizations.of(context)!.couldntReachOurServers,
                      style: Styles.textStyle14(context)
                          .copyWith(color: colors.kTextMutedColor),
                      softWrap: true,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 24,
          ),
          CustomButton(
              text: AppLocalizations.of(context)!.tryAgain,
              itemCallBack: onRetryPressed),
          SizedBox(
            height: 8,
          ),
          CustomButtonWithNoBG(
              text: AppLocalizations.of(context)!.dismiss,
              itemCallBack: onDismiss),
          SizedBox(
            height: 18,
          )
        ],
      ),
    );
  }
}
