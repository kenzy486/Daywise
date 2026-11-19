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
  String get tagline => 'Small habits. Your patterns. Better days.';

  @override
  String get switchLanguage => 'Switch language';

  @override
  String get notMedicalAdvice =>
      'DayWise supports healthy habits; it does not give medical advice.';

  @override
  String get demoDisclosure =>
      'Nour’s illustrative demo · not real health data';

  @override
  String get increase => 'Increase';

  @override
  String get decrease => 'Decrease';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get close => 'Close';

  @override
  String get navToday => 'Today';

  @override
  String get navCheckin => 'Daily check-in';

  @override
  String get navInsights => 'Insights';

  @override
  String get navInsightsLong => 'Personal insights';

  @override
  String get navForYou => 'For you';

  @override
  String get navSupport => 'Support';

  @override
  String get yourSpace => 'Your space';

  @override
  String breadcrumb(String page) {
    return 'Your space / $page';
  }

  @override
  String get welcomeEyebrow => 'A LITTLE ROOM FOR YOU';

  @override
  String get welcomeTitle => 'Better days start with a small hello.';

  @override
  String get email => 'Email address';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get password => 'Password';

  @override
  String get passwordCreateHint => 'Create a password';

  @override
  String get passwordHint => 'Your password';

  @override
  String get passwordHelper => 'Use at least 8 characters.';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get termsAgreement =>
      'I agree to the Terms and Privacy Policy. My journal stays private by default.';

  @override
  String get termsRequired =>
      'Please agree to the Terms and Privacy Policy to continue.';

  @override
  String get createAccount => 'Create my free account';

  @override
  String get haveAccount => 'Already have an account? Sign in';

  @override
  String get trustTitle => 'No real name. No wearable. No pressure.';

  @override
  String get exploreDemo => 'Just looking? Explore Nour’s demo';

  @override
  String get signInEyebrow => 'WELCOME BACK';

  @override
  String get signInTitle => 'Good to see you again.';

  @override
  String get signInBody =>
      'Pick up where you left off. Your journal is just as you left it.';

  @override
  String get signIn => 'Sign in';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get noAccount => 'New here? Create an account';

  @override
  String get resetEyebrow => 'NO WORRIES';

  @override
  String get resetTitle => 'Let’s get you back in.';

  @override
  String get resetBody =>
      'Enter your email and we’ll send you a link to choose a new password.';

  @override
  String get sendResetLink => 'Send reset link';

  @override
  String get resetEmailSent =>
      'If an account exists for that email, a reset link is on its way.';

  @override
  String get backToSignIn => 'Back to sign in';

  @override
  String get errRequired => 'This field is required.';

  @override
  String get errInvalidEmail => 'Please enter a valid email.';

  @override
  String get errWeakPassword => 'Use at least 8 characters.';

  @override
  String get errEmailInUse =>
      'This email is already registered. Try signing in.';

  @override
  String get errWrongCredentials => 'Email or password is incorrect.';

  @override
  String get errTooManyRequests =>
      'Too many attempts. Please wait and try again.';

  @override
  String get errNetwork => 'No connection. Check your internet and try again.';

  @override
  String get errUnknown => 'Something went wrong. Please try again.';

  @override
  String get errSaveFailed => 'Couldn’t save right now. Please try again.';

  @override
  String get goalsEyebrow => 'LET’S MAKE THIS YOURS · 1 OF 2';

  @override
  String get goalsTitle => 'What would you like more room for?';

  @override
  String get goalsBody =>
      'Choose what matters to you. You can change your mind anytime.';

  @override
  String goalsSelected(String count) {
    return 'Choose one or more · $count selected';
  }

  @override
  String get goalSleep => 'Sleep better';

  @override
  String get goalSleepDesc => 'Make a little room for rest';

  @override
  String get goalStress => 'Less stress';

  @override
  String get goalStressDesc => 'Find pauses that fit your day';

  @override
  String get goalEnergy => 'More energy';

  @override
  String get goalEnergyDesc => 'Notice what helps you recharge';

  @override
  String get goalActivity => 'Activity';

  @override
  String get goalActivityDesc => 'Move in ways that feel doable';

  @override
  String get goalNutrition => 'Nutrition';

  @override
  String get goalNutritionDesc => 'Explore everyday eating habits';

  @override
  String get goalsQuote =>
      'No targets to chase. Just a direction that feels like you.';

  @override
  String get continueLabel => 'Continue';

  @override
  String get decideLater => 'I’ll decide later';

  @override
  String get nameEyebrow => 'LET’S MAKE THIS YOURS · 2 OF 2';

  @override
  String get nameTitle => 'What should we call you?';

  @override
  String get nameBody =>
      'A nickname is plenty. It stays in your journal and is never shared.';

  @override
  String get nameLabel => 'Nickname';

  @override
  String get nameHint => 'e.g. Nour';

  @override
  String get startJournal => 'Start my journal';

  @override
  String get back => 'Back';

  @override
  String todayTitle(String name) {
    return 'A little space for you, $name.';
  }

  @override
  String get todayTitleNoName => 'A little space for you.';

  @override
  String get todaySubtitle => 'No perfect day needed. Just yours.';

  @override
  String get todaySubtitleDesktop =>
      'Notice your days. Be kind to the person living them.';

  @override
  String get yourOverview => 'Your overview';

  @override
  String get weekAtGlance => 'Your week at a glance';

  @override
  String get days7 => '7 days';

  @override
  String get days30 => '30 days';

  @override
  String checkinsSoFar(String total, String inRange) {
    return '$total check-ins so far · $inRange in this range';
  }

  @override
  String get wellbeingTitle => 'Well-being';

  @override
  String latestOn(String date) {
    return 'Latest · $date';
  }

  @override
  String outOf100(String score) {
    return '$score out of 100';
  }

  @override
  String get outOf100Short => 'out of 100';

  @override
  String ratingOf5(String value) {
    return '$value / 5';
  }

  @override
  String get mood => 'Mood';

  @override
  String get energy => 'Energy';

  @override
  String get stress => 'Stress';

  @override
  String get wellbeingNote =>
      'A reflection of mood, energy and stress. Not a medical measure or a grade.';

  @override
  String get wellbeingNoteDesktop =>
      'A reflection, not a diagnosis. Your score combines mood, energy and stress.';

  @override
  String get wellbeingEmpty => 'Your score appears after your first check-in.';

  @override
  String get checkinCta => 'How are you today? Check in';

  @override
  String get checkinCtaDesktop => 'Today’s check-in';

  @override
  String get checkinEditCta => 'Edit today’s check-in';

  @override
  String get checkinOpenNote => 'About 30 seconds · Today’s check-in is open';

  @override
  String get checkinDoneNote => 'Saved for today · You can edit it anytime';

  @override
  String get feelingTitle => 'How you’ve been feeling';

  @override
  String feelingCaption(String range) {
    return '$range · scale 1–5 · lower stress is better';
  }

  @override
  String latestTriple(String mood, String energy, String stress) {
    return 'Latest: $mood / $energy / $stress';
  }

  @override
  String get energyVaried =>
      'Energy varied this week. Your notes can help add the context a chart can’t.';

  @override
  String get restTitle => 'Rest & movement';

  @override
  String get sleepHoursSeries => 'Sleep · hours';

  @override
  String get activitySeries => 'Activity · minutes';

  @override
  String get noDataYet => 'Nothing logged in this range yet.';

  @override
  String get oneSmallThing => 'ONE SMALL THING';

  @override
  String pendingProgress(String done, String total) {
    return 'Pending · $done of $total done';
  }

  @override
  String get allDoneTitle => 'That’s all three for today.';

  @override
  String get allDoneBody => 'You made a little room today. Nothing more to do.';

  @override
  String get done => 'Done';

  @override
  String get markDone => 'Mark done';

  @override
  String get skip => 'Skip';

  @override
  String get skipToday => 'Skip today';

  @override
  String get allSuggestions => 'All 3 suggestions';

  @override
  String get seeTodaysSuggestions => 'See today’s 3 suggestions';

  @override
  String patternEyebrow(String count) {
    return 'A PATTERN TO EXPLORE · $count CHECK-INS';
  }

  @override
  String get exploreInsights => 'Explore insights';

  @override
  String get exploreInsightsLong => 'Explore your personal insights';

  @override
  String get patternsNotProof => 'Patterns aren’t proof of cause.';

  @override
  String get patternsNotProofLong =>
      'Patterns aren’t proof of cause. Other things may matter.';

  @override
  String get almostThereTitle => 'Patterns are on their way.';

  @override
  String almostThereBody(String count) {
    return '$count of 7 check-ins so far. Patterns begin after 7+ check-ins.';
  }

  @override
  String get emptyTitle => 'Your space is ready.';

  @override
  String get emptyBody =>
      'Whenever you like, take a 30-second check-in. There’s no wrong answer.';

  @override
  String get sidebarQuoteTitle => 'You’re a person, not a progress bar.';

  @override
  String get sidebarQuoteBody =>
      'No streaks. No catching up. Just room to reflect.';

  @override
  String journalOf(String name) {
    return '$name’s journal';
  }

  @override
  String get myJournal => 'My journal';

  @override
  String cityLanguage(String city) {
    return '$city · English';
  }

  @override
  String get recentReflections => 'Recent reflections';

  @override
  String get viewJournal => 'View journal';

  @override
  String get colCheckin => 'Check-in';

  @override
  String get colSleep => 'Sleep';

  @override
  String get colActive => 'Active';

  @override
  String get colScore => 'Score';

  @override
  String hoursShort(String value) {
    return '$value h';
  }

  @override
  String minutesShort(String value) {
    return '$value min';
  }

  @override
  String get findSupportLink => 'Need someone to talk to? Find support';

  @override
  String checkinEyebrow(String date) {
    return '$date · DAILY CHECK-IN';
  }

  @override
  String get checkinTitle => 'How’s your day, really?';

  @override
  String get checkinBody =>
      'A quick pause, just for you. Your best guess is enough.';

  @override
  String get about30Seconds => 'About 30 seconds';

  @override
  String get demoDraft => 'Demo draft · not submitted';

  @override
  String get editingToday => 'Editing today’s entry';

  @override
  String get restSection => 'Last night’s rest';

  @override
  String get sleepHours => 'Sleep hours';

  @override
  String get sleepHelper => '0–12 hours · half-hour steps';

  @override
  String get sleepQuality => 'Sleep quality';

  @override
  String get veryPoor => 'Very poor';

  @override
  String get veryGood => 'Very good';

  @override
  String get veryLow => 'Very low';

  @override
  String get veryHigh => 'Very high';

  @override
  String get innerWeather => 'Your inner weather';

  @override
  String get feelingsNote =>
      'All feelings belong here. Higher isn’t always better — for stress, lower means calmer.';

  @override
  String get everydayThings => 'The everyday things';

  @override
  String get water => 'Water';

  @override
  String get glasses => 'glasses';

  @override
  String get waterHelper => 'One glass is roughly 250 ml.';

  @override
  String get activity => 'Activity';

  @override
  String get minutes => 'minutes';

  @override
  String get activityHelper =>
      'Walking to class counts, too. Steps of 5 minutes.';

  @override
  String get meals => 'Meals';

  @override
  String get mealsUnit => 'meals';

  @override
  String get breaks => 'Breaks';

  @override
  String get breaksUnit => 'breaks';

  @override
  String get breaksHelper => 'Pauses away from work or study.';

  @override
  String get screenTime => 'Screen time';

  @override
  String get screenHelper => '0–16 hours · half-hour steps';

  @override
  String get caffeine => 'Caffeine';

  @override
  String get servings => 'servings';

  @override
  String get caffeineHelper => 'Count a cup of coffee, tea or an energy drink.';

  @override
  String get phoneAway => 'Phone away 30 min before bed?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get noteTitle => 'Anything on your mind?';

  @override
  String get optional => 'Optional';

  @override
  String get noteHint => 'A sentence or two about your day…';

  @override
  String get notePrivacy => 'Only for your journal. No real name needed.';

  @override
  String get saveCheckin => 'Save today’s check-in';

  @override
  String get updateCheckin => 'Update today’s check-in';

  @override
  String get checkinFooter =>
      'One entry for today. You can edit it later.\nPatterns begin after 7+ check-ins.';

  @override
  String get checkinSaved => 'Saved. Thanks for taking a moment for yourself.';

  @override
  String get insightsEyebrow => 'YOUR PATTERNS, NOT A PRESCRIPTION';

  @override
  String get insightsTitle => 'Get to know your days.';

  @override
  String insightsBody(String count, String range) {
    return '$count check-ins · $range. Small clues, with room for context.';
  }

  @override
  String get insightsBodyEmpty =>
      'Small clues, with room for context. They appear after 7+ check-ins.';

  @override
  String get bestDaysTitle => 'Your best days look like…';

  @override
  String get bestDaysSleep => '7+ hours of sleep.';

  @override
  String get bestDaysMovement => 'A little movement.';

  @override
  String get bestDaysBreaks => 'A few real pauses between study sessions.';

  @override
  String get bestDaysPhone => 'A quieter evening without the phone.';

  @override
  String get bestDaysWater => 'A few more glasses of water.';

  @override
  String get bestDaysNote =>
      'These habits show up alongside higher mood and energy in your entries. They’re clues, not rules.';

  @override
  String get confidenceModerate => 'Moderate confidence';

  @override
  String get confidenceEmerging => 'Emerging · limited data';

  @override
  String get confidenceHigher => 'Higher confidence';

  @override
  String get insSleepTitle => 'Short sleep + no breaks, lower energy.';

  @override
  String insSleepBody(String diff) {
    return 'Energy is about $diff points lower on days with <6h sleep and skipped breaks, compared with 7+ hours and breaks.';
  }

  @override
  String get insSleepAxis => 'AVERAGE ENERGY · 1–5';

  @override
  String get insSleepA => '<6h sleep + no breaks';

  @override
  String get insSleepB => '7+ hours + at least one break';

  @override
  String get insMoveTitle => 'More movement, brighter mood?';

  @override
  String insMoveBody(String diff) {
    return 'Mood is about $diff points higher on days with 30+ active minutes in your journal.';
  }

  @override
  String get insMoveAxis => 'AVERAGE MOOD · 1–5';

  @override
  String get insMoveA => 'Under 30 active minutes';

  @override
  String get insMoveB => '30+ active minutes';

  @override
  String get insPhoneTitle => 'A quieter evening, a longer rest?';

  @override
  String insPhoneBody(String diff) {
    return 'On evenings with the phone away before bed, sleep is about $diff h longer in your journal.';
  }

  @override
  String get insPhoneAxis => 'AVERAGE SLEEP · 0–10 HOURS';

  @override
  String get insPhoneA => 'Phone used near bedtime';

  @override
  String get insPhoneB => 'Phone away 30 min before bed';

  @override
  String get insWaterTitle => 'More water, steadier energy?';

  @override
  String insWaterBody(String diff) {
    return 'Energy is about $diff points higher on days with 6+ glasses of water.';
  }

  @override
  String get insWaterAxis => 'AVERAGE ENERGY · 1–5';

  @override
  String get insWaterA => 'Under 6 glasses';

  @override
  String get insWaterB => '6+ glasses';

  @override
  String insReversed(String a, String b) {
    return 'In your entries this goes the other way: $a vs $b. Worth noticing, not judging.';
  }

  @override
  String daysCount(String count) {
    return '$count days';
  }

  @override
  String demoDaysCount(String count) {
    return '$count demo days';
  }

  @override
  String nightsCount(String count) {
    return '$count nights';
  }

  @override
  String demoNightsCount(String count) {
    return '$count demo nights';
  }

  @override
  String otherDaysExcluded(String count) {
    return '$count other days excluded';
  }

  @override
  String get confidenceExplainTitle => 'Patterns aren’t proof of cause.';

  @override
  String get confidenceExplainBody =>
      'Other things can affect how you feel. Confidence reflects the amount and consistency of your entries, not medical certainty. These are small, self-reported comparisons.';

  @override
  String get trySuggestion => 'Try one small suggestion';

  @override
  String get insightsEmptyTitle => 'Patterns are on their way.';

  @override
  String get insightsNoneTitle => 'No clear patterns yet.';

  @override
  String get insightsNoneBody =>
      'Your days look fairly even so far. Keep checking in and clues may appear.';

  @override
  String forYouEyebrow(String date) {
    return 'FOR YOU · $date';
  }

  @override
  String get forYouTitle => 'Small steps. Your pace.';

  @override
  String forYouBody(String name) {
    return 'Three ideas for today, $name. Try what fits and skip what doesn’t.';
  }

  @override
  String get forYouBodyNoName =>
      'Three ideas for today. Try what fits and skip what doesn’t.';

  @override
  String doneTodayCount(String done, String total) {
    return '$done of $total done today';
  }

  @override
  String get notAScore => 'Not a score to chase';

  @override
  String get doneToday => '✓ Done today';

  @override
  String get pending => 'Pending';

  @override
  String get skippedToday => 'Skipped today';

  @override
  String get madeRoom => 'You made a little room.';

  @override
  String get skippedNote => 'Skipping is useful feedback, too.';

  @override
  String get undo => 'Undo';

  @override
  String get wasHelpful => 'Was this helpful?';

  @override
  String get fitsYourDay => 'Does this fit your day?';

  @override
  String get helpful => 'Helpful';

  @override
  String get notHelpful => 'Not helpful';

  @override
  String get agencyTitle => 'Suggestions, not instructions.';

  @override
  String get agencyBody =>
      'Skipping is useful feedback, too. These experiments don’t promise a particular result.';

  @override
  String get editGoalsLink => 'Change my goals';

  @override
  String get supportEyebrow => 'YOU DON’T HAVE TO DO THIS ALONE';

  @override
  String get supportTitle => 'There’s room for support.';

  @override
  String get supportBody =>
      'A difficult stretch doesn’t have to be something you carry by yourself.';

  @override
  String get supportHardTitle =>
      'It looks like the last stretch has been hard. Talking to someone can help.';

  @override
  String get supportGentleTitle =>
      'Whenever things feel heavy, talking to someone can help.';

  @override
  String get supportInviteBody =>
      'This isn’t a diagnosis. You can explore these options whenever you need them — no score or pattern required.';

  @override
  String get universityTitle => 'Start with your university';

  @override
  String get universityBody =>
      'Ask Student Affairs or your university’s counselling centre about a private appointment, availability and any fees.';

  @override
  String get universityStarter =>
      '“I’ve been finding things difficult lately. How can I book a counselling appointment?”';

  @override
  String get universityAction => 'Find my university’s official site';

  @override
  String get egyptTitle => 'Find support in Egypt';

  @override
  String get egyptBody =>
      'Start with the Egyptian Ministry of Health and Population’s official website. Look for the General Secretariat of Mental Health and Addiction Treatment and its current services.';

  @override
  String get egyptAction => 'Find official Ministry resources';

  @override
  String get egyptNote =>
      'Check contact details, opening hours and eligibility on the official source before reaching out. No phone numbers are listed here.';

  @override
  String get urgentTitle => 'If you need help right now';

  @override
  String get urgentBody =>
      'If you may hurt yourself or someone else, or you’re in immediate danger, contact local emergency services or go to the nearest emergency department. If possible, ask someone you trust to stay with you.';

  @override
  String get urgentNote =>
      'DayWise isn’t an emergency service. Your journal is not monitored for urgent help.';

  @override
  String get linkFailed => 'Couldn’t open the link.';

  @override
  String get copyStarter => 'Copy';

  @override
  String get copied => 'Copied';

  @override
  String get accountTitle => 'Account & data';

  @override
  String get accountData => 'ACCOUNT & DATA';

  @override
  String nicknameLine(String name) {
    return 'Nickname: $name';
  }

  @override
  String get edit => 'Edit';

  @override
  String get privateByDefault => 'Private by default. No real name required.';

  @override
  String get editNickname => 'Edit nickname';

  @override
  String get editGoals => 'Edit goals';

  @override
  String get exportEntries => 'Export my entries';

  @override
  String get exportReady => 'Your entries are ready to copy.';

  @override
  String get deleteData => 'Delete my data';

  @override
  String get deleteConfirmTitle => 'Delete all your data?';

  @override
  String get deleteConfirmBody =>
      'This permanently removes your check-ins, suggestion history and profile. It can’t be undone.';

  @override
  String get deleteConfirm => 'Delete everything';

  @override
  String get dataDeleted => 'Your data has been deleted.';

  @override
  String get signOut => 'Sign out';

  @override
  String get leaveDemo => 'Leave the demo';

  @override
  String get demoCta => 'Like what you see? Create your own private journal.';

  @override
  String get goalsSaved => 'Goals updated.';

  @override
  String get lpNavHow => 'How it works';

  @override
  String get lpNavMade => 'Made for your day';

  @override
  String get lpNavPrivacy => 'Privacy';

  @override
  String get lpExploreDemo => 'Explore demo';

  @override
  String get lpStartDay => 'Start your day';

  @override
  String get lpHeroBadge => 'A little reflection. A little more you.';

  @override
  String get lpHeroTitle => 'Small habits.\nYour patterns.\nBetter days.';

  @override
  String get lpHeroBody =>
      'Your days are full. Make a little room for yourself. A 30-second check-in helps you notice what supports your well-being, one small step at a time.';

  @override
  String get lpStartFree => 'Start free';

  @override
  String get lpExploreNour => 'Explore Nour’s demo';

  @override
  String get lpHeroMeta =>
      'Free for individuals · عربي / English · No wearable needed';

  @override
  String get lpHeroNoteTitle => 'You don’t have to change everything.';

  @override
  String get lpHeroNoteBody => 'Just find one thing that fits today.';

  @override
  String get lpBusyEyebrow => 'FOR THE DAYS THAT FEEL LIKE A LOT';

  @override
  String get lpBusyTitle => 'Busy days can blur the bigger picture.';

  @override
  String get lpBusyBody =>
      'Lectures, commutes, deadlines, late-night scrolling. It can be hard to notice how sleep, movement and everyday routines sit alongside how you feel.';

  @override
  String get lpBusyPoint =>
      'Not another routine to perfect. A way to understand yours.';

  @override
  String get lpLoopEyebrow => 'A SMALL LOOP, BUILT AROUND YOU';

  @override
  String get lpLoopTitle => 'Check in. Notice. Try one thing.';

  @override
  String get lpLoopNote =>
      'No wearable, medical record or perfect week required. Your phone is enough.';

  @override
  String get lpStep1Title => 'Start with how you are.';

  @override
  String get lpStep1Body =>
      'About 30 seconds to log your sleep, mood, energy and everyday habits. No right answers.';

  @override
  String get lpStep1Tag => 'One daily check-in';

  @override
  String get lpStep2Title => 'See your own patterns.';

  @override
  String get lpStep2Body =>
      'After 7+ check-ins, explore simple connections in your days. Not a diagnosis. Not a prediction.';

  @override
  String get lpStep2Tag => 'Your patterns, in plain language';

  @override
  String get lpStep3Title => 'Make room for a small step.';

  @override
  String get lpStep3Body =>
      'Try one realistic experiment that fits your schedule. Keep what feels helpful; skip what doesn’t.';

  @override
  String get lpStep3Tag => 'One small action';

  @override
  String get lpPerspEyebrow => 'LESS GUESSWORK. MORE SELF-KNOWLEDGE.';

  @override
  String get lpPerspTitle => 'Your days, with a little perspective.';

  @override
  String get lpPerspBody =>
      'A gentle overview, not a grade. Follow mood, energy, stress, sleep and movement together — and see what’s worth exploring.';

  @override
  String get lpPerspNote =>
      'Patterns begin after 7+ check-ins. More entries can add context, but missing a day is always okay.';

  @override
  String get lpMeetNour => 'Meet Nour in the demo';

  @override
  String get lpDemoCardTitle => 'A little clearer, Nour.';

  @override
  String get lpIllustrativeDemo => 'Illustrative demo';

  @override
  String lpWellbeingLine(String score) {
    return 'Well-being · $score / 100';
  }

  @override
  String lpLatestCheckin(String date) {
    return 'Latest check-in · $date';
  }

  @override
  String get lpSnapshot => 'A snapshot of how you felt, not a medical measure.';

  @override
  String get lpLast7 => 'Your last 7 days';

  @override
  String get lpDemoInsightBody =>
      'In this demo, mood is about 1.5 points higher on days with 30+ active minutes. A pattern, not proof.';

  @override
  String get lpNudgeEyebrow => 'SMALL ENOUGH FOR REAL LIFE';

  @override
  String get lpNudgeTitle => 'A nudge, not another to-do list.';

  @override
  String get lpNudgeNote =>
      'Three suggestions. Your choice. Tell DayWise what fits and leave the rest.';

  @override
  String get lpNudge1 => 'A little movement';

  @override
  String get lpNudge2 => 'A softer evening';

  @override
  String get lpNudge3 => 'A pause that fits';

  @override
  String get lpNudgeTry => 'Try it. Adapt it. Or skip it.';

  @override
  String get lpEgyptEyebrow => 'EGYPT FIRST. YOUR LANGUAGE, TOO.';

  @override
  String get lpEgyptArabic => 'يومك يستاهل لحظة ليك.';

  @override
  String get lpEgyptTitle =>
      'Made for life between lectures, work and everything else.';

  @override
  String get lpEgyptBody =>
      'Built for students and young workers, ages 18–30. Use DayWise in Arabic or English, with familiar everyday suggestions and a fully right-to-left Arabic experience.';

  @override
  String get lpArabicFirst => 'عربي أولًا';

  @override
  String get lpPhoneOnly => 'Phone-only · No extra devices';

  @override
  String get lpPrivEyebrow => 'A PRIVATE SPACE, NOT A PERFORMANCE';

  @override
  String get lpPrivTitle =>
      'Your life is personal. Your journal should be, too.';

  @override
  String get lpPrivBody =>
      'DayWise supports healthy habits; it does not give medical advice. We don’t diagnose, and a score can never tell the whole story. When you need more support, we help you find a human next step.';

  @override
  String get lpPriv1Title => 'Private by default';

  @override
  String get lpPriv1Body =>
      'No real name required. Reflect without turning your day into a public feed.';

  @override
  String get lpPriv2Title => 'You stay in control';

  @override
  String get lpPriv2Body =>
      'Export your entries or delete your data from your account. Your journal, your decision.';

  @override
  String get lpPriv3Title => 'Care beyond the app';

  @override
  String get lpPriv3Body =>
      'Find university counselling and official Egyptian mental-health resources, without a diagnosis.';

  @override
  String get lpFaqEyebrow => 'A FEW GOOD QUESTIONS';

  @override
  String get lpFaqTitle => 'A little clarity, before you begin.';

  @override
  String get lpExploreSupport => 'Explore support';

  @override
  String get lpQ1 => 'Is DayWise a medical or therapy service?';

  @override
  String get lpA1 =>
      'No. DayWise is an everyday well-being journal. It supports healthy habits, not diagnosis, treatment or medical decisions.';

  @override
  String get lpQ2 => 'When will I see my personal patterns?';

  @override
  String get lpA2 =>
      'After at least 7 check-ins. Patterns are personal associations, not proof that one habit caused a change. More data adds context.';

  @override
  String get lpQ3 => 'What if I miss a day?';

  @override
  String get lpA3 =>
      'Come back whenever you like. There are no streaks to protect, no penalties and no perfect week to chase.';

  @override
  String get lpQ4 => 'Do I need a wearable or a paid plan?';

  @override
  String get lpA4 =>
      'No. DayWise is phone-only and free for individuals. No wearable or medical records needed.';

  @override
  String get lpQ5 => 'Can I use it in Arabic?';

  @override
  String get lpA5 =>
      'Yes. Arabic and English are available throughout, with a mirrored right-to-left layout in Arabic.';

  @override
  String get lpCtaTitle => 'Start with today. The rest can wait.';

  @override
  String get lpCtaBody =>
      'A small check-in is a kind place to begin. No perfect routine required.';

  @override
  String get lpExploreTheDemo => 'Explore the demo';

  @override
  String get lpFooterSupport => 'Support';

  @override
  String get lpFooterAccount => 'Account & data';

  @override
  String get lpFooterSdg =>
      'Designed to support SDG 3: Good Health and Well-being, especially Target 3.4.\nAn independent project. No United Nations affiliation or endorsement.';

  @override
  String get lpFooterCopy => '© 2026 DayWise · Made with room to breathe.';
}
