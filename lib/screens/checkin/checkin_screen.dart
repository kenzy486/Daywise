import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../models/checkin.dart';
import '../../services/checkin_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/disclaimer.dart';
import '../../widgets/eyebrow.dart';
import '../../widgets/language_pill.dart';
import '../../widgets/logo.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rating_tiles.dart';
import '../../widgets/section_card.dart';
import '../../widgets/stepper_row.dart';

class CheckinScreen extends StatefulWidget {
  final DateTime? date;
  final CheckIn? existingCheckin;

  const CheckinScreen({
    super.key,
    this.date,
    this.existingCheckin,
  });

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  late double _sleepHours;
  late int _sleepQuality;
  late int _mood;
  late int _energy;
  late int _stress;
  late int _waterGlasses;
  late int _activityMinutes;
  late int _meals;
  late int _breaks;
  late double _screenTimeHours;
  late int _caffeineServings;
  bool? _phoneAwayBeforeBed;
  final _noteController = TextEditingController();
  bool _isLoading = false;
  bool _isDemo = false;

  @override
  void initState() {
    super.initState();
    final checkin = widget.existingCheckin ?? CheckIn.empty(widget.date ?? DateTime.now());
    _sleepHours = checkin.sleepHours;
    _sleepQuality = checkin.sleepQuality;
    _mood = checkin.mood;
    _energy = checkin.energy;
    _stress = checkin.stress;
    _waterGlasses = checkin.waterGlasses;
    _activityMinutes = checkin.exerciseMinutes;
    _meals = checkin.meals;
    _breaks = checkin.breaks;
    _screenTimeHours = checkin.screenTimeHours;
    _caffeineServings = checkin.caffeineServings;
    _phoneAwayBeforeBed = checkin.phoneAwayBeforeBed;
    _noteController.text = checkin.note ?? '';
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveCheckin() async {
    setState(() => _isLoading = true);

    try {
      final checkin = CheckIn(
        date: CheckIn.dateId(widget.date ?? DateTime.now()),
        sleepHours: _sleepHours,
        sleepQuality: _sleepQuality,
        waterGlasses: _waterGlasses,
        exerciseMinutes: _activityMinutes,
        mood: _mood,
        energy: _energy,
        stress: _stress,
        meals: _meals,
        breaks: _breaks,
        screenTimeHours: _screenTimeHours,
        caffeineServings: _caffeineServings,
        phoneAwayBeforeBed: _phoneAwayBeforeBed,
        note: _noteController.text.isEmpty ? null : _noteController.text,
        createdAt: widget.existingCheckin?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (_isDemo) {
        // Demo mode - don't save
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This is a demo, nothing is saved.')),
          );
          Navigator.pop(context);
        }
      } else {
        final service = CheckinService();
        await service.save(checkin);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Saved. Thanks for checking in.')),
          );
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save. Check your internet and try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final date = widget.date ?? DateTime.now();
    final weekday = DateFormat('EEEE', 'en_US').format(date);
    final formattedDate = DateFormat('d MMMM', 'en_US').format(date);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const Logo(size: 32),
            const Spacer(),
            const LanguagePill(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Eyebrow
            Eyebrow(label: '${weekday.toUpperCase()}, ${formattedDate.toUpperCase()} · DAILY CHECK-IN'),
            const SizedBox(height: 8),

            // Title
            Text(
              t.checkinTitle,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              t.checkinSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Info row
            Row(
              children: [
                Text(
                  t.checkinDuration,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                if (_isDemo)
                  Text(
                    t.demoDraft,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            // Card 1: Last night's rest
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bedtime_outlined, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Text(
                        t.lastNightRest,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Sleep hours
                  Row(
                    children: [
                      Text(
                        t.sleepHours,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        '${_sleepHours.toStringAsFixed(1)} h',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    value: _sleepHours,
                    min: 0,
                    max: 12,
                    divisions: 24,
                    onChanged: (value) => setState(() => _sleepHours = value),
                  ),
                  Text(
                    '0–12 hours · half-hour steps',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),

                  // Sleep quality
                  Text(
                    t.sleepQuality,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  RatingTiles(
                    value: _sleepQuality,
                    count: 5,
                    onChanged: (value) => setState(() => _sleepQuality = value),
                    labels: [t.veryPoor, t.veryGood],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Card 2: Inner weather
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.sentiment_satisfied_outlined, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Text(
                        t.innerWeather,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Mood
                  Text(
                    '${t.moodLabel} $_mood / 5',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  RatingTiles(
                    value: _mood,
                    count: 5,
                    onChanged: (value) => setState(() => _mood = value),
                    showIcons: true,
                    labels: [t.veryLow, t.veryHigh],
                  ),
                  const SizedBox(height: 24),

                  // Energy
                  Text(
                    '${t.energyLabel} $_energy / 5',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  RatingTiles(
                    value: _energy,
                    count: 5,
                    onChanged: (value) => setState(() => _energy = value),
                    showIcons: true,
                    labels: [t.veryLow, t.veryHigh],
                  ),
                  const SizedBox(height: 24),

                  // Stress
                  Text(
                    '${t.stressLabel} $_stress / 5',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  RatingTiles(
                    value: _stress,
                    count: 5,
                    onChanged: (value) => setState(() => _stress = value),
                    labels: [t.veryLow, t.veryHigh],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'All feelings belong here. Higher isn\'t always better — for stress, lower means calmer.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Card 3: Everyday things
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.eco_outlined, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Text(
                        t.everydayThings,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Water
                  StepperRow(
                    value: _waterGlasses,
                    min: 0,
                    max: 15,
                    step: 1,
                    unit: t.waterUnit,
                    helper: t.waterHelper,
                    onChanged: (value) => setState(() => _waterGlasses = value),
                  ),
                  const SizedBox(height: 24),

                  // Activity
                  StepperRow(
                    value: _activityMinutes,
                    min: 0,
                    max: 180,
                    step: 5,
                    unit: t.activityUnit,
                    helper: t.activityHelper,
                    onChanged: (value) => setState(() => _activityMinutes = value),
                  ),
                  const SizedBox(height: 24),

                  // Meals
                  StepperRow(
                    value: _meals,
                    min: 0,
                    max: 6,
                    step: 1,
                    unit: '',
                    helper: '',
                    onChanged: (value) => setState(() => _meals = value),
                  ),
                  const SizedBox(height: 24),

                  // Breaks
                  StepperRow(
                    value: _breaks,
                    min: 0,
                    max: 12,
                    step: 1,
                    unit: '',
                    helper: t.breaksHelper,
                    onChanged: (value) => setState(() => _breaks = value),
                  ),
                  const SizedBox(height: 24),

                  // Screen time
                  Row(
                    children: [
                      Text(
                        t.screenTime,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        '${_screenTimeHours.toStringAsFixed(1)} h',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    value: _screenTimeHours,
                    min: 0,
                    max: 16,
                    divisions: 32,
                    onChanged: (value) => setState(() => _screenTimeHours = value),
                  ),
                  Text(
                    t.screenTimeHelper,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),

                  // Caffeine
                  StepperRow(
                    value: _caffeineServings,
                    min: 0,
                    max: 10,
                    step: 1,
                    unit: t.caffeineUnit,
                    helper: t.caffeineHelper,
                    onChanged: (value) => setState(() => _caffeineServings = value),
                  ),
                  const SizedBox(height: 24),

                  // Phone away
                  Text(
                    t.phoneAway,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildPhoneChip(t.phoneAwayYes, true),
                      const SizedBox(width: 8),
                      _buildPhoneChip(t.phoneAwayNo, false),
                      const SizedBox(width: 8),
                      _buildPhoneChip(t.phoneAwaySkip, null),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Note
            Row(
              children: [
                Text(
                  t.anythingOnMind,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 8),
                Text(
                  t.optional,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _noteController,
              maxLines: 4,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: t.notePlaceholder,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.noteHelper,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),

            // Save button
            PrimaryButton(
              label: widget.existingCheckin != null ? t.saveCheckinEdit : t.saveCheckin,
              onPressed: _isLoading ? null : _saveCheckin,
              isLoading: _isLoading,
              showArrow: true,
            ),
            const SizedBox(height: 16),

            // Info text
            Text(
              t.oneEntryToday,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              t.patternsBegin,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Disclaimer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneChip(String label, bool? value) {
    final isSelected = _phoneAwayBeforeBed == value;
    return InkWell(
      onTap: () => setState(() => _phoneAwayBeforeBed = value),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.sage,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.ink,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
