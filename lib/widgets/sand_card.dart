import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class SandCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool showDangerBorder;

  const SandCard({
    super.key,
    required this.child,
    this.padding,
    this.showDangerBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.sand,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: showDangerBorder
            ? Border.all(color: AppColors.danger, width: 1)
            : null,
      ),
      child: child,
    );
  }
}
