import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/app_state.dart';
import '../services/locale_provider.dart';
import '../services/suggestions_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/dw.dart';
import 'goals_screen.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final list = app.todaysSuggestions;

    return PageBody(
      children: [
        PageIntro(
          eyebrow: t.forYouEyebrow(Fmt.shortDay(context, app.today)),
          title: t.forYouTitle,
          body: app.name(context).isEmpty ? t.forYouBodyNoName : t.forYouBody(app.name(context)),
        ),
        if (app.isDemo) const DemoDisclosure(),
        Row(
          children: [
            Expanded(
              child: Text(
                t.doneTodayCount(Fmt.number(context, app.suggestionsDone), Fmt.number(context, list.length)),
                style: AppTheme.sans(context, size: 13, color: AppColors.primary, weight: FontWeight.w600),
              ),
            ),
            Text(t.notAScore, style: AppTheme.sans(context, size: 11)),
          ],
        ),
        for (final s in list) _SuggestionCard(suggestion: s),
        DwCard(
          tone: CardTone.sand,
          radius: 16,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.agencyTitle, style: AppTheme.serif(context, size: 20)),
              const SizedBox(height: 8),
              Text(t.agencyBody, style: AppTheme.sans(context, size: 12, height: 1.6)),
            ],
          ),
        ),
        if (!app.isDemo)
          TextAction(
            t.editGoalsLink,
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const GoalsScreen(editOnly: true))),
          ),
        const Disclaimer(),
      ],
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  final Suggestion suggestion;
  const _SuggestionCard({required this.suggestion});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final lang = context.watch<LocaleProvider>().locale.languageCode;
    final s = suggestion;
    final state = app.stateOf(s.id);
    final done = state.status == SuggestionStatus.done;
    final skipped = state.status == SuggestionStatus.skipped;

    final badge = switch (state.status) {
      SuggestionStatus.done => ContextBadge(t.doneToday),
      SuggestionStatus.skipped => ContextBadge(t.skippedToday, background: AppColors.sageLight),
      SuggestionStatus.pending => ContextBadge(t.pending, background: AppColors.sand),
    };

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: done ? AppColors.sage : AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: done ? AppColors.mint : AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(s.icon, size: 26, color: AppColors.primary),
              const Spacer(),
              badge,
            ],
          ),
          const SizedBox(height: 15),
          Text(
            s.title(lang),
            style: AppTheme.serif(context, size: 24, color: skipped ? AppColors.body : AppColors.ink),
          ),
          const SizedBox(height: 15),
          Text(s.rationale(lang), style: AppTheme.sans(context, size: 12, height: 1.65)),
          const SizedBox(height: 15),
          if (state.status == SuggestionStatus.pending)
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    t.done,
                    height: 44,
                    onPressed: () => app.setSuggestionStatus(s.id, SuggestionStatus.done),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ActionButton(
                    t.skipToday,
                    height: 44,
                    primary: false,
                    onPressed: () => app.setSuggestionStatus(s.id, SuggestionStatus.skipped),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      done ? t.madeRoom : t.skippedNote,
                      style: AppTheme.sans(
                        context,
                        size: 12,
                        color: AppColors.primary,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => app.setSuggestionStatus(s.id, SuggestionStatus.pending),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      minimumSize: const Size(44, 44),
                    ),
                    child: Text(t.undo, style: AppTheme.sans(context, size: 12, color: AppColors.primary)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 15),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Text(done ? t.wasHelpful : t.fitsYourDay, style: AppTheme.sans(context, size: 11)),
              ),
              SquareIconButton(
                icon: LucideIcons.thumbsUp,
                iconSize: 17,
                semanticLabel: t.helpful,
                selected: state.helpful == true,
                onTap: () => app.setSuggestionFeedback(s.id, true),
              ),
              const SizedBox(width: 5),
              SquareIconButton(
                icon: LucideIcons.thumbsDown,
                iconSize: 17,
                semanticLabel: t.notHelpful,
                selected: state.helpful == false,
                onTap: () => app.setSuggestionFeedback(s.id, false),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
