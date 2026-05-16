import 'dart:io';
import 'package:arenax_mobile_app/core/utils/cashe_helper.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/notification_service.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/forget_password_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/login_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/otp_verification_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:arenax_mobile_app/core/utils/cashe_helper.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:local_auth/local_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: kBGColor, // top status bar color
    statusBarIconBrightness: Brightness.dark, // dark icons for white background
    systemNavigationBarColor: kBGColor,
    statusBarBrightness: Brightness.light, // for ios
    systemNavigationBarIconBrightness: Brightness.dark, // dark icons
  ));
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // ✅ CRITICAL: Initialize SharedPreferences FIRST before using CasheHelper
  await CasheHelper.init();

  // await loadLastChatMessages();

  await loadTokenAndRefreshToken();
  await loadUserId();
  await getIOSDeviceType();
  await getOsAndVersion();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission();
  // if (settings.authorizationStatus == AuthorizationStatus.authorized ||
  //     settings.authorizationStatus == AuthorizationStatus.provisional) {
  //   await AwesomeNotifications()
  //       .initialize('resource://mipmap/notification_logo', [
  //     NotificationChannel(
  //       channelKey: 'ArenaX',
  //       channelName: 'ArenaX',
  //       channelDescription: 'arenaX notification',
  //       playSound: true,
  //       enableVibration: true,
  //       importance: NotificationImportance.Max,
  //       defaultRingtoneType: DefaultRingtoneType.Notification,
  //       icon: 'resource://mipmap/notification_logo',
  //     ),
  //   ]);
  //   FirebaseMessaging.onBackgroundMessage(handlePushNotification);
  //   AwesomeNotifications().setListeners(
  //     onActionReceivedMethod: (receivedAction) async {
  //       handleNotificationTap();
  //     },
  //   );
  //   await requestPermissions();
  // } else {
  //   if (kDebugMode) {
  //     print(
  //         'Notification permission not granted. Skipping notification setup.');
  //   }
  // }
  // Future<void> checkLocationServices() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   while (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   }
  // }

  // Ensure location services are enabled before running the app
  // await checkLocationServices();
  // Bloc.observer = SimpleBlocObserver();
  // setupFirebaseMessaging();
  runApp(
    const RestartWidget(
      child: ProviderScope(child: MyApp()),
    ),
  );
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});
  final Widget child;
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<RestartWidgetState>()?.restartApp();
  }

  @override
  RestartWidgetState createState() => RestartWidgetState();
}

class RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

Future<void> loadTokenAndRefreshToken() async {
  String? token = await CasheHelper.getStringFromSS('token');
  String? refreshToken = await CasheHelper.getStringFromSS('refreshToken');

  if (token != null) {
    CasheHelper.token = token;
  }

  if (refreshToken != null) {
    CasheHelper.refreshToken = refreshToken;
  }
}

Future<void> getOsAndVersion() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  globals.version = packageInfo.version;
  if (Platform.isAndroid) {
    globals.os = 'Android';
  } else if (Platform.isIOS) {
    globals.os = 'IOS';
  }
}

Future<void> loadUserId() async {
  String? userId = await CasheHelper.getStringFromSS('userId');

  if (userId != null) {
    CasheHelper.userId = userId;
  }
}

Future<void> getIOSDeviceType() async {
  if (Platform.isIOS) {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final iosInfo = await deviceInfoPlugin.iosInfo;

    final model = iosInfo.utsname.machine.toLowerCase();

    if (model.startsWith('ipad')) {
      CasheHelper.deviceType = "iPad";
    } else if (model.startsWith('iphone')) {
      CasheHelper.deviceType = "iPhone";
    } else {
      CasheHelper.deviceType = 'Unknown iOS device';
    }
  } else {
    CasheHelper.deviceType = "Android";
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool isAuthenticated = false;
  bool isInBackground = false;
  Future<void> _authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: AppLocalizations.of(context)!.authenticateMsg,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true, // Keeps asking if the app is restarted
        ),
      );
      setState(() {
        isAuthenticated = authenticated;
      });
      if (!authenticated) {
        SystemNavigator.pop();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  SharedPreferences? sharedPrefs;
  @override
  void initState() {
    super.initState();
    _authenticate();
    // Use CasheHelper's already initialized SharedPreferences
    sharedPrefs = CasheHelper.sharedPreferences;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // App is going to the background
      isInBackground = true;
    } else if (state == AppLifecycleState.resumed) {
      // App has come to the foreground, trigger authentication if it was in the background
      if (isInBackground) {
        isInBackground = false;
        _authenticate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      // ✅ Safe null-check for SharedPreferences
      if (sharedPrefs != null) {
        if (sharedPrefs!.getString('locale') == null) {
          sharedPrefs!.setString('locale', globals.appLang);
        }
        globals.appLang = sharedPrefs!.getString('locale') ?? globals.appLang;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'ArenaX',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          locale: Locale(globals.appLang),
          theme: ThemeData(
            colorScheme: const ColorScheme.light(primary: kPrimaryColor),
            useMaterial3: true,
            textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
            primaryColor: kPrimaryColor,
          ),
          navigatorKey: globals.navigatorKey,
          initialRoute: LoginView.id,
          routes: {
            LoginView.id: (context) => const LoginView(),
            RegisterView.id: (context) => const RegisterView(),
            OtpVerificationView.id: (context) => const OtpVerificationView(),
            ForgetPasswordView.id: (context) => const ForgetPasswordView(),
          },
        );
      },
    );
  }
}
