import '../models/checkin.dart';

/// The comparisons DayWise looks for (mirrors the Personal insights design).
enum InsightKind { sleepBreaksEnergy, movementMood, phoneAwaySleep, waterEnergy }

enum Confidence { emerging, moderate, higher }

/// One comparison: the "less helpful" group A vs the "habit" group B.
class Insight {
  final InsightKind kind;
  final double avgA;
  final double avgB;
  final int daysA;
  final int daysB;
  final int excluded;
  const Insight({
    required this.kind,
    required this.avgA,
    required this.avgB,
    required this.daysA,
    required this.daysB,
    required this.excluded,
  });

  /// Positive = the habit group B looks better.
  double get difference => avgB - avgA;

  /// Upper bound of the chart scale (5 for ratings, 10 hours for sleep).
  double get scaleMax => kind == InsightKind.phoneAwaySleep ? 10 : 5;

  Confidence get confidence {
    final smaller = daysA < daysB ? daysA : daysB;
    if (smaller >= 10) return Confidence.higher;
    if (smaller >= 4) return Confidence.moderate;
    return Confidence.emerging;
  }
}

class InsightsService {
  static const minCheckins = 7; // "Patterns begin after 7+ check-ins"
  static const minDaysPerGroup = 2;
  static const minDifference = 0.4;

  /// Returns null when a day doesn't belong to either group.
  static bool? _inB(InsightKind k, CheckIn c) => switch (k) {
    InsightKind.sleepBreaksEnergy =>
      c.sleepHours < 6 && c.breaks == 0 ? false : (c.sleepHours >= 7 && c.breaks >= 1 ? true : null),
    InsightKind.movementMood => c.exerciseMinutes >= 30,
    InsightKind.phoneAwaySleep => c.phoneAwayBeforeBed,
    InsightKind.waterEnergy => c.waterGlasses >= 6,
  };

  static double _value(InsightKind k, CheckIn c) => switch (k) {
    InsightKind.sleepBreaksEnergy => c.energy.toDouble(),
    InsightKind.movementMood => c.mood.toDouble(),
    InsightKind.phoneAwaySleep => c.sleepHours,
    InsightKind.waterEnergy => c.energy.toDouble(),
  };

  static Insight? compute(InsightKind k, List<CheckIn> checkins) {
    final a = <CheckIn>[], b = <CheckIn>[];
    for (final c in checkins) {
      final g = _inB(k, c);
      if (g == true) b.add(c);
      if (g == false) a.add(c);
    }
    if (a.length < minDaysPerGroup || b.length < minDaysPerGroup) return null;
    double avg(List<CheckIn> l) => l.map((c) => _value(k, c)).reduce((x, y) => x + y) / l.length;
    return Insight(
      kind: k,
      avgA: avg(a),
      avgB: avg(b),
      daysA: a.length,
      daysB: b.length,
      excluded: checkins.length - a.length - b.length,
    );
  }

  /// Comparisons worth showing, biggest first. Empty until 7 check-ins.
  static List<Insight> insights(List<CheckIn> checkins) {
    if (checkins.length < minCheckins) return [];
    final list = [
      for (final k in InsightKind.values) compute(k, checkins),
    ].whereType<Insight>().where((i) => i.difference.abs() >= minDifference).toList();
    // Keep the design's order for the main three, then anything else.
    list.sort((x, y) => x.kind.index.compareTo(y.kind.index));
    return list;
  }

  /// Habits that show up on better days (for "Your best days look like…").
  static List<InsightKind> bestDayHabits(List<CheckIn> checkins) => [
    for (final i in insights(checkins))
      if (i.difference > 0) i.kind,
  ];

  /// The insight to preview on Today: largest relative effect.
  static Insight? top(List<CheckIn> checkins) {
    final list = insights(checkins).where((i) => i.difference > 0).toList();
    if (list.isEmpty) return null;
    list.sort((x, y) => (y.difference / y.scaleMax).compareTo(x.difference / x.scaleMax));
    return list.first;
  }

  /// True when the last week looks hard (low mood or high stress on most days).
  static bool hardStretch(List<CheckIn> lastWeek) {
    if (lastWeek.length < 3) return false;
    final hard = lastWeek.where((c) => c.mood <= 2 || c.stress >= 5).length;
    return hard >= (lastWeek.length / 2).ceil();
  }
}
