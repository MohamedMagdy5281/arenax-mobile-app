import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class PasswordInfoBottomSheet extends StatelessWidget {
  const PasswordInfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.passwordRulesInfo,
                style: Styles.textStyle16.copyWith(
                  color: kBlackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  globals.navigatorKey.currentState!.pop();
                },
                icon: const Icon(
                  Iconsax.close_circle,
                  color: kBlackColor,
                ),
                padding: EdgeInsets.zero,
                constraints:
                    const BoxConstraints(), // override default min size of 48px
                style: const ButtonStyle(
                  tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // the '2023' part
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '1- ${AppLocalizations.of(context)!.passwordLengthShort}',
            style: Styles.textStyle12
                .copyWith(color: kBlackColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            '2- ${AppLocalizations.of(context)!.passwordMustHaveNonAlphanumeric}',
            style: Styles.textStyle12
                .copyWith(color: kBlackColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            '3- ${AppLocalizations.of(context)!.passwordMustHaveDigit}',
            style: Styles.textStyle12
                .copyWith(color: kBlackColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            '4- ${AppLocalizations.of(context)!.passwordMustHaveUppercase}',
            style: Styles.textStyle12
                .copyWith(color: kBlackColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            '5- ${AppLocalizations.of(context)!.passwordMustHaveLowercase}',
            style: Styles.textStyle12
                .copyWith(color: kBlackColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            '6- ${AppLocalizations.of(context)!.passwordNoArabic}',
            style: Styles.textStyle12
                .copyWith(color: kBlackColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
