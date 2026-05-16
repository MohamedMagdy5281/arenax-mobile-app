import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';

Future<void> customConnectionCheckDialog(
  BuildContext context, {
  required String content,
  required bool isInternetConnected,
  required Future<void> Function() retryOnPressed,
}) async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult[0] == ConnectivityResult.none) {
    return showLostConnectionDialog(
      context,
      content: "",
      isInternetConnected: false,
      retryOnPressed: retryOnPressed,
    );
  }
  return;
}

Future<void> showLostConnectionDialog(
  BuildContext context, {
  required String content,
  required bool isInternetConnected,
  required Future<void> Function() retryOnPressed,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.noInternetConnection,
          style: Styles.textStyle18,
          textAlign: TextAlign.center,
        ),
        content: Text(
          AppLocalizations.of(context)!.youHaveLostConnection,
          style: Styles.textStyle16.copyWith(
            color: kBlackColor,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: Container(
              decoration: ShapeDecoration(
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: kWhiteColor.withOpacity(0.1),
                  backgroundColor: kPrimaryColor, // Ripple color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 4, // Elevation for button shadow
                ),
                onPressed: () async {
                  // Retry logic
                  var connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (connectivityResult[0] == ConnectivityResult.none) {
                    return;
                  } else {
                    await retryOnPressed();
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.retry,
                  style: Styles.textStyle14.copyWith(color: kWhiteColor),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
