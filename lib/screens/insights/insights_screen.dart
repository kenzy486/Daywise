import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/checkin.dart';
import '../../services/checkin_service.dart';
import '../../services/insights_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/message_box.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  // Last 90 days, updates live when you save a check-in
  late final Stream<List<CheckIn>> _stream = CheckinService().watchLastDays(90);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.myInsights)),
      body: StreamBuilder<List<CheckIn>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: MessageBox(message: t.errLoadFailed),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return _InsightsContent(checkins: snapshot.data!);
        },
      ),
    );
  }
}

class _InsightsContent extends StatelessWidget {
  final List<CheckIn> checkins;
  const _InsightsContent({required this.checkins});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    // Not enough data yet
    if (checkins.length < InsightsService.minCheckins) {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [_NotEnoughData(have: checkins.length)],
      );
    }

    final top = InsightsService.topInsights(checkins);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(t.insightsTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        Text(t.basedOnCheckins(checkins.length),
            style: const TextStyle(fontSize: 13, color: AppTheme.muted)),
        if (top.isEmpty) ...[
          const SizedBox(height: 12),
          _InfoCard(emoji: '🔍', text: t.noPatternsYet),
        ],
        for (var i = 0; i < top.length; i++) _InsightCard(insight: top[i], rank: i),
        const SizedBox(height: 12),
        _InfoCard(emoji: 'ℹ️', text: t.insightsNote),
        const SizedBox(height: 24),
      ],
    );
  }
}

// Builds the sentence in the selected language
String _sentence(Insight insight, AppLocalizations t) {
  final habit = switch (insight.habit) {
    Habit.sleep => t.habitSleep,
    Habit.water => t.habitWater,
    Habit.exercise => t.habitExercise,
  };
  final metric = insight.metric == Metric.energy ? t.metricEnergy : t.metricMood;
  final direction = insight.difference >= 0 ? t.higher : t.lower;
  final points = insight.difference.abs().toStringAsFixed(1); // e.g. "1.8"
  return t.insightSentence(habit, metric, points, direction);
}

// Labels for the two groups, e.g. ("7+ hours", "Under 7 h")
(String, String) _groupLabels(Habit habit, AppLocalizations t) => switch (habit) {
      Habit.sleep => (t.groupSleepYes, t.groupSleepNo),
      Habit.water => (t.groupWaterYes, t.groupWaterNo),
      Habit.exercise => (t.groupExerciseYes, t.groupExerciseNo),
    };

class _InsightCard extends StatelessWidget {
  static const _medals = ['🥇', '🥈', '🥉'];
  final Insight insight;
  final int rank; // 0, 1 or 2
  const _InsightCard({required this.insight, required this.rank});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final (labelWith, labelWithout) = _groupLabels(insight.habit, t);
    final metricName = insight.metric == Metric.energy ? t.energy : t.mood;

    return Card(
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medal + sentence
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_medals[rank], style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _sentence(insight, t),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700, height: 1.35),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Small comparison chart
            Text('$metricName (1–5)',
                style: const TextStyle(
                    fontSize: 13, color: AppTheme.muted, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _CompareBar(
                label: labelWith,
                days: insight.daysWith,
                value: insight.avgWith,
                color: AppTheme.primary),
            const SizedBox(height: 8),
            _CompareBar(
                label: labelWithout,
                days: insight.daysWithout,
                value: insight.avgWithout,
                color: AppTheme.accent),
          ],
        ),
      ),
    );
  }
}

// One horizontal bar: label + days | colored bar | value
class _CompareBar extends StatelessWidget {
  final String label;
  final int days;
  final double value; // 1–5
  final Color color;
  const _CompareBar(
      {required this.label, required this.days, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Row(
      children: [
        SizedBox(
          width: 96,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              Text(t.daysCount(days),
                  style: const TextStyle(fontSize: 11, color: AppTheme.muted)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect( // rounds the corners of the bar
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                // light background = the full 5-point scale
                Container(height: 24, color: color.withValues(alpha: 0.15)),
                // colored part = the average (e.g. 3.9 / 5 of the width)
                FractionallySizedBox(
                  widthFactor: value / 5,
                  alignment: AlignmentDirectional.centerStart, // grows from the start side
                  child: Container(height: 24, color: color),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(value.toStringAsFixed(1),
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}

// Shown when there are fewer than 7 check-ins
class _NotEnoughData extends StatelessWidget {
  final int have;
  const _NotEnoughData({required this.have});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final remaining = InsightsService.minCheckins - have;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const Text('🌱', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(t.logMoreDays(remaining),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: have / InsightsService.minCheckins, // e.g. 3/7
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: AppTheme.primaryLight,
              color: AppTheme.primary,
            ),
            const SizedBox(height: 8),
            Text(t.insightsProgress(have),
                style: const TextStyle(fontSize: 13, color: AppTheme.muted)),
          ],
        ),
      ),
    );
  }
}

// Small card with an emoji and a message
class _InfoCard extends StatelessWidget {
  final String emoji;
  final String text;
  const _InfoCard({required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
                child: Text(text, style: const TextStyle(fontSize: 13, color: AppTheme.muted))),
          ],
        ),
      ),
    );
  }
}