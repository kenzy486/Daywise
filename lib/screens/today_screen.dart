import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/checkin.dart';
import '../services/app_state.dart';
import '../services/insights_service.dart';
import '../services/locale_provider.dart';
import '../services/suggestions_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/charts.dart';
import '../widgets/dw.dart';
import 'app_shell.dart';
import 'insights_screen.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});
  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  int _range = 7;

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final wide = MediaQuery.sizeOf(context).width >= desktopBreakpoint;
    final days = app.chartDays(_range);
    final inRange = app.lastDays(_range);
    final nav = context.read<ShellNav>();

    final title = app.name(context).isEmpty ? t.todayTitleNoName : t.todayTitle(app.name(context));
    final toggle = RangeToggle(
      options: [t.days7, t.days30],
      selected: _range == 7 ? 0 : 1,
      onChanged: (i) => setState(() => _range = i == 0 ? 7 : 30),
    );

    if (wide) {
      return PageBody(
        maxWidth: 1140,
        gap: 24,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: PageIntro(
                  eyebrow: Fmt.longDayYear(context, app.today),
                  title: title,
                  body: t.todaySubtitleDesktop,
                  titleSize: 44,
                ),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 206,
                child: ActionButton(
                  app.todayCheckin == null ? t.checkinCtaDesktop : t.checkinEditCta,
                  arrow: true,
                  onPressed: () => nav.go(ShellPage.checkin),
                ),
              ),
            ],
          ),
          if (app.isDemo) const DemoDisclosure(),
          Row(
            children: [
              Expanded(
                child: Text(
                  t.weekAtGlance,
                  style: AppTheme.sans(context, size: 18, color: AppColors.ink, weight: FontWeight.w600),
                ),
              ),
              Text(
                t.checkinsSoFar(
                  Fmt.number(context, app.checkins.length),
                  Fmt.number(context, inRange.length),
                ),
                style: AppTheme.sans(context, size: 11),
              ),
              const SizedBox(width: 16),
              toggle,
            ],
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 310, child: _WellbeingCard(latest: app.latest, wide: true)),
                const SizedBox(width: 20),
                Expanded(child: _FeelingCard(days: days, wide: true)),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 47, child: _RestCard(days: days)),
              const SizedBox(width: 20),
              Expanded(flex: 65, child: _TinyActionCard(wide: true)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 47, child: _PatternCard(wide: true)),
              const SizedBox(width: 20),
              Expanded(flex: 65, child: _RecentReflections()),
            ],
          ),
          Row(
            children: [
              const Expanded(child: Disclaimer()),
              TextAction(t.findSupportLink, weight: FontWeight.w400, onTap: () => nav.go(ShellPage.support)),
            ],
          ),
        ],
      );
    }

    final logged = app.todayCheckin != null;
    return PageBody(
      children: [
        PageIntro(eyebrow: Fmt.longDay(context, app.today), title: title, body: t.todaySubtitle),
        if (app.isDemo) const DemoDisclosure(),
        Row(
          children: [
            Expanded(
              child: Text(
                t.yourOverview,
                style: AppTheme.sans(context, size: 14, color: AppColors.ink, weight: FontWeight.w600),
              ),
            ),
            toggle,
          ],
        ),
        _WellbeingCard(latest: app.latest, wide: false),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ActionButton(
              logged ? t.checkinEditCta : t.checkinCta,
              arrow: true,
              onPressed: () => nav.go(ShellPage.checkin),
            ),
            const SizedBox(height: 10),
            Text(
              logged ? t.checkinDoneNote : t.checkinOpenNote,
              textAlign: TextAlign.center,
              style: AppTheme.sans(context, size: 11),
            ),
          ],
        ),
        _FeelingCard(days: days, wide: false),
        _RestCard(days: days),
        _TinyActionCard(wide: false),
        _PatternCard(wide: false),
        const Disclaimer(),
      ],
    );
  }
}

// ───────────────────────── Well-being ─────────────────────────

