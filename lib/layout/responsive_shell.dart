import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/locale_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/disclaimer.dart';
import '../widgets/language_pill.dart';
import '../widgets/logo.dart';
import 'today_screen.dart';
import 'insights_screen.dart';
import 'for_you_screen.dart';
import 'support_screen.dart';
import 'checkin/checkin_screen.dart';
import 'journal_screen.dart';
import 'account_bottom_sheet.dart';

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _selectedIndex = 0;

  final List<ShellDestination> _destinations = [
    ShellDestination(
      icon: Icons.home_outlined,
      label: 'Today',
      screen: const TodayScreen(),
    ),
    ShellDestination(
      icon: Icons.bar_chart_outlined,
      label: 'Insights',
      screen: const InsightsScreen(),
    ),
    ShellDestination(
      icon: Icons.favorite_border,
      label: 'For you',
      screen: const ForYouScreen(),
    ),
    ShellDestination(
      icon: Icons.support_agent_outlined,
      label: 'Support',
      screen: const SupportScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    if (isDesktop) {
      return _buildDesktopLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      body: Column(
        children: [
          _buildMobileHeader(),
          Expanded(
            child: _destinations[_selectedIndex].screen,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          destinations: _destinations
              .map((d) => NavigationDestination(
                    icon: Icon(d.icon),
                    label: d.label,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildMobileHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          const Logo(size: 40),
          const Spacer(),
          const LanguagePill(),
          const SizedBox(width: 12),
          _buildAvatarButton(),
        ],
      ),
    );
  }

  Widget _buildAvatarButton() {
    return InkWell(
      onTap: _showAccountBottomSheet,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFFF1DFA0),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            'N',
            style: TextStyle(
              color: AppColors.ink,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          _buildDesktopSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildDesktopHeader(),
                Expanded(
                  child: _destinations[_selectedIndex].screen,
                ),
                _buildDesktopFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopSidebar() {
    return Container(
      width: 300,
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(right: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Logo(size: 48),
            const SizedBox(height: 32),
            Text(
              'YOUR SPACE',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 8),
            Text(
              "Nour's journal",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.primaryDark,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Cairo · English',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 32),
            ..._buildDesktopNavItems(),
            const SizedBox(height: 24),
            _buildDesktopQuoteCard(),
            const SizedBox(height: 32),
            Text(
              'ACCOUNT & DATA',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 16),
            _buildDesktopAccountSection(),
            const SizedBox(height: 24),
            const LanguagePill(),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, size: 18),
              label: const Text('Sign out'),
              style: TextButton.styleFrom(foregroundColor: AppColors.ink),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDesktopNavItems() {
    return [
      _buildDesktopNavItem('Today', Icons.home_outlined, 0),
      _buildDesktopNavItem('Daily check-in', Icons.edit_outlined, -1, action: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckinScreen()));
      }),
      _buildDesktopNavItem('Personal insights', Icons.bar_chart_outlined, 1),
      _buildDesktopNavItem('For you', Icons.favorite_border, 2),
      _buildDesktopNavItem('Support', Icons.support_agent_outlined, 3),
      _buildDesktopNavItem('Journal', Icons.book_outlined, -1, action: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const JournalScreen()));
      }),
    ];
  }

  Widget _buildDesktopNavItem(String label, IconData icon, int index, {VoidCallback? action}) {
    final isSelected = index >= 0 && _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: InkWell(
        onTap: action ?? (index >= 0 ? () => setState(() => _selectedIndex = index) : null),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.sage : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.muted,
                size: 22,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.ink,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopQuoteCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.sand,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.wb_sunny_outlined, color: AppColors.primary),
          const SizedBox(height: 12),
          Text(
            "You're a person, not a progress bar.",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "No streaks. No catching up. Just room to reflect.",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nickname: Nour · Edit',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Private by default. No real name required.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        _buildDesktopAccountLink(Icons.download_outlined, 'Export my entries', AppColors.primary),
        const SizedBox(height: 8),
        _buildDesktopAccountLink(Icons.delete_outline, 'Delete my data', AppColors.danger),
      ],
    );
  }

  Widget _buildDesktopAccountLink(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Row(
        children: [
          Text(
            'Your space / ${_destinations[_selectedIndex].label}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          const LanguagePill(),
          const SizedBox(width: 16),
          _buildAvatarButton(),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          const Disclaimer(),
          const Spacer(),
          TextLink(
            label: 'Need someone to talk to? Find support',
            onTap: () {
              setState(() => _selectedIndex = 3);
            },
          ),
        ],
      ),
    );
  }

  void _showAccountBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AccountBottomSheet(),
    );
  }
}

class ShellDestination {
  final IconData icon;
  final String label;
  final Widget screen;

  ShellDestination({
    required this.icon,
    required this.label,
    required this.screen,
  });
}
