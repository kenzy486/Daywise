import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/app_state.dart';
import '../services/auth_service.dart';
import '../services/locale_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dw.dart';

String? _validateEmail(String? v, AppLocalizations t) {
  if (v == null || v.trim().isEmpty) return t.errRequired;
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim())) return t.errInvalidEmail;
  return null;
}

/// Centered single-column layout shared by the auth screens.
class _AuthScaffold extends StatelessWidget {
  final List<Widget> children;
  final bool showBack;
  const _AuthScaffold({required this.children, this.showBack = false});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          AppHeader(
            leading: showBack
                ? IconButton(
                    tooltip: AppLocalizations.of(context).back,
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? LucideIcons.arrowRight
                          : LucideIcons.arrowLeft,
                      color: AppColors.primary,
                    ),
                  )
                : null,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: spaced(children, 22),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _PasswordToggle extends StatelessWidget {
  final bool obscured;
  final VoidCallback onTap;
  const _PasswordToggle({required this.obscured, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return IconButton(
      tooltip: obscured ? t.showPassword : t.hidePassword,
      onPressed: onTap,
      icon: Icon(obscured ? LucideIcons.eyeOff : LucideIcons.eye, size: 18),
    );
  }
}

// ───────────────────────── Welcome / sign up ─────────────────────────

class WelcomeScreen extends StatefulWidget {
  final bool firebaseReady;
  const WelcomeScreen({super.key, this.firebaseReady = true});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _agreed = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final t = AppLocalizations.of(context);
    setState(() => _error = null);
    if (!_form.currentState!.validate()) return;
    if (!_agreed) {
      setState(() => _error = t.termsRequired);
      return;
    }
    setState(() => _loading = true);
    try {
      await AuthService().signUp(_email.text, _password.text);
      // Root switches to goal onboarding once the auth state changes.
    } catch (e) {
      if (mounted) setState(() => _error = authErrorMessage(e, t));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return _AuthScaffold(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Semantics(
            image: true,
            label: t.welcomeEyebrow,
            child: Image.asset(
              'assets/images/welcome_illustration.jpg',
              height: 184,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        PageIntro(eyebrow: t.welcomeEyebrow, title: t.welcomeTitle, body: t.tagline),
        if (widget.firebaseReady)
          Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: spaced([
                DwTextField(
                  label: t.email,
                  hint: t.emailHint,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  suffix: const Icon(LucideIcons.mail, size: 18),
                  validator: (v) => _validateEmail(v, t),
                ),
                DwTextField(
                  label: t.password,
                  hint: t.passwordCreateHint,
                  controller: _password,
                  obscure: _obscure,
                  helper: t.passwordHelper,
                  autofillHints: const [AutofillHints.newPassword],
                  onSubmitted: (_) => _submit(),
                  suffix: _PasswordToggle(
                    obscured: _obscure,
                    onTap: () => setState(() => _obscure = !_obscure),
                  ),
                  validator: (v) => (v == null || v.length < 8) ? t.errWeakPassword : null,
                ),
                InkWell(
                  onTap: () => setState(() => _agreed = !_agreed),
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 44,
                        height: 44,
                        child: Checkbox(
                          value: _agreed,
                          onChanged: (v) => setState(() => _agreed = v ?? false),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(t.termsAgreement, style: AppTheme.sans(context, size: 11, height: 1.6)),
                      ),
                    ],
                  ),
                ),
                if (_error != null) ErrorNote(_error!),
                ActionButton(t.createAccount, arrow: true, loading: _loading, onPressed: _submit),
                TextAction(
                  t.haveAccount,
                  center: true,
                  weight: FontWeight.w400,
                  onTap: () =>
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignInScreen())),
                ),
              ], 16),
            ),
          ),
        DwCard(
          tone: CardTone.sage,
          radius: 14,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.lockKeyhole, size: 16, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      t.trustTitle,
                      style: AppTheme.sans(
                        context,
                        size: 12,
                        color: AppColors.primary,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              const Disclaimer(),
            ],
          ),
        ),
        TextAction(
          t.exploreDemo,
          external: true,
          center: true,
          weight: FontWeight.w400,
          onTap: () => context.read<AppState>().startDemo(),
        ),
      ],
    );
  }
}

// ───────────────────────── Sign in ─────────────────────────

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final t = AppLocalizations.of(context);
    setState(() => _error = null);
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await AuthService().logIn(_email.text, _password.text);
      if (mounted) Navigator.of(context).popUntil((r) => r.isFirst);
    } catch (e) {
      if (mounted) setState(() => _error = authErrorMessage(e, t));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return _AuthScaffold(
      showBack: true,
      children: [
        PageIntro(eyebrow: t.signInEyebrow, title: t.signInTitle, body: t.signInBody),
        Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: spaced([
              DwTextField(
                label: t.email,
                hint: t.emailHint,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.next,
                suffix: const Icon(LucideIcons.mail, size: 18),
                validator: (v) => _validateEmail(v, t),
              ),
              DwTextField(
                label: t.password,
                hint: t.passwordHint,
                controller: _password,
                obscure: _obscure,
                autofillHints: const [AutofillHints.password],
                onSubmitted: (_) => _submit(),
                suffix: _PasswordToggle(
                  obscured: _obscure,
                  onTap: () => setState(() => _obscure = !_obscure),
                ),
                validator: (v) => (v == null || v.isEmpty) ? t.errRequired : null,
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextAction(
                  t.forgotPassword,
                  weight: FontWeight.w400,
                  onTap: () => Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const ResetPasswordScreen())),
                ),
              ),
              if (_error != null) ErrorNote(_error!),
              ActionButton(t.signIn, arrow: true, loading: _loading, onPressed: _submit),
              TextAction(
                t.noAccount,
                center: true,
                weight: FontWeight.w400,
                onTap: () => Navigator.of(context).pop(),
              ),
            ], 16),
          ),
        ),
        const Disclaimer(),
      ],
    );
  }
}

// ───────────────────────── Reset password ─────────────────────────

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _loading = false;
  bool _sent = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final t = AppLocalizations.of(context);
    final lang = context.read<LocaleProvider>().locale.languageCode;
    setState(() => _error = null);
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await AuthService().sendPasswordReset(_email.text, lang);
      if (mounted) setState(() => _sent = true);
    } catch (e) {
      // Don't reveal whether an account exists; only surface network-type errors.
      final msg = authErrorMessage(e, t);
      if (mounted) {
        setState(() => msg == t.errWrongCredentials ? _sent = true : _error = msg);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return _AuthScaffold(
      showBack: true,
      children: [
        PageIntro(eyebrow: t.resetEyebrow, title: t.resetTitle, body: t.resetBody),
        if (_sent)
          DwCard(
            tone: CardTone.sage,
            child: Row(
              children: [
                const Icon(LucideIcons.mail, color: AppColors.primary, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    t.resetEmailSent,
                    style: AppTheme.sans(context, size: 13, color: AppColors.ink, height: 1.6),
                  ),
                ),
              ],
            ),
          )
        else
          Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: spaced([
                DwTextField(
                  label: t.email,
                  hint: t.emailHint,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  onSubmitted: (_) => _submit(),
                  suffix: const Icon(LucideIcons.mail, size: 18),
                  validator: (v) => _validateEmail(v, t),
                ),
                if (_error != null) ErrorNote(_error!),
                ActionButton(t.sendResetLink, loading: _loading, onPressed: _submit),
              ], 16),
            ),
          ),
        TextAction(
          t.backToSignIn,
          center: true,
          weight: FontWeight.w400,
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
