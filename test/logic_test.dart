import 'package:daywise/models/checkin.dart';
import 'package:daywise/services/app_state.dart';
import 'package:daywise/services/demo_data.dart';
import 'package:daywise/services/insights_service.dart';
import 'package:daywise/services/suggestions_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Demo data (matches the Figma demo)', () {
    final now = DateTime(2026, 10, 22, 16, 20);
    final demo = DemoData.nour(now: now);

    test('14 check-ins from 8 to 21 October, today still open', () {
      expect(demo.length, 14);
      expect(demo.first.date, '2026-10-08');
      expect(demo.last.date, '2026-10-21');
    });

    test('latest check-in is mood 4 / energy 4 / stress 2 = 75', () {
      final l = demo.last;
      expect([l.mood, l.energy, l.stress], [4, 4, 2]);
      expect(l.wellbeingScore, 75);
    });

    test('last week sleep and activity match the charts', () {
      final week = demo.sublist(7);
      expect(week.map((c) => c.sleepHours), [6, 7, 6.5, 8, 5.5, 7, 7.5]);
      expect(week.map((c) => c.exerciseMinutes), [15, 30, 20, 40, 10, 30, 35]);
    });

    test('recent reflections scores (21, 20, 19 Oct) are 75, 75, 33', () {
      final r = demo.reversed.take(3).map((c) => c.wellbeingScore).toList();
      expect(r, [75, 75, 33]);
    });
  });

  group('Insights', () {
    final demo = DemoData.nour(now: DateTime(2026, 10, 22));

    test('sleep + breaks vs energy: 4 days at 2, 6 days at 4, 4 excluded', () {
      final i = InsightsService.compute(InsightKind.sleepBreaksEnergy, demo)!;
      expect(i.daysA, 4);
      expect(i.avgA, 2);
      expect(i.daysB, 6);
      expect(i.avgB, 4);
      expect(i.excluded, 4);
      expect(i.confidence, Confidence.moderate);
    });

    test('movement vs mood: 6 days at 2.5, 8 days at 4', () {
      final i = InsightsService.compute(InsightKind.movementMood, demo)!;
      expect(i.daysA, 6);
      expect(i.avgA, 2.5);
      expect(i.daysB, 8);
      expect(i.avgB, 4);
    });

    test('phone away vs sleep: 4 nights at 7.5', () {
      final i = InsightsService.compute(InsightKind.phoneAwaySleep, demo)!;
      expect(i.daysB, 4);
      expect(i.avgB, 7.5);
      expect(i.confidence, Confidence.moderate);
    });

    test('no insights before 7 check-ins', () {
      expect(InsightsService.insights(demo.take(6).toList()), isEmpty);
    });

    test('hard stretch only when most recent days are low', () {
      expect(InsightsService.hardStretch(demo.sublist(7)), isFalse);
      final low = [
        for (var i = 0; i < 5; i++)
          CheckIn(
            date: '2026-10-1$i',
            sleepHours: 5,
            waterGlasses: 3,
            exerciseMinutes: 0,
            mood: 1,
            energy: 2,
            stress: 5,
          ),
      ];
      expect(InsightsService.hardStretch(low), isTrue);
    });
  });

  group('Suggestions', () {
    test('three per day, stable for the same date, within chosen goals', () {
      final d = DateTime(2026, 10, 22);
      final a = SuggestionsService.forDate(d, [Goal.sleep, Goal.stress]);
      final b = SuggestionsService.forDate(d, [Goal.sleep, Goal.stress]);
      expect(a.length, 3);
      expect(a.map((s) => s.id), b.map((s) => s.id));
      expect(a.every((s) => s.area == Goal.sleep || s.area == Goal.stress), isTrue);
      expect(a.map((s) => s.id).toSet().length, 3);
    });

    test('every suggestion has English and Arabic copy', () {
      for (final s in SuggestionsService.all) {
        expect(s.titleEn, isNotEmpty);
        expect(s.titleAr, isNotEmpty);
        expect(s.rationaleEn, isNotEmpty);
        expect(s.rationaleAr, isNotEmpty);
      }
    });
  });

  group('AppState demo mode', () {
    test('starts with 1 of 3 suggestions done and updates in memory', () async {
      final app = AppState()..startDemo();
      expect(app.isDemo, isTrue);
      expect(app.suggestionsDone, 1);
      expect(app.nextSuggestion!.id, 'sleep_phone');

      await app.setSuggestionStatus('sleep_phone', SuggestionStatus.done);
      expect(app.suggestionsDone, 2);
      expect(app.nextSuggestion!.id, 'stress_study_break');

      await app.setSuggestionFeedback('sleep_phone', true);
      expect(app.stateOf('sleep_phone').helpful, isTrue);
      await app.setSuggestionFeedback('sleep_phone', true); // tap again clears
      expect(app.stateOf('sleep_phone').helpful, isNull);
    });

    test('saving a check-in replaces today and keeps one entry per day', () async {
      final app = AppState()..startDemo();
      final before = app.checkins.length;
      await app.saveCheckin(CheckIn.empty(app.today).copyWith(mood: 5));
      await app.saveCheckin(CheckIn.empty(app.today).copyWith(mood: 2));
      expect(app.checkins.length, before + 1);
      expect(app.todayCheckin!.mood, 2);
    });
  });

  test('withPhoneAway can set and clear the optional answer', () {
    final c = CheckIn.empty(DateTime(2026, 10, 22));
    expect(c.withPhoneAway(true).phoneAwayBeforeBed, isTrue);
    expect(c.withPhoneAway(true).withPhoneAway(null).phoneAwayBeforeBed, isNull);
  });
}
