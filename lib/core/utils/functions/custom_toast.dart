import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';

showCustomToast(FToast? toastShower,
    {ToastGravity? gravity,
    double? width,
    required bool isError,
    required String toastMessage,
    IconData? icon,
    Color? bgColor}) {
  if (toastShower != null) {
    Widget toast = Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: bgColor ?? (isError ? kErrorColor : kSideBG),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: isError ? kWhiteColor : kDarkBlackColor,
              size: 20,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Center(
              child: Text(
                toastMessage,
                style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.w500,
                    color: bgColor == null
                        ? isError
                            ? kWhiteColor
                            : kDarkBlackColor
                        : kWhiteColor),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
    toastShower.showToast(
      child: toast,
      gravity: gravity ?? ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }
}
