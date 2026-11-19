import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_colors.dart';
import '../../widgets/demo_banner.dart';
import '../../widgets/disclaimer.dart';
import '../../widgets/eyebrow.dart';
import '../../widgets/mint_card.dart';
import '../../widgets/sand_card.dart';
import '../../widgets/section_card.dart';
import '../../widgets/secondary_button.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

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
            Eyebrow(label: t.supportTitle),
            const SizedBox(height: 8),

            // Title
            Text(
              t.supportHeading,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              t.supportSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),

            // Demo banner
            // const DemoBanner(),
            const SizedBox(height: 16),

            // Support card
            MintCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.handshake_outlined, color: AppColors.primary, size: 32),
                  const SizedBox(height: 16),
                  Text(
                    t.supportCardTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.supportCardBody,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // University card
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.school_outlined, color: AppColors.primary, size: 24),
                  const SizedBox(height: 12),
                  Text(
                    t.universityTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.universityBody,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.sage,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.universityQuote,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                // Copy quote
                              },
                              child: const Icon(Icons.copy, size: 18, color: AppColors.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SecondaryButton(
                    label: t.findUniversity,
                    showArrow: true,
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.google.com/search?q=university+counselling+services');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Egypt resources card
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_city_outlined, color: AppColors.primary, size: 24),
                  const SizedBox(height: 12),
                  Text(
                    t.egyptTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.egyptBody,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  SecondaryButton(
                    label: t.findMinistry,
                    showArrow: true,
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.mohp.gov.eg');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.egyptNote,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Help right now card
            SandCard(
              showDangerBorder: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.shield_alert_outlined, color: AppColors.danger, size: 24),
                  const SizedBox(height: 12),
                  Text(
                    t.helpRightNow,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.danger,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.helpRightNowBody,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.helpRightNowNote,
                    style: Theme.of(context).textTheme.bodySmall,
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
}
