import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/checkin.dart';
import '../services/checkin_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/confidence_chip.dart';
import '../widgets/demo_banner.dart';
import '../widgets/disclaimer.dart';
import '../widgets/eyebrow.dart';
import '../widgets/language_pill.dart';
import '../widgets/logo.dart';
import '../widgets/mint_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/sage_card.dart';
import '../widgets/sand_card.dart';
import '../widgets/section_card.dart';
import '../widgets/segmented_toggle.dart';
import '../widgets/status_chip.dart';
import '../widgets/text_link.dart';
import '../widgets/wellbeing_ring.dart';
import 'checkin/checkin_screen.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  bool _show7Days = true;
  List<CheckIn> _checkins = [];
  bool _isLoading = true;
  CheckIn? _todayCheckin;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final service = CheckinService();
    final days = _show7Days ? 7 : 30;
    service.watchLastDays(days).listen((checkins) {
      if (mounted) {
        setState(() {
          _checkins = checkins;
          _isLoading = false;
          _todayCheckin = checkins.lastWhere(
            (c) => c.date == CheckIn.dateId(DateTime.now()),
            orElse: () => CheckIn.empty(DateTime.now()),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final now = DateTime.now();
    final weekday = DateFormat('EEEE', 'en_US').format(now).toUpperCase();
    final date = DateFormat('d MMMM', 'en_US').format(now).toUpperCase();
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              children: [
                const Logo(size: 40),
                const Spacer(),
                const LanguagePill(),
              ],
            ),
            const SizedBox(height: 24),

            // Eyebrow with date
            Eyebrow(label: '$weekday, $date'),
            const SizedBox(height: 8),

            // Title
            Text(
              t.todayGreeting.replaceAll('{nickname}', 'Nour'),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              isDesktop ? t.todaySubtitleDesktop : t.todaySubtitleMobile,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),

            // Demo banner (if in demo mode)
            // const DemoBanner(),
            const SizedBox(height: 16),

            // Overview row
            Row(
              children: [
                Text(
                  isDesktop ? t.todayOverviewDesktop : t.todayOverview,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                SegmentedToggle(
                  option1: t.last7Days,
                  option2: t.last30Days,
                  isFirstSelected: _show7Days,
                  onChanged: (is7Days) {
                    setState(() {
                      _show7Days = is7Days;
                      _isLoading = true;
                    });
                    _loadData();
                  },
                ),
              ],
            ),
            if (isDesktop) ...[
              const SizedBox(height: 8),
              Text(
                t.checkinsCount.replaceAll('{count}', _checkins.length.toString()).replaceAll('{countInRange}', _checkins.length.toString()),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 24),

            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_checkins.isEmpty)
              _buildEmptyState(t)
            else
              _buildContent(t, isDesktop),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations t) {
    return SageCard(
      child: Column(
        children: [
          const Icon(Icons.eco_outlined, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            'Your space is ready.',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Whenever you like, take a 30-second check-in.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: t.checkinCTA,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CheckinScreen()),
              );
            },
            showArrow: true,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AppLocalizations t, bool isDesktop) {
    final latest = _checkins.isNotEmpty ? _checkins.last : null;
    final score = latest?.wellbeingScore ?? 0;

    if (isDesktop) {
      return Column(
        children: [
          // Row A: Well-being + Feeling chart
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 35,
                child: _buildWellbeingCard(t, score, latest),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 65,
                child: _buildFeelingChart(t),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Row B: Rest & movement + One small thing
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 45,
                child: _buildRestMovement(t),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 55,
                child: _buildOneSmallThing(t),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Row C: Pattern + Recent reflections
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 45,
                child: _buildPatternCard(t),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 55,
                child: _buildRecentReflections(t),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Disclaimer(),
        ],
      );
    } else {
      return Column(
        children: [
          _buildWellbeingCard(t, score, latest),
          const SizedBox(height: 16),

          // CTA button
          PrimaryButton(
            label: _todayCheckin != null && _todayCheckin!.date == CheckIn.dateId(DateTime.now())
                ? t.checkinEdit
                : t.checkinCTA,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CheckinScreen(existingCheckin: _todayCheckin)),
              );
            },
            showArrow: true,
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              _todayCheckin != null && _todayCheckin!.date == CheckIn.dateId(DateTime.now())
                  ? t.checkinSaved
                  : '${t.checkinDuration} · ${t.checkinOpen}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 24),

          _buildFeelingChart(t),
          const SizedBox(height: 16),
          _buildRestMovement(t),
          const SizedBox(height: 16),
          _buildOneSmallThing(t),
          const SizedBox(height: 16),
          _buildPatternCard(t),
          const SizedBox(height: 16),
          const Disclaimer(),
        ],
      );
    }
  }

  Widget _buildWellbeingCard(AppLocalizations t, int score, CheckIn? latest) {
    final date = latest != null
        ? DateFormat('d MMM', 'en_US').format(latest.day)
        : '';

    return SageCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                t.wellbeingTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (MediaQuery.of(context).size.width >= 900) ...[
                const Spacer(),
                const Icon(Icons.info_outline, size: 20, color: AppColors.muted),
              ],
            ],
          ),
          const SizedBox(height: 24),
          WellbeingRing(score: score, size: MediaQuery.of(context).size.width >= 900 ? 200 : 150),
          const SizedBox(height: 16),
          if (latest != null) ...[
            if (MediaQuery.of(context).size.width >= 900) ...[
              Text(
                'Latest · $date',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Text(
                '${t.moodLabel} ${latest.mood} · ${t.energyLabel} ${latest.energy} · ${t.stressLabel} ${latest.stress}',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(t.moodLabel, style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Text('${latest.mood} / 5', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    children: [
                      Text(t.energyLabel, style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Text('${latest.energy} / 5', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    children: [
                      Text(t.stressLabel, style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Text('${latest.stress} / 5', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ],
          ],
          const SizedBox(height: 16),
          Text(
            MediaQuery.of(context).size.width >= 900 ? t.wellbeingInfoDesktop : t.wellbeingInfo,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeelingChart(AppLocalizations t) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.feelingChartTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          // Legend
          Row(
            children: [
              _buildLegendDot(AppColors.chartMood, t.moodLabel),
              const SizedBox(width: 16),
              _buildLegendDot(AppColors.chartEnergy, t.energyLabel),
              const SizedBox(width: 16),
              _buildLegendDot(AppColors.chartStress, t.stressLabel),
            ],
          ),
          const SizedBox(height: 16),
          // Chart placeholder
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('Chart will be implemented with fl_chart'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.feelingChartCaption.replaceAll('{start}', '15').replaceAll('{end}', '21'),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildRestMovement(AppLocalizations t) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                t.restMovementTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Text(
                '15–21 Oct',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Sleep bars
          Text(
            '${t.sleepLabel} · ${t.sleepUnit}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(7, (index) {
              final heights = [6.0, 7.0, 6.5, 8.0, 5.5, 7.0, 7.5];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < 6 ? 8 : 0),
                  child: Column(
                    children: [
                      Text(
                        heights[index].toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: heights[index] * 8,
                        decoration: BoxDecoration(
                          color: AppColors.sleepBar,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),

          // Activity bars
          Text(
            '${t.activityLabel} · ${t.activityUnit}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(7, (index) {
              final heights = [15.0, 30.0, 20.0, 40.0, 10.0, 30.0, 35.0];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < 6 ? 8 : 0),
                  child: Column(
                    children: [
                      Text(
                        heights[index].toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: heights[index] * 1.5,
                        decoration: BoxDecoration(
                          color: AppColors.activityBar,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(7, (index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < 6 ? 8 : 0),
                  child: Text(
                    '${15 + index}',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOneSmallThing(AppLocalizations t) {
    return SandCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (MediaQuery.of(context).size.width < 900)
                const Icon(Icons.bedtime_outlined, color: AppColors.primary)
              else
                Eyebrow(label: t.oneSmallThing),
              const Spacer(),
              StatusChip(
                label: t.oneSmallThingPending.replaceAll('{done}', '1').replaceAll('{total}', '3'),
                type: StatusType.pending,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Put your phone away 30 minutes before bed',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            t.oneSmallThingRationale,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: MediaQuery.of(context).size.width < 900 ? t.done : t.markDone,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SecondaryButton(
                  label: MediaQuery.of(context).size.width < 900 ? t.skip : t.skipToday,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextLink(
            label: MediaQuery.of(context).size.width < 900 ? t.seeAllSuggestionsShort : t.seeAllSuggestions,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPatternCard(AppLocalizations t) {
    if (_checkins.length < 7) {
      return SageCard(
        child: Column(
          children: [
            Text(
              t.almostThere,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              t.almostThereText.replaceAll('{count}', _checkins.length.toString()),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: _checkins.length / 7,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ],
        ),
      );
    }

    return MintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_outlined, color: AppColors.primary),
              const SizedBox(width: 8),
              ConfidenceChip(label: t.confidenceModerate),
            ],
          ),
          const SizedBox(height: 16),
          if (MediaQuery.of(context).size.width < 900)
            Eyebrow(label: t.patternCardTitle.replaceAll('{count}', _checkins.length.toString())),
          const SizedBox(height: 8),
          Text(
            MediaQuery.of(context).size.width < 900 ? t.patternCardTitleExampleMobile : t.patternCardTitleExample,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Energy is about 2 points lower on days with <6h sleep and skipped breaks.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            t.patternCardBody,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          TextLink(
            label: t.exploreInsights,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReflections(AppLocalizations t) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                t.recentReflections,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              TextLink(
                label: t.viewJournal,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Table placeholder
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  border: const Border(bottom: BorderSide(color: AppColors.border)),
                ),
                children: [
                  _buildTableCell('Check-in', isHeader: true),
                  _buildTableCell('Sleep', isHeader: true),
                  _buildTableCell('Active', isHeader: true),
                  _buildTableCell('Score', isHeader: true, align: TextAlign.end),
                ],
              ),
              ...List.generate(3, (index) {
                final checkin = _checkins[_checkins.length - 1 - index];
                return TableRow(
                  decoration: BoxDecoration(
                    border: const Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  children: [
                    _buildTableCell(DateFormat('d MMM', 'en_US').format(checkin.day)),
                    _buildTableCell('${checkin.sleepHours} h'),
                    _buildTableCell('${checkin.exerciseMinutes} min'),
                    _buildTableCell(
                      checkin.wellbeingScore.toString(),
                      align: TextAlign.end,
                      isBold: true,
                      color: AppColors.primary,
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, TextAlign? align, bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.w600 : (isBold ? FontWeight.w600 : FontWeight.normal),
          color: color,
          fontSize: 14,
        ),
        textAlign: align,
      ),
    );
  }
}
