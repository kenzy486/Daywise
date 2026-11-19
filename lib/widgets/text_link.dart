import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class TextLink extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool external;

  const TextLink({
    super.key,
    required this.label,
    this.onTap,
    this.external = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            external ? Icons.open_in_new : Icons.arrow_forward,
            size: 16,
            color: AppColors.primary,
            textDirection: Directionality.of(context) == TextDirection.rtl
                ? TextDirection.rtl
                : TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}
