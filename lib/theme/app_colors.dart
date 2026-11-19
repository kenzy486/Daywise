import 'package:flutter/material.dart';

/// Design tokens taken from the DayWise Figma file.
class AppColors {
  // Paper, surfaces and lines
  static const Color bg = Color(0xFFF8F7F1);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFDCE3D9);

  // Brand + text
  static const Color primary = Color(0xFF246653);
  static const Color ink = Color(0xFF193E36);
  static const Color body = Color(0xFF596B63);

  // Tinted surfaces
  static const Color sage = Color(0xFFE6EEE1); // well-being card, selected nav
  static const Color sageLight = Color(0xFFEFF4ED); // rating tiles, steppers
  static const Color mint = Color(0xFFD6E9D9); // pattern / best days
  static const Color sand = Color(0xFFF0EBDD); // demo note, tiny action
  static const Color avatar = Color(0xFFF1DFA0);

  // Charts
  static const Color chartMood = Color(0xFF2F6F58);
  static const Color chartEnergy = Color(0xFF9A6F1E);
  static const Color chartStress = Color(0xFFA8574A);
  static const Color sleepBar = Color(0xFF63829B);
  static const Color activityBar = primary;

  // Danger / urgent
  static const Color danger = Color(0xFFB4664E);
}
