import 'dart:math';
import '../models/checkin.dart';
import '../l10n/app_localizations.dart';

enum SuggestionArea { sleep, stress, energy, activity, nutrition }

class Suggestion {
  final String id;
  final SuggestionArea area;
  final String titleEn;
  final String titleAr;
  final String rationaleEn;
  final String rationaleAr;

  const Suggestion({
    required this.id,
    required this.area,
    required this.titleEn,
    required this.titleAr,
    required this.rationaleEn,
    required this.rationaleAr,
  });

  String getTitle(AppLocalizations t) {
    return t.locale.languageCode == 'ar' ? titleAr : titleEn;
  }

  String getRationale(AppLocalizations t) {
    return t.locale.languageCode == 'ar' ? rationaleAr : rationaleEn;
  }
}

class SuggestionsService {
  static const suggestions = [
    // Sleep
    Suggestion(
      id: 'sleep_1',
      area: SuggestionArea.sleep,
      titleEn: 'Put your phone away 30 minutes before bed',
      titleAr: 'ابعد موبايلك قبل النوم بنص ساعة',
      rationaleEn: 'A small wind-down experiment, inspired by your evening notes. Notice how tomorrow feels.',
      rationaleAr: 'تجربة صغيرة لليلة دي، مستوحاة من ملاحظاتك المسائية. شوف بكرة بيحسّك إزاي.',
    ),
    Suggestion(
      id: 'sleep_2',
      area: SuggestionArea.sleep,
      titleEn: 'Try going to bed at the same time tonight',
      titleAr: 'حاول تنام في نفس الموعد الليلة',
      rationaleEn: 'Consistency helps your body know when to rest.',
      rationaleAr: 'الاستمرارية بتعرف جسمك إمتى يرتاح.',
    ),
    Suggestion(
      id: 'sleep_3',
      area: SuggestionArea.sleep,
      titleEn: 'Keep your room dark, quiet and a little cool',
      titleAr: 'خلي غرفتك مظلمة وهادئة وباردة شوية',
      rationaleEn: 'Your environment affects how easily you fall asleep.',
      rationaleAr: 'بيئتك بتأثر إزاي بتنام بسهولة.',
    ),
    // Stress
    Suggestion(
      id: 'stress_1',
      area: SuggestionArea.stress,
      titleEn: 'Take a 5-minute break away from all screens',
      titleAr: 'خذ راحة 5 دقايق بعيدًا عن كل الشاشات',
      rationaleEn: 'A brief screen-free pause can reset your mind.',
      rationaleAr: 'توقف سريع من غير شاشات ممكن يرجع دماغك.',
    ),
    Suggestion(
      id: 'stress_2',
      area: SuggestionArea.stress,
      titleEn: 'Try box breathing: in for 4, hold for 4, out for 4, hold for 4',
      titleAr: 'جرّب التنفس المربع: شهيق 4، احبس 4، زفير 4، احبس 4',
      rationaleEn: 'A simple breathing technique to calm your nervous system.',
      rationaleAr: 'تقنية تنفس بسيطة عشان تهدّي جهازك العصبي.',
    ),
    Suggestion(
      id: 'stress_3',
      area: SuggestionArea.stress,
      titleEn: 'Write down 3 things you\'re grateful for today',
      titleAr: 'اكتب 3 حاجات شاكر فيها النهارده',
      rationaleEn: 'Gratitude practice can shift your perspective.',
      rationaleAr: 'ممارسة الامتنان ممكن تغير منظورك.',
    ),
    // Energy
    Suggestion(
      id: 'energy_1',
      area: SuggestionArea.energy,
      titleEn: 'Take a 10-minute walk after your 2pm lecture',
      titleAr: 'امشي 10 دقايق بعد محاضرة الساعة 2',
      rationaleEn: 'Movement can boost your energy and mood.',
      rationaleAr: 'الحركة ممكن تزيد طاقتك ومزاجك.',
    ),
    Suggestion(
      id: 'energy_2',
      area: SuggestionArea.energy,
      titleEn: 'Drink a glass of water before anything else',
      titleAr: 'اشرب كوب ماء قبل أي حاجة',
      rationaleEn: 'Hydration affects your energy levels.',
      rationaleAr: 'الترطيب بيأثر على مستويات طاقتك.',
    ),
    Suggestion(
      id: 'energy_3',
      area: SuggestionArea.energy,
      titleEn: 'Step outside for some fresh air and sunlight',
      titleAr: 'خرج شوية عشان هوا نقي وشمس',
      rationaleEn: 'Natural light and air can refresh you.',
      rationaleAr: 'الضوء الطبيعي والهوا ممكن يحدّثوك.',
    ),
    // Activity
    Suggestion(
      id: 'activity_1',
      area: SuggestionArea.activity,
      titleEn: 'Take the stairs instead of the elevator today',
      titleAr: 'استخدم السلالم بدل المصعد اليوم',
      rationaleEn: 'Small movements add up over the day.',
      rationaleAr: 'الحركات الصغيرة بتكمل طول اليوم.',
    ),
    Suggestion(
      id: 'activity_2',
      area: SuggestionArea.activity,
      titleEn: 'Stretch for 5 minutes when you wake up',
      titleAr: 'تمدد لمدة 5 دقايق لما تستيقظ',
      rationaleEn: 'Gentle stretching starts your day positively.',
      rationaleAr: 'التمدد اللطيف بيبدأ يومك بإيجابية.',
    ),
    Suggestion(
      id: 'activity_3',
      area: SuggestionArea.activity,
      titleEn: 'Dance to your favorite song for 3 minutes',
      titleAr: 'رقص على أغنيتك المفضلة لمدة 3 دقايق',
      rationaleEn: 'Music and movement lift your spirits.',
      rationaleAr: 'الموسيقى والحركة بترفع روحك.',
    ),
    // Nutrition
    Suggestion(
      id: 'nutrition_1',
      area: SuggestionArea.nutrition,
      titleEn: 'Eat a meal without distractions today',
      titleAr: 'اكل وجبة من غير تشتتات النهارده',
      rationaleEn: 'Mindful eating helps you enjoy your food more.',
      rationaleAr: 'الأكل الواعي بيخليك تستمتع بأكلك أكتر.',
    ),
    Suggestion(
      id: 'nutrition_2',
      area: SuggestionArea.nutrition,
      titleEn: 'Drink a glass of water with every meal',
      titleAr: 'اشرب كوب ماء مع كل وجبة',
      rationaleEn: 'Hydration supports healthy digestion.',
      rationaleAr: 'الترطيب بيدعم هضم صحي.',
    ),
    Suggestion(
      id: 'nutrition_3',
      area: SuggestionArea.nutrition,
      titleEn: 'Add one more vegetable to your plate today',
      titleAr: 'ضيف خضار واحد كتر لطبقك النهارده',
      rationaleEn: 'Small nutrition improvements build over time.',
      rationaleAr: 'تحسينات تغذية صغيرة بتتكون مع الوقت.',
    ),
  ];

  // Get 3 suggestions for a specific date
  static List<Suggestion> getSuggestionsForDate(DateTime date, List<String> userGoals) {
    final random = Random(date.millisecondsSinceEpoch ~/ 86400000);
    final available = suggestions.where((s) => userGoals.isEmpty || userGoals.contains(s.area.name)).toList();
    available.shuffle(random);
    return available.take(3).toList();
  }
}
