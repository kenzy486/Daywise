import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool showArrow;
  final bool isLoading;
  final Widget? trailing;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.showArrow = false,
    this.isLoading = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.muted.withValues(alpha: 0.3),
        elevation: 0,
        minimumSize: const Size.fromHeight(56),
        shape: const StadiumBorder(),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Row(
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
                if (trailing != null) trailing!,
              ],
            ),
    );
  }
}
