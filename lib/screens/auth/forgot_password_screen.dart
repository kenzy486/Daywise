import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../services/auth_service.dart';
import '../../services/locale_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/disclaimer.dart';
import '../../widgets/eyebrow.dart';
import '../../widgets/language_pill.dart';
import '../../widgets/logo.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_link.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final localeProvider = context.read<LocaleProvider>();
      final authService = AuthService();
      await authService.sendPasswordReset(
        _emailController.text,
        localeProvider.locale.languageCode,
      );
      setState(() {
        _successMessage = 'Check your email for a reset link.';
        _isLoading = false;
      });
    } catch (e) {
      final t = AppLocalizations.of(context);
      setState(() {
        _errorMessage = authErrorMessage(e, t);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  children: [
                    const Logo(size: 40),
                    const Spacer(),
                    const LanguagePill(),
                  ],
                ),
                const SizedBox(height: 32),

                // Eyebrow
                Eyebrow(label: 'NO WORRIES'),
                const SizedBox(height: 8),

                // Title
                Text(
                  t.resetPasswordTitle,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  t.resetPasswordInfo,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),

                // Email field
                Text(
                  t.email,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'you@example.com',
                    suffixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return t.errRequired;
                    if (!value.contains('@')) return t.errInvalidEmail;
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Error message
                if (_errorMessage != null) ...[
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: AppColors.danger, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                ],

                // Success message
                if (_successMessage != null) ...[
                  Text(
                    _successMessage!,
                    style: const TextStyle(color: AppColors.primary, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                ],

                // Send reset link button
                PrimaryButton(
                  label: t.sendResetLink,
                  onPressed: _isLoading ? null : _sendResetLink,
                  isLoading: _isLoading,
                  showArrow: true,
                ),
                const SizedBox(height: 24),

                // Back to login link
                Center(
                  child: TextLink(
                    label: t.backToLogin,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Disclaimer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
