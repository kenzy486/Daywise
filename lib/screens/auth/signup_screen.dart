import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../services/auth_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/disclaimer.dart';
import '../../widgets/eyebrow.dart';
import '../../widgets/language_pill.dart';
import '../../widgets/logo.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';
import '../../widgets/text_link.dart';
import '../../widgets/sage_card.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _agreeToTerms = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate() || !_agreeToTerms) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = AuthService();
      await authService.signUp(_emailController.text, _passwordController.text);
      if (mounted) {
        // AuthGate will handle navigation
      }
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
    final isFormValid = _emailController.text.isNotEmpty &&
        _passwordController.text.length >= 8 &&
        _agreeToTerms;

    return Scaffold(
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

                // Illustration card
                _buildIllustrationCard(),
                const SizedBox(height: 32),

                // Eyebrow
                Eyebrow(label: t.signupSubtitle),
                const SizedBox(height: 8),

                // Title
                Text(
                  t.signupInfo,
                  style: Theme.of(context).textTheme.displayMedium,
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

                // Password field
                Text(
                  t.password,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Create a password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return t.errRequired;
                    if (value.length < 8) return t.errWeakPassword;
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'Use at least 8 characters.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 20),

                // Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (value) => setState(() => _agreeToTerms = value ?? false),
                      activeColor: AppColors.primary,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _agreeToTerms = !_agreeToTerms),
                        child: Text.rich(
                          TextSpan(
                            text: 'I agree to the ',
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              WidgetSpan(
                                child: TextLink(
                                  label: 'Terms',
                                  onTap: () => _showTerms(context),
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              WidgetSpan(
                                child: TextLink(
                                  label: 'Privacy Policy',
                                  onTap: () => _showPrivacy(context),
                                ),
                              ),
                              const TextSpan(text: '. My journal stays private by default.'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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

                // Sign up button
                PrimaryButton(
                  label: t.signup,
                  onPressed: isFormValid && !_isLoading ? _signup : null,
                  isLoading: _isLoading,
                  showArrow: true,
                ),
                const SizedBox(height: 24),

                // Login link
                Center(
                  child: TextLink(
                    label: t.haveAccount,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Info box
                SageCard(
                  child: Row(
                    children: [
                      const Icon(Icons.lock_outline, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'No real name. No wearable. No pressure.',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              t.notMedicalAdvice,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Demo link
                Center(
                  child: TextLink(
                    label: 'Just looking? Explore Nour\'s demo',
                    external: true,
                    onTap: () {
                      // TODO: Navigate to demo mode
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

  Widget _buildIllustrationCard() {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.sage, AppColors.sand],
        ),
      ),
      child: const Center(
        child: Icon(Icons.eco_outlined, size: 80, color: AppColors.primary),
      ),
    );
  }

  void _showTerms(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const SingleChildScrollView(
          child: Text(
            'By using DayWise, you agree to these terms:\n\n'
            '1. DayWise is a wellness journal, not a medical service.\n'
            '2. Your data is stored securely and privately.\n'
            '3. You can export or delete your data at any time.\n'
            '4. We do not sell your personal information.\n'
            '5. DayWise is provided as-is without warranties.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPrivacy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Your privacy is important to us:\n\n'
            '1. We collect only the data you provide.\n'
            '2. Your data is encrypted and stored securely.\n'
            '3. You have full control over your data.\n'
            '4. We do not share your data with third parties.\n'
            '5. You can request deletion of all your data at any time.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
