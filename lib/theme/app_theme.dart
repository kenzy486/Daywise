import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography and shapes from the DayWise Figma file.
/// English: Lora (serif headings) + Inter (UI text).
/// Arabic: IBM Plex Sans Arabic for both.
class AppTheme {
  static const double cardRadius = 20;
  static const double tileRadius = 12;

  static bool isArabic(BuildContext context) => Localizations.localeOf(context).languageCode == 'ar';

  /// Serif display font (Lora) — Arabic falls back to IBM Plex Sans Arabic.
  static TextStyle serif(
    BuildContext context, {
    double size = 23,
    Color color = AppColors.ink,
    double height = 1.25,
  }) {
    if (isArabic(context)) {
      return GoogleFonts.ibmPlexSansArabic(
        fontSize: size,
        color: color,
        height: height + 0.1,
        fontWeight: FontWeight.w400,
      );
    }
    return GoogleFonts.lora(fontSize: size, color: color, height: height, fontWeight: FontWeight.w400);
  }

  /// Sans UI font (Inter / IBM Plex Sans Arabic).
  static TextStyle sans(
    BuildContext context, {
    double size = 13,
    Color color = AppColors.body,
    FontWeight weight = FontWeight.w400,
    double? height,
    double? letterSpacing,
  }) {
    final ar = isArabic(context);
    // Arabic glyphs read smaller, so nudge them up one point.
    final s = ar ? size + 1 : size;
    final w = ar && weight == FontWeight.w600 ? FontWeight.w700 : weight;
    final base = ar ? GoogleFonts.ibmPlexSansArabic() : GoogleFonts.inter();
    return base.copyWith(
      fontSize: s,
      color: color,
      fontWeight: w,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static ThemeData ofLocale(Locale locale) {
    final ar = locale.languageCode == 'ar';
    final textTheme = ar ? GoogleFonts.ibmPlexSansArabicTextTheme() : GoogleFonts.interTextTheme();
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.bg,
        onSurface: AppColors.ink,
      ),
      textTheme: textTheme.apply(bodyColor: AppColors.ink, displayColor: AppColors.ink),
      splashFactory: InkSparkle.splashFactory,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.ink,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.border,
        thumbColor: AppColors.surface,
        trackHeight: 6,
        overlayColor: Color(0x22246653),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 11, elevation: 1),
        showValueIndicator: ShowValueIndicator.never,
        tickMarkShape: SliderTickMarkShape.noTickMark,
      ),
      checkboxTheme: CheckboxThemeData(
        side: const BorderSide(color: AppColors.primary, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? AppColors.primary : Colors.transparent,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardRadius)),
      ),
    );
  }
}
