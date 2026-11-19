import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        "DayWise supports healthy habits; it does not give medical advice.",
        style: TextStyle(
          color: AppColors.muted,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
