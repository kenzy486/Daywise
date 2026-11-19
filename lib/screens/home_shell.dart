import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'checkin/checkin_screen.dart';
import 'insights/insights_screen.dart';
import 'settings/settings_screen.dart';
import 'tips/tips_screen.dart';
import 'trends/trends_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0; // which tab is selected (0 = Check-in)

  static const _pages = [
    CheckinScreen(),
    TrendsScreen(),
    InsightsScreen(),
    TipsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.edit_note), label: t.navCheckin),
          NavigationDestination(icon: const Icon(Icons.show_chart), label: t.navTrends),
          NavigationDestination(icon: const Icon(Icons.insights), label: t.navInsights),
          NavigationDestination(
              icon: const Icon(Icons.tips_and_updates_outlined), label: t.navTips),
          NavigationDestination(
              icon: const Icon(Icons.settings_outlined), label: t.navSettings),
        ],
      ),
    );
  }
}