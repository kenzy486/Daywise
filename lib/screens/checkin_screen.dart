import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/checkin.dart';
import '../services/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/dw.dart';
import 'app_shell.dart';

/// One scrollable daily check-in (Figma "Daily check-in").
class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});
  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  late CheckIn _c;
  late final bool _editing;
  late final TextEditingController _note;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppState>();
    final existing = app.todayCheckin;
    _editing = existing != null;
    _c = existing ?? CheckIn.empty(app.today);
    _note = TextEditingController(text: _c.note ?? '');
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  void _set(CheckIn Function(CheckIn) f) => setState(() => _c = f(_c));

  Future<void> _save() async {
    final app = context.read<AppState>();
    final nav = context.read<ShellNav>();
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _saving = true);
    try {
      final note = _note.text.trim();
      await app.saveCheckin(
        CheckIn(
          date: _c.date,
          sleepHours: _c.sleepHours,
          sleepQuality: _c.sleepQuality,
          waterGlasses: _c.waterGlasses,
          exerciseMinutes: _c.exerciseMinutes,
          mood: _c.mood,
          energy: _c.energy,
          stress: _c.stress,
          meals: _c.meals,
          breaks: _c.breaks,
          screenTimeHours: _c.screenTimeHours,
          caffeineServings: _c.caffeineServings,
          phoneAwayBeforeBed: _c.phoneAwayBeforeBed,
          note: note.isEmpty ? null : note,
          createdAt: _c.createdAt,
        ),
      );
      messenger.showSnackBar(SnackBar(content: Text(t.checkinSaved)));
      nav.go(ShellPage.today);
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(t.errSaveFailed)));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    String n(num v) => Fmt.number(context, v);
    String r(int v) => t.ratingOf5(n(v));

    Widget section(IconData icon, String title, List<Widget> children, {double gap = 22}) => DwCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: spaced([
          Row(
            children: [
              Icon(icon, size: 22, color: AppColors.primary),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: AppTheme.serif(context, size: 23))),
            ],
          ),
          ...children,
        ], gap),
      ),
    );

    return PageBody(
      gap: 22,
      children: [
        PageIntro(
          eyebrow: t.checkinEyebrow(Fmt.shortDay(context, app.today)),
          title: t.checkinTitle,
          body: t.checkinBody,
        ),
        if (app.isDemo) const DemoDisclosure(),
        Row(
          children: [
            Expanded(child: Text(t.about30Seconds, style: AppTheme.sans(context, size: 11))),
            Text(
              _editing ? t.editingToday : (app.isDemo ? t.demoDraft : ''),
              style: AppTheme.sans(context, size: 11, color: AppColors.primary, weight: FontWeight.w600),
            ),
          ],
        ),

        // ── Last night's rest
        section(LucideIcons.moon, t.restSection, [
          SliderInput(
            label: t.sleepHours,
            valueLabel: t.hoursShort(n(_c.sleepHours)),
            value: _c.sleepHours,
            min: 0,
            max: 12,
            divisions: 24,
            helper: t.sleepHelper,
            onChanged: (v) => _set((c) => c.copyWith(sleepHours: v)),
          ),
          RatingInput(
            label: t.sleepQuality,
            valueLabel: r(_c.sleepQuality),
            value: _c.sleepQuality,
            lowLabel: t.veryPoor,
            highLabel: t.veryGood,
            numberLabel: n,
            onChanged: (v) => _set((c) => c.copyWith(sleepQuality: v)),
          ),
        ]),

        // ── Inner weather
        section(LucideIcons.smile, t.innerWeather, gap: 28, [
          RatingInput(
            label: t.mood,
            valueLabel: r(_c.mood),
            value: _c.mood,
            faces: true,
            lowLabel: t.veryLow,
            highLabel: t.veryGood,
            numberLabel: n,
            onChanged: (v) => _set((c) => c.copyWith(mood: v)),
          ),
          RatingInput(
            label: t.energy,
            valueLabel: r(_c.energy),
            value: _c.energy,
            faces: true,
            lowLabel: t.veryLow,
            highLabel: t.veryHigh,
            numberLabel: n,
            onChanged: (v) => _set((c) => c.copyWith(energy: v)),
          ),
          RatingInput(
            label: t.stress,
            valueLabel: r(_c.stress),
            value: _c.stress,
            lowLabel: t.veryLow,
            highLabel: t.veryHigh,
            numberLabel: n,
            onChanged: (v) => _set((c) => c.copyWith(stress: v)),
          ),
          Text(t.feelingsNote, style: AppTheme.sans(context, size: 11, height: 1.6)),
        ]),

        // ── Everyday things
        section(LucideIcons.leaf, t.everydayThings, gap: 24, [
          StepperInput(
            label: t.water,
            valueLabel: n(_c.waterGlasses),
            unit: t.glasses,
            helper: t.waterHelper,
            onDecrease: _c.waterGlasses > 0
                ? () => _set((c) => c.copyWith(waterGlasses: c.waterGlasses - 1))
                : null,
            onIncrease: _c.waterGlasses < 15
                ? () => _set((c) => c.copyWith(waterGlasses: c.waterGlasses + 1))
                : null,
          ),
          StepperInput(
            label: t.activity,
            valueLabel: n(_c.exerciseMinutes),
            unit: t.minutes,
            helper: t.activityHelper,
            onDecrease: _c.exerciseMinutes > 0
                ? () => _set((c) => c.copyWith(exerciseMinutes: c.exerciseMinutes - 5))
                : null,
            onIncrease: _c.exerciseMinutes < 180
                ? () => _set((c) => c.copyWith(exerciseMinutes: c.exerciseMinutes + 5))
                : null,
          ),
          StepperInput(
            label: t.meals,
            valueLabel: n(_c.meals),
            unit: t.mealsUnit,
            onDecrease: _c.meals > 0 ? () => _set((c) => c.copyWith(meals: c.meals - 1)) : null,
            onIncrease: _c.meals < 6 ? () => _set((c) => c.copyWith(meals: c.meals + 1)) : null,
          ),
          StepperInput(
            label: t.breaks,
            valueLabel: n(_c.breaks),
            unit: t.breaksUnit,
            helper: t.breaksHelper,
            onDecrease: _c.breaks > 0 ? () => _set((c) => c.copyWith(breaks: c.breaks - 1)) : null,
            onIncrease: _c.breaks < 12 ? () => _set((c) => c.copyWith(breaks: c.breaks + 1)) : null,
          ),
          SliderInput(
            label: t.screenTime,
            valueLabel: t.hoursShort(n(_c.screenTimeHours)),
            value: _c.screenTimeHours,
            min: 0,
            max: 16,
            divisions: 32,
            helper: t.screenHelper,
            onChanged: (v) => _set((c) => c.copyWith(screenTimeHours: v)),
          ),
          StepperInput(
            label: t.caffeine,
            valueLabel: n(_c.caffeineServings),
            unit: t.servings,
            helper: t.caffeineHelper,
            onDecrease: _c.caffeineServings > 0
                ? () => _set((c) => c.copyWith(caffeineServings: c.caffeineServings - 1))
                : null,
            onIncrease: _c.caffeineServings < 10
                ? () => _set((c) => c.copyWith(caffeineServings: c.caffeineServings + 1))
                : null,
          ),
          _PhoneAwayChoice(value: _c.phoneAwayBeforeBed, onChanged: (v) => _set((c) => c.withPhoneAway(v))),
        ]),

        // ── Optional note
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    t.noteTitle,
                    style: AppTheme.sans(context, size: 13, color: AppColors.ink, weight: FontWeight.w600),
                  ),
                ),
                Text(t.optional, style: AppTheme.sans(context, size: 11)),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _note,
              minLines: 4,
              maxLines: 8,
              maxLength: 500,
              style: AppTheme.sans(context, size: 13, color: AppColors.ink, height: 1.7),
              decoration: InputDecoration(
                hintText: t.noteHint,
                hintStyle: AppTheme.sans(context, size: 13),
                filled: true,
                fillColor: AppColors.surface,
                counterStyle: AppTheme.sans(context, size: 10),
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            Text(t.notePrivacy, style: AppTheme.sans(context, size: 11)),
          ],
        ),
        ActionButton(
          _editing ? t.updateCheckin : t.saveCheckin,
          arrow: true,
          loading: _saving,
          onPressed: _save,
        ),
        Text(
          t.checkinFooter,
          textAlign: TextAlign.center,
          style: AppTheme.sans(context, size: 11, height: 1.6),
        ),
        const Disclaimer(),
      ],
    );
  }
}

/// Optional yes/no for "phone away before bed" (feeds the evening insight).
class _PhoneAwayChoice extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?> onChanged;
  const _PhoneAwayChoice({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    Widget chip(String label, bool v) {
      final sel = value == v;
      return Semantics(
        button: true,
        selected: sel,
        child: Material(
          color: sel ? AppColors.primary : AppColors.sageLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: sel ? AppColors.primary : AppColors.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => onChanged(sel ? null : v), // tap again to clear
            child: SizedBox(
              width: 64,
              height: 44,
              child: Center(
                child: Text(
                  label,
                  style: AppTheme.sans(
                    context,
                    size: 12,
                    color: sel ? Colors.white : AppColors.primary,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                t.phoneAway,
                style: AppTheme.sans(context, size: 13, color: AppColors.ink, weight: FontWeight.w600),
              ),
            ),
            chip(t.yes, true),
            const SizedBox(width: 8),
            chip(t.no, false),
          ],
        ),
        const SizedBox(height: 10),
        Text(t.optional, style: AppTheme.sans(context, size: 11)),
      ],
    );
  }
}
