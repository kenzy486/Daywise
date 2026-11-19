import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/checkin.dart';
import '../../theme/app_colors.dart';
import '../../widgets/disclaimer.dart';
import '../../widgets/section_card.dart';
import 'checkin/checkin_screen.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.journalTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.journalEmpty,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Disclaimer(),
          ],
        ),
      ),
    );
  }
}
