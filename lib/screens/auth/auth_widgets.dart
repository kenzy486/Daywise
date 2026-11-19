import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../services/locale_provider.dart';

// Page layout shared by Log in, Sign up and Forgot password
class AuthScaffold extends StatelessWidget {
  final Widget child;
  const AuthScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [LanguageButton()],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView( // scrolls on small phones / when keyboard opens
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420), // not too wide in Chrome
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

// Logo + app name + subtitle
class AuthHeader extends StatelessWidget {
  final String subtitle;
  const AuthHeader({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(Icons.spa_outlined, size: 64, color: theme.colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          t.appTitle,
          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}

// Password box with show/hide button
class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.onSubmitted,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidden = true; // start hidden (dots)

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _hidden,
      textDirection: TextDirection.ltr, // passwords are typed left-to-right, even in Arabic
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(_hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: () => setState(() => _hidden = !_hidden),
        ),
      ),
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}

// Small button: switch language
class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final localeProvider = context.read<LocaleProvider>();
    return TextButton.icon(
      onPressed: () => localeProvider.setLocale(localeProvider.isArabic ? 'en' : 'ar'),
      icon: const Icon(Icons.language),
      label: Text(t.switchLanguage),
    );
  }
}

// Form checks: return null = OK, or a message = problem
class AuthValidators {
  static String? required(String? value, AppLocalizations t) {
    if (value == null || value.trim().isEmpty) return t.errRequired;
    return null;
  }

  static String? email(String? value, AppLocalizations t) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return t.errRequired;
    // simple check: something@something.something
    final valid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
    return valid ? null : t.errInvalidEmail;
  }

  static String? newPassword(String? value, AppLocalizations t) {
    if (value == null || value.isEmpty) return t.errRequired;
    if (value.length < 6) return t.errWeakPassword; // Firebase needs 6+ characters
    return null;
  }
}