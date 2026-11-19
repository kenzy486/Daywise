// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'DayWise';

  @override
  String get tagline => 'عادات يومية صغيرة، لصحة أفضل.';

  @override
  String get switchLanguage => 'English';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get resetPasswordInfo =>
      'أدخل بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين كلمة المرور.';

  @override
  String get sendResetLink => 'إرسال الرابط';

  @override
  String get resetEmailSent =>
      'تحقق من بريدك الإلكتروني للحصول على رابط إعادة التعيين.';

  @override
  String get noAccount => 'ليس لديك حساب؟ أنشئ حسابًا';

  @override
  String get haveAccount => 'لديك حساب بالفعل؟ سجّل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get notMedicalAdvice => 'DayWise ليس نصيحة طبية.';

  @override
  String get errRequired => 'هذا الحقل مطلوب.';

  @override
  String get errInvalidEmail => 'يرجى إدخال بريد إلكتروني صحيح.';

  @override
  String get errWeakPassword => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';

  @override
  String get errPasswordsDontMatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get errEmailInUse => 'هذا البريد مسجّل بالفعل. جرّب تسجيل الدخول.';

  @override
  String get errWrongCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get errTooManyRequests =>
      'محاولات كثيرة. يرجى الانتظار ثم المحاولة مرة أخرى.';

  @override
  String get errNetwork => 'لا يوجد اتصال بالإنترنت. حاول مرة أخرى.';

  @override
  String get errUnknown => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get loginSubtitle => 'أهلًا بعودتك! سجّل الدخول للمتابعة.';

  @override
  String get signupSubtitle => 'أنشئ حسابًا لتبدأ الاهتمام بيومك.';

  @override
  String get backToLogin => 'العودة لتسجيل الدخول';

  @override
  String loggedInAs(String email) {
    return 'تم تسجيل الدخول باسم $email';
  }

  @override
  String get navCheckin => 'تسجيل';

  @override
  String get navTrends => 'الاتجاهات';

  @override
  String get navInsights => 'الرؤى';

  @override
  String get navTips => 'نصائح';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get dailyCheckin => 'تسجيل اليوم';

  @override
  String get myTrends => 'اتجاهاتي';

  @override
  String get myInsights => 'رؤاي';

  @override
  String get tipsForToday => 'نصائح اليوم';

  @override
  String get comingSoon => 'قريبًا…';

  @override
  String get language => 'اللغة';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get account => 'الحساب';

  @override
  String get about => 'عن التطبيق';

  @override
  String get logoutConfirm => 'هل تريد تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get medicalDisclaimer =>
      'يساعدك DayWise على ملاحظة عاداتك. لا يشخّص أي حالة ولا يُغني عن الطبيب. إذا شعرت بتوعّك، يرجى التحدث مع مختص صحي.';

  @override
  String get welcomeTitle => 'مرحبًا بك في DayWise';

  @override
  String get welcomePoint1 => 'سجّل يومك في أقل من دقيقة.';

  @override
  String get welcomePoint2 =>
      'اكتشف كيف يؤثر النوم والماء والرياضة على مزاجك وطاقتك.';

  @override
  String get welcomePoint3 => 'احصل على نصائح لطيفة ليومك.';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get date => 'التاريخ';

  @override
  String get today => 'اليوم';

  @override
  String get sleepHours => 'النوم (ساعات)';

  @override
  String get waterGlasses => 'الماء (أكواب)';

  @override
  String get exerciseMinutes => 'الرياضة (دقائق)';

  @override
  String get mood => 'المزاج';

  @override
  String get energy => 'الطاقة';

  @override
  String get stress => 'التوتر';

  @override
  String get level1 => 'منخفض جدًا';

  @override
  String get level2 => 'منخفض';

  @override
  String get level3 => 'متوسط';

  @override
  String get level4 => 'مرتفع';

  @override
  String get level5 => 'مرتفع جدًا';

  @override
  String get save => 'حفظ';

  @override
  String get updateCheckin => 'تحديث التسجيل';

  @override
  String get alreadyLogged => 'لقد سجّلت هذا اليوم من قبل. الحفظ سيحدّثه.';

  @override
  String get savedMessage => 'تم الحفظ! أحسنت في الاهتمام بنفسك.';

  @override
  String get errSaveFailed => 'تعذّر الحفظ. تحقق من الإنترنت وحاول مرة أخرى.';

  @override
  String get errLoadFailed => 'تعذّر تحميل هذا اليوم. تحقق من الإنترنت.';

  @override
  String get greeting => 'أهلًا 👋';

  @override
  String get checkinPrompt => 'كيف يومك؟ يلا نسجّل.';

  @override
  String get demoTools => 'أدوات العرض';

  @override
  String get demoToolsInfo =>
      'للعرض في الهاكاثون فقط. املأ هذا الحساب ببيانات تجريبية لمدة 60 يومًا، أو احذف كل التسجيلات. الملء يستبدل آخر 60 يومًا.';

  @override
  String get demoFill => 'ملء 60 يومًا';

  @override
  String get demoClear => 'حذف الكل';

  @override
  String demoFilled(int count) {
    return 'تمت إضافة $count يومًا تجريبيًا.';
  }

  @override
  String demoCleared(int count) {
    return 'تم حذف $count يوم.';
  }

  @override
  String get last7Days => '7 أيام';

  @override
  String get last30Days => '30 يومًا';

  @override
  String get averagesTitle => 'متوسطاتك';

  @override
  String basedOnCheckins(int count) {
    return 'بناءً على $count تسجيل';
  }

  @override
  String get avgSleep => 'النوم (ساعة)';

  @override
  String get avgWater => 'الماء (أكواب)';

  @override
  String get avgExercise => 'الرياضة (دقيقة)';

  @override
  String get sleepGoalNote =>
      'الأعمدة الخضراء = 7 ساعات أو أكثر. الخط المتقطع = 7 ساعات.';

  @override
  String get stressNote => 'كلما قلّ كان أفضل.';

  @override
  String get noCheckinsYet =>
      'لا توجد تسجيلات في هذه الفترة بعد. سجّل يومك لترى اتجاهاتك!';

  @override
  String get insightsTitle => 'ما الذي يؤثر عليك أكثر';

  @override
  String logMoreDays(int count) {
    return 'سجّل $count أيام إضافية لترى رؤاك.';
  }

  @override
  String insightsProgress(int count) {
    return 'تم تسجيل $count من 7 أيام';
  }

  @override
  String insightSentence(
    String habit,
    String metric,
    String points,
    String direction,
  ) {
    return 'في الأيام التي $habit، $metric $direction بمقدار $points نقطة.';
  }

  @override
  String get habitSleep => 'تنام فيها 7 ساعات أو أكثر';

  @override
  String get habitWater => 'تشرب فيها 6 أكواب ماء أو أكثر';

  @override
  String get habitExercise => 'تمارس فيها الرياضة 30 دقيقة أو أكثر';

  @override
  String get metricEnergy => 'طاقتك';

  @override
  String get metricMood => 'مزاجك';

  @override
  String get higher => 'أعلى';

  @override
  String get lower => 'أقل';

  @override
  String get groupSleepYes => '7 ساعات أو أكثر';

  @override
  String get groupSleepNo => 'أقل من 7 ساعات';

  @override
  String get groupWaterYes => '6 أكواب أو أكثر';

  @override
  String get groupWaterNo => 'أقل من 6';

  @override
  String get groupExerciseYes => '30 دقيقة أو أكثر';

  @override
  String get groupExerciseNo => 'أقل من 30 دقيقة';

  @override
  String daysCount(int count) {
    return '$count يوم';
  }

  @override
  String get noPatternsYet =>
      'لا توجد أنماط واضحة بعد. استمر في التسجيل وعد قريبًا!';

  @override
  String get insightsNote =>
      'هذه أنماط في تسجيلاتك أنت، وليست دليلًا على السبب ولا نصيحة طبية.';

  @override
  String get tipsHeader => '3 أشياء صغيرة تجربها اليوم ✨';

  @override
  String get tipsPersonal => 'اخترناها لك من تسجيلاتك.';

  @override
  String get tipsGeneral => 'سجّل 7 أيام لتحصل على نصائح مختارة لك.';

  @override
  String get areaSleep => 'النوم';

  @override
  String get areaWater => 'الماء';

  @override
  String get areaExercise => 'الرياضة';

  @override
  String get reasonBigEffect => 'يُحدث فرقًا كبيرًا معك';

  @override
  String get reasonHighStress => 'كان توترك مرتفعًا هذا الأسبوع';

  @override
  String get reasonGeneral => 'عادة صحية تستحق التجربة';

  @override
  String get seeAllTips => 'عرض النصائح الخمس';

  @override
  String get tipSleep1 => 'حاول أن تنام في نفس الموعد الليلة، حتى في الإجازات.';

  @override
  String get tipSleep2 => 'ابعد هاتفك قبل النوم بـ30 دقيقة. 📵';

  @override
  String get tipSleep3 => 'اجعل غرفتك مظلمة وهادئة وباردة قليلًا.';

  @override
  String get tipSleep4 => 'تجنّب القهوة ومشروبات الطاقة بعد الساعة 4 عصرًا. ☕';

  @override
  String get tipSleep5 =>
      'روتين بسيط قبل النوم يساعد: دش، أو تمدد، أو صفحات قليلة من كتاب.';

  @override
  String get tipWater1 => 'ابدأ يومك بكوب ماء قبل أي شيء. 💧';

  @override
  String get tipWater2 => 'ضع زجاجة ماء على مكتبك أمام عينيك.';

  @override
  String get tipWater3 => 'اشرب كوب ماء مع كل وجبة.';

  @override
  String get tipWater4 =>
      'أضف ليمونًا أو نعناعًا إذا كان الماء العادي مملًا. 🍋';

  @override
  String get tipWater5 => 'اضبط 3 تذكيرات صغيرة على هاتفك لتشرب الماء.';

  @override
  String get tipExercise1 => 'مشي 10 دقائق يُحسب! جرّبه بعد الغداء. 🚶';

  @override
  String get tipExercise2 => 'استخدم السلالم بدل المصعد اليوم.';

  @override
  String get tipExercise3 => 'شغّل أغنيتك المفضلة وارقص عليها. 💃';

  @override
  String get tipExercise4 => 'ادعُ صديقًا للمشي معك، فالأمر أمتع معًا.';

  @override
  String get tipExercise5 => 'تمدد لمدة 5 دقائق عندما تستيقظ.';

  @override
  String get tipStress1 =>
      'جرّب التنفس المربع: شهيق 4، احبس 4، زفير 4، احبس 4. 🫁';

  @override
  String get tipStress2 => 'اكتب 3 أشياء تشعر بالامتنان لها اليوم. ✍️';

  @override
  String get tipStress3 => 'خذ استراحة 5 دقائق بعيدًا عن كل الشاشات.';

  @override
  String get tipStress4 => 'تحدّث مع صديق أو أحد أفراد عائلتك عن يومك.';

  @override
  String get tipStress5 => 'اخرج قليلًا لتستنشق هواءً نقيًا وترى الشمس. ☀️';

  @override
  String get supportTitle => 'نحن معك 💜';

  @override
  String get supportBody =>
      'كان مزاجك منخفضًا كل يوم خلال الأسبوع الماضي، ويبدو أن هذا صعب فعلًا. لست مضطرًا لمواجهة ذلك وحدك. التحدث مع شخص تثق به أو مع مختص يمكن أن يساعد كثيرًا.';

  @override
  String get supportHelpline => 'خط المساعدة';

  @override
  String get copyNumber => 'نسخ الرقم';

  @override
  String get numberCopied => 'تم نسخ الرقم';

  @override
  String get demoLowMood => 'أسبوع مزاج منخفض';

  @override
  String get demoLowMoodDone => 'تم ضبط آخر 7 أيام على مزاج منخفض.';
}
