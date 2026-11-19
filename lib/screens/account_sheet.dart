import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/app_state.dart';
import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dw.dart';
import 'goals_screen.dart';

void showAccountSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.bg,
    constraints: const BoxConstraints(maxWidth: 520),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => const _AccountSheet(),
  );
}

class _AccountSheet extends StatelessWidget {
  const _AccountSheet();

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final t = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                AvatarButton(initial: app.initial(context), onTap: () {}, size: 44),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.name(context).isEmpty ? t.myJournal : t.journalOf(app.name(context)),
                        style: AppTheme.sans(
                          context,
                          size: 15,
                          color: AppColors.ink,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(t.privateByDefault, style: AppTheme.sans(context, size: 11)),
                    ],
                  ),
                ),
              ],
            ),
            if (app.isDemo) ...[const SizedBox(height: 16), const DemoDisclosure()],
            const SizedBox(height: 16),
            _Item(icon: LucideIcons.pencil, label: t.editNickname, onTap: () => editNickname(context)),
            _Item(
              icon: LucideIcons.sprout,
              label: t.editGoals,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const GoalsScreen(editOnly: true)));
              },
            ),
            const Divider(height: 24, color: AppColors.border),
            _Item(
              icon: LucideIcons.download,
              label: t.exportEntries,
              color: AppColors.primary,
              onTap: () => exportEntries(context),
            ),
            _Item(
              icon: LucideIcons.trash2,
              label: t.deleteData,
              color: AppColors.danger,
              onTap: () => confirmDeleteData(context),
            ),
            const Divider(height: 24, color: AppColors.border),
            _Item(
              icon: LucideIcons.logOut,
              label: app.isDemo ? t.leaveDemo : t.signOut,
              onTap: () async {
                Navigator.of(context).pop();
                if (app.isDemo) {
                  app.exitDemo();
                } else {
                  await AuthService().logOut();
                }
              },
            ),
            if (app.isDemo) ...[
              const SizedBox(height: 8),
              Text(t.demoCta, style: AppTheme.sans(context, size: 11), textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  const _Item({required this.icon, required this.label, required this.onTap, this.color = AppColors.ink});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 14),
          Text(label, style: AppTheme.sans(context, size: 14, color: color)),
        ],
      ),
    ),
  );
}

Future<void> editNickname(BuildContext context) async {
  final app = context.read<AppState>();
  final t = AppLocalizations.of(context);
  final controller = TextEditingController(text: app.nickname);
  final result = await showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(t.editNickname, style: AppTheme.serif(ctx, size: 22)),
      content: DwTextField(
        label: t.nameLabel,
        hint: t.nameHint,
        controller: controller,
        onSubmitted: (v) => Navigator.pop(ctx, v),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text(t.cancel)),
        FilledButton(onPressed: () => Navigator.pop(ctx, controller.text), child: Text(t.save)),
      ],
    ),
  );
  controller.dispose();
  if (result != null && result.trim().isNotEmpty) {
    await app.setNickname(result);
  }
}

Future<void> exportEntries(BuildContext context) async {
  final app = context.read<AppState>();
  final t = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  String json;
  try {
    json = await app.exportJson();
  } catch (_) {
    messenger.showSnackBar(SnackBar(content: Text(t.errUnknown)));
    return;
  }
  if (!context.mounted) return;
  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(t.exportEntries, style: AppTheme.serif(ctx, size: 22)),
      content: SizedBox(
        width: 480,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.exportReady, style: AppTheme.sans(ctx, size: 12)),
            const SizedBox(height: 12),
            Container(
              constraints: const BoxConstraints(maxHeight: 280),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  json,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: AppColors.ink),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text(t.close)),
        FilledButton.icon(
          icon: const Icon(LucideIcons.copy, size: 16),
          label: Text(t.copyStarter),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: json));
            if (ctx.mounted) Navigator.pop(ctx);
            messenger.showSnackBar(SnackBar(content: Text(t.copied)));
          },
        ),
      ],
    ),
  );
}

Future<void> confirmDeleteData(BuildContext context) async {
  final app = context.read<AppState>();
  final t = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(t.deleteConfirmTitle, style: AppTheme.serif(ctx, size: 22)),
      content: Text(t.deleteConfirmBody, style: AppTheme.sans(ctx, size: 13, height: 1.6)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.cancel)),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(t.deleteConfirm),
        ),
      ],
    ),
  );
  if (ok != true) return;
  try {
    await app.deleteAllData();
    messenger.showSnackBar(SnackBar(content: Text(t.dataDeleted)));
  } catch (_) {
    messenger.showSnackBar(SnackBar(content: Text(t.errUnknown)));
  }
}