class _WellbeingCard extends StatelessWidget {
  final CheckIn? latest;
  final bool wide;
  const _WellbeingCard({required this.latest, required this.wide});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final l = latest;
    final heading = Row(
      children: [
        Expanded(
          child: Text(
            t.wellbeingTitle,
            style: AppTheme.sans(
              context,
              size: wide ? 15 : 14,
              color: AppColors.ink,
              weight: FontWeight.w600,
            ),
          ),
        ),
        if (wide)
          Tooltip(
            message: t.wellbeingNoteDesktop,
            child: const Icon(LucideIcons.info, size: 18, color: AppColors.primary),
          )
        else if (l != null)
          Text(t.latestOn(Fmt.dayMonth(context, l.day)), style: AppTheme.sans(context, size: 10)),
      ],
    );

    if (l == null) {
      return DwCard(
        tone: CardTone.sage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading,
            const SizedBox(height: 14),
            Text(t.emptyTitle, style: AppTheme.serif(context, size: 23)),
            const SizedBox(height: 8),
            Text(t.emptyBody, style: AppTheme.sans(context, size: 12, height: 1.6)),
          ],
        ),
      );
    }

    String r(int v) => t.ratingOf5(Fmt.number(context, v));

    if (wide) {
      return DwCard(
        tone: CardTone.sage,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            heading,
            const SizedBox(height: 18),
            WellbeingRing(score: l.wellbeingScore, size: 158, stroke: 9),
            const SizedBox(height: 18),
            Text(t.latestOn(Fmt.weekdayDayMonth(context, l.day)), style: AppTheme.sans(context, size: 11)),
            const SizedBox(height: 10),
            Text(
              '${t.mood} ${Fmt.number(context, l.mood)} · ${t.energy} ${Fmt.number(context, l.energy)} · ${t.stress} ${Fmt.number(context, l.stress)}',
              style: AppTheme.sans(context, size: 11, color: AppColors.primary, weight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            Text(
              t.wellbeingNoteDesktop,
              textAlign: TextAlign.center,
              style: AppTheme.sans(context, size: 11, height: 1.6),
            ),
          ],
        ),
      );
    }

    return DwCard(
      tone: CardTone.sage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading,
          const SizedBox(height: 14),
          Row(
            children: [
              WellbeingRing(score: l.wellbeingScore),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final (label, v) in [
                      (t.mood, l.mood),
                      (t.energy, l.energy),
                      (t.stress, l.stress),
                    ]) ...[
                      Text('$label   ${r(v)}', style: AppTheme.sans(context, size: 12, color: AppColors.ink)),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(t.wellbeingNote, style: AppTheme.sans(context, size: 11, height: 1.6)),
        ],
      ),
    );
  }
}

// ───────────────────────── Feeling trends ─────────────────────────

class _FeelingCard extends StatelessWidget {
  final List<DateTime> days;
  final bool wide;
  const _FeelingCard({required this.days, required this.wide});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final entries = days.map(app.checkinOn).toList();
    final logged = entries.whereType<CheckIn>().toList();
    final latest = app.latest;
    final energies = logged.map((c) => c.energy);
    final energyVaried =
        logged.length >= 3 &&
        (energies.reduce((a, b) => a > b ? a : b) - energies.reduce((a, b) => a < b ? a : b)) >= 2;

