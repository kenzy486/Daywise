import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../services/app_state.dart';
import '../services/insights_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dw.dart';

/// Official starting points only — no phone numbers, as the design specifies.
const _ministryUrl = 'https://www.mohp.gov.eg/';
const _universitySearchEn = 'https://www.google.com/search?q=university+student+counselling+centre+Egypt';
const _universitySearchAr =
    'https://www.google.com/search?q=%D9%85%D8%B1%D9%83%D8%B2+%D8%A7%D9%84%D8%A5%D8%B1%D8%B4%D8%A7%D8%AF+%D8%A7%D9%84%D9%86%D9%81%D8%B3%D9%8A+%D8%AC%D8%A7%D9%85%D8%B9%D8%A9';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  Future<void> _open(BuildContext context, String url) async {
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    if (!ok) messenger.showSnackBar(SnackBar(content: Text(t.linkFailed)));
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final ar = AppTheme.isArabic(context);
    final hard = InsightsService.hardStretch(app.lastDays(7));

    return PageBody(
      gap: 22,
      children: [
        PageIntro(eyebrow: t.supportEyebrow, title: t.supportTitle, body: t.supportBody),
        if (app.isDemo) const DemoDisclosure(),
        DwCard(
          tone: CardTone.mint,
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(LucideIcons.heartHandshake, size: 32, color: AppColors.primary),
              const SizedBox(height: 16),
              Text(
                hard ? t.supportHardTitle : t.supportGentleTitle,
                style: AppTheme.serif(context, size: 25, height: 1.3),
              ),
              const SizedBox(height: 16),
              Text(t.supportInviteBody, style: AppTheme.sans(context, size: 12, height: 1.65)),
            ],
          ),
        ),
        DwCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Heading(icon: LucideIcons.graduationCap, text: t.universityTitle),
              const SizedBox(height: 16),
              Text(t.universityBody, style: AppTheme.sans(context, size: 12, height: 1.7)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 14, 6, 14),
                decoration: BoxDecoration(
                  color: AppColors.sageLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        t.universityStarter,
                        style: AppTheme.sans(context, size: 12, color: AppColors.ink, height: 1.7),
                      ),
                    ),
                    IconButton(
                      tooltip: t.copyStarter,
                      icon: const Icon(LucideIcons.copy, size: 16, color: AppColors.primary),
                      onPressed: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        await Clipboard.setData(ClipboardData(text: t.universityStarter));
                        messenger.showSnackBar(SnackBar(content: Text(t.copied)));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ActionButton(
                t.universityAction,
                primary: false,
                external: true,
                height: 44,
                onPressed: () => _open(context, ar ? _universitySearchAr : _universitySearchEn),
              ),
            ],
          ),
        ),
        DwCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Heading(icon: LucideIcons.landmark, text: t.egyptTitle),
              const SizedBox(height: 16),
              Text(t.egyptBody, style: AppTheme.sans(context, size: 12, height: 1.7)),
              const SizedBox(height: 16),
              ActionButton(
                t.egyptAction,
                primary: false,
                external: true,
                height: 44,
                onPressed: () => _open(context, _ministryUrl),
              ),
              const SizedBox(height: 16),
              Text(t.egyptNote, style: AppTheme.sans(context, size: 11, height: 1.6)),
            ],
          ),
        ),
        DwCard(
          tone: CardTone.sand,
          borderColor: AppColors.danger,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Heading(icon: LucideIcons.shieldAlert, text: t.urgentTitle, size: 15, iconSize: 23),
              const SizedBox(height: 14),
              Text(t.urgentBody, style: AppTheme.sans(context, size: 13, color: AppColors.ink, height: 1.7)),
              const SizedBox(height: 14),
              Text(t.urgentNote, style: AppTheme.sans(context, size: 11, height: 1.6)),
            ],
          ),
        ),
        const Disclaimer(),
      ],
    );
  }
}

class _Heading extends StatelessWidget {
  final IconData icon;
  final String text;
  final double size;
  final double iconSize;
  const _Heading({required this.icon, required this.text, this.size = 16, this.iconSize = 24});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: iconSize, color: AppColors.primary),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          text,
          style: AppTheme.sans(context, size: size, color: AppColors.ink, weight: FontWeight.w600),
        ),
      ),
    ],
  );
}
