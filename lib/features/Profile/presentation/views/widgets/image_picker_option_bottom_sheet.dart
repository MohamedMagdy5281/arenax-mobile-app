import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:iconsax/iconsax.dart';

class ImagePickerOptionBottomSheet extends StatelessWidget {
  final VoidCallback onCameraSelect;
  final VoidCallback onGallerySelect;
  final VoidCallback onRemoveImageSelect;

  const ImagePickerOptionBottomSheet({
    super.key,
    required this.onCameraSelect,
    required this.onGallerySelect,
    required this.onRemoveImageSelect,
  });

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onCameraSelect,
    required VoidCallback onGallerySelect,
    required VoidCallback onRemoveImageSelect,
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
        child: ImagePickerOptionBottomSheet(
          onCameraSelect: onCameraSelect,
          onGallerySelect: onGallerySelect,
          onRemoveImageSelect: onRemoveImageSelect,
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
    return Column(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                AppLocalizations.of(context)!.changeProfileImg,
                style: Styles.textStyle18(context).copyWith(
                  color: colors.kTextColor,
                ),
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: colors.kDisabledButtonColor),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: onCameraSelect,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: colors.kPrimaryDarkColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Iconsax.camera,
                                size: 16,
                                color: colors.kPrimaryColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.takePhoto,
                                style: Styles.textStyle14(context).copyWith(
                                  color: colors.kTextColor,
                                ),
                              ),
                            ),
                            Icon(
                              globals.appLang == "en"
                                  ? Iconsax.arrow_right_3
                                  : Iconsax.arrow_left_2,
                              color: colors.kTextMutedColor,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onGallerySelect,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1,
                                    color: colors.kDisabledButtonColor))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: colors.kPrimaryDarkColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Iconsax.image,
                                  size: 16,
                                  color: colors.kPrimaryColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.choosePhoto,
                                  style: Styles.textStyle14(context).copyWith(
                                    color: colors.kTextColor,
                                  ),
                                ),
                              ),
                              Icon(
                                globals.appLang == "en"
                                    ? Iconsax.arrow_right_3
                                    : Iconsax.arrow_left_2,
                                color: colors.kTextMutedColor,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onRemoveImageSelect,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1,
                                    color: colors.kDisabledButtonColor))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: colors.kErrorBGColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Iconsax.trash,
                                  size: 16,
                                  color: colors.kErrorTextColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.removePhoto,
                                  style: Styles.textStyle14(context).copyWith(
                                    color: colors.kErrorTextColor,
                                  ),
                                ),
                              ),
                              Icon(
                                globals.appLang == "en"
                                    ? Iconsax.arrow_right_3
                                    : Iconsax.arrow_left_2,
                                color: colors.kTextMutedColor,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButtonWithNoBG(
              text: AppLocalizations.of(context)!.cancel,
              itemCallBack: () {
                globals.navigatorKey.currentState!.pop();
              }),
        ),
        SizedBox(
          height: 18,
        )
      ],
    );
  }
}
