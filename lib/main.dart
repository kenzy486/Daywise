import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'screens/auth_gate.dart';
import 'screens/onboarding_screen.dart';
import 'services/locale_provider.dart';
import 'services/onboarding_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final localeProvider = LocaleProvider();
  await localeProvider.load();
  final seenOnboarding = await OnboardingService.hasSeen();

  runApp(
    ChangeNotifierProvider.value(
      value: localeProvider,
      child: DayWiseApp(showOnboarding: !seenOnboarding),
    ),
  );
}

class DayWiseApp extends StatelessWidget {
  final bool showOnboarding;
  const DayWiseApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.ofLocale(localeProvider.locale),
      locale: localeProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: showOnboarding ? const OnboardingScreen() : const AuthGate(),
    );
  }
}