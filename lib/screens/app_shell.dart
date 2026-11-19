import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dw.dart';
import 'account_sheet.dart';
import 'checkin_screen.dart';
import 'for_you_screen.dart';
import 'insights_screen.dart';
import 'support_screen.dart';
import 'today_screen.dart';

enum ShellPage { today, checkin, insights, forYou, support }

/// Lets any screen switch the visible page.
class ShellNav extends ChangeNotifier {
  ShellPage _page = ShellPage.today;
  ShellPage get page => _page;
  void go(ShellPage p) {
    if (p == _page) return;
    _page = p;
    notifyListeners();
  }
}

const desktopBreakpoint = 1024.0;

class AppShell extends StatelessWidget {
  const AppShell({super.key});
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (_) => ShellNav(),
    child: LayoutBuilder(
      builder: (context, c) => c.maxWidth >= desktopBreakpoint ? const _DesktopShell() : const _MobileShell(),
    ),
  );
}

Widget _pageFor(ShellPage p) => switch (p) {
  ShellPage.today => const TodayScreen(),
  ShellPage.checkin => const CheckinScreen(),
  ShellPage.insights => const InsightsScreen(),
  ShellPage.forYou => const ForYouScreen(),
  ShellPage.support => const SupportScreen(),
};

String pageLabel(ShellPage p, AppLocalizations t) => switch (p) {
  ShellPage.today => t.navToday,
  ShellPage.checkin => t.navCheckin,
  ShellPage.insights => t.navInsightsLong,
  ShellPage.forYou => t.navForYou,
  ShellPage.support => t.navSupport,
};

// ───────────────────────── Mobile ─────────────────────────

class _MobileShell extends StatelessWidget {
  const _MobileShell();

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<ShellNav>();
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    // The check-in lives under the Today tab, as in the design.
    final tab = nav.page == ShellPage.checkin ? ShellPage.today : nav.page;
    final items = [
      (ShellPage.today, LucideIcons.house, t.navToday),
      (ShellPage.insights, LucideIcons.chartNoAxesCombined, t.navInsights),
      (ShellPage.forYou, LucideIcons.sprout, t.navForYou),
      (ShellPage.support, LucideIcons.heartHandshake, t.navSupport),
    ];
    return PopScope(
      canPop: nav.page == ShellPage.today,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) nav.go(ShellPage.today);
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppHeader(
                trailing: AvatarButton(initial: app.initial(context), onTap: () => showAccountSheet(context)),
              ),
              Expanded(child: _PageSwitcher(page: nav.page)),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    if (i > 0) const SizedBox(width: 4),
                    Expanded(
                      child: _NavItem(
                        icon: items[i].$2,
                        label: items[i].$3,
                        selected: tab == items[i].$1,
                        onTap: () => nav.go(items[i].$1),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.body;
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? AppColors.sage : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 20, color: color),
                  const SizedBox(height: 5),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.sans(context, size: 11, color: color),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── Desktop ─────────────────────────

class _DesktopShell extends StatelessWidget {
  const _DesktopShell();

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<ShellNav>();
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Sidebar(),
          const VerticalDivider(width: 1, color: AppColors.border),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 36, 36, 8),
                  child: Row(
                    children: [
                      Text(t.breadcrumb(pageLabel(nav.page, t)), style: AppTheme.sans(context, size: 12)),
                      const Spacer(),
                      const LanguageChoice(),
                      const SizedBox(width: 16),
                      AvatarButton(
                        initial: app.initial(context),
                        size: 36,
                        onTap: () => showAccountSheet(context),
                      ),
                    ],
                  ),
                ),
                Expanded(child: _PageSwitcher(page: nav.page)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<ShellNav>();
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    final items = [
      (ShellPage.today, LucideIcons.house, t.navToday),
      (ShellPage.checkin, LucideIcons.squarePen, t.navCheckin),
      (ShellPage.insights, LucideIcons.chartNoAxesCombined, t.navInsightsLong),
      (ShellPage.forYou, LucideIcons.sprout, t.navForYou),
      (ShellPage.support, LucideIcons.heartHandshake, t.navSupport),
    ];
    return SizedBox(
      width: 228,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DayWiseIdentity(markSize: 34, fontSize: 23),
            const SizedBox(height: 36),
            Text(t.yourSpace.toUpperCase(), style: AppTheme.sans(context, size: 10)),
            const SizedBox(height: 6),
            Text(
              app.name(context).isEmpty ? t.myJournal : t.journalOf(app.name(context)),
              style: AppTheme.sans(context, size: 15, color: AppColors.ink, weight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(t.cityLanguage(app.city), style: AppTheme.sans(context, size: 11)),
            const SizedBox(height: 28),
            for (final it in items) ...[
              _SideNavItem(
                icon: it.$2,
                label: it.$3,
                selected: nav.page == it.$1,
                onTap: () => nav.go(it.$1),
              ),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 24),
            DwCard(
              tone: CardTone.sand,
              padding: const EdgeInsets.all(16),
              radius: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LucideIcons.sun, size: 20, color: AppColors.primary),
                  const SizedBox(height: 14),
                  Text(t.sidebarQuoteTitle, style: AppTheme.serif(context, size: 19, height: 1.3)),
                  const SizedBox(height: 12),
                  Text(t.sidebarQuoteBody, style: AppTheme.sans(context, size: 11, height: 1.6)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(t.accountData, style: AppTheme.sans(context, size: 10)),
            const SizedBox(height: 14),
            Row(
              children: [
                Flexible(
                  child: Text(
                    t.nicknameLine(app.name(context).isEmpty ? '—' : app.name(context)),
                    style: AppTheme.sans(context, size: 12, color: AppColors.ink),
                  ),
                ),
                Text(' · ', style: AppTheme.sans(context, size: 12, color: AppColors.ink)),
                InkWell(
                  onTap: () => editNickname(context),
                  child: Text(t.edit, style: AppTheme.sans(context, size: 12, color: AppColors.ink)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(t.privateByDefault, style: AppTheme.sans(context, size: 11, height: 1.6)),
            const SizedBox(height: 18),
            _SideLink(
              icon: LucideIcons.download,
              label: t.exportEntries,
              color: AppColors.primary,
              onTap: () => exportEntries(context),
            ),
            const SizedBox(height: 18),
            _SideLink(
              icon: LucideIcons.trash2,
              label: t.deleteData,
              color: AppColors.danger,
              onTap: () => confirmDeleteData(context),
            ),
            const SizedBox(height: 28),
            const LanguageChoice(),
          ],
        ),
      ),
    );
  }
}

class _SideNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SideNavItem({required this.icon, required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    child: Material(
      color: selected ? AppColors.sage : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(icon, size: 18, color: selected ? AppColors.primary : AppColors.body),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: AppTheme.sans(
                    context,
                    size: 13,
                    color: selected ? AppColors.primary : AppColors.body,
                    weight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _SideLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _SideLink({required this.icon, required this.label, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 10),
          Text(label, style: AppTheme.sans(context, size: 12, color: color)),
        ],
      ),
    ),
  );
}

/// Cross-fades between pages; each page fills the available space.
class _PageSwitcher extends StatelessWidget {
  final ShellPage page;
  const _PageSwitcher({required this.page});
  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    duration: const Duration(milliseconds: 180),
    layoutBuilder: (current, previous) => Stack(fit: StackFit.expand, children: [...previous, ?current]),
    child: KeyedSubtree(key: ValueKey(page), child: _pageFor(page)),
  );
}
