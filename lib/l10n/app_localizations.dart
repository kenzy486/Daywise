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
  /// **'Small habits. Your patterns. Better days.'**
  String get tagline;

  /// No description provided for @switchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get switchLanguage;

  /// No description provided for @notMedicalAdvice.
  ///
  /// In en, this message translates to:
  /// **'DayWise supports healthy habits; it does not give medical advice.'**
  String get notMedicalAdvice;

  /// No description provided for @demoDisclosure.
  ///
  /// In en, this message translates to:
  /// **'Nour’s illustrative demo · not real health data'**
  String get demoDisclosure;

  /// No description provided for @increase.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get increase;

  /// No description provided for @decrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get decrease;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navCheckin.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in'**
  String get navCheckin;

  /// No description provided for @navInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// No description provided for @navInsightsLong.
  ///
  /// In en, this message translates to:
  /// **'Personal insights'**
  String get navInsightsLong;

  /// No description provided for @navForYou.
  ///
  /// In en, this message translates to:
  /// **'For you'**
  String get navForYou;

  /// No description provided for @navSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get navSupport;

  /// No description provided for @yourSpace.
  ///
  /// In en, this message translates to:
  /// **'Your space'**
  String get yourSpace;

  /// No description provided for @breadcrumb.
  ///
  /// In en, this message translates to:
  /// **'Your space / {page}'**
  String breadcrumb(String page);

  /// No description provided for @welcomeEyebrow.
  ///
  /// In en, this message translates to:
  /// **'A LITTLE ROOM FOR YOU'**
  String get welcomeEyebrow;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Better days start with a small hello.'**
  String get welcomeTitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordCreateHint.
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get passwordCreateHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get passwordHint;

  /// No description provided for @passwordHelper.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters.'**
  String get passwordHelper;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms and Privacy Policy. My journal stays private by default.'**
  String get termsAgreement;

  /// No description provided for @termsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms and Privacy Policy to continue.'**
  String get termsRequired;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create my free account'**
  String get createAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get haveAccount;

  /// No description provided for @trustTitle.
  ///
  /// In en, this message translates to:
  /// **'No real name. No wearable. No pressure.'**
  String get trustTitle;

  /// No description provided for @exploreDemo.
  ///
  /// In en, this message translates to:
  /// **'Just looking? Explore Nour’s demo'**
  String get exploreDemo;

  /// No description provided for @signInEyebrow.
  ///
  /// In en, this message translates to:
  /// **'WELCOME BACK'**
  String get signInEyebrow;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Good to see you again.'**
  String get signInTitle;

  /// No description provided for @signInBody.
  ///
  /// In en, this message translates to:
  /// **'Pick up where you left off. Your journal is just as you left it.'**
  String get signInBody;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'New here? Create an account'**
  String get noAccount;

  /// No description provided for @resetEyebrow.
  ///
  /// In en, this message translates to:
  /// **'NO WORRIES'**
  String get resetEyebrow;

  /// No description provided for @resetTitle.
  ///
  /// In en, this message translates to:
  /// **'Let’s get you back in.'**
  String get resetTitle;

  /// No description provided for @resetBody.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we’ll send you a link to choose a new password.'**
  String get resetBody;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get sendResetLink;

  /// No description provided for @resetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for that email, a reset link is on its way.'**
  String get resetEmailSent;

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get backToSignIn;

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
  /// **'Use at least 8 characters.'**
  String get errWeakPassword;

  /// No description provided for @errEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered. Try signing in.'**
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
  /// **'No connection. Check your internet and try again.'**
  String get errNetwork;

  /// No description provided for @errUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errUnknown;

  /// No description provided for @errSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t save right now. Please try again.'**
  String get errSaveFailed;

  /// No description provided for @goalsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'LET’S MAKE THIS YOURS · 1 OF 2'**
  String get goalsEyebrow;

  /// No description provided for @goalsTitle.
  ///
  /// In en, this message translates to:
  /// **'What would you like more room for?'**
  String get goalsTitle;

  /// No description provided for @goalsBody.
  ///
  /// In en, this message translates to:
  /// **'Choose what matters to you. You can change your mind anytime.'**
  String get goalsBody;

  /// No description provided for @goalsSelected.
  ///
  /// In en, this message translates to:
  /// **'Choose one or more · {count} selected'**
  String goalsSelected(String count);

  /// No description provided for @goalSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep better'**
  String get goalSleep;

  /// No description provided for @goalSleepDesc.
  ///
  /// In en, this message translates to:
  /// **'Make a little room for rest'**
  String get goalSleepDesc;

  /// No description provided for @goalStress.
  ///
  /// In en, this message translates to:
  /// **'Less stress'**
  String get goalStress;

  /// No description provided for @goalStressDesc.
  ///
  /// In en, this message translates to:
  /// **'Find pauses that fit your day'**
  String get goalStressDesc;

  /// No description provided for @goalEnergy.
  ///
  /// In en, this message translates to:
  /// **'More energy'**
  String get goalEnergy;

  /// No description provided for @goalEnergyDesc.
  ///
  /// In en, this message translates to:
  /// **'Notice what helps you recharge'**
  String get goalEnergyDesc;

  /// No description provided for @goalActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get goalActivity;

  /// No description provided for @goalActivityDesc.
  ///
  /// In en, this message translates to:
  /// **'Move in ways that feel doable'**
  String get goalActivityDesc;

  /// No description provided for @goalNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get goalNutrition;

  /// No description provided for @goalNutritionDesc.
  ///
  /// In en, this message translates to:
  /// **'Explore everyday eating habits'**
  String get goalNutritionDesc;

  /// No description provided for @goalsQuote.
  ///
  /// In en, this message translates to:
  /// **'No targets to chase. Just a direction that feels like you.'**
  String get goalsQuote;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @decideLater.
  ///
  /// In en, this message translates to:
  /// **'I’ll decide later'**
  String get decideLater;

  /// No description provided for @nameEyebrow.
  ///
  /// In en, this message translates to:
  /// **'LET’S MAKE THIS YOURS · 2 OF 2'**
  String get nameEyebrow;

  /// No description provided for @nameTitle.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get nameTitle;

  /// No description provided for @nameBody.
  ///
  /// In en, this message translates to:
  /// **'A nickname is plenty. It stays in your journal and is never shared.'**
  String get nameBody;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Nour'**
  String get nameHint;

  /// No description provided for @startJournal.
  ///
  /// In en, this message translates to:
  /// **'Start my journal'**
  String get startJournal;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @todayTitle.
  ///
  /// In en, this message translates to:
  /// **'A little space for you, {name}.'**
  String todayTitle(String name);

  /// No description provided for @todayTitleNoName.
  ///
  /// In en, this message translates to:
  /// **'A little space for you.'**
  String get todayTitleNoName;

  /// No description provided for @todaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'No perfect day needed. Just yours.'**
  String get todaySubtitle;

  /// No description provided for @todaySubtitleDesktop.
  ///
  /// In en, this message translates to:
  /// **'Notice your days. Be kind to the person living them.'**
  String get todaySubtitleDesktop;

  /// No description provided for @yourOverview.
  ///
  /// In en, this message translates to:
  /// **'Your overview'**
  String get yourOverview;

  /// No description provided for @weekAtGlance.
  ///
  /// In en, this message translates to:
  /// **'Your week at a glance'**
  String get weekAtGlance;

  /// No description provided for @days7.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get days7;

  /// No description provided for @days30.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get days30;

  /// No description provided for @checkinsSoFar.
  ///
  /// In en, this message translates to:
  /// **'{total} check-ins so far · {inRange} in this range'**
  String checkinsSoFar(String total, String inRange);

  /// No description provided for @wellbeingTitle.
  ///
  /// In en, this message translates to:
  /// **'Well-being'**
  String get wellbeingTitle;

  /// No description provided for @latestOn.
  ///
  /// In en, this message translates to:
  /// **'Latest · {date}'**
  String latestOn(String date);

  /// No description provided for @outOf100.
  ///
  /// In en, this message translates to:
  /// **'{score} out of 100'**
  String outOf100(String score);

  /// No description provided for @outOf100Short.
  ///
  /// In en, this message translates to:
  /// **'out of 100'**
  String get outOf100Short;

  /// No description provided for @ratingOf5.
  ///
  /// In en, this message translates to:
  /// **'{value} / 5'**
  String ratingOf5(String value);

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

  /// No description provided for @wellbeingNote.
  ///
  /// In en, this message translates to:
  /// **'A reflection of mood, energy and stress. Not a medical measure or a grade.'**
  String get wellbeingNote;

  /// No description provided for @wellbeingNoteDesktop.
  ///
  /// In en, this message translates to:
  /// **'A reflection, not a diagnosis. Your score combines mood, energy and stress.'**
  String get wellbeingNoteDesktop;

  /// No description provided for @wellbeingEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your score appears after your first check-in.'**
  String get wellbeingEmpty;

  /// No description provided for @checkinCta.
  ///
  /// In en, this message translates to:
  /// **'How are you today? Check in'**
  String get checkinCta;

  /// No description provided for @checkinCtaDesktop.
  ///
  /// In en, this message translates to:
  /// **'Today’s check-in'**
  String get checkinCtaDesktop;

  /// No description provided for @checkinEditCta.
  ///
  /// In en, this message translates to:
  /// **'Edit today’s check-in'**
  String get checkinEditCta;

  /// No description provided for @checkinOpenNote.
  ///
  /// In en, this message translates to:
  /// **'About 30 seconds · Today’s check-in is open'**
  String get checkinOpenNote;

  /// No description provided for @checkinDoneNote.
  ///
  /// In en, this message translates to:
  /// **'Saved for today · You can edit it anytime'**
  String get checkinDoneNote;

  /// No description provided for @feelingTitle.
  ///
  /// In en, this message translates to:
  /// **'How you’ve been feeling'**
  String get feelingTitle;

  /// No description provided for @feelingCaption.
  ///
  /// In en, this message translates to:
  /// **'{range} · scale 1–5 · lower stress is better'**
  String feelingCaption(String range);

  /// No description provided for @latestTriple.
  ///
  /// In en, this message translates to:
  /// **'Latest: {mood} / {energy} / {stress}'**
  String latestTriple(String mood, String energy, String stress);

  /// No description provided for @energyVaried.
  ///
  /// In en, this message translates to:
  /// **'Energy varied this week. Your notes can help add the context a chart can’t.'**
  String get energyVaried;

  /// No description provided for @restTitle.
  ///
  /// In en, this message translates to:
  /// **'Rest & movement'**
  String get restTitle;

  /// No description provided for @sleepHoursSeries.
  ///
  /// In en, this message translates to:
  /// **'Sleep · hours'**
  String get sleepHoursSeries;

  /// No description provided for @activitySeries.
  ///
  /// In en, this message translates to:
  /// **'Activity · minutes'**
  String get activitySeries;

  /// No description provided for @noDataYet.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged in this range yet.'**
  String get noDataYet;

  /// No description provided for @oneSmallThing.
  ///
  /// In en, this message translates to:
  /// **'ONE SMALL THING'**
  String get oneSmallThing;

  /// No description provided for @pendingProgress.
  ///
  /// In en, this message translates to:
  /// **'Pending · {done} of {total} done'**
  String pendingProgress(String done, String total);

  /// No description provided for @allDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'That’s all three for today.'**
  String get allDoneTitle;

  /// No description provided for @allDoneBody.
  ///
  /// In en, this message translates to:
  /// **'You made a little room today. Nothing more to do.'**
  String get allDoneBody;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @markDone.
  ///
  /// In en, this message translates to:
  /// **'Mark done'**
  String get markDone;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @skipToday.
  ///
  /// In en, this message translates to:
  /// **'Skip today'**
  String get skipToday;

  /// No description provided for @allSuggestions.
  ///
  /// In en, this message translates to:
  /// **'All 3 suggestions'**
  String get allSuggestions;

  /// No description provided for @seeTodaysSuggestions.
  ///
  /// In en, this message translates to:
  /// **'See today’s 3 suggestions'**
  String get seeTodaysSuggestions;

  /// No description provided for @patternEyebrow.
  ///
  /// In en, this message translates to:
  /// **'A PATTERN TO EXPLORE · {count} CHECK-INS'**
  String patternEyebrow(String count);

  /// No description provided for @exploreInsights.
  ///
  /// In en, this message translates to:
  /// **'Explore insights'**
  String get exploreInsights;

  /// No description provided for @exploreInsightsLong.
  ///
  /// In en, this message translates to:
  /// **'Explore your personal insights'**
  String get exploreInsightsLong;

  /// No description provided for @patternsNotProof.
  ///
  /// In en, this message translates to:
  /// **'Patterns aren’t proof of cause.'**
  String get patternsNotProof;

  /// No description provided for @patternsNotProofLong.
  ///
  /// In en, this message translates to:
  /// **'Patterns aren’t proof of cause. Other things may matter.'**
  String get patternsNotProofLong;

  /// No description provided for @almostThereTitle.
  ///
  /// In en, this message translates to:
  /// **'Patterns are on their way.'**
  String get almostThereTitle;

  /// No description provided for @almostThereBody.
  ///
  /// In en, this message translates to:
  /// **'{count} of 7 check-ins so far. Patterns begin after 7+ check-ins.'**
  String almostThereBody(String count);

  /// No description provided for @emptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your space is ready.'**
  String get emptyTitle;

  /// No description provided for @emptyBody.
  ///
  /// In en, this message translates to:
  /// **'Whenever you like, take a 30-second check-in. There’s no wrong answer.'**
  String get emptyBody;

  /// No description provided for @sidebarQuoteTitle.
  ///
  /// In en, this message translates to:
  /// **'You’re a person, not a progress bar.'**
  String get sidebarQuoteTitle;

  /// No description provided for @sidebarQuoteBody.
  ///
  /// In en, this message translates to:
  /// **'No streaks. No catching up. Just room to reflect.'**
  String get sidebarQuoteBody;

  /// No description provided for @journalOf.
  ///
  /// In en, this message translates to:
  /// **'{name}’s journal'**
  String journalOf(String name);

  /// No description provided for @myJournal.
  ///
  /// In en, this message translates to:
  /// **'My journal'**
  String get myJournal;

  /// No description provided for @cityLanguage.
  ///
  /// In en, this message translates to:
  /// **'{city} · English'**
  String cityLanguage(String city);

  /// No description provided for @recentReflections.
  ///
  /// In en, this message translates to:
  /// **'Recent reflections'**
  String get recentReflections;

  /// No description provided for @viewJournal.
  ///
  /// In en, this message translates to:
  /// **'View journal'**
  String get viewJournal;

  /// No description provided for @colCheckin.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get colCheckin;

  /// No description provided for @colSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get colSleep;

  /// No description provided for @colActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get colActive;

  /// No description provided for @colScore.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get colScore;

  /// No description provided for @hoursShort.
  ///
  /// In en, this message translates to:
  /// **'{value} h'**
  String hoursShort(String value);

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{value} min'**
  String minutesShort(String value);

  /// No description provided for @findSupportLink.
  ///
  /// In en, this message translates to:
  /// **'Need someone to talk to? Find support'**
  String get findSupportLink;

  /// No description provided for @checkinEyebrow.
  ///
  /// In en, this message translates to:
  /// **'{date} · DAILY CHECK-IN'**
  String checkinEyebrow(String date);

  /// No description provided for @checkinTitle.
  ///
  /// In en, this message translates to:
  /// **'How’s your day, really?'**
  String get checkinTitle;

  /// No description provided for @checkinBody.
  ///
  /// In en, this message translates to:
  /// **'A quick pause, just for you. Your best guess is enough.'**
  String get checkinBody;

  /// No description provided for @about30Seconds.
  ///
  /// In en, this message translates to:
  /// **'About 30 seconds'**
  String get about30Seconds;

  /// No description provided for @demoDraft.
  ///
  /// In en, this message translates to:
  /// **'Demo draft · not submitted'**
  String get demoDraft;

  /// No description provided for @editingToday.
  ///
  /// In en, this message translates to:
  /// **'Editing today’s entry'**
  String get editingToday;

  /// No description provided for @restSection.
  ///
  /// In en, this message translates to:
  /// **'Last night’s rest'**
  String get restSection;

  /// No description provided for @sleepHours.
  ///
  /// In en, this message translates to:
  /// **'Sleep hours'**
  String get sleepHours;

  /// No description provided for @sleepHelper.
  ///
  /// In en, this message translates to:
  /// **'0–12 hours · half-hour steps'**
  String get sleepHelper;

  /// No description provided for @sleepQuality.
  ///
  /// In en, this message translates to:
  /// **'Sleep quality'**
  String get sleepQuality;

  /// No description provided for @veryPoor.
  ///
  /// In en, this message translates to:
  /// **'Very poor'**
  String get veryPoor;

  /// No description provided for @veryGood.
  ///
  /// In en, this message translates to:
  /// **'Very good'**
  String get veryGood;

  /// No description provided for @veryLow.
  ///
  /// In en, this message translates to:
  /// **'Very low'**
  String get veryLow;

  /// No description provided for @veryHigh.
  ///
  /// In en, this message translates to:
  /// **'Very high'**
  String get veryHigh;

  /// No description provided for @innerWeather.
  ///
  /// In en, this message translates to:
  /// **'Your inner weather'**
  String get innerWeather;

  /// No description provided for @feelingsNote.
  ///
  /// In en, this message translates to:
  /// **'All feelings belong here. Higher isn’t always better — for stress, lower means calmer.'**
  String get feelingsNote;

  /// No description provided for @everydayThings.
  ///
  /// In en, this message translates to:
  /// **'The everyday things'**
  String get everydayThings;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @glasses.
  ///
  /// In en, this message translates to:
  /// **'glasses'**
  String get glasses;

  /// No description provided for @waterHelper.
  ///
  /// In en, this message translates to:
  /// **'One glass is roughly 250 ml.'**
  String get waterHelper;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @activityHelper.
  ///
  /// In en, this message translates to:
  /// **'Walking to class counts, too. Steps of 5 minutes.'**
  String get activityHelper;

  /// No description provided for @meals.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get meals;

  /// No description provided for @mealsUnit.
  ///
  /// In en, this message translates to:
  /// **'meals'**
  String get mealsUnit;

  /// No description provided for @breaks.
  ///
  /// In en, this message translates to:
  /// **'Breaks'**
  String get breaks;

  /// No description provided for @breaksUnit.
  ///
  /// In en, this message translates to:
  /// **'breaks'**
  String get breaksUnit;

  /// No description provided for @breaksHelper.
  ///
  /// In en, this message translates to:
  /// **'Pauses away from work or study.'**
  String get breaksHelper;

  /// No description provided for @screenTime.
  ///
  /// In en, this message translates to:
  /// **'Screen time'**
  String get screenTime;

  /// No description provided for @screenHelper.
  ///
  /// In en, this message translates to:
  /// **'0–16 hours · half-hour steps'**
  String get screenHelper;

  /// No description provided for @caffeine.
  ///
  /// In en, this message translates to:
  /// **'Caffeine'**
  String get caffeine;

  /// No description provided for @servings.
  ///
  /// In en, this message translates to:
  /// **'servings'**
  String get servings;

  /// No description provided for @caffeineHelper.
  ///
  /// In en, this message translates to:
  /// **'Count a cup of coffee, tea or an energy drink.'**
  String get caffeineHelper;

  /// No description provided for @phoneAway.
  ///
  /// In en, this message translates to:
  /// **'Phone away 30 min before bed?'**
  String get phoneAway;

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

  /// No description provided for @noteTitle.
  ///
  /// In en, this message translates to:
  /// **'Anything on your mind?'**
  String get noteTitle;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'A sentence or two about your day…'**
  String get noteHint;

  /// No description provided for @notePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Only for your journal. No real name needed.'**
  String get notePrivacy;

  /// No description provided for @saveCheckin.
  ///
  /// In en, this message translates to:
  /// **'Save today’s check-in'**
  String get saveCheckin;

  /// No description provided for @updateCheckin.
  ///
  /// In en, this message translates to:
  /// **'Update today’s check-in'**
  String get updateCheckin;

  /// No description provided for @checkinFooter.
  ///
  /// In en, this message translates to:
  /// **'One entry for today. You can edit it later.\nPatterns begin after 7+ check-ins.'**
  String get checkinFooter;

  /// No description provided for @checkinSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved. Thanks for taking a moment for yourself.'**
  String get checkinSaved;

  /// No description provided for @insightsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'YOUR PATTERNS, NOT A PRESCRIPTION'**
  String get insightsEyebrow;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Get to know your days.'**
  String get insightsTitle;

  /// No description provided for @insightsBody.
  ///
  /// In en, this message translates to:
  /// **'{count} check-ins · {range}. Small clues, with room for context.'**
  String insightsBody(String count, String range);

  /// No description provided for @insightsBodyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Small clues, with room for context. They appear after 7+ check-ins.'**
  String get insightsBodyEmpty;

  /// No description provided for @bestDaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Your best days look like…'**
  String get bestDaysTitle;

  /// No description provided for @bestDaysSleep.
  ///
  /// In en, this message translates to:
  /// **'7+ hours of sleep.'**
  String get bestDaysSleep;

  /// No description provided for @bestDaysMovement.
  ///
  /// In en, this message translates to:
  /// **'A little movement.'**
  String get bestDaysMovement;

  /// No description provided for @bestDaysBreaks.
  ///
  /// In en, this message translates to:
  /// **'A few real pauses between study sessions.'**
  String get bestDaysBreaks;

  /// No description provided for @bestDaysPhone.
  ///
  /// In en, this message translates to:
  /// **'A quieter evening without the phone.'**
  String get bestDaysPhone;

  /// No description provided for @bestDaysWater.
  ///
  /// In en, this message translates to:
  /// **'A few more glasses of water.'**
  String get bestDaysWater;

  /// No description provided for @bestDaysNote.
  ///
  /// In en, this message translates to:
  /// **'These habits show up alongside higher mood and energy in your entries. They’re clues, not rules.'**
  String get bestDaysNote;

  /// No description provided for @confidenceModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate confidence'**
  String get confidenceModerate;

  /// No description provided for @confidenceEmerging.
  ///
  /// In en, this message translates to:
  /// **'Emerging · limited data'**
  String get confidenceEmerging;

  /// No description provided for @confidenceHigher.
  ///
  /// In en, this message translates to:
  /// **'Higher confidence'**
  String get confidenceHigher;

  /// No description provided for @insSleepTitle.
  ///
  /// In en, this message translates to:
  /// **'Short sleep + no breaks, lower energy.'**
  String get insSleepTitle;

  /// No description provided for @insSleepBody.
  ///
  /// In en, this message translates to:
  /// **'Energy is about {diff} points lower on days with <6h sleep and skipped breaks, compared with 7+ hours and breaks.'**
  String insSleepBody(String diff);

  /// No description provided for @insSleepAxis.
  ///
  /// In en, this message translates to:
  /// **'AVERAGE ENERGY · 1–5'**
  String get insSleepAxis;

  /// No description provided for @insSleepA.
  ///
  /// In en, this message translates to:
  /// **'<6h sleep + no breaks'**
  String get insSleepA;

  /// No description provided for @insSleepB.
  ///
  /// In en, this message translates to:
  /// **'7+ hours + at least one break'**
  String get insSleepB;

  /// No description provided for @insMoveTitle.
  ///
  /// In en, this message translates to:
  /// **'More movement, brighter mood?'**
  String get insMoveTitle;

  /// No description provided for @insMoveBody.
  ///
  /// In en, this message translates to:
  /// **'Mood is about {diff} points higher on days with 30+ active minutes in your journal.'**
  String insMoveBody(String diff);

  /// No description provided for @insMoveAxis.
  ///
  /// In en, this message translates to:
  /// **'AVERAGE MOOD · 1–5'**
  String get insMoveAxis;

  /// No description provided for @insMoveA.
  ///
  /// In en, this message translates to:
  /// **'Under 30 active minutes'**
  String get insMoveA;

  /// No description provided for @insMoveB.
  ///
  /// In en, this message translates to:
  /// **'30+ active minutes'**
  String get insMoveB;

  /// No description provided for @insPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'A quieter evening, a longer rest?'**
  String get insPhoneTitle;

  /// No description provided for @insPhoneBody.
  ///
  /// In en, this message translates to:
  /// **'On evenings with the phone away before bed, sleep is about {diff} h longer in your journal.'**
  String insPhoneBody(String diff);

  /// No description provided for @insPhoneAxis.
  ///
  /// In en, this message translates to:
  /// **'AVERAGE SLEEP · 0–10 HOURS'**
  String get insPhoneAxis;

  /// No description provided for @insPhoneA.
  ///
  /// In en, this message translates to:
  /// **'Phone used near bedtime'**
  String get insPhoneA;

  /// No description provided for @insPhoneB.
  ///
  /// In en, this message translates to:
  /// **'Phone away 30 min before bed'**
  String get insPhoneB;

  /// No description provided for @insWaterTitle.
  ///
  /// In en, this message translates to:
  /// **'More water, steadier energy?'**
  String get insWaterTitle;

  /// No description provided for @insWaterBody.
  ///
  /// In en, this message translates to:
  /// **'Energy is about {diff} points higher on days with 6+ glasses of water.'**
  String insWaterBody(String diff);

  /// No description provided for @insWaterAxis.
  ///
  /// In en, this message translates to:
  /// **'AVERAGE ENERGY · 1–5'**
  String get insWaterAxis;

  /// No description provided for @insWaterA.
  ///
  /// In en, this message translates to:
  /// **'Under 6 glasses'**
  String get insWaterA;

  /// No description provided for @insWaterB.
  ///
  /// In en, this message translates to:
  /// **'6+ glasses'**
  String get insWaterB;

  /// No description provided for @insReversed.
  ///
  /// In en, this message translates to:
  /// **'In your entries this goes the other way: {a} vs {b}. Worth noticing, not judging.'**
  String insReversed(String a, String b);

  /// No description provided for @daysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String daysCount(String count);

  /// No description provided for @demoDaysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} demo days'**
  String demoDaysCount(String count);

  /// No description provided for @nightsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} nights'**
  String nightsCount(String count);

  /// No description provided for @demoNightsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} demo nights'**
  String demoNightsCount(String count);

  /// No description provided for @otherDaysExcluded.
  ///
  /// In en, this message translates to:
  /// **'{count} other days excluded'**
  String otherDaysExcluded(String count);

  /// No description provided for @confidenceExplainTitle.
  ///
  /// In en, this message translates to:
  /// **'Patterns aren’t proof of cause.'**
  String get confidenceExplainTitle;

  /// No description provided for @confidenceExplainBody.
  ///
  /// In en, this message translates to:
  /// **'Other things can affect how you feel. Confidence reflects the amount and consistency of your entries, not medical certainty. These are small, self-reported comparisons.'**
  String get confidenceExplainBody;

  /// No description provided for @trySuggestion.
  ///
  /// In en, this message translates to:
  /// **'Try one small suggestion'**
  String get trySuggestion;

  /// No description provided for @insightsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Patterns are on their way.'**
  String get insightsEmptyTitle;

  /// No description provided for @insightsNoneTitle.
  ///
  /// In en, this message translates to:
  /// **'No clear patterns yet.'**
  String get insightsNoneTitle;

  /// No description provided for @insightsNoneBody.
  ///
  /// In en, this message translates to:
  /// **'Your days look fairly even so far. Keep checking in and clues may appear.'**
  String get insightsNoneBody;

  /// No description provided for @forYouEyebrow.
  ///
  /// In en, this message translates to:
  /// **'FOR YOU · {date}'**
  String forYouEyebrow(String date);

  /// No description provided for @forYouTitle.
  ///
  /// In en, this message translates to:
  /// **'Small steps. Your pace.'**
  String get forYouTitle;

  /// No description provided for @forYouBody.
  ///
  /// In en, this message translates to:
  /// **'Three ideas for today, {name}. Try what fits and skip what doesn’t.'**
  String forYouBody(String name);

  /// No description provided for @forYouBodyNoName.
  ///
  /// In en, this message translates to:
  /// **'Three ideas for today. Try what fits and skip what doesn’t.'**
  String get forYouBodyNoName;

  /// No description provided for @doneTodayCount.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} done today'**
  String doneTodayCount(String done, String total);

  /// No description provided for @notAScore.
  ///
  /// In en, this message translates to:
  /// **'Not a score to chase'**
  String get notAScore;

  /// No description provided for @doneToday.
  ///
  /// In en, this message translates to:
  /// **'✓ Done today'**
  String get doneToday;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @skippedToday.
  ///
  /// In en, this message translates to:
  /// **'Skipped today'**
  String get skippedToday;

  /// No description provided for @madeRoom.
  ///
  /// In en, this message translates to:
  /// **'You made a little room.'**
  String get madeRoom;

  /// No description provided for @skippedNote.
  ///
  /// In en, this message translates to:
  /// **'Skipping is useful feedback, too.'**
  String get skippedNote;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @wasHelpful.
  ///
  /// In en, this message translates to:
  /// **'Was this helpful?'**
  String get wasHelpful;

  /// No description provided for @fitsYourDay.
  ///
  /// In en, this message translates to:
  /// **'Does this fit your day?'**
  String get fitsYourDay;

  /// No description provided for @helpful.
  ///
  /// In en, this message translates to:
  /// **'Helpful'**
  String get helpful;

  /// No description provided for @notHelpful.
  ///
  /// In en, this message translates to:
  /// **'Not helpful'**
  String get notHelpful;

  /// No description provided for @agencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Suggestions, not instructions.'**
  String get agencyTitle;

  /// No description provided for @agencyBody.
  ///
  /// In en, this message translates to:
  /// **'Skipping is useful feedback, too. These experiments don’t promise a particular result.'**
  String get agencyBody;

  /// No description provided for @editGoalsLink.
  ///
  /// In en, this message translates to:
  /// **'Change my goals'**
  String get editGoalsLink;

  /// No description provided for @supportEyebrow.
  ///
  /// In en, this message translates to:
  /// **'YOU DON’T HAVE TO DO THIS ALONE'**
  String get supportEyebrow;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'There’s room for support.'**
  String get supportTitle;

  /// No description provided for @supportBody.
  ///
  /// In en, this message translates to:
  /// **'A difficult stretch doesn’t have to be something you carry by yourself.'**
  String get supportBody;

  /// No description provided for @supportHardTitle.
  ///
  /// In en, this message translates to:
  /// **'It looks like the last stretch has been hard. Talking to someone can help.'**
  String get supportHardTitle;

  /// No description provided for @supportGentleTitle.
  ///
  /// In en, this message translates to:
  /// **'Whenever things feel heavy, talking to someone can help.'**
  String get supportGentleTitle;

  /// No description provided for @supportInviteBody.
  ///
  /// In en, this message translates to:
  /// **'This isn’t a diagnosis. You can explore these options whenever you need them — no score or pattern required.'**
  String get supportInviteBody;

  /// No description provided for @universityTitle.
  ///
  /// In en, this message translates to:
  /// **'Start with your university'**
  String get universityTitle;

  /// No description provided for @universityBody.
  ///
  /// In en, this message translates to:
  /// **'Ask Student Affairs or your university’s counselling centre about a private appointment, availability and any fees.'**
  String get universityBody;

  /// No description provided for @universityStarter.
  ///
  /// In en, this message translates to:
  /// **'“I’ve been finding things difficult lately. How can I book a counselling appointment?”'**
  String get universityStarter;

  /// No description provided for @universityAction.
  ///
  /// In en, this message translates to:
  /// **'Find my university’s official site'**
  String get universityAction;

  /// No description provided for @egyptTitle.
  ///
  /// In en, this message translates to:
  /// **'Find support in Egypt'**
  String get egyptTitle;

  /// No description provided for @egyptBody.
  ///
  /// In en, this message translates to:
  /// **'Start with the Egyptian Ministry of Health and Population’s official website. Look for the General Secretariat of Mental Health and Addiction Treatment and its current services.'**
  String get egyptBody;

  /// No description provided for @egyptAction.
  ///
  /// In en, this message translates to:
  /// **'Find official Ministry resources'**
  String get egyptAction;

  /// No description provided for @egyptNote.
  ///
  /// In en, this message translates to:
  /// **'Check contact details, opening hours and eligibility on the official source before reaching out. No phone numbers are listed here.'**
  String get egyptNote;

  /// No description provided for @urgentTitle.
  ///
  /// In en, this message translates to:
  /// **'If you need help right now'**
  String get urgentTitle;

  /// No description provided for @urgentBody.
  ///
  /// In en, this message translates to:
  /// **'If you may hurt yourself or someone else, or you’re in immediate danger, contact local emergency services or go to the nearest emergency department. If possible, ask someone you trust to stay with you.'**
  String get urgentBody;

  /// No description provided for @urgentNote.
  ///
  /// In en, this message translates to:
  /// **'DayWise isn’t an emergency service. Your journal is not monitored for urgent help.'**
  String get urgentNote;

  /// No description provided for @linkFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t open the link.'**
  String get linkFailed;

  /// No description provided for @copyStarter.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyStarter;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account & data'**
  String get accountTitle;

  /// No description provided for @accountData.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT & DATA'**
  String get accountData;

  /// No description provided for @nicknameLine.
  ///
  /// In en, this message translates to:
  /// **'Nickname: {name}'**
  String nicknameLine(String name);

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @privateByDefault.
  ///
  /// In en, this message translates to:
  /// **'Private by default. No real name required.'**
  String get privateByDefault;

  /// No description provided for @editNickname.
  ///
  /// In en, this message translates to:
  /// **'Edit nickname'**
  String get editNickname;

  /// No description provided for @editGoals.
  ///
  /// In en, this message translates to:
  /// **'Edit goals'**
  String get editGoals;

  /// No description provided for @exportEntries.
  ///
  /// In en, this message translates to:
  /// **'Export my entries'**
  String get exportEntries;

  /// No description provided for @exportReady.
  ///
  /// In en, this message translates to:
  /// **'Your entries are ready to copy.'**
  String get exportReady;

  /// No description provided for @deleteData.
  ///
  /// In en, this message translates to:
  /// **'Delete my data'**
  String get deleteData;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all your data?'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes your check-ins, suggestion history and profile. It can’t be undone.'**
  String get deleteConfirmBody;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete everything'**
  String get deleteConfirm;

  /// No description provided for @dataDeleted.
  ///
  /// In en, this message translates to:
  /// **'Your data has been deleted.'**
  String get dataDeleted;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @leaveDemo.
  ///
  /// In en, this message translates to:
  /// **'Leave the demo'**
  String get leaveDemo;

  /// No description provided for @demoCta.
  ///
  /// In en, this message translates to:
  /// **'Like what you see? Create your own private journal.'**
  String get demoCta;

  /// No description provided for @goalsSaved.
  ///
  /// In en, this message translates to:
  /// **'Goals updated.'**
  String get goalsSaved;

  /// No description provided for @lpNavHow.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get lpNavHow;

  /// No description provided for @lpNavMade.
  ///
  /// In en, this message translates to:
  /// **'Made for your day'**
  String get lpNavMade;

  /// No description provided for @lpNavPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get lpNavPrivacy;

  /// No description provided for @lpExploreDemo.
  ///
  /// In en, this message translates to:
  /// **'Explore demo'**
  String get lpExploreDemo;

  /// No description provided for @lpStartDay.
  ///
  /// In en, this message translates to:
  /// **'Start your day'**
  String get lpStartDay;

  /// No description provided for @lpHeroBadge.
  ///
  /// In en, this message translates to:
  /// **'A little reflection. A little more you.'**
  String get lpHeroBadge;

  /// No description provided for @lpHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Small habits.\nYour patterns.\nBetter days.'**
  String get lpHeroTitle;

  /// No description provided for @lpHeroBody.
  ///
  /// In en, this message translates to:
  /// **'Your days are full. Make a little room for yourself. A 30-second check-in helps you notice what supports your well-being, one small step at a time.'**
  String get lpHeroBody;

  /// No description provided for @lpStartFree.
  ///
  /// In en, this message translates to:
  /// **'Start free'**
  String get lpStartFree;

  /// No description provided for @lpExploreNour.
  ///
  /// In en, this message translates to:
  /// **'Explore Nour’s demo'**
  String get lpExploreNour;

  /// No description provided for @lpHeroMeta.
  ///
  /// In en, this message translates to:
  /// **'Free for individuals · عربي / English · No wearable needed'**
  String get lpHeroMeta;

  /// No description provided for @lpHeroNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'You don’t have to change everything.'**
  String get lpHeroNoteTitle;

  /// No description provided for @lpHeroNoteBody.
  ///
  /// In en, this message translates to:
  /// **'Just find one thing that fits today.'**
  String get lpHeroNoteBody;

  /// No description provided for @lpBusyEyebrow.
  ///
  /// In en, this message translates to:
  /// **'FOR THE DAYS THAT FEEL LIKE A LOT'**
  String get lpBusyEyebrow;

  /// No description provided for @lpBusyTitle.
  ///
  /// In en, this message translates to:
  /// **'Busy days can blur the bigger picture.'**
  String get lpBusyTitle;

  /// No description provided for @lpBusyBody.
  ///
  /// In en, this message translates to:
  /// **'Lectures, commutes, deadlines, late-night scrolling. It can be hard to notice how sleep, movement and everyday routines sit alongside how you feel.'**
  String get lpBusyBody;

  /// No description provided for @lpBusyPoint.
  ///
  /// In en, this message translates to:
  /// **'Not another routine to perfect. A way to understand yours.'**
  String get lpBusyPoint;

  /// No description provided for @lpLoopEyebrow.
  ///
  /// In en, this message translates to:
  /// **'A SMALL LOOP, BUILT AROUND YOU'**
  String get lpLoopEyebrow;

  /// No description provided for @lpLoopTitle.
  ///
  /// In en, this message translates to:
  /// **'Check in. Notice. Try one thing.'**
  String get lpLoopTitle;

  /// No description provided for @lpLoopNote.
  ///
  /// In en, this message translates to:
  /// **'No wearable, medical record or perfect week required. Your phone is enough.'**
  String get lpLoopNote;

  /// No description provided for @lpStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Start with how you are.'**
  String get lpStep1Title;

  /// No description provided for @lpStep1Body.
  ///
  /// In en, this message translates to:
  /// **'About 30 seconds to log your sleep, mood, energy and everyday habits. No right answers.'**
  String get lpStep1Body;

  /// No description provided for @lpStep1Tag.
  ///
  /// In en, this message translates to:
  /// **'One daily check-in'**
  String get lpStep1Tag;

  /// No description provided for @lpStep2Title.
  ///
  /// In en, this message translates to:
  /// **'See your own patterns.'**
  String get lpStep2Title;

  /// No description provided for @lpStep2Body.
  ///
  /// In en, this message translates to:
  /// **'After 7+ check-ins, explore simple connections in your days. Not a diagnosis. Not a prediction.'**
  String get lpStep2Body;

  /// No description provided for @lpStep2Tag.
  ///
  /// In en, this message translates to:
  /// **'Your patterns, in plain language'**
  String get lpStep2Tag;

  /// No description provided for @lpStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Make room for a small step.'**
  String get lpStep3Title;

  /// No description provided for @lpStep3Body.
  ///
  /// In en, this message translates to:
  /// **'Try one realistic experiment that fits your schedule. Keep what feels helpful; skip what doesn’t.'**
  String get lpStep3Body;

  /// No description provided for @lpStep3Tag.
  ///
  /// In en, this message translates to:
  /// **'One small action'**
  String get lpStep3Tag;

  /// No description provided for @lpPerspEyebrow.
  ///
  /// In en, this message translates to:
  /// **'LESS GUESSWORK. MORE SELF-KNOWLEDGE.'**
  String get lpPerspEyebrow;

  /// No description provided for @lpPerspTitle.
  ///
  /// In en, this message translates to:
  /// **'Your days, with a little perspective.'**
  String get lpPerspTitle;

  /// No description provided for @lpPerspBody.
  ///
  /// In en, this message translates to:
  /// **'A gentle overview, not a grade. Follow mood, energy, stress, sleep and movement together — and see what’s worth exploring.'**
  String get lpPerspBody;

  /// No description provided for @lpPerspNote.
  ///
  /// In en, this message translates to:
  /// **'Patterns begin after 7+ check-ins. More entries can add context, but missing a day is always okay.'**
  String get lpPerspNote;

  /// No description provided for @lpMeetNour.
  ///
  /// In en, this message translates to:
  /// **'Meet Nour in the demo'**
  String get lpMeetNour;

  /// No description provided for @lpDemoCardTitle.
  ///
  /// In en, this message translates to:
  /// **'A little clearer, Nour.'**
  String get lpDemoCardTitle;

  /// No description provided for @lpIllustrativeDemo.
  ///
  /// In en, this message translates to:
  /// **'Illustrative demo'**
  String get lpIllustrativeDemo;

  /// No description provided for @lpWellbeingLine.
  ///
  /// In en, this message translates to:
  /// **'Well-being · {score} / 100'**
  String lpWellbeingLine(String score);

  /// No description provided for @lpLatestCheckin.
  ///
  /// In en, this message translates to:
  /// **'Latest check-in · {date}'**
  String lpLatestCheckin(String date);

  /// No description provided for @lpSnapshot.
  ///
  /// In en, this message translates to:
  /// **'A snapshot of how you felt, not a medical measure.'**
  String get lpSnapshot;

  /// No description provided for @lpLast7.
  ///
  /// In en, this message translates to:
  /// **'Your last 7 days'**
  String get lpLast7;

  /// No description provided for @lpDemoInsightBody.
  ///
  /// In en, this message translates to:
  /// **'In this demo, mood is about 1.5 points higher on days with 30+ active minutes. A pattern, not proof.'**
  String get lpDemoInsightBody;

  /// No description provided for @lpNudgeEyebrow.
  ///
  /// In en, this message translates to:
  /// **'SMALL ENOUGH FOR REAL LIFE'**
  String get lpNudgeEyebrow;

  /// No description provided for @lpNudgeTitle.
  ///
  /// In en, this message translates to:
  /// **'A nudge, not another to-do list.'**
  String get lpNudgeTitle;

  /// No description provided for @lpNudgeNote.
  ///
  /// In en, this message translates to:
  /// **'Three suggestions. Your choice. Tell DayWise what fits and leave the rest.'**
  String get lpNudgeNote;

  /// No description provided for @lpNudge1.
  ///
  /// In en, this message translates to:
  /// **'A little movement'**
  String get lpNudge1;

  /// No description provided for @lpNudge2.
  ///
  /// In en, this message translates to:
  /// **'A softer evening'**
  String get lpNudge2;

  /// No description provided for @lpNudge3.
  ///
  /// In en, this message translates to:
  /// **'A pause that fits'**
  String get lpNudge3;

  /// No description provided for @lpNudgeTry.
  ///
  /// In en, this message translates to:
  /// **'Try it. Adapt it. Or skip it.'**
  String get lpNudgeTry;

  /// No description provided for @lpEgyptEyebrow.
  ///
  /// In en, this message translates to:
  /// **'EGYPT FIRST. YOUR LANGUAGE, TOO.'**
  String get lpEgyptEyebrow;

  /// No description provided for @lpEgyptArabic.
  ///
  /// In en, this message translates to:
  /// **'يومك يستاهل لحظة ليك.'**
  String get lpEgyptArabic;

  /// No description provided for @lpEgyptTitle.
  ///
  /// In en, this message translates to:
  /// **'Made for life between lectures, work and everything else.'**
  String get lpEgyptTitle;

  /// No description provided for @lpEgyptBody.
  ///
  /// In en, this message translates to:
  /// **'Built for students and young workers, ages 18–30. Use DayWise in Arabic or English, with familiar everyday suggestions and a fully right-to-left Arabic experience.'**
  String get lpEgyptBody;

  /// No description provided for @lpArabicFirst.
  ///
  /// In en, this message translates to:
  /// **'عربي أولًا'**
  String get lpArabicFirst;

  /// No description provided for @lpPhoneOnly.
  ///
  /// In en, this message translates to:
  /// **'Phone-only · No extra devices'**
  String get lpPhoneOnly;

  /// No description provided for @lpPrivEyebrow.
  ///
  /// In en, this message translates to:
  /// **'A PRIVATE SPACE, NOT A PERFORMANCE'**
  String get lpPrivEyebrow;

  /// No description provided for @lpPrivTitle.
  ///
  /// In en, this message translates to:
  /// **'Your life is personal. Your journal should be, too.'**
  String get lpPrivTitle;

  /// No description provided for @lpPrivBody.
  ///
  /// In en, this message translates to:
  /// **'DayWise supports healthy habits; it does not give medical advice. We don’t diagnose, and a score can never tell the whole story. When you need more support, we help you find a human next step.'**
  String get lpPrivBody;

  /// No description provided for @lpPriv1Title.
  ///
  /// In en, this message translates to:
  /// **'Private by default'**
  String get lpPriv1Title;

  /// No description provided for @lpPriv1Body.
  ///
  /// In en, this message translates to:
  /// **'No real name required. Reflect without turning your day into a public feed.'**
  String get lpPriv1Body;

  /// No description provided for @lpPriv2Title.
  ///
  /// In en, this message translates to:
  /// **'You stay in control'**
  String get lpPriv2Title;

  /// No description provided for @lpPriv2Body.
  ///
  /// In en, this message translates to:
  /// **'Export your entries or delete your data from your account. Your journal, your decision.'**
  String get lpPriv2Body;

  /// No description provided for @lpPriv3Title.
  ///
  /// In en, this message translates to:
  /// **'Care beyond the app'**
  String get lpPriv3Title;

  /// No description provided for @lpPriv3Body.
  ///
  /// In en, this message translates to:
  /// **'Find university counselling and official Egyptian mental-health resources, without a diagnosis.'**
  String get lpPriv3Body;

  /// No description provided for @lpFaqEyebrow.
  ///
  /// In en, this message translates to:
  /// **'A FEW GOOD QUESTIONS'**
  String get lpFaqEyebrow;

  /// No description provided for @lpFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'A little clarity, before you begin.'**
  String get lpFaqTitle;

  /// No description provided for @lpExploreSupport.
  ///
  /// In en, this message translates to:
  /// **'Explore support'**
  String get lpExploreSupport;

  /// No description provided for @lpQ1.
  ///
  /// In en, this message translates to:
  /// **'Is DayWise a medical or therapy service?'**
  String get lpQ1;

  /// No description provided for @lpA1.
  ///
  /// In en, this message translates to:
  /// **'No. DayWise is an everyday well-being journal. It supports healthy habits, not diagnosis, treatment or medical decisions.'**
  String get lpA1;

  /// No description provided for @lpQ2.
  ///
  /// In en, this message translates to:
  /// **'When will I see my personal patterns?'**
  String get lpQ2;

  /// No description provided for @lpA2.
  ///
  /// In en, this message translates to:
  /// **'After at least 7 check-ins. Patterns are personal associations, not proof that one habit caused a change. More data adds context.'**
  String get lpA2;

  /// No description provided for @lpQ3.
  ///
  /// In en, this message translates to:
  /// **'What if I miss a day?'**
  String get lpQ3;

  /// No description provided for @lpA3.
  ///
  /// In en, this message translates to:
  /// **'Come back whenever you like. There are no streaks to protect, no penalties and no perfect week to chase.'**
  String get lpA3;

  /// No description provided for @lpQ4.
  ///
  /// In en, this message translates to:
  /// **'Do I need a wearable or a paid plan?'**
  String get lpQ4;

  /// No description provided for @lpA4.
  ///
  /// In en, this message translates to:
  /// **'No. DayWise is phone-only and free for individuals. No wearable or medical records needed.'**
  String get lpA4;

  /// No description provided for @lpQ5.
  ///
  /// In en, this message translates to:
  /// **'Can I use it in Arabic?'**
  String get lpQ5;

  /// No description provided for @lpA5.
  ///
  /// In en, this message translates to:
  /// **'Yes. Arabic and English are available throughout, with a mirrored right-to-left layout in Arabic.'**
  String get lpA5;

  /// No description provided for @lpCtaTitle.
  ///
  /// In en, this message translates to:
  /// **'Start with today. The rest can wait.'**
  String get lpCtaTitle;

  /// No description provided for @lpCtaBody.
  ///
  /// In en, this message translates to:
  /// **'A small check-in is a kind place to begin. No perfect routine required.'**
  String get lpCtaBody;

  /// No description provided for @lpExploreTheDemo.
  ///
  /// In en, this message translates to:
  /// **'Explore the demo'**
  String get lpExploreTheDemo;

  /// No description provided for @lpFooterSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get lpFooterSupport;

  /// No description provided for @lpFooterAccount.
  ///
  /// In en, this message translates to:
  /// **'Account & data'**
  String get lpFooterAccount;

  /// No description provided for @lpFooterSdg.
  ///
  /// In en, this message translates to:
  /// **'Designed to support SDG 3: Good Health and Well-being, especially Target 3.4.\nAn independent project. No United Nations affiliation or endorsement.'**
  String get lpFooterSdg;

  /// No description provided for @lpFooterCopy.
  ///
  /// In en, this message translates to:
  /// **'© 2026 DayWise · Made with room to breathe.'**
  String get lpFooterCopy;
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