    return DwCard(
      padding: EdgeInsets.all(wide ? 24 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  t.feelingTitle,
                  style: AppTheme.sans(
                    context,
                    size: wide ? 15 : 14,
                    color: AppColors.ink,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              if (wide && latest != null)
                Text(
                  t.latestTriple(
                    Fmt.number(context, latest.mood),
                    Fmt.number(context, latest.energy),
                    Fmt.number(context, latest.stress),
                  ),
                  style: AppTheme.sans(context, size: 11),
                ),
            ],
          ),
          const SizedBox(height: 18),
          if (logged.isEmpty)
            Text(t.noDataYet, style: AppTheme.sans(context, size: 12))
          else ...[
            TrendChart(
              days: days,
              height: wide ? 120 : 120,
              series: [
                TrendSeries(
                  t.mood,
                  AppColors.chartMood,
                  LineStyle.solid,
                  entries.map((c) => c?.mood.toDouble()).toList(),
                ),
                TrendSeries(
                  t.energy,
                  AppColors.chartEnergy,
                  LineStyle.dashed,
                  entries.map((c) => c?.energy.toDouble()).toList(),
                ),
                TrendSeries(
                  t.stress,
                  AppColors.chartStress,
                  LineStyle.dotted,
                  entries.map((c) => c?.stress.toDouble()).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              t.feelingCaption(Fmt.range(context, days.first, days.last)),
              style: AppTheme.sans(context, size: 11),
            ),
            if (wide && energyVaried) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.sageLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.leaf, size: 16, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Expanded(child: Text(t.energyVaried, style: AppTheme.sans(context, size: 11))),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

// ───────────────────────── Rest & movement ─────────────────────────

class _RestCard extends StatelessWidget {
  final List<DateTime> days;
  const _RestCard({required this.days});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final entries = days.map(app.checkinOn).toList();
    final sleep = entries.map((c) => c?.sleepHours).toList();
    final active = entries.map((c) => c?.exerciseMinutes.toDouble()).toList();
    double maxOf(List<double?> l, double floor, double step) {
      final m = l.whereType<double>().fold<double>(floor, (a, b) => b > a ? b : a);
      return (m / step).ceil() * step;
    }

    final sleepMax = maxOf(sleep, 8, 2);
    final activeMax = maxOf(active, 40, 10);

    return DwCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  t.restTitle,
                  style: AppTheme.sans(context, size: 14, color: AppColors.ink, weight: FontWeight.w600),
                ),
              ),
              Text(Fmt.range(context, days.first, days.last), style: AppTheme.sans(context, size: 10)),
            ],
          ),
          const SizedBox(height: 18),
          if (entries.every((c) => c == null))
            Text(t.noDataYet, style: AppTheme.sans(context, size: 12))
          else ...[
            BarSeries(
              title: t.sleepHoursSeries,
              scaleLabel: Fmt.digits(context, '0–${sleepMax.round()}'),
              values: sleep,
              max: sleepMax,
              color: AppColors.sleepBar,
            ),
            const SizedBox(height: 14),
            BarSeries(
              title: t.activitySeries,
              scaleLabel: Fmt.digits(context, '0–${activeMax.round()}'),
              values: active,
              max: activeMax,
              color: AppColors.activityBar,
            ),
            const SizedBox(height: 10),
            DateAxis(days: days),
          ],
        ],
      ),
    );
  }
}

// ───────────────────────── One small thing ─────────────────────────

class _TinyActionCard extends StatelessWidget {
  final bool wide;
  const _TinyActionCard({required this.wide});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final lang = context.watch<LocaleProvider>().locale.languageCode;
    final nav = context.read<ShellNav>();
    final s = app.nextSuggestion;
    final total = app.todaysSuggestions.length;
    final badge = ContextBadge(
      t.pendingProgress(Fmt.number(context, app.suggestionsDone), Fmt.number(context, total)),
    );

    return DwCard(
      tone: CardTone.sand,
      padding: EdgeInsets.all(wide ? 26 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (wide)
                Eyebrow(t.oneSmallThing)
              else
                Icon(s?.icon ?? LucideIcons.sprout, size: 22, color: AppColors.primary),
              const Spacer(),
              badge,
            ],
          ),
          SizedBox(height: wide ? 20 : 14),
          if (s == null) ...[
            Text(t.allDoneTitle, style: AppTheme.serif(context, size: wide ? 30 : 23)),
            const SizedBox(height: 14),
            Text(t.allDoneBody, style: AppTheme.sans(context, size: 12, height: 1.6)),
          ] else ...[
            Text(s.title(lang), style: AppTheme.serif(context, size: wide ? 28 : 23)),
            const SizedBox(height: 14),
            Text(s.rationale(lang), style: AppTheme.sans(context, size: 12, height: 1.6)),
            SizedBox(height: wide ? 20 : 14),
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    wide ? t.markDone : t.done,
                    height: 44,
                    onPressed: () => app.setSuggestionStatus(s.id, SuggestionStatus.done),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ActionButton(
                    wide ? t.skipToday : t.skip,
                    height: 44,
                    primary: false,
                    onPressed: () => app.setSuggestionStatus(s.id, SuggestionStatus.skipped),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 10),
          TextAction(wide ? t.seeTodaysSuggestions : t.allSuggestions, onTap: () => nav.go(ShellPage.forYou)),
        ],
      ),
    );
  }
}

// ───────────────────────── Pattern preview ─────────────────────────

class _PatternCard extends StatelessWidget {
  final bool wide;
  const _PatternCard({required this.wide});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final nav = context.read<ShellNav>();
    final count = app.checkins.length;

