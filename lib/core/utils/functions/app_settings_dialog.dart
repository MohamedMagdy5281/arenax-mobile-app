import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

void showAppSettingsDialog(
  BuildContext context, {
  required String content,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.permissionRequired,
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context)!.cancel,
          ),
        ),
        TextButton(
          onPressed: () async {
            await openAppSettings();

            globals.navigatorKey.currentState!.pop();
          },
          child: Text(
            AppLocalizations.of(context)!.settings,
          ),
        ),
      ],
    ),
  );
}
