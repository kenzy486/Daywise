import 'package:flutter/material.dart';
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
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = AuthService();
      await authService.logIn(_emailController.text, _passwordController.text);
      // AuthGate will handle navigation
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
                Eyebrow(label: 'WELCOME BACK'),
                const SizedBox(height: 8),

                // Title
                Text(
                  t.loginSubtitle,
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
                    hintText: 'Your password',
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
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                // Forgot password link
                Align(
                  alignment: Alignment.end,
                  child: TextLink(
                    label: t.forgotPassword,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                      );
                    },
                  ),
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

                // Login button
                PrimaryButton(
                  label: t.login,
                  onPressed: _isLoading ? null : _login,
                  isLoading: _isLoading,
                  showArrow: true,
                ),
                const SizedBox(height: 24),

                // Sign up link
                Center(
                  child: TextLink(
                    label: t.noAccount,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
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
}
