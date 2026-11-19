import 'dart:math';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/checkin.dart';
import '../services/checkin_service.dart';

class DemoData {
  // Builds [days] fake check-ins, ending today.
  // Designed to match the spec: 14 check-ins visible, latest 4/4/2 = 75
  static List<CheckIn> generate({int days = 30}) {
    final random = Random(42); // fixed seed = same data every time
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final list = <CheckIn>[];
    for (var daysAgo = days - 1; daysAgo >= 0; daysAgo--) {
      final day = DateTime(today.year, today.month, today.day - daysAgo);

      // Last 7 days data (to match spec)
      if (daysAgo < 7) {
        final sleepValues = [6.0, 7.0, 6.5, 8.0, 5.5, 7.0, 7.5];
        final activityValues = [15, 30, 20, 40, 10, 30, 35];
        final moodValues = [3, 4, 3, 4, 3, 4, 4];
        final energyValues = [2, 3, 3, 4, 2, 4, 4];
        final stressValues = [5, 3, 4, 3, 4, 2, 2];

        list.add(CheckIn(
          date: CheckIn.dateId(day),
          sleepHours: sleepValues[daysAgo],
          sleepQuality: 3 + random.nextInt(2),
          waterGlasses: 4 + random.nextInt(3),
          exerciseMinutes: activityValues[daysAgo],
          mood: moodValues[daysAgo],
          energy: energyValues[daysAgo],
          stress: stressValues[daysAgo],
          meals: 3,
          breaks: daysAgo % 2 == 0 ? 1 : 0,
          screenTimeHours: 4 + random.nextDouble() * 2,
          caffeineServings: random.nextInt(3),
          phoneAwayBeforeBed: random.nextBool,
          note: null,
          createdAt: day,
          updatedAt: day,
        ));
      } else {
        // Older days with varied data
        final sleep = 6 + random.nextDouble() * 2;
        list.add(CheckIn(
          date: CheckIn.dateId(day),
          sleepHours: (sleep * 2).round() / 2,
          sleepQuality: 2 + random.nextInt(3),
          waterGlasses: 3 + random.nextInt(5),
          exerciseMinutes: random.nextBool ? 30 + random.nextInt(6) * 5 : random.nextInt(4) * 5,
          mood: 2 + random.nextInt(3),
          energy: 2 + random.nextInt(3),
          stress: 2 + random.nextInt(3),
          meals: 2 + random.nextInt(4),
          breaks: random.nextInt(5),
          screenTimeHours: 3 + random.nextDouble() * 4,
          caffeineServings: random.nextInt(4),
          phoneAwayBeforeBed: random.nextBool,
          note: null,
          createdAt: day,
          updatedAt: day,
        ));
      }
    }
    return list;
  }

  // Last 7 days with low mood (1–2) and high stress, to show the support message
  static List<CheckIn> lowMoodWeek() {
    final random = Random(7);
    final now = DateTime.now();
    return [
      for (var daysAgo = 6; daysAgo >= 0; daysAgo--)
        CheckIn(
          date: CheckIn.dateId(DateTime(now.year, now.month, now.day - daysAgo)),
          sleepHours: 5 + random.nextInt(3) * 0.5,
          sleepQuality: 2,
          waterGlasses: 3 + random.nextInt(3),
          exerciseMinutes: random.nextInt(3) * 5,
          mood: 1 + random.nextInt(2),
          energy: 2 + random.nextInt(2),
          stress: 4 + random.nextInt(2),
          meals: 2,
          breaks: 0,
          screenTimeHours: 5 + random.nextDouble() * 2,
          caffeineServings: random.nextInt(3),
          phoneAwayBeforeBed: false,
          note: null,
          createdAt: DateTime.now().subtract(Duration(days: daysAgo)),
          updatedAt: DateTime.now().subtract(Duration(days: daysAgo)),
        ),
    ];
  }
}

// The hidden pop-up (opened by long-pressing "About" in Settings)
Future<void> showDemoTools(BuildContext context) async {
  final t = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final service = CheckinService();

  final choice = await showDialog<String>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(t.demoTools),
      content: Text(t.demoToolsInfo),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(t.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, 'clear'),
          style: TextButton.styleFrom(foregroundColor: Colors.red.shade700),
          child: Text(t.demoClear),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, 'lowmood'),
          child: Text(t.demoLowMood),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, 'fill'),
          child: Text(t.demoFill),
        ),
      ],
    ),
  );
  if (choice == null) return; // cancelled

  try {
    switch (choice) {
      case 'fill':
        final days = DemoData.generate();
        await service.saveMany(days);
        messenger.showSnackBar(SnackBar(content: Text(t.demoFilled(days.length))));
      case 'lowmood':
        await service.saveMany(DemoData.lowMoodWeek());
        messenger.showSnackBar(SnackBar(content: Text(t.demoLowMoodDone)));
      case 'clear':
        final count = await service.deleteAll();
        messenger.showSnackBar(SnackBar(content: Text(t.demoCleared(count))));
    }
  } catch (_) {
    messenger.showSnackBar(SnackBar(
      content: Text(t.errSaveFailed),
      backgroundColor: Colors.red.shade700,
    ));
  }
}