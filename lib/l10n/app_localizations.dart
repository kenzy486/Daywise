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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'DayWise'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Small daily habits, a healthier you.'**
  String get tagline;

  /// No description provided for @switchLanguage.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get switchLanguage;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

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

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a link to reset your password.'**
  String get resetPasswordInfo;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get sendResetLink;

  /// No description provided for @resetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Check your email for a reset link.'**
  String get resetEmailSent;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get noAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log in'**
  String get haveAccount;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @notMedicalAdvice.
  ///
  /// In en, this message translates to:
  /// **'DayWise is not medical advice.'**
  String get notMedicalAdvice;

  /// No description provided for @errRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get errRequired;

  /// No description provided for @errInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email.'**
  String get errInvalidEmail;

  /// No description provided for @errWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get errWeakPassword;

  /// No description provided for @errPasswordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get errPasswordsDontMatch;

  /// No description provided for @errEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered. Try logging in.'**
  String get errEmailInUse;

  /// No description provided for @errWrongCredentials.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect.'**
  String get errWrongCredentials;

  /// No description provided for @errTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait and try again.'**
  String get errTooManyRequests;

  /// No description provided for @errNetwork.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please try again.'**
  String get errNetwork;

  /// No description provided for @errUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errUnknown;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Log in to continue.'**
  String get loginSubtitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account to start caring for your day.'**
  String get signupSubtitle;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to log in'**
  String get backToLogin;

  /// No description provided for @loggedInAs.
  ///
  /// In en, this message translates to:
  /// **'Logged in as {email}'**
  String loggedInAs(String email);

  /// No description provided for @navCheckin.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get navCheckin;

  /// No description provided for @navTrends.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get navTrends;

  /// No description provided for @navInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// No description provided for @navTips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get navTips;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @dailyCheckin.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in'**
  String get dailyCheckin;

  /// No description provided for @myTrends.
  ///
  /// In en, this message translates to:
  /// **'My trends'**
  String get myTrends;

  /// No description provided for @myInsights.
  ///
  /// In en, this message translates to:
  /// **'My insights'**
  String get myInsights;

  /// No description provided for @tipsForToday.
  ///
  /// In en, this message translates to:
  /// **'Tips for today'**
  String get tipsForToday;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon…'**
  String get comingSoon;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to log out?'**
  String get logoutConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @medicalDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'DayWise helps you notice your own habits. It does not diagnose any condition and is not a replacement for a doctor. If you feel unwell, please talk to a health professional.'**
  String get medicalDisclaimer;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to DayWise'**
  String get welcomeTitle;

  /// No description provided for @welcomePoint1.
  ///
  /// In en, this message translates to:
  /// **'Log your day in less than a minute.'**
  String get welcomePoint1;

  /// No description provided for @welcomePoint2.
  ///
  /// In en, this message translates to:
  /// **'See how sleep, water and exercise affect your mood and energy.'**
  String get welcomePoint2;

  /// No description provided for @welcomePoint3.
  ///
  /// In en, this message translates to:
  /// **'Get friendly tips for today.'**
  String get welcomePoint3;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @sleepHours.
  ///
  /// In en, this message translates to:
  /// **'Sleep (hours)'**
  String get sleepHours;

  /// No description provided for @waterGlasses.
  ///
  /// In en, this message translates to:
  /// **'Water (glasses)'**
  String get waterGlasses;

  /// No description provided for @exerciseMinutes.
  ///
  /// In en, this message translates to:
  /// **'Exercise (minutes)'**
  String get exerciseMinutes;

  /// No description provided for @mood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get mood;

  /// No description provided for @energy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get energy;

  /// No description provided for @stress.
  ///
  /// In en, this message translates to:
  /// **'Stress'**
  String get stress;

  /// No description provided for @level1.
  ///
  /// In en, this message translates to:
  /// **'Very low'**
  String get level1;

  /// No description provided for @level2.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get level2;

  /// No description provided for @level3.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get level3;

  /// No description provided for @level4.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get level4;

  /// No description provided for @level5.
  ///
  /// In en, this message translates to:
  /// **'Very high'**
  String get level5;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @updateCheckin.
  ///
  /// In en, this message translates to:
  /// **'Update check-in'**
  String get updateCheckin;

  /// No description provided for @alreadyLogged.
  ///
  /// In en, this message translates to:
  /// **'You already logged this day. Saving will update it.'**
  String get alreadyLogged;

  /// No description provided for @savedMessage.
  ///
  /// In en, this message translates to:
  /// **'Saved! Great job taking care of yourself.'**
  String get savedMessage;

  /// No description provided for @errSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save. Check your internet and try again.'**
  String get errSaveFailed;

  /// No description provided for @errLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load this day. Check your internet.'**
  String get errLoadFailed;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hey there 👋'**
  String get greeting;

  /// No description provided for @checkinPrompt.
  ///
  /// In en, this message translates to:
  /// **'How\'s your day going? Let\'s check in.'**
  String get checkinPrompt;

  /// No description provided for @demoTools.
  ///
  /// In en, this message translates to:
  /// **'Demo tools'**
  String get demoTools;

  /// No description provided for @demoToolsInfo.
  ///
  /// In en, this message translates to:
  /// **'For the hackathon demo only. Fill this account with 60 days of sample check-ins, or delete all check-ins. Filling replaces the last 60 days.'**
  String get demoToolsInfo;

  /// No description provided for @demoFill.
  ///
  /// In en, this message translates to:
  /// **'Fill 60 days'**
  String get demoFill;

  /// No description provided for @demoClear.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get demoClear;

  /// No description provided for @demoFilled.
  ///
  /// In en, this message translates to:
  /// **'{count} demo days added.'**
  String demoFilled(int count);

  /// No description provided for @demoCleared.
  ///
  /// In en, this message translates to:
  /// **'{count} days deleted.'**
  String demoCleared(int count);

  /// No description provided for @last7Days.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get last7Days;

  /// No description provided for @last30Days.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get last30Days;

  /// No description provided for @averagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Your averages'**
  String get averagesTitle;

  /// No description provided for @basedOnCheckins.
  ///
  /// In en, this message translates to:
  /// **'Based on {count} check-ins'**
  String basedOnCheckins(int count);

  /// No description provided for @avgSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep (h)'**
  String get avgSleep;

  /// No description provided for @avgWater.
  ///
  /// In en, this message translates to:
  /// **'Water (glasses)'**
  String get avgWater;

  /// No description provided for @avgExercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise (min)'**
  String get avgExercise;

  /// No description provided for @sleepGoalNote.
  ///
  /// In en, this message translates to:
  /// **'Green bars = 7+ hours. Dashed line = 7 hours.'**
  String get sleepGoalNote;

  /// No description provided for @stressNote.
  ///
  /// In en, this message translates to:
  /// **'Lower is better.'**
  String get stressNote;

  /// No description provided for @noCheckinsYet.
  ///
  /// In en, this message translates to:
  /// **'No check-ins in this period yet. Log your day to see your trends!'**
  String get noCheckinsYet;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'What affects you most'**
  String get insightsTitle;

  /// No description provided for @logMoreDays.
  ///
  /// In en, this message translates to:
  /// **'Log {count} more days to see your insights.'**
  String logMoreDays(int count);

  /// No description provided for @insightsProgress.
  ///
  /// In en, this message translates to:
  /// **'{count} of 7 days logged'**
  String insightsProgress(int count);

  /// No description provided for @insightSentence.
  ///
  /// In en, this message translates to:
  /// **'On days you {habit}, {metric} is {points} points {direction}.'**
  String insightSentence(
    String habit,
    String metric,
    String points,
    String direction,
  );

  /// No description provided for @habitSleep.
  ///
  /// In en, this message translates to:
  /// **'sleep 7+ hours'**
  String get habitSleep;

  /// No description provided for @habitWater.
  ///
  /// In en, this message translates to:
  /// **'drink 6+ glasses of water'**
  String get habitWater;

  /// No description provided for @habitExercise.
  ///
  /// In en, this message translates to:
  /// **'exercise 30+ minutes'**
  String get habitExercise;

  /// No description provided for @metricEnergy.
  ///
  /// In en, this message translates to:
  /// **'your energy'**
  String get metricEnergy;

  /// No description provided for @metricMood.
  ///
  /// In en, this message translates to:
  /// **'your mood'**
  String get metricMood;

  /// No description provided for @higher.
  ///
  /// In en, this message translates to:
  /// **'higher'**
  String get higher;

  /// No description provided for @lower.
  ///
  /// In en, this message translates to:
  /// **'lower'**
  String get lower;

  /// No description provided for @groupSleepYes.
  ///
  /// In en, this message translates to:
  /// **'7+ hours'**
  String get groupSleepYes;

  /// No description provided for @groupSleepNo.
  ///
  /// In en, this message translates to:
  /// **'Under 7 h'**
  String get groupSleepNo;

  /// No description provided for @groupWaterYes.
  ///
  /// In en, this message translates to:
  /// **'6+ glasses'**
  String get groupWaterYes;

  /// No description provided for @groupWaterNo.
  ///
  /// In en, this message translates to:
  /// **'Under 6'**
  String get groupWaterNo;

  /// No description provided for @groupExerciseYes.
  ///
  /// In en, this message translates to:
  /// **'30+ min'**
  String get groupExerciseYes;

  /// No description provided for @groupExerciseNo.
  ///
  /// In en, this message translates to:
  /// **'Under 30 min'**
  String get groupExerciseNo;

  /// No description provided for @daysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String daysCount(int count);

  /// No description provided for @noPatternsYet.
  ///
  /// In en, this message translates to:
  /// **'No clear patterns yet. Keep logging and check back soon!'**
  String get noPatternsYet;

  /// No description provided for @insightsNote.
  ///
  /// In en, this message translates to:
  /// **'These are patterns in your own check-ins, not proof of cause and not medical advice.'**
  String get insightsNote;

  /// No description provided for @tipsHeader.
  ///
  /// In en, this message translates to:
  /// **'3 small things to try today ✨'**
  String get tipsHeader;

  /// No description provided for @tipsPersonal.
  ///
  /// In en, this message translates to:
  /// **'Picked for you from your check-ins.'**
  String get tipsPersonal;

  /// No description provided for @tipsGeneral.
  ///
  /// In en, this message translates to:
  /// **'Log 7 days to get tips picked just for you.'**
  String get tipsGeneral;

  /// No description provided for @areaSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get areaSleep;

  /// No description provided for @areaWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get areaWater;

  /// No description provided for @areaExercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get areaExercise;

  /// No description provided for @reasonBigEffect.
  ///
  /// In en, this message translates to:
  /// **'Makes a big difference for you'**
  String get reasonBigEffect;

  /// No description provided for @reasonHighStress.
  ///
  /// In en, this message translates to:
  /// **'Your stress has been high this week'**
  String get reasonHighStress;

  /// No description provided for @reasonGeneral.
  ///
  /// In en, this message translates to:
  /// **'A healthy habit to try'**
  String get reasonGeneral;

  /// No description provided for @seeAllTips.
  ///
  /// In en, this message translates to:
  /// **'See all 5 tips'**
  String get seeAllTips;

  /// No description provided for @tipSleep1.
  ///
  /// In en, this message translates to:
  /// **'Try going to bed at the same time tonight, even on weekends.'**
  String get tipSleep1;

  /// No description provided for @tipSleep2.
  ///
  /// In en, this message translates to:
  /// **'Put your phone away 30 minutes before sleep. 📵'**
  String get tipSleep2;

  /// No description provided for @tipSleep3.
  ///
  /// In en, this message translates to:
  /// **'Keep your room dark, quiet and a little cool.'**
  String get tipSleep3;

  /// No description provided for @tipSleep4.
  ///
  /// In en, this message translates to:
  /// **'Skip coffee and energy drinks after 4 pm. ☕'**
  String get tipSleep4;

  /// No description provided for @tipSleep5.
  ///
  /// In en, this message translates to:
  /// **'A short wind-down routine helps: a shower, a stretch, or a few pages of a book.'**
  String get tipSleep5;

  /// No description provided for @tipWater1.
  ///
  /// In en, this message translates to:
  /// **'Start your day with a glass of water before anything else. 💧'**
  String get tipWater1;

  /// No description provided for @tipWater2.
  ///
  /// In en, this message translates to:
  /// **'Keep a water bottle on your desk where you can see it.'**
  String get tipWater2;

  /// No description provided for @tipWater3.
  ///
  /// In en, this message translates to:
  /// **'Drink a glass of water with every meal.'**
  String get tipWater3;

  /// No description provided for @tipWater4.
  ///
  /// In en, this message translates to:
  /// **'Add lemon or mint if plain water feels boring. 🍋'**
  String get tipWater4;

  /// No description provided for @tipWater5.
  ///
  /// In en, this message translates to:
  /// **'Set 3 small reminders on your phone to sip some water.'**
  String get tipWater5;

  /// No description provided for @tipExercise1.
  ///
  /// In en, this message translates to:
  /// **'A 10-minute walk counts! Try one after lunch. 🚶'**
  String get tipExercise1;

  /// No description provided for @tipExercise2.
  ///
  /// In en, this message translates to:
  /// **'Take the stairs instead of the elevator today.'**
  String get tipExercise2;

  /// No description provided for @tipExercise3.
  ///
  /// In en, this message translates to:
  /// **'Put on your favorite song and dance it out. 💃'**
  String get tipExercise3;

  /// No description provided for @tipExercise4.
  ///
  /// In en, this message translates to:
  /// **'Invite a friend for a walk. It\'s more fun together.'**
  String get tipExercise4;

  /// No description provided for @tipExercise5.
  ///
  /// In en, this message translates to:
  /// **'Stretch for 5 minutes when you wake up.'**
  String get tipExercise5;

  /// No description provided for @tipStress1.
  ///
  /// In en, this message translates to:
  /// **'Try box breathing: in for 4, hold for 4, out for 4, hold for 4. 🫁'**
  String get tipStress1;

  /// No description provided for @tipStress2.
  ///
  /// In en, this message translates to:
  /// **'Write down 3 things you\'re grateful for today. ✍️'**
  String get tipStress2;

  /// No description provided for @tipStress3.
  ///
  /// In en, this message translates to:
  /// **'Take a 5-minute break away from all screens.'**
  String get tipStress3;

  /// No description provided for @tipStress4.
  ///
  /// In en, this message translates to:
  /// **'Talk to a friend or family member about your day.'**
  String get tipStress4;

  /// No description provided for @tipStress5.
  ///
  /// In en, this message translates to:
  /// **'Step outside for some fresh air and sunlight. ☀️'**
  String get tipStress5;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'We\'re here for you 💜'**
  String get supportTitle;

  /// No description provided for @supportBody.
  ///
  /// In en, this message translates to:
  /// **'Your mood has been low every day this past week. That sounds really hard. You don\'t have to go through it alone. Talking to someone you trust, or to a professional, can really help.'**
  String get supportBody;

  /// No description provided for @supportHelpline.
  ///
  /// In en, this message translates to:
  /// **'Helpline'**
  String get supportHelpline;

  /// No description provided for @copyNumber.
  ///
  /// In en, this message translates to:
  /// **'Copy number'**
  String get copyNumber;

  /// No description provided for @numberCopied.
  ///
  /// In en, this message translates to:
  /// **'Number copied'**
  String get numberCopied;

  /// No description provided for @demoLowMood.
  ///
  /// In en, this message translates to:
  /// **'Low-mood week'**
  String get demoLowMood;

  /// No description provided for @demoLowMoodDone.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days set to low mood.'**
  String get demoLowMoodDone;
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
    'that was used.',
  );
}
