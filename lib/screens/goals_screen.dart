import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/app_state.dart';
import '../services/suggestions_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/dw.dart';

IconData goalIcon(Goal g) => switch (g) {
  Goal.sleep => LucideIcons.moon,
  Goal.stress => LucideIcons.wind,
  Goal.energy => LucideIcons.sun,
  Goal.activity => LucideIcons.footprints,
  Goal.nutrition => LucideIcons.utensils,
};

(String, String) goalCopy(Goal g, AppLocalizations t) => switch (g) {
  Goal.sleep => (t.goalSleep, t.goalSleepDesc),
  Goal.stress => (t.goalStress, t.goalStressDesc),
  Goal.energy => (t.goalEnergy, t.goalEnergyDesc),
  Goal.activity => (t.goalActivity, t.goalActivityDesc),
  Goal.nutrition => (t.goalNutrition, t.goalNutritionDesc),
};

/// "Choose your goals" (1 of 2) then nickname (2 of 2).
/// With [editOnly], shows just the goals step and pops on save.
class GoalsScreen extends StatefulWidget {
  final bool editOnly;
  const GoalsScreen({super.key, this.editOnly = false});
  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  late final Set<Goal> _selected = {...context.read<AppState>().goals};
  late final _name = TextEditingController(text: context.read<AppState>().nickname);
  int _step = 0;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _finish({bool skipGoals = false}) async {
    final app = context.read<AppState>();
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
    setState(() => _saving = true);
    try {
      final goals = skipGoals ? <Goal>[] : Goal.values.where(_selected.contains).toList();
      if (widget.editOnly) {
        await app.setGoals(goals);
        messenger.showSnackBar(SnackBar(content: Text(t.goalsSaved)));
        nav.pop();
      } else {
        await app.saveOnboarding(goals: goals, nickname: _name.text);
      }
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(t.errSaveFailed)));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              leading: (widget.editOnly || _step == 1)
                  ? IconButton(
                      tooltip: t.back,
                      onPressed: () => widget.editOnly && _step == 0
                          ? Navigator.of(context).pop()
                          : setState(() => _step = 0),
                      icon: Icon(
                        Directionality.of(context) == TextDirection.rtl
                            ? LucideIcons.arrowRight
                            : LucideIcons.arrowLeft,
                        color: AppColors.primary,
                      ),
                    )
                  : null,
            ),
            Expanded(
              child: PageBody(maxWidth: 520, gap: 24, children: _step == 0 ? _goalsStep(t) : _nameStep(t)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _progress() => Row(
    children: [
      for (var i = 0; i < 2; i++) ...[
        if (i > 0) const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: i <= _step ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    ],
  );

  List<Widget> _goalsStep(AppLocalizations t) => [
    if (!widget.editOnly) _progress(),
    PageIntro(
      eyebrow: widget.editOnly ? t.editGoals.toUpperCase() : t.goalsEyebrow,
      title: t.goalsTitle,
      body: t.goalsBody,
    ),
    Eyebrow(t.goalsSelected(Fmt.number(context, _selected.length)), size: 12),
    Column(children: spaced([for (final g in Goal.values) _goalChoice(g, t)], 12)),
    Text(t.goalsQuote, style: AppTheme.serif(context, size: 19, color: AppColors.body, height: 1.4)),
    ActionButton(
      widget.editOnly ? t.save : t.continueLabel,
      arrow: !widget.editOnly,
      loading: _saving,
      onPressed: _selected.isEmpty ? null : () => widget.editOnly ? _finish() : setState(() => _step = 1),
    ),
    if (!widget.editOnly)
      TextAction(
        t.decideLater,
        center: true,
        weight: FontWeight.w400,
        onTap: () {
          _selected.clear();
          setState(() => _step = 1);
        },
      ),
    const Disclaimer(),
  ];

  Widget _goalChoice(Goal g, AppLocalizations t) {
    final sel = _selected.contains(g);
    final (title, desc) = goalCopy(g, t);
    return Semantics(
      checked: sel,
      button: true,
      child: Material(
        color: sel ? AppColors.sage : AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: sel ? AppColors.primary : AppColors.border, width: sel ? 1.5 : 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => setState(() => sel ? _selected.remove(g) : _selected.add(g)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 82),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(goalIcon(g), size: 26, color: AppColors.primary),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTheme.sans(
                            context,
                            size: 15,
                            color: AppColors.ink,
                            weight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(desc, style: AppTheme.sans(context, size: 11, height: 1.4)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: sel ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sel ? AppColors.primary : AppColors.border),
                    ),
                    child: sel ? const Icon(LucideIcons.check, size: 16, color: Colors.white) : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _nameStep(AppLocalizations t) => [
    _progress(),
    PageIntro(eyebrow: t.nameEyebrow, title: t.nameTitle, body: t.nameBody),
    DwTextField(
      label: t.nameLabel,
      hint: t.nameHint,
      controller: _name,
      autofillHints: const [AutofillHints.nickname],
      suffix: const Icon(LucideIcons.userRound, size: 18),
      onSubmitted: (_) => _finish(skipGoals: _selected.isEmpty),
    ),
    ActionButton(
      t.startJournal,
      arrow: true,
      loading: _saving,
      onPressed: () => _finish(skipGoals: _selected.isEmpty),
    ),
    const Disclaimer(),
  ];
}
