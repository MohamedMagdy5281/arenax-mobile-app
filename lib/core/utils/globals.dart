library;

// import 'package:arenax_mobile_app/client/api.dart';
import 'package:arenax_mobile_app/core/utils/cashe_helper.dart';
import 'package:arenax_mobile_app/core/utils/functions/custom_dialog.dart';
import 'package:arenax_mobile_app/main.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String appLang = "en";
String? token;
String? refreshToken;
int? localeVersion;
String? ethpatDate;
String? currentLocation;
Color? shortcutNameColor;
bool isTheFirst = false;
String openAttachmentApi =
    "https://befluent.trust2s.com/api/Attachment/open-attachment/";
String openLessonAttachmentByName =
    "https://befluent.trust2s.com/open-lesson-attachment/";
bool isNewChat = true;
List<Map<String, String?>> lastChatMessages = [];
List<Map<String, String?>> allOldChatMessages = [];
bool? isProfilePicUpdate;
bool? isHomePicUpdate;
String? subscriptionRemainingDays;
String? freeRemainingDays;
String? version;
String? os;
String? freeChatPrompt;

// List<ValidatedSubscriptionItem> validatedSubscriptionItems = [];
List<String> activeProductIds = [];
bool isFreeTrialActive = false;
bool isSubscriptionActive = false;

const String apiKey = "AIzaSyDQeI_JZSPH1uoVO2ycJ7da1rUe5BFmxNg";

Future<void> removeStringFromSP(String key) async {
  CasheHelper.removeStringFromSP(key);
}

Future<void> restartApp() async {
  runApp(MyApp());
}

String convertArabicNumbersToEnglish(String input) {
  const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  for (int i = 0; i < arabicDigits.length; i++) {
    input = input.replaceAll(arabicDigits[i], englishDigits[i]);
  }
  return input;
}

Future<void> showUpdateDialog(BuildContext context, String updateUrl) async {
  await customUpdateDialog(context, updateUrl: updateUrl);
}
