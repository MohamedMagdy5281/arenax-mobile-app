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
  final IconData? optionalPrefixIcon;
  final VoidCallback? onPrefixIconTap;
  final IconData? optionalSuffixIcon;
  final VoidCallback? onSuffixIconTap;
  final IconData? optionalSecondSuffixIcon;
  final VoidCallback? onSecondSuffixIconTap;

  @override
  Widget build(BuildContext context) {
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
                  child: Icon(
                    optionalPrefixIcon,
                    color: kSoftDarkishColor,
                    size: 28,
                  ),
                )
              : SizedBox(),
          Text(
            title,
            style: Styles.textStyle22
                .copyWith(fontWeight: FontWeight.w900, color: kBlackColor),
          ),
          optionalSecondSuffixIcon != null
              ? Row(
                  children: [
                    GestureDetector(
                      onTap: onSecondSuffixIconTap,
                      child: Icon(
                        optionalSecondSuffixIcon,
                        color: kSoftDarkishColor,
                        size: 28,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: onSuffixIconTap,
                      child: Icon(
                        optionalSuffixIcon,
                        color: kSoftDarkishColor,
                        size: 28,
                      ),
                    ),
                  ],
                )
              : optionalSuffixIcon != null
                  ? GestureDetector(
                      onTap: onSuffixIconTap,
                      child: Icon(
                        optionalSuffixIcon,
                        color: kSoftDarkishColor,
                        size: 28,
                      ),
                    )
                  : SizedBox(),
        ],
      ),
    );
  }
}
