import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool showArrow;

  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.border, width: 1),
        elevation: 0,
        minimumSize: const Size.fromHeight(56),
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (showArrow) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              size: 18,
              textDirection: Directionality.of(context) == TextDirection.rtl
                  ? TextDirection.rtl
                  : TextDirection.ltr,
            ),
          ],
        ],
      ),
    );
  }
}
