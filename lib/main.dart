import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'screens/app_shell.dart';
import 'screens/auth_screens.dart';
import 'screens/goals_screen.dart';
import 'screens/landing_screen.dart';
import 'services/app_state.dart';
import 'services/locale_provider.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var firebaseReady = true;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).timeout(const Duration(seconds: 10));
  } catch (e) {
    // Lets the demo still run on platforms without Firebase configuration.
    debugPrint('DayWise: Firebase unavailable ($e). Demo mode only.');
    firebaseReady = false;
  }

  final localeProvider = LocaleProvider();
  await localeProvider.load();

  // Shareable links on the web: ?demo=1 opens Nour's demo, ?lang=ar|en picks a language.
  final params = Uri.base.queryParameters;
  final lang = params['lang'];
  if (lang == 'ar' || lang == 'en') await localeProvider.setLocale(lang!);
  final appState = AppState();
  if (params['demo'] == '1') appState.startDemo();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeProvider),
        ChangeNotifierProvider.value(value: appState),
      ],
      child: DayWiseApp(firebaseReady: firebaseReady),
    ),
  );
}

class DayWiseApp extends StatelessWidget {
  final bool firebaseReady;
  const DayWiseApp({super.key, required this.firebaseReady});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>().locale;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.ofLocale(locale),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Root(firebaseReady: firebaseReady),
    );
  }
}

/// Decides what to show: demo, welcome / sign-up, goal onboarding or the app.
class Root extends StatelessWidget {
  final bool firebaseReady;
  const Root({super.key, required this.firebaseReady});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    if (app.isDemo) return const AppShell();
    if (!firebaseReady) return const _SignedOut(firebaseReady: false);

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) return const _Loading();
        final user = snap.data;
        if (user == null) {
          if (app.ready) {
            WidgetsBinding.instance.addPostFrameCallback((_) => app.detachUser());
          }
          return const _SignedOut();
        }
        WidgetsBinding.instance.addPostFrameCallback((_) => app.attachUser(user.uid));
        if (!app.ready) return const _Loading();
        if (!app.onboarded) return const GoalsScreen();
        return const AppShell();
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
  );
}

/// Signed-out home: the website on wide screens, the Welcome screen on phones.
class _SignedOut extends StatelessWidget {
  final bool firebaseReady;
  const _SignedOut({this.firebaseReady = true});
  @override
  Widget build(BuildContext context) => MediaQuery.sizeOf(context).width >= 900
      ? LandingScreen(firebaseReady: firebaseReady)
      : WelcomeScreen(firebaseReady: firebaseReady);
}