    if (count < InsightsService.minCheckins) {
      return DwCard(
        tone: CardTone.mint,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(LucideIcons.sparkles, size: 22, color: AppColors.primary),
            const SizedBox(height: 12),
            Text(t.almostThereTitle, style: AppTheme.serif(context, size: 23)),
            const SizedBox(height: 10),
            Text(
              t.almostThereBody(Fmt.number(context, count)),
              style: AppTheme.sans(context, size: 12, height: 1.6),
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: count / InsightsService.minCheckins,
                minHeight: 6,
                backgroundColor: AppColors.surface,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      );
    }

    final top = InsightsService.top(app.checkins);
    if (top == null) {
      return DwCard(
        tone: CardTone.mint,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Eyebrow(t.patternEyebrow(Fmt.number(context, count))),
            const SizedBox(height: 12),
            Text(t.insightsNoneTitle, style: AppTheme.serif(context, size: 23)),
            const SizedBox(height: 12),
            Text(t.insightsNoneBody, style: AppTheme.sans(context, size: 12, height: 1.6)),
          ],
        ),
      );
    }
    final copy = InsightCopy.of(top, context, demo: app.isDemo);

    return DwCard(
      tone: CardTone.mint,
      padding: EdgeInsets.all(wide ? 24 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (wide)
            Row(
              children: [
                const Icon(LucideIcons.sparkles, size: 22, color: AppColors.primary),
                const Spacer(),
                ContextBadge(copy.confidence),
              ],
            )
          else
            Eyebrow(t.patternEyebrow(Fmt.number(context, count))),
          const SizedBox(height: 12),
          Text(copy.title, style: AppTheme.serif(context, size: wide ? 26 : 23)),
          const SizedBox(height: 12),
          Text(
            wide ? copy.body : '${copy.body} ${t.patternsNotProof}',
            style: AppTheme.sans(context, size: wide ? 13 : 12, height: 1.6),
          ),
          if (wide) ...[
            const SizedBox(height: 14),
            Text(t.patternsNotProofLong, style: AppTheme.sans(context, size: 11)),
          ],
          const SizedBox(height: 8),
          TextAction(
            wide ? t.exploreInsightsLong : t.exploreInsights,
            onTap: () => nav.go(ShellPage.insights),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Recent reflections (desktop) ─────────────────────────

class _RecentReflections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final nav = context.read<ShellNav>();
    final recent = app.checkins.reversed.take(3).toList();
    final head = AppTheme.sans(context, size: 10);
    final cell = AppTheme.sans(context, size: 12, color: AppColors.ink);

    Widget row(List<Widget> cells, {bool border = true}) => Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: border ? const Border(top: BorderSide(color: AppColors.border)) : null,
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: cells[0]),
          Expanded(
            flex: 2,
            child: Align(alignment: AlignmentDirectional.center, child: cells[1]),
          ),
          Expanded(
            flex: 2,
            child: Align(alignment: AlignmentDirectional.center, child: cells[2]),
          ),
          Expanded(
            flex: 2,
            child: Align(alignment: AlignmentDirectional.centerEnd, child: cells[3]),
          ),
        ],
      ),
    );

    return DwCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  t.recentReflections,
                  style: AppTheme.sans(context, size: 15, color: AppColors.ink, weight: FontWeight.w600),
                ),
              ),
              TextAction(
                t.viewJournal,
                size: 11,
                weight: FontWeight.w400,
                onTap: () => nav.go(ShellPage.checkin),
              ),
            ],
          ),
          const SizedBox(height: 8),
          row([
            Text(t.colCheckin, style: head),
            Text(t.colSleep, style: head),
            Text(t.colActive, style: head),
            Text(t.colScore, style: head),
          ], border: false),
          if (recent.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(t.noDataYet, style: AppTheme.sans(context, size: 12)),
            ),
          for (final c in recent)
            row([
              Text(Fmt.weekdayDayMonth(context, c.day), style: cell),
              Text(t.hoursShort(Fmt.number(context, c.sleepHours)), style: cell),
              Text(t.minutesShort(Fmt.number(context, c.exerciseMinutes)), style: cell),
              Text(
                Fmt.number(context, c.wellbeingScore),
                style: AppTheme.sans(context, size: 12, color: AppColors.primary, weight: FontWeight.w600),
              ),
            ]),
        ],
      ),
    );
  }
}
