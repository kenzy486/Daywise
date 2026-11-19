import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo({super.key, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.eco_outlined,
            color: Colors.white,
            size: size * 0.5,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'DayWise',
          style: GoogleFonts.newsreader(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            color: AppColors.ink,
          ),
        ),
      ],
    );
  }
}
