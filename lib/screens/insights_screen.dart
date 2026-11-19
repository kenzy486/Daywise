import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/app_state.dart';
import '../services/insights_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/charts.dart';
import '../widgets/dw.dart';
import 'app_shell.dart';

/// Localized words for one insight card.
class InsightCopy {
  final String title;
  final String body;
  final String axis;
  final String labelA;
  final String labelB;
  final String captionA;
  final String captionB;
  final String confidence;
  const InsightCopy({
    required this.title,
    required this.body,
    required this.axis,
    required this.labelA,
    required this.labelB,
    required this.captionA,
    required this.captionB,
    required this.confidence,
  });

  static InsightCopy of(Insight i, BuildContext context, {required bool demo}) {
    final t = AppLocalizations.of(context);
    String n(num v) => Fmt.number(context, v);
    // Round the difference to the nearest half point, as the design does ("about 1.5").
    final diff = n((i.difference.abs() * 2).round() / 2);
    final nights = i.kind == InsightKind.phoneAwaySleep;
    String count(int c) => nights
        ? (demo ? t.demoNightsCount(n(c)) : t.nightsCount(n(c)))
        : (demo ? t.demoDaysCount(n(c)) : t.daysCount(n(c)));

    final (title, body, axis, a, b) = switch (i.kind) {
      InsightKind.sleepBreaksEnergy => (
        t.insSleepTitle,
        t.insSleepBody(diff),
        t.insSleepAxis,
        t.insSleepA,
        t.insSleepB,
      ),
      InsightKind.movementMood => (
        t.insMoveTitle,
        t.insMoveBody(diff),
        t.insMoveAxis,
        t.insMoveA,
        t.insMoveB,
      ),
      InsightKind.phoneAwaySleep => (
        t.insPhoneTitle,
        t.insPhoneBody(diff),
        t.insPhoneAxis,
        t.insPhoneA,
        t.insPhoneB,
      ),
      InsightKind.waterEnergy => (
        t.insWaterTitle,
        t.insWaterBody(diff),
        t.insWaterAxis,
        t.insWaterA,
        t.insWaterB,
      ),
    };
    final captionB = i.excluded > 0 && i.kind == InsightKind.sleepBreaksEnergy
        ? '${count(i.daysB)} · ${t.otherDaysExcluded(n(i.excluded))}'
        : count(i.daysB);
    return InsightCopy(
      title: title,
      // If the data points the other way, say so plainly instead of the usual sentence.
      body: i.difference >= 0 ? body : t.insReversed(n(i.avgB), n(i.avgA)),
      axis: axis,
      labelA: a,
      labelB: b,
      captionA: count(i.daysA),
      captionB: captionB,
      confidence: switch (i.confidence) {
        Confidence.emerging => t.confidenceEmerging,
        Confidence.moderate => t.confidenceModerate,
        Confidence.higher => t.confidenceHigher,
      },
    );
  }
}

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final nav = context.read<ShellNav>();
    final all = app.checkins;
    final insights = InsightsService.insights(all);
    final best = InsightsService.bestDayHabits(all);
    final enough = all.length >= InsightsService.minCheckins;

    return PageBody(
      children: [
        PageIntro(
          eyebrow: t.insightsEyebrow,
          title: t.insightsTitle,
          body: all.isEmpty
              ? t.insightsBodyEmpty
              : t.insightsBody(
                  Fmt.number(context, all.length),
                  Fmt.longRange(context, all.first.day, all.last.day),
                ),
        ),
        if (app.isDemo) const DemoDisclosure(),
        if (!enough)
          DwCard(
            tone: CardTone.mint,
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(LucideIcons.sparkles, size: 26, color: AppColors.primary),
                const SizedBox(height: 15),
                Text(t.insightsEmptyTitle, style: AppTheme.serif(context, size: 26, height: 1.2)),
                const SizedBox(height: 15),
                Text(
                  t.almostThereBody(Fmt.number(context, all.length)),
                  style: AppTheme.sans(context, size: 13, color: AppColors.ink, height: 1.7),
                ),
              ],
            ),
          )
        else ...[
          if (best.isNotEmpty) _BestDaysCard(habits: best),
          if (insights.isEmpty)
            DwCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.insightsNoneTitle, style: AppTheme.serif(context, size: 23)),
                  const SizedBox(height: 12),
                  Text(t.insightsNoneBody, style: AppTheme.sans(context, size: 12, height: 1.65)),
                ],
              ),
            ),
          for (final i in insights) _InsightCard(insight: i, demo: app.isDemo),
        ],
        DwCard(
          tone: CardTone.sand,
          radius: 16,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.confidenceExplainTitle,
                style: AppTheme.sans(context, size: 13, color: AppColors.ink, weight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Text(t.confidenceExplainBody, style: AppTheme.sans(context, size: 12, height: 1.7)),
            ],
          ),
        ),
        ActionButton(t.trySuggestion, arrow: true, onPressed: () => nav.go(ShellPage.forYou)),
        const Disclaimer(),
      ],
    );
  }
}

class _BestDaysCard extends StatelessWidget {
  final List<InsightKind> habits;
  const _BestDaysCard({required this.habits});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final parts = <String>[
      if (habits.contains(InsightKind.sleepBreaksEnergy)) t.bestDaysSleep,
      if (habits.contains(InsightKind.movementMood)) t.bestDaysMovement,
      if (habits.contains(InsightKind.sleepBreaksEnergy)) t.bestDaysBreaks,
      if (habits.contains(InsightKind.phoneAwaySleep)) t.bestDaysPhone,
      if (habits.contains(InsightKind.waterEnergy)) t.bestDaysWater,
    ];
    return DwCard(
      tone: CardTone.mint,
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(LucideIcons.sun, size: 26, color: AppColors.primary),
          const SizedBox(height: 15),
          Text(t.bestDaysTitle, style: AppTheme.serif(context, size: 26, height: 1.2)),
          const SizedBox(height: 15),
          Text(parts.join(' '), style: AppTheme.sans(context, size: 13, color: AppColors.ink, height: 1.7)),
          const SizedBox(height: 15),
          Text(t.bestDaysNote, style: AppTheme.sans(context, size: 11, height: 1.6)),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final Insight insight;
  final bool demo;
  const _InsightCard({required this.insight, required this.demo});

  @override
  Widget build(BuildContext context) {
    final c = InsightCopy.of(insight, context, demo: demo);
    final betterIsB = insight.difference >= 0;
    return DwCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContextBadge(c.confidence, background: AppColors.sage),
          const SizedBox(height: 16),
          Text(c.title, style: AppTheme.serif(context, size: 23)),
          const SizedBox(height: 16),
          Text(c.body, style: AppTheme.sans(context, size: 12, height: 1.65)),
          const SizedBox(height: 16),
          Text(c.axis, style: AppTheme.sans(context, size: 10, weight: FontWeight.w600)),
          const SizedBox(height: 15),
          ComparisonGroup(
            label: c.labelA,
            value: insight.avgA,
            max: insight.scaleMax,
            caption: c.captionA,
            highlight: !betterIsB,
          ),
          const SizedBox(height: 15),
          ComparisonGroup(
            label: c.labelB,
            value: insight.avgB,
            max: insight.scaleMax,
            caption: c.captionB,
            highlight: betterIsB,
          ),
        ],
      ),
    );
  }
}
