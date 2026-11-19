import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// The goal areas from "Choose your goals".
enum Goal { sleep, stress, energy, activity, nutrition }

enum SuggestionStatus { pending, done, skipped }

class Suggestion {
  final String id;
  final Goal area;
  final IconData icon;
  final String titleEn;
  final String titleAr;
  final String rationaleEn;
  final String rationaleAr;

  const Suggestion({
    required this.id,
    required this.area,
    required this.icon,
    required this.titleEn,
    required this.titleAr,
    required this.rationaleEn,
    required this.rationaleAr,
  });

  String title(String lang) => lang == 'ar' ? titleAr : titleEn;
  String rationale(String lang) => lang == 'ar' ? rationaleAr : rationaleEn;
}

/// What the user did with one suggestion today.
class SuggestionState {
  final SuggestionStatus status;
  final bool? helpful; // thumbs up = true, down = false
  const SuggestionState({this.status = SuggestionStatus.pending, this.helpful});

  SuggestionState copyWith({SuggestionStatus? status, bool? helpful, bool clearHelpful = false}) =>
      SuggestionState(
        status: status ?? this.status,
        helpful: clearHelpful ? null : (helpful ?? this.helpful),
      );

  Map<String, dynamic> toMap() => {'status': status.name, if (helpful != null) 'helpful': helpful};

  factory SuggestionState.fromMap(Map<String, dynamic> m) => SuggestionState(
    status: SuggestionStatus.values.firstWhere(
      (s) => s.name == m['status'],
      orElse: () => SuggestionStatus.pending,
    ),
    helpful: m['helpful'] as bool?,
  );
}

