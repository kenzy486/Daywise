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
  String get tagline => 'عادات صغيرة. أنماطك. أيام أحسن.';

  @override
  String get switchLanguage => 'تغيير اللغة';

  @override
  String get notMedicalAdvice =>
      'DayWise بيساعدك تبني عادات صحية؛ لكنه مش بيقدم نصيحة طبية.';

  @override
  String get demoDisclosure => 'بيانات توضيحية لنور · ليست بيانات حقيقية';

  @override
  String get increase => 'زوّد';

  @override
  String get decrease => 'قلّل';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get close => 'إغلاق';

  @override
  String get navToday => 'اليوم';

  @override
  String get navCheckin => 'تسجيل اليوم';

  @override
  String get navInsights => 'أنماطك';

  @override
  String get navInsightsLong => 'أنماطك الشخصية';

  @override
  String get navForYou => 'لك';

  @override
  String get navSupport => 'الدعم';

  @override
  String get yourSpace => 'مساحتك';

  @override
  String breadcrumb(String page) {
    return 'مساحتك / $page';
  }

  @override
  String get welcomeEyebrow => 'مساحة صغيرة ليك';

  @override
  String get welcomeTitle => 'الأيام الأحسن بتبدأ بسلام صغير.';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get password => 'كلمة السر';

  @override
  String get passwordCreateHint => 'اختار كلمة سر';

  @override
  String get passwordHint => 'كلمة السر بتاعتك';

  @override
  String get passwordHelper => 'استخدم ٨ حروف على الأقل.';

  @override
  String get showPassword => 'إظهار كلمة السر';

  @override
  String get hidePassword => 'إخفاء كلمة السر';

  @override
  String get termsAgreement =>
      'موافق على الشروط وسياسة الخصوصية. يومياتي خاصة بيا بشكل افتراضي.';

  @override
  String get termsRequired =>
      'لازم توافق على الشروط وسياسة الخصوصية عشان تكمّل.';

  @override
  String get createAccount => 'اعمل حسابي المجاني';

  @override
  String get haveAccount => 'عندك حساب؟ سجّل دخول';

  @override
  String get trustTitle => 'من غير اسم حقيقي. من غير أجهزة. من غير ضغط.';

  @override
  String get exploreDemo => 'بتتفرج بس؟ جرّب نسخة نور التوضيحية';

  @override
  String get signInEyebrow => 'أهلًا بيك تاني';

  @override
  String get signInTitle => 'مبسوطين إنك رجعت.';

  @override
  String get signInBody => 'كمّل من مكان ما وقفت. يومياتك زي ما سبتها.';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get forgotPassword => 'نسيت كلمة السر؟';

  @override
  String get noAccount => 'جديد هنا؟ اعمل حساب';

  @override
  String get resetEyebrow => 'ولا يهمك';

  @override
  String get resetTitle => 'يلا نرجّعك.';

  @override
  String get resetBody =>
      'اكتب بريدك الإلكتروني وهنبعتلك لينك تختار بيه كلمة سر جديدة.';

  @override
  String get sendResetLink => 'ابعت لينك التغيير';

  @override
  String get resetEmailSent =>
      'لو فيه حساب بالبريد ده، لينك التغيير في الطريق.';

  @override
  String get backToSignIn => 'ارجع لتسجيل الدخول';

  @override
  String get errRequired => 'الخانة دي مطلوبة.';

  @override
  String get errInvalidEmail => 'اكتب بريد إلكتروني صحيح.';

  @override
  String get errWeakPassword => 'استخدم ٨ حروف على الأقل.';

  @override
  String get errEmailInUse => 'البريد ده متسجل قبل كده. جرّب تسجّل دخول.';

  @override
  String get errWrongCredentials => 'البريد أو كلمة السر مش صح.';

  @override
  String get errTooManyRequests => 'محاولات كتير. استنى شوية وجرّب تاني.';

  @override
  String get errNetwork => 'مفيش اتصال. اتأكد من النت وجرّب تاني.';

  @override
  String get errUnknown => 'حصلت مشكلة. جرّب تاني.';

  @override
  String get errSaveFailed => 'مقدرناش نحفظ دلوقتي. جرّب تاني.';

  @override
  String get goalsEyebrow => 'خلّيها على مقاسك · ١ من ٢';

  @override
  String get goalsTitle => 'عايز مساحة أكبر لإيه؟';

  @override
  String get goalsBody => 'اختار اللي يهمك. تقدر تغيّر رأيك في أي وقت.';

  @override
  String goalsSelected(String count) {
    return 'اختار واحد أو أكتر · $count مختارين';
  }

  @override
  String get goalSleep => 'نوم أحسن';

  @override
  String get goalSleepDesc => 'مساحة صغيرة للراحة';

  @override
  String get goalStress => 'توتر أقل';

  @override
  String get goalStressDesc => 'وقفات تناسب يومك';

  @override
  String get goalEnergy => 'طاقة أكتر';

  @override
  String get goalEnergyDesc => 'لاحظ إيه اللي بيشحنك';

  @override
  String get goalActivity => 'الحركة';

  @override
  String get goalActivityDesc => 'اتحرك بطريقة تقدر عليها';

  @override
  String get goalNutrition => 'الأكل';

  @override
  String get goalNutritionDesc => 'اكتشف عادات أكلك اليومية';

  @override
  String get goalsQuote => 'مفيش أهداف تجري وراها. بس اتجاه شبهك.';

  @override
  String get continueLabel => 'كمّل';

  @override
  String get decideLater => 'هقرر بعدين';

  @override
  String get nameEyebrow => 'خلّيها على مقاسك · ٢ من ٢';

  @override
  String get nameTitle => 'نناديك بإيه؟';

  @override
  String get nameBody => 'اسم دلع كفاية. بيفضل في يومياتك ومش بيتشارك مع حد.';

  @override
  String get nameLabel => 'اسم الدلع';

  @override
  String get nameHint => 'مثلًا: نور';

  @override
  String get startJournal => 'ابدأ يومياتي';

  @override
  String get back => 'رجوع';

  @override
  String todayTitle(String name) {
    return 'لحظة ليك يا $name.';
  }

  @override
  String get todayTitleNoName => 'لحظة ليك.';

  @override
  String get todaySubtitle => 'مش لازم يومك يكون مثالي. المهم يكون يومك.';

  @override
  String get todaySubtitleDesktop => 'لاحظ أيامك. وخليك لطيف مع اللي عايشها.';

  @override
  String get yourOverview => 'نظرة على أيامك';

  @override
  String get weekAtGlance => 'أسبوعك في لمحة';

  @override
  String get days7 => '٧ أيام';

  @override
  String get days30 => '٣٠ يومًا';

  @override
  String checkinsSoFar(String total, String inRange) {
    return '$total تسجيل لحد دلوقتي · $inRange في الفترة دي';
  }

  @override
  String get wellbeingTitle => 'مؤشر رفاهيتك';

  @override
  String latestOn(String date) {
    return 'آخر تسجيل · $date';
  }

  @override
  String outOf100(String score) {
    return '$score من ١٠٠';
  }

  @override
  String get outOf100Short => 'من ١٠٠';

  @override
  String ratingOf5(String value) {
    return '$value من ٥';
  }

  @override
  String get mood => 'المزاج';

  @override
  String get energy => 'الطاقة';

  @override
  String get stress => 'التوتر';

  @override
  String get wellbeingNote =>
      'لمحة عن مزاجك وطاقتك وتوترك، مش تقييم ليك ولا مقياس طبي.';

  @override
  String get wellbeingNoteDesktop =>
      'لمحة، مش تشخيص. المؤشر بيجمع مزاجك وطاقتك وتوترك.';

  @override
  String get wellbeingEmpty => 'المؤشر بيظهر بعد أول تسجيل.';

  @override
  String get checkinCta => 'عامل إيه النهارده؟ سجّل يومك';

  @override
  String get checkinCtaDesktop => 'تسجيل النهارده';

  @override
  String get checkinEditCta => 'عدّل تسجيل النهارده';

  @override
  String get checkinOpenNote => 'حوالي ٣٠ ثانية · تسجيل النهارده لسه مفتوح';

  @override
  String get checkinDoneNote => 'اتحفظ النهارده · تقدر تعدّله في أي وقت';

  @override
  String get feelingTitle => 'إحساسك خلال الأسبوع';

  @override
  String feelingCaption(String range) {
    return '$range · مقياس ١–٥ · التوتر الأقل أفضل';
  }

  @override
  String latestTriple(String mood, String energy, String stress) {
    return 'آخر تسجيل: $mood / $energy / $stress';
  }

  @override
  String get energyVaried =>
      'طاقتك اتغيرت الأسبوع ده. ملاحظاتك ممكن تضيف اللي الرسم مش بيقوله.';

  @override
  String get restTitle => 'الراحة والحركة';

  @override
  String get sleepHoursSeries => 'النوم · ساعات';

  @override
  String get activitySeries => 'النشاط · دقائق';

  @override
  String get noDataYet => 'مفيش تسجيلات في الفترة دي لسه.';

  @override
  String get oneSmallThing => 'خطوة صغيرة';

  @override
  String pendingProgress(String done, String total) {
    return 'لسه · خلّصت $done من $total';
  }

  @override
  String get allDoneTitle => 'خلّصت التلاتة النهارده.';

  @override
  String get allDoneBody => 'عملت مساحة صغيرة لنفسك النهارده. مفيش حاجة تانية.';

  @override
  String get done => 'تم';

  @override
  String get markDone => 'تم';

  @override
  String get skip => 'تخطي';

  @override
  String get skipToday => 'تخطي النهارده';

  @override
  String get allSuggestions => 'اقتراحات النهارده التلاتة';

  @override
  String get seeTodaysSuggestions => 'شوف اقتراحات النهارده التلاتة';

  @override
  String patternEyebrow(String count) {
    return 'نمط يستاهل تستكشفه · $count تسجيل';
  }

  @override
  String get exploreInsights => 'اكتشف أنماطك';

  @override
  String get exploreInsightsLong => 'اكتشف أنماطك الشخصية';

  @override
  String get patternsNotProof => 'الأنماط مش دليل على السبب.';

  @override
  String get patternsNotProofLong =>
      'الأنماط مش دليل على السبب. حاجات تانية ممكن تفرق.';

  @override
  String get almostThereTitle => 'الأنماط جاية في الطريق.';

  @override
  String almostThereBody(String count) {
    return '$count من ٧ تسجيلات لحد دلوقتي. الأنماط بتبدأ بعد ٧ تسجيلات أو أكتر.';
  }

  @override
  String get emptyTitle => 'مساحتك جاهزة.';

  @override
  String get emptyBody => 'وقت ما تحب، سجّل يومك في ٣٠ ثانية. مفيش إجابة غلط.';

  @override
  String get sidebarQuoteTitle => 'إنت إنسان، مش شريط تقدّم.';

  @override
  String get sidebarQuoteBody =>
      'من غير سلاسل أيام. من غير تعويض. بس مساحة تفكر فيها.';

  @override
  String journalOf(String name) {
    return 'يوميات $name';
  }

  @override
  String get myJournal => 'يومياتي';

  @override
  String cityLanguage(String city) {
    return '$city · العربية';
  }

  @override
  String get recentReflections => 'آخر تسجيلاتك';

  @override
  String get viewJournal => 'شوف اليوميات';

  @override
  String get colCheckin => 'التسجيل';

  @override
  String get colSleep => 'النوم';

  @override
  String get colActive => 'الحركة';

  @override
  String get colScore => 'المؤشر';

  @override
  String hoursShort(String value) {
    return '$value س';
  }

  @override
  String minutesShort(String value) {
    return '$value د';
  }

  @override
  String get findSupportLink => 'محتاج حد تتكلم معاه؟ لاقي دعم';

  @override
  String checkinEyebrow(String date) {
    return '$date · تسجيل اليوم';
  }

  @override
  String get checkinTitle => 'يومك عامل إيه بجد؟';

  @override
  String get checkinBody => 'وقفة سريعة ليك إنت بس. تخمينك كفاية.';

  @override
  String get about30Seconds => 'حوالي ٣٠ ثانية';

  @override
  String get demoDraft => 'مسودة توضيحية · مش متسجلة';

  @override
  String get editingToday => 'بتعدّل تسجيل النهارده';

  @override
  String get restSection => 'راحة امبارح بالليل';

  @override
  String get sleepHours => 'ساعات النوم';

  @override
  String get sleepHelper => '٠–١٢ ساعة · كل نص ساعة';

  @override
  String get sleepQuality => 'جودة النوم';

  @override
  String get veryPoor => 'وحش جدًا';

  @override
  String get veryGood => 'كويس جدًا';

  @override
  String get veryLow => 'قليل جدًا';

  @override
  String get veryHigh => 'عالي جدًا';

  @override
  String get innerWeather => 'الجو اللي جواك';

  @override
  String get feelingsNote =>
      'كل المشاعر ليها مكان هنا. الأعلى مش دايمًا أحسن — في التوتر، الأقل يعني أهدى.';

  @override
  String get everydayThings => 'حاجات كل يوم';

  @override
  String get water => 'المية';

  @override
  String get glasses => 'كوبايات';

  @override
  String get waterHelper => 'الكوباية حوالي ٢٥٠ مل.';

  @override
  String get activity => 'الحركة';

  @override
  String get minutes => 'دقايق';

  @override
  String get activityHelper => 'المشي للمحاضرة بيتحسب برضه. كل خطوة ٥ دقايق.';

  @override
  String get meals => 'الوجبات';

  @override
  String get mealsUnit => 'وجبات';

  @override
  String get breaks => 'البريكات';

  @override
  String get breaksUnit => 'بريكات';

  @override
  String get breaksHelper => 'وقفات بعيد عن الشغل أو المذاكرة.';

  @override
  String get screenTime => 'وقت الشاشة';

  @override
  String get screenHelper => '٠–١٦ ساعة · كل نص ساعة';

  @override
  String get caffeine => 'الكافيين';

  @override
  String get servings => 'مرات';

  @override
  String get caffeineHelper => 'احسب كوباية القهوة أو الشاي أو مشروب الطاقة.';

  @override
  String get phoneAway => 'بعدت الموبايل قبل النوم بنص ساعة؟';

  @override
  String get yes => 'أيوه';

  @override
  String get no => 'لأ';

  @override
  String get noteTitle => 'في حاجة في بالك؟';

  @override
  String get optional => 'اختياري';

  @override
  String get noteHint => 'جملة أو اتنين عن يومك…';

  @override
  String get notePrivacy => 'ليومياتك بس. مش محتاج اسم حقيقي.';

  @override
  String get saveCheckin => 'احفظ تسجيل النهارده';

  @override
  String get updateCheckin => 'حدّث تسجيل النهارده';

  @override
  String get checkinFooter =>
      'تسجيل واحد لكل يوم. تقدر تعدّله بعدين.\nالأنماط بتبدأ بعد ٧ تسجيلات أو أكتر.';

  @override
  String get checkinSaved => 'اتحفظ. شكرًا إنك خدت لحظة لنفسك.';

  @override
  String get insightsEyebrow => 'أنماطك، مش روشتة';

  @override
  String get insightsTitle => 'اتعرّف على أيامك.';

  @override
  String insightsBody(String count, String range) {
    return '$count تسجيل · $range. خيوط صغيرة، مع مساحة للسياق.';
  }

  @override
  String get insightsBodyEmpty =>
      'خيوط صغيرة، مع مساحة للسياق. بتظهر بعد ٧ تسجيلات أو أكتر.';

  @override
  String get bestDaysTitle => 'أحسن أيامك شكلها…';

  @override
  String get bestDaysSleep => 'نوم ٧ ساعات أو أكتر.';

  @override
  String get bestDaysMovement => 'شوية حركة.';

  @override
  String get bestDaysBreaks => 'كام وقفة حقيقية بين المذاكرة.';

  @override
  String get bestDaysPhone => 'ليلة أهدى من غير موبايل.';

  @override
  String get bestDaysWater => 'كام كوباية مية زيادة.';

  @override
  String get bestDaysNote =>
      'العادات دي بتظهر مع مزاج وطاقة أعلى في تسجيلاتك. دي خيوط، مش قواعد.';

  @override
  String get confidenceModerate => 'ثقة متوسطة';

  @override
  String get confidenceEmerging => 'بادئة · بيانات قليلة';

  @override
  String get confidenceHigher => 'ثقة أعلى';

  @override
  String get insSleepTitle => 'نوم قليل ومفيش بريكات، طاقة أقل.';

  @override
  String insSleepBody(String diff) {
    return 'الطاقة أقل بحوالي $diff نقطة في الأيام اللي فيها نوم أقل من ٦ ساعات ومن غير بريكات، مقارنة بـ ٧ ساعات أو أكتر مع بريكات.';
  }

  @override
  String get insSleepAxis => 'متوسط الطاقة · ١–٥';

  @override
  String get insSleepA => 'نوم أقل من ٦ ساعات + من غير بريكات';

  @override
  String get insSleepB => '٧ ساعات أو أكتر + بريك واحد على الأقل';

  @override
  String get insMoveTitle => 'حركة أكتر، مزاج أحسن؟';

  @override
  String insMoveBody(String diff) {
    return 'المزاج أعلى بحوالي $diff نقطة في الأيام اللي فيها ٣٠ دقيقة حركة أو أكتر في يومياتك.';
  }

  @override
  String get insMoveAxis => 'متوسط المزاج · ١–٥';

  @override
  String get insMoveA => 'أقل من ٣٠ دقيقة حركة';

  @override
  String get insMoveB => '٣٠ دقيقة حركة أو أكتر';

  @override
  String get insPhoneTitle => 'ليلة أهدى، نوم أطول؟';

  @override
  String insPhoneBody(String diff) {
    return 'في الليالي اللي بعدت فيها الموبايل قبل النوم، النوم أطول بحوالي $diff ساعة في يومياتك.';
  }

  @override
  String get insPhoneAxis => 'متوسط النوم · ٠–١٠ ساعات';

  @override
  String get insPhoneA => 'الموبايل قريب من وقت النوم';

  @override
  String get insPhoneB => 'الموبايل بعيد قبل النوم بنص ساعة';

  @override
  String get insWaterTitle => 'مية أكتر، طاقة أثبت؟';

  @override
  String insWaterBody(String diff) {
    return 'الطاقة أعلى بحوالي $diff نقطة في الأيام اللي فيها ٦ كوبايات مية أو أكتر.';
  }

  @override
  String get insWaterAxis => 'متوسط الطاقة · ١–٥';

  @override
  String get insWaterA => 'أقل من ٦ كوبايات';

  @override
  String get insWaterB => '٦ كوبايات أو أكتر';

  @override
  String insReversed(String a, String b) {
    return 'في تسجيلاتك الموضوع ماشي بالعكس: $a مقابل $b. حاجة تلاحظها، مش تحكم عليها.';
  }

  @override
  String daysCount(String count) {
    return '$count أيام';
  }

  @override
  String demoDaysCount(String count) {
    return '$count أيام توضيحية';
  }

  @override
  String nightsCount(String count) {
    return '$count ليالي';
  }

  @override
  String demoNightsCount(String count) {
    return '$count ليالي توضيحية';
  }

  @override
  String otherDaysExcluded(String count) {
    return '$count أيام تانية مش محسوبة';
  }

  @override
  String get confidenceExplainTitle => 'الأنماط مش دليل على السبب.';

  @override
  String get confidenceExplainBody =>
      'حاجات تانية ممكن تأثر على إحساسك. الثقة بتعكس عدد تسجيلاتك وانتظامها، مش يقين طبي. دي مقارنات صغيرة من تسجيلك إنت.';

  @override
  String get trySuggestion => 'جرّب اقتراح صغير';

  @override
  String get insightsEmptyTitle => 'الأنماط جاية في الطريق.';

  @override
  String get insightsNoneTitle => 'مفيش أنماط واضحة لسه.';

  @override
  String get insightsNoneBody =>
      'أيامك شبه بعض لحد دلوقتي. كمّل تسجيل وممكن تظهر خيوط.';

  @override
  String forYouEyebrow(String date) {
    return 'لك · $date';
  }

  @override
  String get forYouTitle => 'خطوات صغيرة. على راحتك.';

  @override
  String forYouBody(String name) {
    return 'تلات أفكار للنهارده يا $name. جرّب اللي يناسبك وسيب اللي لأ.';
  }

  @override
  String get forYouBodyNoName =>
      'تلات أفكار للنهارده. جرّب اللي يناسبك وسيب اللي لأ.';

  @override
  String doneTodayCount(String done, String total) {
    return 'خلّصت $done من $total النهارده';
  }

  @override
  String get notAScore => 'مش نتيجة تجري وراها';

  @override
  String get doneToday => '✓ اتعمل النهارده';

  @override
  String get pending => 'لسه';

  @override
  String get skippedToday => 'اتخطّى النهارده';

  @override
  String get madeRoom => 'عملت مساحة صغيرة لنفسك.';

  @override
  String get skippedNote => 'التخطي معلومة مفيدة برضه.';

  @override
  String get undo => 'تراجع';

  @override
  String get wasHelpful => 'كان مفيد؟';

  @override
  String get fitsYourDay => 'مناسب ليومك؟';

  @override
  String get helpful => 'مفيد';

  @override
  String get notHelpful => 'مش مفيد';

  @override
  String get agencyTitle => 'اقتراحات، مش أوامر.';

  @override
  String get agencyBody =>
      'التخطي معلومة مفيدة برضه. التجارب دي مش بتوعد بنتيجة معينة.';

  @override
  String get editGoalsLink => 'غيّر أهدافي';

  @override
  String get supportEyebrow => 'مش لازم تشيلها لوحدك';

  @override
  String get supportTitle => 'فيه مساحة للدعم.';

  @override
  String get supportBody => 'الفترة الصعبة مش لازم تشيلها لوحدك.';

  @override
  String get supportHardTitle =>
      'شكل الفترة اللي فاتت كانت صعبة. الكلام مع حد ممكن يساعد.';

  @override
  String get supportGentleTitle => 'لما الدنيا تتقل، الكلام مع حد ممكن يساعد.';

  @override
  String get supportInviteBody =>
      'ده مش تشخيص. تقدر تشوف الاختيارات دي وقت ما تحتاجها — من غير مؤشر أو نمط.';

  @override
  String get universityTitle => 'ابدأ بجامعتك';

  @override
  String get universityBody =>
      'اسأل شؤون الطلاب أو مركز الإرشاد النفسي في جامعتك عن ميعاد خاص، والمواعيد المتاحة وأي مصاريف.';

  @override
  String get universityStarter =>
      '«الفترة دي صعبة عليا شوية. أقدر أحجز ميعاد مع الإرشاد النفسي إزاي؟»';

  @override
  String get universityAction => 'لاقي الموقع الرسمي لجامعتي';

  @override
  String get egyptTitle => 'لاقي دعم في مصر';

  @override
  String get egyptBody =>
      'ابدأ بالموقع الرسمي لوزارة الصحة والسكان المصرية. دوّر على الأمانة العامة للصحة النفسية وعلاج الإدمان وخدماتها الحالية.';

  @override
  String get egyptAction => 'لاقي مصادر الوزارة الرسمية';

  @override
  String get egyptNote =>
      'اتأكد من بيانات التواصل والمواعيد وشروط الخدمة من المصدر الرسمي قبل ما تتواصل. مفيش أرقام تليفونات هنا.';

  @override
  String get urgentTitle => 'لو محتاج مساعدة دلوقتي';

  @override
  String get urgentBody =>
      'لو ممكن تأذي نفسك أو حد تاني، أو في خطر حالًا، كلّم خدمات الطوارئ أو روح أقرب طوارئ. ولو تقدر، اطلب من حد بتثق فيه يفضل معاك.';

  @override
  String get urgentNote =>
      'DayWise مش خدمة طوارئ. يومياتك مش متراقبة عشان طلبات المساعدة العاجلة.';

  @override
  String get linkFailed => 'مقدرناش نفتح اللينك.';

  @override
  String get copyStarter => 'انسخ';

  @override
  String get copied => 'اتنسخ';

  @override
  String get accountTitle => 'الحساب والبيانات';

  @override
  String get accountData => 'الحساب والبيانات';

  @override
  String nicknameLine(String name) {
    return 'اسم الدلع: $name';
  }

  @override
  String get edit => 'تعديل';

  @override
  String get privateByDefault => 'خاص بشكل افتراضي. مش محتاج اسم حقيقي.';

  @override
  String get editNickname => 'عدّل اسم الدلع';

  @override
  String get editGoals => 'عدّل الأهداف';

  @override
  String get exportEntries => 'صدّر تسجيلاتي';

  @override
  String get exportReady => 'تسجيلاتك جاهزة للنسخ.';

  @override
  String get deleteData => 'امسح بياناتي';

  @override
  String get deleteConfirmTitle => 'تمسح كل بياناتك؟';

  @override
  String get deleteConfirmBody =>
      'ده هيمسح تسجيلاتك واقتراحاتك وملفك نهائيًا. مينفعش يرجع.';

  @override
  String get deleteConfirm => 'امسح كل حاجة';

  @override
  String get dataDeleted => 'بياناتك اتمسحت.';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get leaveDemo => 'اخرج من النسخة التوضيحية';

  @override
  String get demoCta => 'عجبك؟ اعمل يومياتك الخاصة.';

  @override
  String get goalsSaved => 'الأهداف اتحدّثت.';

  @override
  String get lpNavHow => 'إزاي بيشتغل';

  @override
  String get lpNavMade => 'معمول ليومك';

  @override
  String get lpNavPrivacy => 'الخصوصية';

  @override
  String get lpExploreDemo => 'جرّب النسخة التوضيحية';

  @override
  String get lpStartDay => 'ابدأ يومك';

  @override
  String get lpHeroBadge => 'لحظة تفكير صغيرة. وشوية أكتر منك.';

  @override
  String get lpHeroTitle => 'عادات صغيرة.\nأنماطك.\nأيام أحسن.';

  @override
  String get lpHeroBody =>
      'أيامك مليانة. اعمل مساحة صغيرة لنفسك. تسجيل في ٣٠ ثانية بيساعدك تلاحظ إيه اللي بيدعم راحتك، خطوة صغيرة كل مرة.';

  @override
  String get lpStartFree => 'ابدأ مجانًا';

  @override
  String get lpExploreNour => 'جرّب نسخة نور التوضيحية';

  @override
  String get lpHeroMeta => 'مجاني للأفراد · عربي / English · من غير أجهزة';

  @override
  String get lpHeroNoteTitle => 'مش لازم تغيّر كل حاجة.';

  @override
  String get lpHeroNoteBody => 'بس لاقي حاجة واحدة تناسب النهارده.';

  @override
  String get lpBusyEyebrow => 'للأيام اللي بتحس إنها كتير';

  @override
  String get lpBusyTitle => 'الأيام الزحمة ممكن تخبّي الصورة الكبيرة.';

  @override
  String get lpBusyBody =>
      'محاضرات، مواصلات، ديدلاينز، وسكرول لآخر الليل. صعب تلاحظ إزاي النوم والحركة وروتينك اليومي ماشيين جنب إحساسك.';

  @override
  String get lpBusyPoint =>
      'مش روتين جديد لازم يبقى مثالي. طريقة تفهم بيها روتينك.';

  @override
  String get lpLoopEyebrow => 'دايرة صغيرة، معمولة حواليك';

  @override
  String get lpLoopTitle => 'سجّل. لاحظ. جرّب حاجة واحدة.';

  @override
  String get lpLoopNote =>
      'مش محتاج أجهزة ولا ملف طبي ولا أسبوع مثالي. موبايلك كفاية.';

  @override
  String get lpStep1Title => 'ابدأ بإنت عامل إيه.';

  @override
  String get lpStep1Body =>
      'حوالي ٣٠ ثانية تسجّل فيها نومك ومزاجك وطاقتك وعاداتك اليومية. مفيش إجابات صح.';

  @override
  String get lpStep1Tag => 'تسجيل واحد في اليوم';

  @override
  String get lpStep2Title => 'شوف أنماطك إنت.';

  @override
  String get lpStep2Body =>
      'بعد ٧ تسجيلات أو أكتر، اكتشف روابط بسيطة في أيامك. مش تشخيص. ومش توقّع.';

  @override
  String get lpStep2Tag => 'أنماطك، بكلام بسيط';

  @override
  String get lpStep3Title => 'اعمل مساحة لخطوة صغيرة.';

  @override
  String get lpStep3Body =>
      'جرّب تجربة واقعية تناسب جدولك. خلّي اللي يفيدك، وسيب اللي لأ.';

  @override
  String get lpStep3Tag => 'خطوة صغيرة واحدة';

  @override
  String get lpPerspEyebrow => 'تخمين أقل. معرفة أكتر بنفسك.';

  @override
  String get lpPerspTitle => 'أيامك، من زاوية أوضح شوية.';

  @override
  String get lpPerspBody =>
      'نظرة هادية، مش تقييم. تابع المزاج والطاقة والتوتر والنوم والحركة مع بعض — وشوف إيه اللي يستاهل تستكشفه.';

  @override
  String get lpPerspNote =>
      'الأنماط بتبدأ بعد ٧ تسجيلات أو أكتر. التسجيلات الأكتر بتضيف سياق، بس لو فوّت يوم، عادي خالص.';

  @override
  String get lpMeetNour => 'قابل نور في النسخة التوضيحية';

  @override
  String get lpDemoCardTitle => 'الصورة أوضح شوية يا نور.';

  @override
  String get lpIllustrativeDemo => 'نسخة توضيحية';

  @override
  String lpWellbeingLine(String score) {
    return 'مؤشر الرفاهية · $score / ١٠٠';
  }

  @override
  String lpLatestCheckin(String date) {
    return 'آخر تسجيل · $date';
  }

  @override
  String get lpSnapshot => 'لمحة عن إحساسك، مش مقياس طبي.';

  @override
  String get lpLast7 => 'آخر ٧ أيام';

  @override
  String get lpDemoInsightBody =>
      'في النسخة التوضيحية، المزاج أعلى بحوالي نقطة ونص في الأيام اللي فيها ٣٠ دقيقة حركة أو أكتر. نمط، مش دليل.';

  @override
  String get lpNudgeEyebrow => 'صغير كفاية للحياة الحقيقية';

  @override
  String get lpNudgeTitle => 'تشجيعة صغيرة، مش قايمة مهام جديدة.';

  @override
  String get lpNudgeNote =>
      'تلات اقتراحات. والاختيار ليك. قول لـ DayWise إيه اللي يناسبك وسيب الباقي.';

  @override
  String get lpNudge1 => 'شوية حركة';

  @override
  String get lpNudge2 => 'ليلة أهدى';

  @override
  String get lpNudge3 => 'وقفة تناسبك';

  @override
  String get lpNudgeTry => 'جرّبها. عدّلها. أو سيبها.';

  @override
  String get lpEgyptEyebrow => 'مصر الأول. ولغتك كمان.';

  @override
  String get lpEgyptArabic => 'يومك يستاهل لحظة ليك.';

  @override
  String get lpEgyptTitle =>
      'معمول للحياة اللي بين المحاضرات والشغل وكل حاجة تانية.';

  @override
  String get lpEgyptBody =>
      'معمول للطلاب والشباب اللي بيشتغلوا، من ١٨ لـ ٣٠ سنة. استخدم DayWise بالعربي أو الإنجليزي، باقتراحات يومية مألوفة وتجربة عربي كاملة من اليمين للشمال.';

  @override
  String get lpArabicFirst => 'عربي أولًا';

  @override
  String get lpPhoneOnly => 'موبايل بس · من غير أجهزة زيادة';

  @override
  String get lpPrivEyebrow => 'مساحة خاصة، مش عرض';

  @override
  String get lpPrivTitle => 'حياتك شخصية. ويومياتك لازم تبقى كده كمان.';

  @override
  String get lpPrivBody =>
      'DayWise بيساعدك تبني عادات صحية؛ لكنه مش بيقدم نصيحة طبية. إحنا مش بنشخّص، والمؤشر عمره ما هيحكي الحكاية كلها. ولما تحتاج دعم أكتر، بنساعدك تلاقي خطوة جاية مع إنسان.';

  @override
  String get lpPriv1Title => 'خاص بشكل افتراضي';

  @override
  String get lpPriv1Body =>
      'مش محتاج اسم حقيقي. فكّر في يومك من غير ما يتحول لمنشور عام.';

  @override
  String get lpPriv2Title => 'القرار في إيدك';

  @override
  String get lpPriv2Body =>
      'صدّر تسجيلاتك أو امسح بياناتك من حسابك. يومياتك، وقرارك.';

  @override
  String get lpPriv3Title => 'رعاية أبعد من التطبيق';

  @override
  String get lpPriv3Body =>
      'لاقي الإرشاد النفسي في جامعتك ومصادر الصحة النفسية الرسمية في مصر، من غير تشخيص.';

  @override
  String get lpFaqEyebrow => 'كام سؤال مهم';

  @override
  String get lpFaqTitle => 'شوية وضوح، قبل ما تبدأ.';

  @override
  String get lpExploreSupport => 'شوف الدعم';

  @override
  String get lpQ1 => 'هل DayWise خدمة طبية أو علاج نفسي؟';

  @override
  String get lpA1 =>
      'لأ. DayWise يوميات للراحة اليومية. بيدعم العادات الصحية، مش التشخيص أو العلاج أو القرارات الطبية.';

  @override
  String get lpQ2 => 'إمتى هشوف أنماطي الشخصية؟';

  @override
  String get lpA2 =>
      'بعد ٧ تسجيلات على الأقل. الأنماط روابط شخصية، مش دليل إن عادة واحدة سببت تغيير. البيانات الأكتر بتضيف سياق.';

  @override
  String get lpQ3 => 'لو فوّت يوم؟';

  @override
  String get lpA3 =>
      'ارجع وقت ما تحب. مفيش سلاسل أيام تحافظ عليها، ولا عقاب، ولا أسبوع مثالي تجري وراه.';

  @override
  String get lpQ4 => 'محتاج جهاز أو اشتراك مدفوع؟';

  @override
  String get lpA4 =>
      'لأ. DayWise على الموبايل بس ومجاني للأفراد. مش محتاج أجهزة ولا ملفات طبية.';

  @override
  String get lpQ5 => 'أقدر أستخدمه بالعربي؟';

  @override
  String get lpA5 =>
      'أيوه. العربي والإنجليزي موجودين في كل مكان، مع تصميم معكوس من اليمين للشمال بالعربي.';

  @override
  String get lpCtaTitle => 'ابدأ بالنهارده. والباقي يستنى.';

  @override
  String get lpCtaBody => 'تسجيل صغير بداية لطيفة. مش محتاج روتين مثالي.';

  @override
  String get lpExploreTheDemo => 'جرّب النسخة التوضيحية';

  @override
  String get lpFooterSupport => 'الدعم';

  @override
  String get lpFooterAccount => 'الحساب والبيانات';

  @override
  String get lpFooterSdg =>
      'معمول لدعم الهدف ٣ من أهداف التنمية المستدامة: الصحة الجيدة والرفاه، خصوصًا الغاية ٣.٤.\nمشروع مستقل. مالوش علاقة بالأمم المتحدة ولا معتمد منها.';

  @override
  String get lpFooterCopy => '© ٢٠٢٦ DayWise · معمول بمساحة للتنفس.';
}
