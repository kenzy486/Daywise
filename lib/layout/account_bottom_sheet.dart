import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class AccountBottomSheet extends StatelessWidget {
  const AccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildAccountItem(
                    icon: Icons.edit_outlined,
                    label: t.editNickname,
                    onTap: () => _showEditNicknameDialog(context, t),
                  ),
                  _buildAccountItem(
                    icon: Icons.flag_outlined,
                    label: t.editGoals,
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to onboarding
                    },
                  ),
                  _buildAccountItem(
                    icon: Icons.translate_outlined,
                    label: t.language,
                    onTap: () {
                      // Language toggle is already in the header
                    },
                  ),
                  _buildAccountItem(
                    icon: Icons.notifications_outlined,
                    label: t.dailyReminder,
                    onTap: () {},
                  ),
                  const Divider(height: 32),
                  _buildAccountItem(
                    icon: Icons.download_outlined,
                    label: t.exportEntries,
                    color: AppColors.primary,
                    onTap: () => _exportEntries(context),
                  ),
                  _buildAccountItem(
                    icon: Icons.delete_outline,
                    label: t.deleteData,
                    color: AppColors.danger,
                    onTap: () => _showDeleteDataDialog(context, t),
                  ),
                  const Divider(height: 32),
                  _buildAccountItem(
                    icon: Icons.logout,
                    label: t.signOut,
                    onTap: () => _signOut(context, t),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color ?? AppColors.ink),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: color ?? AppColors.ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.muted),
          ],
        ),
      ),
    );
  }

  void _showEditNicknameDialog(BuildContext context, AppLocalizations t) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.editNickname),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Nour',
            helperText: t.nicknameMaxChars,
          ),
          maxLength: 20,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.cancel),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final userService = UserService();
                await userService.saveProfile({'nickname': controller.text});
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.nicknameSaved)),
                  );
                }
              }
            },
            child: Text(t.save),
          ),
        ],
      ),
    );
  }

  Future<void> _exportEntries(BuildContext context) async {
    try {
      final userService = UserService();
      await userService.shareEntries();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not export entries')),
        );
      }
    }
  }

  void _showDeleteDataDialog(BuildContext context, AppLocalizations t) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.deleteData),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.deleteDataConfirm),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: t.deleteDataConfirmTyped,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: controller.text == 'DELETE' ? () async {
              try {
                final userService = UserService();
                await userService.deleteAllData();
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.dataDeleted)),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.requiresRecentLogin)),
                  );
                }
              }
            } : null,
            child: Text(t.delete),
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context, AppLocalizations t) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.signOut),
        content: Text(t.signOutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.cancel),
          ),
          FilledButton(
            onPressed: () async {
              final authService = AuthService();
              await authService.logOut();
              if (context.mounted) {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close bottom sheet
              }
            },
            child: Text(t.signOut),
          ),
        ],
      ),
    );
  }
}
