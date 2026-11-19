import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../services/locale_provider.dart';
import '../../services/onboarding_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/disclaimer.dart';
import '../../widgets/eyebrow.dart';
import '../../widgets/language_pill.dart';
import '../../widgets/logo.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';
import '../../widgets/text_link.dart';
import '../../widgets/section_card.dart';
import '../../widgets/sage_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 1;
  final Set<String> _selectedGoals = {};
  final _nicknameController = TextEditingController();
  final _cityController = TextEditingController(text: 'Cairo');
  final _workplaceController = TextEditingController();
  bool _reminderEnabled = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    _cityController.dispose();
    _workplaceController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    // Save goals and user profile
    await OnboardingService.markSeen();
    // TODO: Save to Firestore
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
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

              // Progress bar
              _buildProgressBar(),
              const SizedBox(height: 24),

              if (_step == 1) _buildStep1(t) else _buildStep2(t),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.sage,
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        widthFactor: _step == 1 ? 0.5 : 1.0,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildStep1(AppLocalizations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Eyebrow
        Eyebrow(label: '${t.onboardingTitle} · ${t.onboardingStep1}'),
        const SizedBox(height: 8),

        // Title
        Text(
          t.onboardingGoalsTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 8),

        // Subtitle
        Text(
          t.onboardingGoalsSubtitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),

        // Selected count
        Text(
          t.onboardingGoalsSelected.replaceAll('{count}', _selectedGoals.length.toString()),
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),

        // Goal options
        _buildGoalOption(
          icon: Icons.bedtime_outlined,
          title: t.onboardingGoalSleep,
          subtitle: t.onboardingGoalSleepDesc,
          value: 'sleep',
        ),
        const SizedBox(height: 12),
        _buildGoalOption(
          icon: Icons.air_outlined,
          title: t.onboardingGoalStress,
          subtitle: t.onboardingGoalStressDesc,
          value: 'stress',
        ),
        const SizedBox(height: 12),
        _buildGoalOption(
          icon: Icons.wb_sunny_outlined,
          title: t.onboardingGoalEnergy,
          subtitle: t.onboardingGoalEnergyDesc,
          value: 'energy',
        ),
        const SizedBox(height: 12),
        _buildGoalOption(
          icon: Icons.directions_walk_outlined,
          title: t.onboardingGoalActivity,
          subtitle: t.onboardingGoalActivityDesc,
          value: 'activity',
        ),
        const SizedBox(height: 12),
        _buildGoalOption(
          icon: Icons.restaurant_outlined,
          title: t.onboardingGoalNutrition,
          subtitle: t.onboardingGoalNutritionDesc,
          value: 'nutrition',
        ),
        const SizedBox(height: 24),

        // Note
        Text(
          t.onboardingGoalsNote,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),

        // Continue button
        PrimaryButton(
          label: t.onboardingContinue,
          onPressed: _selectedGoals.isNotEmpty ? () => setState(() => _step = 2) : null,
          showArrow: true,
        ),
        const SizedBox(height: 16),

        // Decide later link
        Center(
          child: TextLink(
            label: t.onboardingDecideLater,
            onTap: () => setState(() => _step = 2),
          ),
        ),
        const SizedBox(height: 16),
        const Disclaimer(),
      ],
    );
  }

  Widget _buildGoalOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    final isSelected = _selectedGoals.contains(value);
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedGoals.remove(value);
          } else {
            _selectedGoals.add(value);
          }
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.sage : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2(AppLocalizations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Eyebrow
        Eyebrow(label: '${t.onboardingTitle} · ${t.onboardingStep2}'),
        const SizedBox(height: 8),

        // Title
        Text(
          t.onboardingNicknameTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 32),

        // Nickname field
        Text(
          t.onboardingNicknameHelper,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _nicknameController,
          decoration: InputDecoration(
            hintText: 'Nour',
          ),
          maxLength: 20,
        ),
        const SizedBox(height: 20),

        // City field
        Text(
          t.onboardingCity,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _cityController,
          decoration: InputDecoration(
            hintText: t.onboardingCityHelper,
          ),
        ),
        const SizedBox(height: 20),

        // Workplace field
        Text(
          t.onboardingWorkplace,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _workplaceController,
          decoration: const InputDecoration(
            hintText: 'Optional',
          ),
        ),
        const SizedBox(height: 20),

        // Reminder toggle
        Row(
          children: [
            Switch(
              value: _reminderEnabled,
              onChanged: (value) => setState(() => _reminderEnabled = value),
              activeColor: AppColors.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                t.onboardingReminder,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Start button
        PrimaryButton(
          label: t.onboardingStart,
          onPressed: _completeOnboarding,
          showArrow: true,
        ),
        const SizedBox(height: 16),

        // Skip link
        Center(
          child: TextLink(
            label: t.onboardingSkip,
            onTap: _completeOnboarding,
          ),
        ),
        const SizedBox(height: 16),
        const Disclaimer(),
      ],
    );
  }
}
