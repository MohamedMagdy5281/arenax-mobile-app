import 'dart:math';

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
                              "${globals.userDetails.firstName![0]}${globals.userDetails.lastName![0]}"),
                        ),
                      ),
              ]),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                color: colors.kSurfaceColor,
                border:
                    Border.all(color: colors.kDisabledButtonColor, width: 1),
                borderRadius: BorderRadius.circular(16)),
          );
  }
}
