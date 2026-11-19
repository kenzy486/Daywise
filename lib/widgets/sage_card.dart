import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class SageCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool showBorder;

  const SageCard({
    super.key,
    required this.child,
    this.padding,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.sage,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: showBorder
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
      ),
      child: child,
    );
  }
}
