import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_colors.dart';
import '../../widgets/demo_banner.dart';
import '../../widgets/disclaimer.dart';
import '../../widgets/eyebrow.dart';
import '../../widgets/sage_card.dart';
import '../../widgets/sand_card.dart';
import '../../widgets/section_card.dart';
import '../../widgets/status_chip.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final now = DateTime.now();
    final date = DateFormat('d MMM', 'en_US').format(now);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Eyebrow
            Eyebrow(label: t.forYouTitle.replaceAll('{date}', date)),
            const SizedBox(height: 8),

            // Title
            Text(
              t.forYouHeading,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              t.forYouSubtitle.replaceAll('{nickname}', 'Nour'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Demo banner
            // const DemoBanner(),
            const SizedBox(height: 16),

            // Progress row
            Row(
              children: [
                Text(
                  t.doneToday.replaceAll('{done}', '1'),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  t.notScore,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Suggestion 1 - Done
            SageCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.directions_walk_outlined, color: AppColors.primary),
                      const Spacer(),
                      StatusChip(label: '✓ Done today', type: StatusType.done),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.suggestion1Title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.suggestion1Rationale,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        t.nourMadeRoom,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextLink(
                        label: t.undo,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    t.wasThisHelpful,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildThumbButton(Icons.thumb_up_outlined, true),
                      const SizedBox(width: 8),
                      _buildThumbButton(Icons.thumb_down_outlined, false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Suggestion 2 - Pending
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bedtime_outlined, color: AppColors.primary),
                      const Spacer(),
                      StatusChip(label: 'Pending', type: StatusType.pending),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.suggestion2Title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.suggestion2Rationale,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(t.done, true),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(t.skip, false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    t.doesThisFit,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildThumbButton(Icons.thumb_up_outlined, true),
                      const SizedBox(width: 8),
                      _buildThumbButton(Icons.thumb_down_outlined, false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Suggestion 3 - Pending
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.coffee_outlined, color: AppColors.primary),
                      const Spacer(),
                      StatusChip(label: 'Pending', type: StatusType.pending),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.suggestion3Title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.suggestion3Rationale,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(t.done, true),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(t.skip, false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    t.doesThisFit,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildThumbButton(Icons.thumb_up_outlined, true),
                      const SizedBox(width: 8),
                      _buildThumbButton(Icons.thumb_down_outlined, false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Closing card
            SandCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.suggestionsNotInstructions,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.suggestionsNotInstructionsBody,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Disclaimer(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, bool isPrimary) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : AppColors.surface,
          border: isPrimary ? null : Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isPrimary ? Colors.white : AppColors.primary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbButton(IconData icon, bool isSelected) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.sage : AppColors.bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.muted, size: 20),
      ),
    );
  }
}
