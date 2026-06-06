import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  ///
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go'**
  String get letsGo;

  /// No description provided for @authenticateMsg.
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to access the app'**
  String get authenticateMsg;

  /// No description provided for @cantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'This field can\'t be empty'**
  String get cantBeEmpty;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @dontHaveAcc.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAcc;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @letsGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started by filling out the form below'**
  String get letsGetStarted;

  /// No description provided for @signUpHere.
  ///
  /// In en, this message translates to:
  /// **'Sign up here'**
  String get signUpHere;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @skill.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get skill;

  /// No description provided for @englishFor.
  ///
  /// In en, this message translates to:
  /// **'English for'**
  String get englishFor;

  /// No description provided for @practice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practice;

  /// No description provided for @keywordsDictionary.
  ///
  /// In en, this message translates to:
  /// **'Keywords Dictionary'**
  String get keywordsDictionary;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More...'**
  String get more;

  /// No description provided for @dataVault.
  ///
  /// In en, this message translates to:
  /// **'Data Vault'**
  String get dataVault;

  /// No description provided for @daysOnStreak.
  ///
  /// In en, this message translates to:
  /// **'Days on streak:'**
  String get daysOnStreak;

  /// No description provided for @bestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best streak:'**
  String get bestStreak;

  /// No description provided for @sessionInfo.
  ///
  /// In en, this message translates to:
  /// **'Session info:'**
  String get sessionInfo;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @enterFullNamme.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullNamme;

  /// No description provided for @englishLevel.
  ///
  /// In en, this message translates to:
  /// **'English Level'**
  String get englishLevel;

  /// No description provided for @nativeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Native Language'**
  String get nativeLanguage;

  /// No description provided for @avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @inviteFriend.
  ///
  /// In en, this message translates to:
  /// **'Invite a friend'**
  String get inviteFriend;

  /// No description provided for @joinDiscord.
  ///
  /// In en, this message translates to:
  /// **'Join Discord Community'**
  String get joinDiscord;

  /// No description provided for @manageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage Subscription'**
  String get manageSubscription;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email '**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password '**
  String get enterPassword;

  /// No description provided for @currentChat.
  ///
  /// In en, this message translates to:
  /// **'Current chat'**
  String get currentChat;

  /// No description provided for @newChat.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get newChat;

  /// No description provided for @savedWords.
  ///
  /// In en, this message translates to:
  /// **'Saved words'**
  String get savedWords;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share app'**
  String get shareApp;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @whatToSend.
  ///
  /// In en, this message translates to:
  /// **'Type your message'**
  String get whatToSend;

  /// No description provided for @conversationPaused.
  ///
  /// In en, this message translates to:
  /// **'You have paused the conversation'**
  String get conversationPaused;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @editPreferences.
  ///
  /// In en, this message translates to:
  /// **'Edit preferences'**
  String get editPreferences;

  /// No description provided for @helpAndSupp.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get helpAndSupp;

  /// No description provided for @firstname.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstname;

  /// No description provided for @nativeLang.
  ///
  /// In en, this message translates to:
  /// **'Native language'**
  String get nativeLang;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @editHobbies.
  ///
  /// In en, this message translates to:
  /// **'Edit interests'**
  String get editHobbies;

  /// No description provided for @editLearningGoals.
  ///
  /// In en, this message translates to:
  /// **'Edit learning main goal'**
  String get editLearningGoals;

  /// No description provided for @editPreferredAccent.
  ///
  /// In en, this message translates to:
  /// **'Edit preferred accent'**
  String get editPreferredAccent;

  /// No description provided for @whatYourHobbies.
  ///
  /// In en, this message translates to:
  /// **'What are your hobbies and interests ?'**
  String get whatYourHobbies;

  /// No description provided for @weHaveLibraries.
  ///
  /// In en, this message translates to:
  /// **'We have a rich library of lessons, topics and Al Avatars, so we need to pick the best suitable for you'**
  String get weHaveLibraries;

  /// No description provided for @interview.
  ///
  /// In en, this message translates to:
  /// **'Interview'**
  String get interview;

  /// No description provided for @cooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking'**
  String get cooking;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @traveling.
  ///
  /// In en, this message translates to:
  /// **'Traveling'**
  String get traveling;

  /// No description provided for @art.
  ///
  /// In en, this message translates to:
  /// **'Art'**
  String get art;

  /// No description provided for @sports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sports;

  /// No description provided for @gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get gaming;

  /// No description provided for @tech.
  ///
  /// In en, this message translates to:
  /// **'Tech'**
  String get tech;

  /// No description provided for @finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// No description provided for @editMainGoal.
  ///
  /// In en, this message translates to:
  /// **'Edit main goal'**
  String get editMainGoal;

  /// No description provided for @whatYourGoal.
  ///
  /// In en, this message translates to:
  /// **'What are your main learning goal ?'**
  String get whatYourGoal;

  /// No description provided for @careerGrowth.
  ///
  /// In en, this message translates to:
  /// **'Career growth'**
  String get careerGrowth;

  /// No description provided for @travelEasily.
  ///
  /// In en, this message translates to:
  /// **'Travel easily'**
  String get travelEasily;

  /// No description provided for @studyAbroad.
  ///
  /// In en, this message translates to:
  /// **'Study abroad'**
  String get studyAbroad;

  /// No description provided for @livingAbroad.
  ///
  /// In en, this message translates to:
  /// **'Living abroad'**
  String get livingAbroad;

  /// No description provided for @personalDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Personal development'**
  String get personalDevelopment;

  /// No description provided for @whatAccentYouPrefer.
  ///
  /// In en, this message translates to:
  /// **'Which accent are you prefer ?'**
  String get whatAccentYouPrefer;

  /// No description provided for @aiTutorsWithAccents.
  ///
  /// In en, this message translates to:
  /// **'In the app, you\'ll meet Al tutors with different accents, giving you the chance to practice conversations in the accent your prefer'**
  String get aiTutorsWithAccents;

  /// No description provided for @american.
  ///
  /// In en, this message translates to:
  /// **'American'**
  String get american;

  /// No description provided for @british.
  ///
  /// In en, this message translates to:
  /// **'British'**
  String get british;

  /// No description provided for @indian.
  ///
  /// In en, this message translates to:
  /// **'Indian'**
  String get indian;

  /// No description provided for @asian.
  ///
  /// In en, this message translates to:
  /// **'Asian'**
  String get asian;

  /// No description provided for @australian.
  ///
  /// In en, this message translates to:
  /// **'Australian'**
  String get australian;

  /// No description provided for @languageChange.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get languageChange;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// No description provided for @newPasswordVerification.
  ///
  /// In en, this message translates to:
  /// **'New password verification'**
  String get newPasswordVerification;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signForNewAcc.
  ///
  /// In en, this message translates to:
  /// **'Sign up for new account'**
  String get signForNewAcc;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password ?'**
  String get forgotPassword;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enterFirstName;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get enterLastName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your confirm password'**
  String get enterConfirmPassword;

  /// No description provided for @createPassword.
  ///
  /// In en, this message translates to:
  /// **'Create password'**
  String get createPassword;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @choosingGender.
  ///
  /// In en, this message translates to:
  /// **'Choosing gender'**
  String get choosingGender;

  /// No description provided for @chooseYourGender.
  ///
  /// In en, this message translates to:
  /// **'Choose your gender'**
  String get chooseYourGender;

  /// No description provided for @specifyYourGender.
  ///
  /// In en, this message translates to:
  /// **'Specify your gender to better\npersonalize your interactions'**
  String get specifyYourGender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @determineAge.
  ///
  /// In en, this message translates to:
  /// **'Determine age'**
  String get determineAge;

  /// No description provided for @howOldQues.
  ///
  /// In en, this message translates to:
  /// **'How old are you ?'**
  String get howOldQues;

  /// No description provided for @specifyYourAge.
  ///
  /// In en, this message translates to:
  /// **'Specify your age to better\npersonalize your interactions'**
  String get specifyYourAge;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @determineNativeLang.
  ///
  /// In en, this message translates to:
  /// **'Determine native language'**
  String get determineNativeLang;

  /// No description provided for @whatNativeLang.
  ///
  /// In en, this message translates to:
  /// **'What is your native\nlanguage ?'**
  String get whatNativeLang;

  /// No description provided for @nativeLangDesc.
  ///
  /// In en, this message translates to:
  /// **'You\'ll get Al hints, feedback and translations in your native language during conversations with Avatars'**
  String get nativeLangDesc;

  /// No description provided for @searchYourLang.
  ///
  /// In en, this message translates to:
  /// **'Search about your language'**
  String get searchYourLang;

  /// No description provided for @choosingHobbies.
  ///
  /// In en, this message translates to:
  /// **'Choosing interests'**
  String get choosingHobbies;

  /// No description provided for @whatHobbies.
  ///
  /// In en, this message translates to:
  /// **'What are your hobbies\nand interests ?'**
  String get whatHobbies;

  /// No description provided for @hobbiesDesc.
  ///
  /// In en, this message translates to:
  /// **'We have a rich library of lessons, topics and Al Avatars, so we need to pick the best suitable for you'**
  String get hobbiesDesc;

  /// No description provided for @determineGoal.
  ///
  /// In en, this message translates to:
  /// **'Determine main goal'**
  String get determineGoal;

  /// No description provided for @whatYourGoalDesc.
  ///
  /// In en, this message translates to:
  /// **'What are your main\nlearning goal ?'**
  String get whatYourGoalDesc;

  /// No description provided for @chooseAccent.
  ///
  /// In en, this message translates to:
  /// **'Choosing accent'**
  String get chooseAccent;

  /// No description provided for @whichAccent.
  ///
  /// In en, this message translates to:
  /// **'Which accent are you\ntargeting ?'**
  String get whichAccent;

  /// No description provided for @accentDesc.
  ///
  /// In en, this message translates to:
  /// **'In the app, you\'ll meet Al tutors with different accents, giving you the chance to practice conversations in the accent your prefer'**
  String get accentDesc;

  /// No description provided for @enterYourAge.
  ///
  /// In en, this message translates to:
  /// **'Enter your age'**
  String get enterYourAge;

  /// No description provided for @pleaseSelectLang.
  ///
  /// In en, this message translates to:
  /// **'Please select language'**
  String get pleaseSelectLang;

  /// No description provided for @thereIsNoLang.
  ///
  /// In en, this message translates to:
  /// **'There is no language with this name'**
  String get thereIsNoLang;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @chooseContent.
  ///
  /// In en, this message translates to:
  /// **'Choose level'**
  String get chooseContent;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @youHaveLostConnection.
  ///
  /// In en, this message translates to:
  /// **'It seems you are offline. Please check your connection.'**
  String get youHaveLostConnection;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @enterUserName.
  ///
  /// In en, this message translates to:
  /// **'Enter your user name'**
  String get enterUserName;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @errorMsg.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try later'**
  String get errorMsg;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in'**
  String get resendCodeIn;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @enterDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Enter your date of birth'**
  String get enterDateOfBirth;

  /// No description provided for @tryAgainMsg.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again'**
  String get tryAgainMsg;

  /// No description provided for @failedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed loading'**
  String get failedToLoad;

  /// No description provided for @noThingToDisplay.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to display'**
  String get noThingToDisplay;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @userDataUpdatedSuccessfuly.
  ///
  /// In en, this message translates to:
  /// **'Your data has been updated successfully'**
  String get userDataUpdatedSuccessfuly;

  /// No description provided for @unexpectedErrorOccured.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred, please try again later.'**
  String get unexpectedErrorOccured;

  /// No description provided for @yourInterestsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your interests have been updated successfully'**
  String get yourInterestsUpdated;

  /// No description provided for @yourMainGoalUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your main goal has been updated successfully'**
  String get yourMainGoalUpdated;

  /// No description provided for @yourPreferedAccentUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your prefered accent has been updated successfully'**
  String get yourPreferedAccentUpdated;

  /// No description provided for @letsPractice.
  ///
  /// In en, this message translates to:
  /// **'Let’s practice your English'**
  String get letsPractice;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter current password'**
  String get enterCurrentPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @enterNewConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm new password'**
  String get enterNewConfirmPassword;

  /// No description provided for @yourPasswordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password has been updated successfully'**
  String get yourPasswordUpdated;

  /// No description provided for @nameValidation.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get nameValidation;

  /// No description provided for @mobileValidation.
  ///
  /// In en, this message translates to:
  /// **'Mobile number must contain only numbers'**
  String get mobileValidation;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email'**
  String get enterValidEmail;

  /// No description provided for @passwordLengthShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordLengthShort;

  /// No description provided for @passwordMustHaveNonAlphanumeric.
  ///
  /// In en, this message translates to:
  /// **'Password must have at least one special character like (-, _ ,@)'**
  String get passwordMustHaveNonAlphanumeric;

  /// No description provided for @passwordMustHaveDigit.
  ///
  /// In en, this message translates to:
  /// **'Password must have at least one digit (\'0\'-\'9\')'**
  String get passwordMustHaveDigit;

  /// No description provided for @passwordMustHaveUppercase.
  ///
  /// In en, this message translates to:
  /// **'Password must have at least one uppercase (\'A\'-\'Z\')'**
  String get passwordMustHaveUppercase;

  /// No description provided for @passwordMustHaveLowercase.
  ///
  /// In en, this message translates to:
  /// **'Password must have at least one lowercase (\'a\'-\'z\')'**
  String get passwordMustHaveLowercase;

  /// No description provided for @logOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to logout?'**
  String get logOutConfirm;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @wordsHaveBeenSaved.
  ///
  /// In en, this message translates to:
  /// **'Selected words have been saved successfully'**
  String get wordsHaveBeenSaved;

  /// No description provided for @failedToSaveWords.
  ///
  /// In en, this message translates to:
  /// **'Failed to save selected words'**
  String get failedToSaveWords;

  /// No description provided for @selectWordsToSave.
  ///
  /// In en, this message translates to:
  /// **'Select words to save'**
  String get selectWordsToSave;

  /// No description provided for @confirmDeleteSavedWord.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete'**
  String get confirmDeleteSavedWord;

  /// No description provided for @fromSavedWords.
  ///
  /// In en, this message translates to:
  /// **'from saved words?'**
  String get fromSavedWords;

  /// No description provided for @failedToDeleteSavedWord.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete saved word'**
  String get failedToDeleteSavedWord;

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Permission Required'**
  String get permissionRequired;

  /// No description provided for @cameraPermissionSettings.
  ///
  /// In en, this message translates to:
  /// **'Camera access is required. Please enable camera permission in the app settings.'**
  String get cameraPermissionSettings;

  /// No description provided for @galleryPermissionSettings.
  ///
  /// In en, this message translates to:
  /// **'Gallery access is required. Please enable camera permission in the app settings.'**
  String get galleryPermissionSettings;

  /// No description provided for @qrPermissionError.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is denied'**
  String get qrPermissionError;

  /// No description provided for @galleryPermissionError.
  ///
  /// In en, this message translates to:
  /// **'Gallery permission is denied'**
  String get galleryPermissionError;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @waitToturRespond.
  ///
  /// In en, this message translates to:
  /// **'Wait for the tutor to finish responding'**
  String get waitToturRespond;

  /// No description provided for @onlyLettersAllowed.
  ///
  /// In en, this message translates to:
  /// **'This field can contain only letters.'**
  String get onlyLettersAllowed;

  /// No description provided for @finishRecoridng.
  ///
  /// In en, this message translates to:
  /// **'Please finish recording first.'**
  String get finishRecoridng;

  /// No description provided for @editAccent.
  ///
  /// In en, this message translates to:
  /// **'Edit accent'**
  String get editAccent;

  /// No description provided for @avatarMuted.
  ///
  /// In en, this message translates to:
  /// **'The avatar voice is muted'**
  String get avatarMuted;

  /// No description provided for @joinGlosa.
  ///
  /// In en, this message translates to:
  /// **'Join me to try ArenaX today!'**
  String get joinGlosa;

  /// No description provided for @searchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search for the country'**
  String get searchCountry;

  /// No description provided for @passwordRulesInfo.
  ///
  /// In en, this message translates to:
  /// **'Password rules'**
  String get passwordRulesInfo;

  /// No description provided for @passwordNoArabic.
  ///
  /// In en, this message translates to:
  /// **'Password must not contain arabic letters.'**
  String get passwordNoArabic;

  /// No description provided for @loginWithGmail.
  ///
  /// In en, this message translates to:
  /// **'Login with gmail'**
  String get loginWithGmail;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'An email containing password reset data has been sent'**
  String get emailSent;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @enterLesson.
  ///
  /// In en, this message translates to:
  /// **'Please enter the lesson name'**
  String get enterLesson;

  /// No description provided for @micPermissionSettings.
  ///
  /// In en, this message translates to:
  /// **'Microphone access is required. Please enable microphone permission in the app settings.'**
  String get micPermissionSettings;

  /// No description provided for @enterPhoneToResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to reset password'**
  String get enterPhoneToResetPassword;

  /// No description provided for @b1IntermediateLevel.
  ///
  /// In en, this message translates to:
  /// **'B1 (Intermediate)'**
  String get b1IntermediateLevel;

  /// No description provided for @b2UpperIntermediateLevel.
  ///
  /// In en, this message translates to:
  /// **'B2 (Upper-Intermediate)'**
  String get b2UpperIntermediateLevel;

  /// No description provided for @a1ElementaryLevel.
  ///
  /// In en, this message translates to:
  /// **'A1 (Elementary)'**
  String get a1ElementaryLevel;

  /// No description provided for @a2PreIntermediateLevel.
  ///
  /// In en, this message translates to:
  /// **'A2 (Pre-Intermediate)'**
  String get a2PreIntermediateLevel;

  /// No description provided for @startTrialDays.
  ///
  /// In en, this message translates to:
  /// **'Start your '**
  String get startTrialDays;

  /// No description provided for @startTrialDaysContinueText.
  ///
  /// In en, this message translates to:
  /// **' days free trial to continue'**
  String get startTrialDaysContinueText;

  /// No description provided for @limitlessChat.
  ///
  /// In en, this message translates to:
  /// **'Limitless chats with AI'**
  String get limitlessChat;

  /// No description provided for @talkAndLearn.
  ///
  /// In en, this message translates to:
  /// **'Talk & learn without limits'**
  String get talkAndLearn;

  /// No description provided for @limitlessAccess.
  ///
  /// In en, this message translates to:
  /// **'Limitless acces'**
  String get limitlessAccess;

  /// No description provided for @accessAllLevels.
  ///
  /// In en, this message translates to:
  /// **'Access all English levels '**
  String get accessAllLevels;

  /// No description provided for @bestValue.
  ///
  /// In en, this message translates to:
  /// **'Best Value'**
  String get bestValue;

  /// No description provided for @subscripe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscripe;

  /// No description provided for @startFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'Start free trial'**
  String get startFreeTrial;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @plus.
  ///
  /// In en, this message translates to:
  /// **'Plus'**
  String get plus;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @accountDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully'**
  String get accountDeletedSuccessfully;

  /// No description provided for @confirmDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Confirm delete account'**
  String get confirmDeleteAccount;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorOccured.
  ///
  /// In en, this message translates to:
  /// **'An error has occurred,please try again'**
  String get errorOccured;

  /// No description provided for @reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  /// No description provided for @quarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get quarterly;

  /// No description provided for @annual.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get annual;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @yourPlanIs.
  ///
  /// In en, this message translates to:
  /// **'Your plan is'**
  String get yourPlanIs;

  /// No description provided for @youtRenewDateIs.
  ///
  /// In en, this message translates to:
  /// **'Your renew date is:'**
  String get youtRenewDateIs;

  /// No description provided for @daysLeftInFree.
  ///
  /// In en, this message translates to:
  /// **'in free trial, Subscribe to continue'**
  String get daysLeftInFree;

  /// No description provided for @dayLeftInSubscription.
  ///
  /// In en, this message translates to:
  /// **'in your subscription, Subscribe to continue'**
  String get dayLeftInSubscription;

  /// No description provided for @continueFree.
  ///
  /// In en, this message translates to:
  /// **'Continue free trial'**
  String get continueFree;

  /// No description provided for @continueSubscription.
  ///
  /// In en, this message translates to:
  /// **'Continue subscription'**
  String get continueSubscription;

  /// No description provided for @freeTrialEnded.
  ///
  /// In en, this message translates to:
  /// **'Your free trial has ended. Subscribe to continue.'**
  String get freeTrialEnded;

  /// No description provided for @subscriptionEnded.
  ///
  /// In en, this message translates to:
  /// **'Your subscription has ended. Subscribe to continue.'**
  String get subscriptionEnded;

  /// No description provided for @yourPlanIsFree.
  ///
  /// In en, this message translates to:
  /// **'Your on free trial plan'**
  String get yourPlanIsFree;

  /// No description provided for @yourPlanIsQuarterly.
  ///
  /// In en, this message translates to:
  /// **'Your plan is Quarterly.'**
  String get yourPlanIsQuarterly;

  /// No description provided for @yourPlanIsAnnual.
  ///
  /// In en, this message translates to:
  /// **'Your plan is annual.'**
  String get yourPlanIsAnnual;

  /// No description provided for @annualPlanEnded.
  ///
  /// In en, this message translates to:
  /// **'Your annual plan ended, Subscribe to continue.'**
  String get annualPlanEnded;

  /// No description provided for @quarterlyPlanEnded.
  ///
  /// In en, this message translates to:
  /// **'Your quarterly plan ended, Subscribe to continue.'**
  String get quarterlyPlanEnded;

  /// No description provided for @alreadyPurchased.
  ///
  /// In en, this message translates to:
  /// **'This is your active product , you can’t buy it right now'**
  String get alreadyPurchased;

  /// No description provided for @alreadyPurchasedSubscription.
  ///
  /// In en, this message translates to:
  /// **'Already purchased subscription ?'**
  String get alreadyPurchasedSubscription;

  /// No description provided for @restorePurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore purchase'**
  String get restorePurchase;

  /// No description provided for @notSubscribed.
  ///
  /// In en, this message translates to:
  /// **'Not subscribed'**
  String get notSubscribed;

  /// No description provided for @newSupscriptionActivateOnRenew.
  ///
  /// In en, this message translates to:
  /// **'The new package that you would like to purchase will be activated after the current package is expired'**
  String get newSupscriptionActivateOnRenew;

  /// No description provided for @termsOfUser.
  ///
  /// In en, this message translates to:
  /// **'Terms of user'**
  String get termsOfUser;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @appUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'App Update'**
  String get appUpdateTitle;

  /// No description provided for @updateMessage.
  ///
  /// In en, this message translates to:
  /// **'To enjoy latest features and experience, please update the application'**
  String get updateMessage;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get updateNow;

  /// No description provided for @noSubscriptionsFound.
  ///
  /// In en, this message translates to:
  /// **'No active subscriptions found'**
  String get noSubscriptionsFound;

  /// No description provided for @loginVerification.
  ///
  /// In en, this message translates to:
  /// **'Login verification'**
  String get loginVerification;

  /// No description provided for @nameDetails.
  ///
  /// In en, this message translates to:
  /// **'Name Details'**
  String get nameDetails;

  /// No description provided for @giveCreadential.
  ///
  /// In en, this message translates to:
  /// **'Give credential to sign in your account'**
  String get giveCreadential;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @weSentConfirmationCode.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you the verification code to'**
  String get weSentConfirmationCode;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @enterEmailToResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email adress to request a Password reset'**
  String get enterEmailToResetPassword;

  /// No description provided for @selectInterests.
  ///
  /// In en, this message translates to:
  /// **'Select Your Three Interests'**
  String get selectInterests;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @locationPermissionSettings.
  ///
  /// In en, this message translates to:
  /// **'Location access is required. Please enable location permission in the app settings.'**
  String get locationPermissionSettings;

  /// No description provided for @searchNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Search new address...'**
  String get searchNewAddress;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @findBookPlayTogether.
  ///
  /// In en, this message translates to:
  /// **'Find. Book. Play. Together.'**
  String get findBookPlayTogether;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @findYourPlaceToPlay.
  ///
  /// In en, this message translates to:
  /// **'Find your place to play'**
  String get findYourPlaceToPlay;

  /// No description provided for @discoverThings.
  ///
  /// In en, this message translates to:
  /// **'Discover padel, football pitches, and co-working spaces near you.'**
  String get discoverThings;

  /// No description provided for @findBookPlay.
  ///
  /// In en, this message translates to:
  /// **'Find. Book. Play.'**
  String get findBookPlay;

  /// No description provided for @together.
  ///
  /// In en, this message translates to:
  /// **'Together.'**
  String get together;

  /// No description provided for @bookThenSplit.
  ///
  /// In en, this message translates to:
  /// **'Book padel, football, and co-working spaces — then split it with your crew.'**
  String get bookThenSplit;

  /// No description provided for @continueWithPhone.
  ///
  /// In en, this message translates to:
  /// **'Continue with phone'**
  String get continueWithPhone;

  /// No description provided for @iAlreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get iAlreadyHaveAnAccount;

  /// No description provided for @byContinuingYouAgreeToOur.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our'**
  String get byContinuingYouAgreeToOur;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @mobileValidateMsg.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid mobile number'**
  String get mobileValidateMsg;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhoneNumber;

  /// No description provided for @enterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhone;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get phoneIsRequired;

  /// No description provided for @weWillSendDigits.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a 6-digit code to verify it\'s you.'**
  String get weWillSendDigits;

  /// No description provided for @egyptionsOnly.
  ///
  /// In en, this message translates to:
  /// **'Egyptian mobile numbers only at launch'**
  String get egyptionsOnly;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendCode;

  /// No description provided for @enterTheCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get enterTheCode;

  /// No description provided for @weSentItToYou.
  ///
  /// In en, this message translates to:
  /// **'We sent it to '**
  String get weSentItToYou;

  /// No description provided for @changeNumber.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get changeNumber;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
