import 'package:flutter/material.dart';
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/styles.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/login_view.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

Future<dynamic> customLogOutDialog(BuildContext context) {
  Future<void> clearTokensAndData() async {
    CasheHelper.removeStringFromSP("token");
    CasheHelper.removeStringFromSP("refreshToken");
    CasheHelper.user = null;
    CasheHelper.authenticationResult = null;
    CasheHelper.accentId = null;
    CasheHelper.mainGoalId = null;
    CasheHelper.firstName = null;
    CasheHelper.lastName = null;
    CasheHelper.languageId = null;
    CasheHelper.accentCode = null;
    CasheHelper.userInterests = null;
  }

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.confirm,
        style: Styles.textStyle18,
        textAlign: TextAlign.center,
      ),
      content: Text(
        AppLocalizations.of(context)!.logOutConfirm,
        style: Styles.textStyle16.copyWith(
          color: kBlackColor,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.yes,
                    style: Styles.textStyle14.copyWith(
                      color: kWhiteColor,
                    ),
                  ),
                  onPressed: () async {
                    await clearTokensAndData();
                    CasheHelper.removeStringFromSS("token");
                    CasheHelper.removeStringFromSS("refresshToken");
                    globals.subscriptionRemainingDays = null;
                    globals.freeRemainingDays = null;
                    globals.navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        LoginView.id, (Route<dynamic> route) => false);
                  },
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: kPrimaryColor,
                ),
                child: TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.no,
                    style: Styles.textStyle14.copyWith(
                      color: kWhiteColor,
                    ),
                  ),
                  onPressed: () {
                    globals.navigatorKey.currentState!.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Future<dynamic> customDialog(BuildContext context,
    {void Function()? okOnPressed, required String content}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.confirm,
        style: Styles.textStyle18,
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        style: Styles.textStyle16.copyWith(
          color: kBlackColor,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: TextButton(
                  onPressed: okOnPressed,
                  child: Text(
                    AppLocalizations.of(context)!.yes,
                    style: Styles.textStyle14.copyWith(
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: kPrimaryColor,
                ),
                child: TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.no,
                    style: Styles.textStyle14.copyWith(
                      color: kWhiteColor,
                    ),
                  ),
                  onPressed: () {
                    globals.navigatorKey.currentState!.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Future<dynamic> customUpdateDialog(BuildContext context, {String? updateUrl}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.appUpdateTitle,
            style: Styles.textStyle18,
            textAlign: TextAlign.center,
          ),
          content: Text(
            AppLocalizations.of(context)!.updateMessage,
            style: Styles.textStyle16.copyWith(
              color: kBlackColor,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: kPrimaryColor,
                ),
                child: TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.updateNow,
                    style: Styles.textStyle14.copyWith(
                      color: kWhiteColor,
                    ),
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse(updateUrl ?? ''));
                  },
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
