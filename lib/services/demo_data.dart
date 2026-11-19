import '../models/checkin.dart';

/// Nour's illustrative journal: 14 check-ins ending yesterday, so today's
/// check-in is still open. The last 7 days match the Figma charts
/// (sleep 6 → 7.5 h, activity 15 → 35 min, latest mood/energy/stress 4/4/2).
class DemoData {
  static List<CheckIn> nour({DateTime? now}) {
    final n = now ?? DateTime.now();
    final today = DateTime(n.year, n.month, n.day);

    // Oldest → newest. The last seven rows are the week shown in the design.
    const rows = <List<num>>[
      // sleep, quality, water, active, mood, energy, stress, meals, breaks, screen, caffeine, phoneAway(1/0)
      [5.5, 2, 4, 10, 2, 2, 4, 2, 0, 6.5, 3, 0],
      [7.5, 4, 6, 35, 4, 4, 2, 3, 2, 4.0, 1, 1],
      [5.5, 2, 4, 20, 2, 2, 4, 3, 0, 5.0, 2, 0],
      [5.5, 2, 4, 15, 2, 2, 4, 2, 0, 6.0, 3, 0],
      [8.0, 4, 7, 40, 4, 4, 2, 3, 2, 3.5, 1, 1],
      [6.5, 3, 5, 30, 4, 3, 3, 3, 1, 5.5, 2, 0],
      [7.0, 4, 6, 30, 4, 4, 2, 3, 2, 4.5, 1, 1],
      // The week in the design (15–21 Oct)
      [6.0, 3, 5, 15, 3, 2, 4, 3, 0, 5.5, 2, 0],
      [7.0, 4, 6, 30, 4, 3, 3, 3, 0, 4.5, 1, 0],
      [6.5, 3, 5, 20, 3, 3, 4, 3, 1, 5.0, 2, 0],
      [8.0, 4, 7, 40, 4, 4, 3, 3, 3, 4.0, 1, 0],
      [5.5, 2, 4, 10, 3, 2, 4, 2, 0, 6.5, 3, 0],
      [7.0, 4, 6, 30, 4, 4, 2, 3, 2, 4.5, 2, 0],
      [7.5, 4, 6, 35, 4, 4, 2, 3, 3, 4.5, 2, 1],
    ];

    final notes = <int, String>{
      13: 'A busy lecture day. The walk after class gave me a bit of breathing room.',
      11: 'Stayed up scrolling. Felt foggy all morning.',
      10: 'Long walk with friends by the Nile.',
    };

    return [
      for (var i = 0; i < rows.length; i++)
        () {
          final r = rows[i];
          final day = DateTime(today.year, today.month, today.day - (rows.length - i));
          return CheckIn(
            date: CheckIn.dateId(day),
            sleepHours: r[0].toDouble(),
            sleepQuality: r[1].toInt(),
            waterGlasses: r[2].toInt(),
            exerciseMinutes: r[3].toInt(),
            mood: r[4].toInt(),
            energy: r[5].toInt(),
            stress: r[6].toInt(),
            meals: r[7].toInt(),
            breaks: r[8].toInt(),
            screenTimeHours: r[9].toDouble(),
            caffeineServings: r[10].toInt(),
            phoneAwayBeforeBed: r[11] == 1,
            note: notes[i],
            createdAt: day,
            updatedAt: day,
          );
        }(),
    ];
  }
}
