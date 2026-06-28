import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:arenax_mobile_app/client/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class CasheHelper {
  static SharedPreferences? sharedPreferences;

  static String? token;
  static String? refreshToken;
  // static UserModel? user;
  // static AuthResultModel? authenticationResult;
  static List<String>? userInterests = [];
  static DateTime? dateOfBirth;
  static String? firstName;
  static String? lastName;
  static String? languageId;
  static String? accentId;
  static String? accentCode;
  static String? mainGoalId;
  static String? userId;
  static int? freeTrialPeriod;
  static File? selectedImage;

  // static String openAttachmentUrl =
  //     "https://befluent.trust2s.com/api/Attachment/open-attachment/";
  // String openLessonAttachmentByName =
  //     "https://befluent.trust2s.com/open-lesson-attachment/";

  static String? deviceType;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static addStringToSP(String key, dynamic value) async {
    if (value is String) return await sharedPreferences?.setString(key, value);
    if (value is int) return await sharedPreferences?.setInt(key, value);
    if (value is bool) return await sharedPreferences?.setBool(key, value);

    return await sharedPreferences?.setDouble(key, value);
  }

  static dynamic getStringFromSP(String key) async {
    return sharedPreferences?.getString(key);
  }

  static Future<void> removeStringFromSP(String key) async {
    await sharedPreferences?.remove(key);
  }

  static Future<void> loadTokenAndRefreshToken() async {
    String? tokenFun = await getStringFromSP('token');
    String? refreshTokenFun = await getStringFromSP('refreshToken');

    // if (tokenFun != null) {
    //   authenticationResult?.token = tokenFun;
    // }

    // if (refreshTokenFun != null) {
    //   authenticationResult?.refreshToken = refreshTokenFun;
    // }
  }

  static Future<void> loadLocale() async {
    String? locale = await getStringFromSP('locale');
    globals.appLang = locale ?? PlatformDispatcher.instance.locale.languageCode;
  }

  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<void> addStringToSS(String key, String? value) async {
    await secureStorage.write(
      key: key,
      value: value,
    );
  }

  static Future<String?> getStringFromSS(String key) async {
    return await secureStorage.read(
      key: key,
    );
  }

  static Future<void> removeStringFromSS(String key) async {
    await secureStorage.delete(
      key: key,
    );
  }

  static Future<void> addBoolToSS(String key, bool? value) async {
    await secureStorage.write(
      key: key,
      value: value?.toString(), // store as "true" or "false"
    );
  }

  static addListToSP(String key, List<Map<String, String?>> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringList = value.map((m) => jsonEncode(m)).toList();
    await prefs.setStringList(key, stringList);
  }

  static Future<List<Map<String, String?>>> getListFromSP(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(key);
    if (stringList == null) return [];
    return stringList
        .map((jsonStr) => Map<String, String?>.from(jsonDecode(jsonStr)))
        .toList();
  }

  Future<void> loadLastChatMessages() async {
    List<Map<String, String?>> lastMessages = await getListFromSP('lastChat');
    List<Map<String, String?>> allChatMessages =
        await getListFromSP('allMessages');

    if (lastMessages != []) {
      globals.lastChatMessages = lastMessages;
    }
    if (allChatMessages != []) {
      globals.allOldChatMessages = allChatMessages;
    }
  }

  static addBoolToSP(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
