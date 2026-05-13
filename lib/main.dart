import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:local_auth/local_auth.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/notification_service.dart';
import 'package:praktika_clone_app/features/AppLoader/presentation/views/app_loader_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/app_loader_after_login_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/choose_accent_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/choose_gender_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/choose_hobbies_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/create_password_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/determine_age_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/forget_password_create_password_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/forget_password_otp_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/forget_password_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/login_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/otp_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/register_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/select_language_view.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/select_main_goal_view.dart';
import 'package:praktika_clone_app/features/Courses/presentation/views/courses_view.dart';
import 'package:praktika_clone_app/features/Courses/presentation/views/filter_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/home_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/lessons_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/saved_words_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/select_saved_words_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/lesson_tutor_chat_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/supscriptioin_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/supscription_from_home_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/tutor_chat_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/change_password_otp_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/change_password_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/delete_account_otp_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/delete_account_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/edit_hobbies_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/edit_main_goals_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/edit_preference_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/edit_preferred_accent_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/edit_profile_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/language_settings_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/profile_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/subscription_plan_view.dart';
import 'package:praktika_clone_app/firebase_options.dart';
import 'package:praktika_clone_app/simple_bloc_observer.dart';
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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ CRITICAL: Initialize SharedPreferences FIRST before using CasheHelper
  await CasheHelper.init();

  Gemini.init(apiKey: globals.apiKey);
  // await loadLastChatMessages();
  if (Platform.isIOS) {
    InAppPurchaseStoreKitPlatform.registerPlatform();
  }
  await loadTokenAndRefreshToken();
  await loadUserId();
  await getIOSDeviceType();
  await getOsAndVersion();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission();
  if (settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional) {
    await AwesomeNotifications()
        .initialize('resource://mipmap/notification_logo', [
      NotificationChannel(
        channelKey: 'befluent',
        channelName: 'befluent',
        channelDescription: 'befluent notification',
        playSound: true,
        enableVibration: true,
        importance: NotificationImportance.Max,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        icon: 'resource://mipmap/notification_logo',
      ),
    ]);
    FirebaseMessaging.onBackgroundMessage(handlePushNotification);
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (receivedAction) async {
        handleNotificationTap();
      },
    );
    await requestPermissions();
  } else {
    if (kDebugMode) {
      print(
          'Notification permission not granted. Skipping notification setup.');
    }
  }
  // Future<void> checkLocationServices() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   while (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   }
  // }

  // Ensure location services are enabled before running the app
  // await checkLocationServices();
  Bloc.observer = SimpleBlocObserver();
  setupFirebaseMessaging();
  runApp(
    const RestartWidget(
      child: MyApp(),
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
          title: 'Be Fluent',
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
          initialRoute: AppLoaderView.id,
          routes: {
            AppLoaderView.id: (context) => const AppLoaderView(),
            LoginView.id: (context) => const LoginView(),
            ForgetPasswordView.id: (context) => const ForgetPasswordView(),
            RegisterView.id: (context) => const RegisterView(),
            CreatePasswordView.id: (context) => const CreatePasswordView(),
            OtpView.id: (context) => const OtpView(),
            ChooseGenderView.id: (context) => const ChooseGenderView(),
            DetermineAgeView.id: (context) => const DetermineAgeView(),
            SelectLanguageView.id: (context) => const SelectLanguageView(),
            ChooseHobbiesView.id: (context) => const ChooseHobbiesView(),
            SelectMainGoalView.id: (context) => const SelectMainGoalView(),
            ChooseAccentView.id: (context) => const ChooseAccentView(),
            ProfileView.id: (context) => const ProfileView(),
            TutorChatView.id: (context) => const TutorChatView(),
            HomeView.id: (context) => const HomeView(),
            EditProfileView.id: (context) => const EditProfileView(),
            EditPreferenceView.id: (context) => const EditPreferenceView(),
            EditHobbiesView.id: (context) => const EditHobbiesView(),
            EditMainGoalsView.id: (context) => const EditMainGoalsView(),
            EditPreferredAccentView.id: (context) =>
                const EditPreferredAccentView(),
            ChangePasswordView.id: (context) => const ChangePasswordView(),
            ChangePasswordOtpView.id: (context) =>
                const ChangePasswordOtpView(),
            LanguageSettingsView.id: (context) => const LanguageSettingsView(),
            CoursesView.id: (context) => const CoursesView(),
            FilterView.id: (context) => const FilterView(),
            LessonTutorChatView.id: (context) => const LessonTutorChatView(),
            SelectSavedWordsView.id: (context) => const SelectSavedWordsView(),
            SavedWordsView.id: (context) => const SavedWordsView(),
            ForgetPasswordCreatePasswordView.id: (context) =>
                const ForgetPasswordCreatePasswordView(),
            ForgetPasswordOtpView.id: (context) =>
                const ForgetPasswordOtpView(),
            SupscriptioinView.id: (context) => const SupscriptioinView(),
            LessonsView.id: (context) => const LessonsView(),
            SupscriptionFromHomeView.id: (context) =>
                const SupscriptionFromHomeView(),
            DeleteAccountView.id: (context) => const DeleteAccountView(),
            DeleteAccountOtpView.id: (context) => const DeleteAccountOtpView(),
            SubscriptionPlanView.id: (context) => const SubscriptionPlanView(),
            AppLoaderAfterLoginView.id: (context) =>
                const AppLoaderAfterLoginView(),
          },
        );
      },
    );
  }
}
