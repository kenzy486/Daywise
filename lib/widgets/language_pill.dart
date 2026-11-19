import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/locale_provider.dart';
import '../theme/app_colors.dart';
import 'package:provider/provider.dart';

class LanguagePill extends StatelessWidget {
  const LanguagePill({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final t = AppLocalizations.of(context);

    return InkWell(
      onTap: () {
        final newCode = localeProvider.isArabic ? 'en' : 'ar';
        localeProvider.setLocale(newCode);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.translate_outlined, size: 16, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              localeProvider.isArabic ? 'EN · العربية' : 'EN · العربية',
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
