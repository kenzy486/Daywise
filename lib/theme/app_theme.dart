import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // Typography
  static const double cardRadius = 24;
  static const double innerRadius = 16;
  static const double inputRadius = 18;

  // English fonts
  static final textThemeEn = GoogleFonts.interTextTheme().copyWith(
    displayLarge: GoogleFonts.newsreader(
      fontSize: 56,
      fontWeight: FontWeight.w400,
      height: 1.1,
      color: AppColors.ink,
    ),
    displayMedium: GoogleFonts.newsreader(
      fontSize: 40,
      fontWeight: FontWeight.w400,
      height: 1.1,
      color: AppColors.ink,
    ),
    displaySmall: GoogleFonts.newsreader(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.1,
      color: AppColors.ink,
    ),
    headlineMedium: GoogleFonts.newsreader(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 1.2,
      color: AppColors.ink,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.ink,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.body,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.body,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.muted,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.ink,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
      color: AppColors.primary,
    ),
  );

  // Arabic fonts
  static final textThemeAr = GoogleFonts.ibmPlexSansArabicTextTheme().copyWith(
    displayLarge: GoogleFonts.notoNaskhArabic(
      fontSize: 56,
      fontWeight: FontWeight.w400,
      height: 1.1,
      color: AppColors.ink,
    ),
    displayMedium: GoogleFonts.notoNaskhArabic(
      fontSize: 40,
      fontWeight: FontWeight.w400,
      height: 1.1,
      color: AppColors.ink,
    ),
    displaySmall: GoogleFonts.notoNaskhArabic(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.1,
      color: AppColors.ink,
    ),
    headlineMedium: GoogleFonts.notoNaskhArabic(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 1.2,
      color: AppColors.ink,
    ),
    titleLarge: GoogleFonts.ibmPlexSansArabic(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
    ),
    titleMedium: GoogleFonts.ibmPlexSansArabic(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.ink,
    ),
    bodyLarge: GoogleFonts.ibmPlexSansArabic(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.body,
    ),
    bodyMedium: GoogleFonts.ibmPlexSansArabic(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.body,
    ),
    bodySmall: GoogleFonts.ibmPlexSansArabic(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.muted,
    ),
    labelLarge: GoogleFonts.ibmPlexSansArabic(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
    ),
    labelMedium: GoogleFonts.ibmPlexSansArabic(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.ink,
    ),
    labelSmall: GoogleFonts.ibmPlexSansArabic(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
      color: AppColors.primary,
    ),
  );

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
    );

    return base.copyWith(
      textTheme: textThemeEn,
      // Will be overridden by locale-specific theme in the app
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.muted.withValues(alpha: 0.3),
          disabledForegroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(56),
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.bg,
          disabledForegroundColor: AppColors.muted,
          elevation: 0,
          minimumSize: const Size.fromHeight(56),
          side: const BorderSide(color: AppColors.border, width: 1),
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: const BorderSide(color: AppColors.danger, width: 2),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.sage,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withValues(alpha: 0.1),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      ),
    );
  }

  static ThemeData ofLocale(Locale locale) {
    if (locale.languageCode == 'ar') {
      return light.copyWith(textTheme: textThemeAr);
    }
    return light.copyWith(textTheme: textThemeEn);
  }
}
