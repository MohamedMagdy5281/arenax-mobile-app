import 'dart:math';

import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations_ar.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class UserDetailsContainer extends StatelessWidget {
  const UserDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return globals.userDetails.firstName == null ||
            globals.userDetails.lastName == null ||
            globals.userDetails.email == null
        ? Container(
            decoration: BoxDecoration(
              color: colors.kSurfaceColor,
              border: Border.all(color: colors.kDisabledButtonColor, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                globals.userDetails.firstName == null ||
                        globals.userDetails.lastName == null
                    ? GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: colors.kPrimaryDarkColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: Styles.textStyle18(context)
                                  .copyWith(color: colors.kPrimaryColor),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: colors.kUserNameShortcutBGColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "${globals.userDetails.firstName![0]}${globals.userDetails.lastName![0]}",
                            style: Styles.textStyle18(context).copyWith(
                                color: colors.kUserNameShortcutTextColor),
                          ),
                        ),
                      ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    globals.userDetails.firstName == null ||
                            globals.userDetails.lastName == null
                        ? Text(
                            AppLocalizations.of(context)!.addYourName,
                            style: Styles.textStyle16(context)
                                .copyWith(color: colors.kTextColor),
                          )
                        : Column(
                            children: [
                              Text(
                                globals.userDetails.firstName!,
                                style: Styles.textStyle18(context)
                                    .copyWith(color: colors.kTextColor),
                              ),
                              Text(
                                globals.userDetails.lastName!,
                                style: Styles.textStyle18(context)
                                    .copyWith(color: colors.kTextColor),
                              )
                            ],
                          ),
                    Text(
                      globals.userDetails.phoneNumber,
                      style: Styles.textStyle14(context)
                          .copyWith(color: colors.kTextMutedColor),
                    ),
                    globals.userDetails.email != null
                        ? Text(
                            globals.userDetails.email!,
                            style: Styles.textStyle14(context)
                                .copyWith(color: colors.kTextMutedColor),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: 143,
                      decoration: BoxDecoration(
                          color: colors.kWarningBGColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8),
                        child: Text(
                          AppLocalizations.of(context)!.requiredBeforeBooking,
                          style: Styles.textStyle12(context).copyWith(
                              color: colors.kWarningTextColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                color: colors.kSurfaceColor,
                border:
                    Border.all(color: colors.kDisabledButtonColor, width: 1),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: colors.kUserNameShortcutBGColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        "${globals.userDetails.firstName![0]}${globals.userDetails.lastName![0]}",
                        style: Styles.textStyle18(context)
                            .copyWith(color: colors.kUserNameShortcutTextColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          globals.userDetails.firstName!,
                          style: Styles.textStyle18(context)
                              .copyWith(color: colors.kTextColor),
                          softWrap: true,
                        ),
                        Text(
                          globals.userDetails.lastName!,
                          style: Styles.textStyle18(context)
                              .copyWith(color: colors.kTextColor),
                          softWrap: true,
                        ),
                        Text(
                          globals.userDetails.phoneNumber,
                          style: Styles.textStyle14(context)
                              .copyWith(color: colors.kTextMutedColor),
                          softWrap: true,
                        ),
                        Text(
                          globals.userDetails.email!,
                          style: Styles.textStyle14(context)
                              .copyWith(color: colors.kTextMutedColor),
                          softWrap: true,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: colors.kSuccessBGColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.check,
                            color: colors.kSuccessTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                          color: colors.kSurfaceColor,
                          border: Border.all(
                              width: 1, color: colors.kDisabledButtonColor),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Image.asset(
                          AssetsData.editPen,
                          width: 13,
                          height: 13,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