class SuggestionsService {
  static const all = <Suggestion>[
    // Sleep
    Suggestion(
      id: 'sleep_phone',
      area: Goal.sleep,
      icon: LucideIcons.moon,
      titleEn: 'Put your phone away 30 minutes before bed',
      titleAr: 'ابعد موبايلك قبل النوم بنص ساعة',
      rationaleEn: 'A small wind-down experiment, inspired by your evening notes. Notice how tomorrow feels.',
      rationaleAr: 'تجربة صغيرة لليلة دي. شوف إيه يناسبك، من غير ما تبقى قاعدة لازم تمشي عليها.',
    ),
    Suggestion(
      id: 'sleep_same_time',
      area: Goal.sleep,
      icon: LucideIcons.bedDouble,
      titleEn: 'Aim for the same bedtime as last night',
      titleAr: 'حاول تنام في نفس معاد امبارح',
      rationaleEn: 'A steadier rhythm can make it easier to wind down. No alarm needed for this one.',
      rationaleAr: 'لما المواعيد تبقى ثابتة شوية، الهدوء قبل النوم بيبقى أسهل.',
    ),
    Suggestion(
      id: 'sleep_dark_room',
      area: Goal.sleep,
      icon: LucideIcons.lampDesk,
      titleEn: 'Dim the lights an hour before sleep',
      titleAr: 'وطّي النور قبل النوم بساعة',
      rationaleEn: 'Softer light in the evening is a gentle cue that the day is winding down.',
      rationaleAr: 'النور الهادي بالليل إشارة لطيفة إن اليوم بيخلص.',
    ),
    // Stress
    Suggestion(
      id: 'stress_study_break',
      area: Goal.stress,
      icon: LucideIcons.coffee,
      titleEn: 'Take a 5-minute break every 50 minutes of study',
      titleAr: 'خد بريك ٥ دقايق كل ٥٠ دقيقة مذاكرة',
      rationaleEn: 'Stand up, stretch or look out the window. A pause doesn’t have to be productive.',
      rationaleAr: 'قوم، اتمطّع، أو بص من الشباك. البريك مش لازم يكون مفيد.',
    ),
    Suggestion(
      id: 'stress_breathing',
      area: Goal.stress,
      icon: LucideIcons.wind,
      titleEn: 'Try four slow breaths before your next task',
      titleAr: 'جرّب أربع أنفاس بطيئة قبل المهمة الجاية',
      rationaleEn: 'In for four, out for six. A tiny reset you can do anywhere.',
      rationaleAr: 'شهيق لأربعة، زفير لستة. وقفة صغيرة تقدر تعملها في أي مكان.',
    ),
    Suggestion(
      id: 'stress_write_down',
      area: Goal.stress,
      icon: LucideIcons.notebookPen,
      titleEn: 'Write down what’s on your mind, then close the notebook',
      titleAr: 'اكتب اللي في دماغك، وبعدين اقفل الكشكول',
      rationaleEn: 'Putting worries on paper can make them feel a little smaller.',
      rationaleAr: 'لما تكتب اللي شاغلك، ممكن تحس إنه بقى أصغر شوية.',
    ),
    // Energy
    Suggestion(
      id: 'energy_water',
      area: Goal.energy,
      icon: LucideIcons.glassWater,
      titleEn: 'Start your day with a glass of water',
      titleAr: 'ابدأ يومك بكوباية مية',
      rationaleEn: 'An easy first step before coffee or your phone.',
      rationaleAr: 'خطوة سهلة قبل القهوة أو الموبايل.',
    ),
    Suggestion(
      id: 'energy_daylight',
      area: Goal.energy,
      icon: LucideIcons.sun,
      titleEn: 'Get ten minutes of daylight before noon',
      titleAr: 'اقعد في الشمس عشر دقايق قبل الضهر',
      rationaleEn: 'A balcony, a walk to the bus or a coffee by the window all count.',
      rationaleAr: 'البلكونة أو المشي للمواصلات أو قهوة جنب الشباك، كله ينفع.',
    ),
    Suggestion(
      id: 'energy_caffeine',
      area: Goal.energy,
      icon: LucideIcons.cupSoda,
      titleEn: 'Keep your last coffee before 3pm today',
      titleAr: 'خلّي آخر قهوة النهارده قبل الساعة ٣',
      rationaleEn: 'See whether an earlier cut-off changes how tonight feels.',
      rationaleAr: 'شوف لو ده هيفرق في إحساسك بالليل.',
    ),
    // Activity
    Suggestion(
      id: 'activity_walk',
      area: Goal.activity,
      icon: LucideIcons.footprints,
      titleEn: 'Take a 10-minute walk after your 2pm lecture',
      titleAr: 'اتمشى ١٠ دقايق بعد محاضرة الساعة ٢',
      rationaleEn:
          'Your entries pair more movement with higher mood. A short walk is one way to explore that.',
      rationaleAr: 'تسجيلاتك بتربط الحركة الأكتر بمزاج أحسن. مشية قصيرة طريقة تجرّب بيها ده.',
    ),
    Suggestion(
      id: 'activity_stairs',
      area: Goal.activity,
      icon: LucideIcons.trendingUp,
      titleEn: 'Take the stairs once today',
      titleAr: 'اطلع السلم مرة النهارده',
      rationaleEn: 'Small bits of movement add up across a day.',
      rationaleAr: 'الحركة الصغيرة بتتجمع على مدار اليوم.',
    ),
    Suggestion(
      id: 'activity_stretch',
      area: Goal.activity,
      icon: LucideIcons.personStanding,
      titleEn: 'Stretch for five minutes when you get home',
      titleAr: 'اتمطّع خمس دقايق أول ما توصل البيت',
      rationaleEn: 'A gentle way to shift from the day into the evening.',
      rationaleAr: 'طريقة لطيفة تنقلك من زحمة اليوم لهدوء الليل.',
    ),
    // Nutrition
    Suggestion(
      id: 'nutrition_breakfast',
      area: Goal.nutrition,
      icon: LucideIcons.eggFried,
      titleEn: 'Eat something before your first class',
      titleAr: 'كُل حاجة قبل أول محاضرة',
      rationaleEn: 'Even a small breakfast counts. Notice how your morning goes.',
      rationaleAr: 'حتى فطار صغير ينفع. لاحظ صباحك هيبقى عامل إزاي.',
    ),
    Suggestion(
      id: 'nutrition_no_screen',
      area: Goal.nutrition,
      icon: LucideIcons.utensils,
      titleEn: 'Have one meal today without a screen',
      titleAr: 'كُل وجبة واحدة النهارده من غير شاشة',
      rationaleEn: 'A quieter meal can be a small pause in a busy day.',
      rationaleAr: 'وجبة هادية ممكن تبقى وقفة صغيرة في يوم زحمة.',
    ),
    Suggestion(
      id: 'nutrition_fruit',
      area: Goal.nutrition,
      icon: LucideIcons.apple,
      titleEn: 'Add a piece of fruit to your day',
      titleAr: 'زوّد فاكهة على يومك',
      rationaleEn: 'An easy snack to keep in your bag between lectures.',
      rationaleAr: 'سناك سهل تشيله في شنطتك بين المحاضرات.',
    ),
  ];

  /// Nour's demo day, as shown in the design.
  static const demoIds = ['activity_walk', 'sleep_phone', 'stress_study_break'];

  static Suggestion byId(String id) => all.firstWhere((s) => s.id == id);

  /// Three suggestions for [date], stable for the whole day,
  /// spread across the user's goals (all areas if none chosen).
  static List<Suggestion> forDate(DateTime date, List<Goal> goals) {
    final areas = goals.isEmpty ? Goal.values : goals;
    final seed = date.year * 10000 + date.month * 100 + date.day;
    final random = Random(seed);
    final pools = {for (final a in areas) a: (all.where((s) => s.area == a).toList()..shuffle(random))};
    final order = [...areas]..shuffle(random);
    final picked = <Suggestion>[];
    var round = 0;
    while (picked.length < 3 && round < 3) {
      for (final a in order) {
        if (picked.length == 3) break;
        if (pools[a]!.length > round) picked.add(pools[a]![round]);
      }
      round++;
    }
    return picked;
  }
}
