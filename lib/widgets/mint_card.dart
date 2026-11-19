import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class MintCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const MintCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.mint,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
      ),
      child: child,
    );
  }
}
