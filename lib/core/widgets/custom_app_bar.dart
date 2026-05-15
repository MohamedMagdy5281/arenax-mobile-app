import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:arenax_mobile_app/core/utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kLightBlueColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 16,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                color: kWhiteColor,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 55, bottom: 24, right: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: onPressed ??
                        () {
                          globals.navigatorKey.currentState!.pop();
                        },
                    icon: Icon(
                      isArabic ? Iconsax.arrow_right_14 : Iconsax.arrow_left4,
                      color: kBlackColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Styles.textStyle18.copyWith(
                    color: kDarkBlackColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
