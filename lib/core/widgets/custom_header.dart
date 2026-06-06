import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:arenax_mobile_app/core/utils/styles.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader(
      {super.key,
      required this.title,
      required this.optionalPrefixIcon,
      this.onPrefixIconTap,
      this.optionalSuffixIcon,
      this.onSuffixIconTap,
      this.optionalSecondSuffixIcon,
      this.onSecondSuffixIconTap});

  final String title;
  final Widget? optionalPrefixIcon;
  final VoidCallback? onPrefixIconTap;
  final Widget? optionalSuffixIcon;
  final VoidCallback? onSuffixIconTap;
  final Widget? optionalSecondSuffixIcon;
  final VoidCallback? onSecondSuffixIconTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 55,
        bottom: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          optionalPrefixIcon != null
              ? GestureDetector(
                  onTap: onPrefixIconTap ??
                      () => globals.navigatorKey.currentState!.pop(),
                  child: optionalPrefixIcon)
              : SizedBox(),
          Text(
            title,
            style: Styles.textStyle22(context).copyWith(
                fontWeight: FontWeight.w900, color: colors.kBlackColor),
          ),
          optionalSecondSuffixIcon != null
              ? Row(
                  children: [
                    GestureDetector(
                        onTap: onSecondSuffixIconTap,
                        child: optionalSecondSuffixIcon),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                        onTap: onSuffixIconTap, child: optionalSuffixIcon),
                  ],
                )
              : optionalSuffixIcon != null
                  ? GestureDetector(
                      onTap: onSuffixIconTap, child: optionalSuffixIcon)
                  : SizedBox(),
        ],
      ),
    );
  }
}
