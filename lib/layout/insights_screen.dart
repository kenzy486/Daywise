import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../models/checkin.dart';
import '../../services/checkin_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/confidence_chip.dart';
import '../../widgets/demo_banner.dart';
import '../../widgets/disclaimer.dart';
import '../../widgets/eyebrow.dart';
import '../../widgets/mint_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/sage_card.dart';
import '../../widgets/sand_card.dart';
import '../../widgets/section_card.dart';
import '../../widgets/text_link.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  List<CheckIn> _checkins = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final service = CheckinService();
    service.watchLastDays(30).listen((checkins) {
      if (mounted) {
        setState(() {
          _checkins = checkins;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Eyebrow
            Eyebrow(label: t.insightsTitle),
            const SizedBox(height: 8),

            // Title
            Text(
              t.insightsHeading,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),

            // Subtitle
            if (_checkins.isNotEmpty) ...[
              Text(
                t.insightsSubtitle
                    .replaceAll('{count}', _checkins.length.toString())
                    .replaceAll('{startDate}', DateFormat('d MMM', 'en_US').format(_checkins.first.day))
                    .replaceAll('{endDate}', DateFormat('d MMM', 'en_US').format(_checkins.last.day)),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
            const SizedBox(height: 24),

            // Demo banner
            // const DemoBanner(),
            const SizedBox(height: 16),

            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_checkins.length < 7)
              _buildProgressCard(t)
            else
              _buildInsights(t),
            const SizedBox(height: 16),
            const Disclaimer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(AppLocalizations t) {
    return SageCard(
      child: Column(
        children: [
          Text(
            t.almostThere,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            t.insightsProgress.replaceAll('{count}', _checkins.length.toString()),
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

  Widget _buildInsights(AppLocalizations t) {
    return Column(
      children: [
        // Best days card
        MintCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.wb_sunny_outlined, color: AppColors.primary, size: 32),
              const SizedBox(height: 16),
              Text(
                t.bestDaysTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                t.bestDaysText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                t.bestDaysDemo,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Comparison cards
        _buildComparisonCard(
          t: t,
          title: t.comparisonTitle1,
          body: t.comparisonBody1,
          metricLabel: t.avgEnergy,
          bar1Label: '<6h sleep + no breaks',
          bar1Value: '2',
          bar2Label: '7+ hours + at least one break',
          bar2Value: '4',
          confidence: t.confidenceModerate,
        ),
        const SizedBox(height: 16),

        _buildComparisonCard(
          t: t,
          title: t.comparisonTitle2,
          body: t.comparisonBody2,
          metricLabel: t.avgMood,
          bar1Label: 'Under 30 active minutes',
          bar1Value: '2.5',
          bar2Label: '30+ active minutes',
          bar2Value: '4',
          confidence: t.confidenceModerate,
        ),
        const SizedBox(height: 16),

        _buildComparisonCard(
          t: t,
          title: t.comparisonTitle3,
          body: t.comparisonBody3,
          metricLabel: t.avgSleep,
          bar1Label: 'Phone used near bedtime',
          bar1Value: '6.5',
          bar2Label: 'Phone away 30 min before bed',
          bar2Value: '7.5',
          confidence: t.confidenceEmerging,
        ),
        const SizedBox(height: 16),

        // Note box
        SandCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.patternsNotProof,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                t.patternsNotProofBody,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // CTA
        PrimaryButton(
          label: t.trySuggestion,
          onPressed: () {},
          showArrow: true,
        ),
      ],
    );
  }

  Widget _buildComparisonCard({
    required AppLocalizations t,
    required String title,
    required String body,
    required String metricLabel,
    required String bar1Label,
    required String bar1Value,
    required String bar2Label,
    required String bar2Value,
    required String confidence,
  }) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConfidenceChip(label: confidence),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Eyebrow(label: metricLabel),
          const SizedBox(height: 12),
          _buildBar(bar1Label, bar1Value, AppColors.chartStress, false),
          const SizedBox(height: 8),
          _buildBar(bar2Label, bar2Value, AppColors.primary, true),
          const SizedBox(height: 8),
          Text(
            t.daysCount.replaceAll('{count}', '14'),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String label, String value, Color color, bool isPrimary) {
    final double barWidth = double.tryParse(value) ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: isPrimary ? AppColors.primary : AppColors.ink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.sage,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            widthFactor: barWidth / 5,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
