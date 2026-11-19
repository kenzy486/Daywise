import '../models/checkin.dart';

// The habits and the feelings we compare
enum Habit { sleep, water, exercise, breaks, phoneAway }
enum Metric { energy, mood, stress }

// One comparison, e.g. "sleep 7+ vs under 7, looking at energy"
class Insight {
  final Habit habit;
  final Metric metric;
  final double avgWith;    // average on days the habit WAS met
  final double avgWithout; // average on days it was NOT met
  final int daysWith;
  final int daysWithout;

  const Insight({
    required this.habit,
    required this.metric,
    required this.avgWith,
    required this.avgWithout,
    required this.daysWith,
    required this.daysWithout,
  });

  // Positive = feeling is higher with the habit; negative = lower
  double get difference => avgWith - avgWithout;
}

class InsightsService {
  static const minCheckins = 7;     // needed before showing insights
  static const minDaysPerGroup = 2; // each group needs at least this many days
  static const minDifference = 0.2; // smaller differences are ignored

  // Did this day meet the habit?
  static bool meetsHabit(CheckIn c, Habit habit) => switch (habit) {
        Habit.sleep => c.sleepHours >= 7,
        Habit.water => c.waterGlasses >= 6,
        Habit.exercise => c.exerciseMinutes >= 30,
        Habit.breaks => c.breaks >= 1,
        Habit.phoneAway => c.phoneAwayBeforeBed == true,
      };

  // Read energy, mood, or stress from a check-in
  static double valueOf(CheckIn c, Metric metric) => switch (metric) {
        Metric.energy => c.energy.toDouble(),
        Metric.mood => c.mood.toDouble(),
        Metric.stress => c.stress.toDouble(),
      };

  // All valid comparisons, biggest difference first
  static List<Insight> allInsights(List<CheckIn> checkins) {
    final results = <Insight>[];

    for (final habit in Habit.values) {
      // Skip phoneAway if no data
      if (habit == Habit.phoneAway && !checkins.any((c) => c.phoneAwayBeforeBed != null)) {
        continue;
      }

      // Split the days into two groups
      final withHabit = checkins.where((c) => meetsHabit(c, habit)).toList();
      final withoutHabit = checkins.where((c) => !meetsHabit(c, habit)).toList();

      // Not enough days in one of the groups -> skip this habit (not fair)
      if (withHabit.length < minDaysPerGroup || withoutHabit.length < minDaysPerGroup) {
        continue;
      }

      for (final metric in Metric.values) {
        results.add(Insight(
          habit: habit,
          metric: metric,
          avgWith: _average(withHabit, metric),
          avgWithout: _average(withoutHabit, metric),
          daysWith: withHabit.length,
          daysWithout: withoutHabit.length,
        ));
      }
    }

    // Biggest difference first (ignore + or -, so we use .abs())
    results.sort((a, b) => b.difference.abs().compareTo(a.difference.abs()));
    return results;
  }

  // The top [count] insights that are big enough to mention
  static List<Insight> topInsights(List<CheckIn> checkins, {int count = 3}) =>
      allInsights(checkins)
          .where((i) => i.difference.abs() >= minDifference)
          .take(count)
          .toList();

  static double _average(List<CheckIn> list, Metric metric) =>
      list.map((c) => valueOf(c, metric)).reduce((a, b) => a + b) / list.length;
}