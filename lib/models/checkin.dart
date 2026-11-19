class CheckIn {
  final String date; // 'yyyy-MM-dd', also the document name
  final double sleepHours; // 0–12 (half hours allowed, e.g. 7.5)
  final int sleepQuality; // 1–5
  final int waterGlasses; // 0–15
  final int exerciseMinutes; // 0–180
  final int mood; // 1–5
  final int energy; // 1–5
  final int stress; // 1–5
  final int meals; // 0–6
  final int breaks; // 0–12
  final double screenTimeHours; // 0–16 (half hours allowed)
  final int caffeineServings; // 0–10
  final bool? phoneAwayBeforeBed; // optional
  final String? note; // optional, max 500 chars
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CheckIn({
    required this.date,
    required this.sleepHours,
    this.sleepQuality = 3,
    required this.waterGlasses,
    required this.exerciseMinutes,
    required this.mood,
    required this.energy,
    required this.stress,
    this.meals = 3,
    this.breaks = 0,
    this.screenTimeHours = 4,
    this.caffeineServings = 0,
    this.phoneAwayBeforeBed,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  // Starting values for a day that has no check-in yet
  factory CheckIn.empty(DateTime day) => CheckIn(
    date: dateId(day),
    sleepHours: 7,
    sleepQuality: 3,
    waterGlasses: 4,
    exerciseMinutes: 0,
    mood: 3,
    energy: 3,
    stress: 3,
    meals: 3,
    breaks: 0,
    screenTimeHours: 4,
    caffeineServings: 0,
  );

  // DateTime -> '2026-10-21'
  static String dateId(DateTime day) =>
      '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

  // '2026-10-21' -> DateTime (used for charts later)
  DateTime get day => DateTime.parse(date);

  // Calculate well-being score (0-100)
  // Formula: round(((mood-1) + (energy-1) + (5-stress)) / 12 * 100)
  int get wellbeingScore {
    final moodScore = (mood - 1);
    final energyScore = (energy - 1);
    final stressScore = (5 - stress);
    final total = moodScore + energyScore + stressScore;
    return ((total / 12) * 100).round();
  }

  // Check-in -> Map (to save in Firestore)
  Map<String, dynamic> toMap() => {
    'date': date,
    'sleepHours': sleepHours,
    'sleepQuality': sleepQuality,
    'waterGlasses': waterGlasses,
    'exerciseMinutes': exerciseMinutes,
    'mood': mood,
    'energy': energy,
    'stress': stress,
    'meals': meals,
    'breaks': breaks,
    'screenTimeHours': screenTimeHours,
    'caffeineServings': caffeineServings,
    if (phoneAwayBeforeBed != null) 'phoneAwayBeforeBed': phoneAwayBeforeBed,
    if (note != null) 'note': note,
    if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
  };

  // Map from Firestore -> Check-in (with backward compatibility)
  factory CheckIn.fromMap(Map<String, dynamic> m) => CheckIn(
    date: m['date'] as String,
    sleepHours: (m['sleepHours'] as num?)?.toDouble() ?? 7.0,
    sleepQuality: (m['sleepQuality'] as num?)?.toInt() ?? 3,
    waterGlasses: (m['waterGlasses'] as num?)?.toInt() ?? 4,
    exerciseMinutes: (m['exerciseMinutes'] as num?)?.toInt() ?? 0,
    mood: (m['mood'] as num?)?.toInt() ?? 3,
    energy: (m['energy'] as num?)?.toInt() ?? 3,
    stress: (m['stress'] as num?)?.toInt() ?? 3,
    meals: (m['meals'] as num?)?.toInt() ?? 3,
    breaks: (m['breaks'] as num?)?.toInt() ?? 0,
    screenTimeHours: (m['screenTimeHours'] as num?)?.toDouble() ?? 4.0,
    caffeineServings: (m['caffeineServings'] as num?)?.toInt() ?? 0,
    phoneAwayBeforeBed: m['phoneAwayBeforeBed'] as bool?,
    note: m['note'] as String?,
    createdAt: _toDate(m['createdAt']),
    updatedAt: _toDate(m['updatedAt']),
  );

  // Firestore gives a Timestamp for server times; older entries store ISO strings.
  static DateTime? _toDate(Object? v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String) return DateTime.tryParse(v);
    try {
      return (v as dynamic).toDate() as DateTime;
    } catch (_) {
      return null;
    }
  }

  // Set or clear the optional phone-away answer (copyWith can't clear to null).
  CheckIn withPhoneAway(bool? value) =>
      CheckIn.fromMap({...toMap()..remove('phoneAwayBeforeBed'), 'phoneAwayBeforeBed': ?value});

  // Copy with method for easy updates
  CheckIn copyWith({
    String? date,
    double? sleepHours,
    int? sleepQuality,
    int? waterGlasses,
    int? exerciseMinutes,
    int? mood,
    int? energy,
    int? stress,
    int? meals,
    int? breaks,
    double? screenTimeHours,
    int? caffeineServings,
    bool? phoneAwayBeforeBed,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CheckIn(
      date: date ?? this.date,
      sleepHours: sleepHours ?? this.sleepHours,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      waterGlasses: waterGlasses ?? this.waterGlasses,
      exerciseMinutes: exerciseMinutes ?? this.exerciseMinutes,
      mood: mood ?? this.mood,
      energy: energy ?? this.energy,
      stress: stress ?? this.stress,
      meals: meals ?? this.meals,
      breaks: breaks ?? this.breaks,
      screenTimeHours: screenTimeHours ?? this.screenTimeHours,
      caffeineServings: caffeineServings ?? this.caffeineServings,
      phoneAwayBeforeBed: phoneAwayBeforeBed ?? this.phoneAwayBeforeBed,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
