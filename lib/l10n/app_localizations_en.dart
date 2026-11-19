// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DayWise';

  @override
  String get tagline => 'Small daily habits, a healthier you.';

  @override
  String get switchLanguage => 'العربية';

  @override
  String get login => 'Log in';

  @override
  String get signup => 'Sign up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get resetPasswordInfo =>
      'Enter your email and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Send reset link';

  @override
  String get resetEmailSent => 'Check your email for a reset link.';

  @override
  String get noAccount => 'Don\'t have an account? Sign up';

  @override
  String get haveAccount => 'Already have an account? Log in';

  @override
  String get logout => 'Log out';

  @override
  String get notMedicalAdvice => 'DayWise is not medical advice.';

  @override
  String get errRequired => 'This field is required.';

  @override
  String get errInvalidEmail => 'Please enter a valid email.';

  @override
  String get errWeakPassword => 'Password must be at least 6 characters.';

  @override
  String get errPasswordsDontMatch => 'Passwords do not match.';

  @override
  String get errEmailInUse =>
      'This email is already registered. Try logging in.';

  @override
  String get errWrongCredentials => 'Email or password is incorrect.';

  @override
  String get errTooManyRequests =>
      'Too many attempts. Please wait and try again.';

  @override
  String get errNetwork => 'No internet connection. Please try again.';

  @override
  String get errUnknown => 'Something went wrong. Please try again.';

  @override
  String get loginSubtitle => 'Welcome back! Log in to continue.';

  @override
  String get signupSubtitle =>
      'Create an account to start caring for your day.';

  @override
  String get backToLogin => 'Back to log in';

  @override
  String loggedInAs(String email) {
    return 'Logged in as $email';
  }

  @override
  String get navCheckin => 'Check-in';

  @override
  String get navTrends => 'Trends';

  @override
  String get navInsights => 'Insights';

  @override
  String get navTips => 'Tips';

  @override
  String get navSettings => 'Settings';

  @override
  String get dailyCheckin => 'Daily check-in';

  @override
  String get myTrends => 'My trends';

  @override
  String get myInsights => 'My insights';

  @override
  String get tipsForToday => 'Tips for today';

  @override
  String get comingSoon => 'Coming soon…';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get account => 'Account';

  @override
  String get about => 'About';

  @override
  String get logoutConfirm => 'Do you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get medicalDisclaimer =>
      'DayWise helps you notice your own habits. It does not diagnose any condition and is not a replacement for a doctor. If you feel unwell, please talk to a health professional.';

  @override
  String get welcomeTitle => 'Welcome to DayWise';

  @override
  String get welcomePoint1 => 'Log your day in less than a minute.';

  @override
  String get welcomePoint2 =>
      'See how sleep, water and exercise affect your mood and energy.';

  @override
  String get welcomePoint3 => 'Get friendly tips for today.';

  @override
  String get getStarted => 'Get started';

  @override
  String get date => 'Date';

  @override
  String get today => 'Today';

  @override
  String get sleepHours => 'Sleep (hours)';

  @override
  String get waterGlasses => 'Water (glasses)';

  @override
  String get exerciseMinutes => 'Exercise (minutes)';

  @override
  String get mood => 'Mood';

  @override
  String get energy => 'Energy';

  @override
  String get stress => 'Stress';

  @override
  String get level1 => 'Very low';

  @override
  String get level2 => 'Low';

  @override
  String get level3 => 'Medium';

  @override
  String get level4 => 'High';

  @override
  String get level5 => 'Very high';

  @override
  String get save => 'Save';

  @override
  String get updateCheckin => 'Update check-in';

  @override
  String get alreadyLogged =>
      'You already logged this day. Saving will update it.';

  @override
  String get savedMessage => 'Saved! Great job taking care of yourself.';

  @override
  String get errSaveFailed =>
      'Could not save. Check your internet and try again.';

  @override
  String get errLoadFailed => 'Could not load this day. Check your internet.';

  @override
  String get greeting => 'Hey there 👋';

  @override
  String get checkinPrompt => 'How\'s your day going? Let\'s check in.';

  @override
  String get demoTools => 'Demo tools';

  @override
  String get demoToolsInfo =>
      'For the hackathon demo only. Fill this account with 60 days of sample check-ins, or delete all check-ins. Filling replaces the last 60 days.';

  @override
  String get demoFill => 'Fill 60 days';

  @override
  String get demoClear => 'Delete all';

  @override
  String demoFilled(int count) {
    return '$count demo days added.';
  }

  @override
  String demoCleared(int count) {
    return '$count days deleted.';
  }

  @override
  String get last7Days => '7 days';

  @override
  String get last30Days => '30 days';

  @override
  String get averagesTitle => 'Your averages';

  @override
  String basedOnCheckins(int count) {
    return 'Based on $count check-ins';
  }

  @override
  String get avgSleep => 'Sleep (h)';

  @override
  String get avgWater => 'Water (glasses)';

  @override
  String get avgExercise => 'Exercise (min)';

  @override
  String get sleepGoalNote => 'Green bars = 7+ hours. Dashed line = 7 hours.';

  @override
  String get stressNote => 'Lower is better.';

  @override
  String get noCheckinsYet =>
      'No check-ins in this period yet. Log your day to see your trends!';

  @override
  String get insightsTitle => 'What affects you most';

  @override
  String logMoreDays(int count) {
    return 'Log $count more days to see your insights.';
  }

  @override
  String insightsProgress(int count) {
    return '$count of 7 days logged';
  }

  @override
  String insightSentence(
    String habit,
    String metric,
    String points,
    String direction,
  ) {
    return 'On days you $habit, $metric is $points points $direction.';
  }

  @override
  String get habitSleep => 'sleep 7+ hours';

  @override
  String get habitWater => 'drink 6+ glasses of water';

  @override
  String get habitExercise => 'exercise 30+ minutes';

  @override
  String get metricEnergy => 'your energy';

  @override
  String get metricMood => 'your mood';

  @override
  String get higher => 'higher';

  @override
  String get lower => 'lower';

  @override
  String get groupSleepYes => '7+ hours';

  @override
  String get groupSleepNo => 'Under 7 h';

  @override
  String get groupWaterYes => '6+ glasses';

  @override
  String get groupWaterNo => 'Under 6';

  @override
  String get groupExerciseYes => '30+ min';

  @override
  String get groupExerciseNo => 'Under 30 min';

  @override
  String daysCount(int count) {
    return '$count days';
  }

  @override
  String get noPatternsYet =>
      'No clear patterns yet. Keep logging and check back soon!';

  @override
  String get insightsNote =>
      'These are patterns in your own check-ins, not proof of cause and not medical advice.';

  @override
  String get tipsHeader => '3 small things to try today ✨';

  @override
  String get tipsPersonal => 'Picked for you from your check-ins.';

  @override
  String get tipsGeneral => 'Log 7 days to get tips picked just for you.';

  @override
  String get areaSleep => 'Sleep';

  @override
  String get areaWater => 'Water';

  @override
  String get areaExercise => 'Exercise';

  @override
  String get reasonBigEffect => 'Makes a big difference for you';

  @override
  String get reasonHighStress => 'Your stress has been high this week';

  @override
  String get reasonGeneral => 'A healthy habit to try';

  @override
  String get seeAllTips => 'See all 5 tips';

  @override
  String get tipSleep1 =>
      'Try going to bed at the same time tonight, even on weekends.';

  @override
  String get tipSleep2 => 'Put your phone away 30 minutes before sleep. 📵';

  @override
  String get tipSleep3 => 'Keep your room dark, quiet and a little cool.';

  @override
  String get tipSleep4 => 'Skip coffee and energy drinks after 4 pm. ☕';

  @override
  String get tipSleep5 =>
      'A short wind-down routine helps: a shower, a stretch, or a few pages of a book.';

  @override
  String get tipWater1 =>
      'Start your day with a glass of water before anything else. 💧';

  @override
  String get tipWater2 =>
      'Keep a water bottle on your desk where you can see it.';

  @override
  String get tipWater3 => 'Drink a glass of water with every meal.';

  @override
  String get tipWater4 => 'Add lemon or mint if plain water feels boring. 🍋';

  @override
  String get tipWater5 =>
      'Set 3 small reminders on your phone to sip some water.';

  @override
  String get tipExercise1 => 'A 10-minute walk counts! Try one after lunch. 🚶';

  @override
  String get tipExercise2 => 'Take the stairs instead of the elevator today.';

  @override
  String get tipExercise3 => 'Put on your favorite song and dance it out. 💃';

  @override
  String get tipExercise4 =>
      'Invite a friend for a walk. It\'s more fun together.';

  @override
  String get tipExercise5 => 'Stretch for 5 minutes when you wake up.';

  @override
  String get tipStress1 =>
      'Try box breathing: in for 4, hold for 4, out for 4, hold for 4. 🫁';

  @override
  String get tipStress2 => 'Write down 3 things you\'re grateful for today. ✍️';

  @override
  String get tipStress3 => 'Take a 5-minute break away from all screens.';

  @override
  String get tipStress4 => 'Talk to a friend or family member about your day.';

  @override
  String get tipStress5 => 'Step outside for some fresh air and sunlight. ☀️';

  @override
  String get supportTitle => 'We\'re here for you 💜';

  @override
  String get supportBody =>
      'Your mood has been low every day this past week. That sounds really hard. You don\'t have to go through it alone. Talking to someone you trust, or to a professional, can really help.';

  @override
  String get supportHelpline => 'Helpline';

  @override
  String get copyNumber => 'Copy number';

  @override
  String get numberCopied => 'Number copied';

  @override
  String get demoLowMood => 'Low-mood week';

  @override
  String get demoLowMoodDone => 'Last 7 days set to low mood.';
}
