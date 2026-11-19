import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum StatusType { pending, done }

class StatusChip extends StatelessWidget {
  final String label;
  final StatusType type;

  const StatusChip({
    super.key,
    required this.label,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = type == StatusType.pending ? AppColors.sand : AppColors.sage;
    final textColor = type == StatusType.pending ? AppColors.ink : AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (type == StatusType.done) ...[
            const Icon(Icons.check, size: 14, color: AppColors.primary),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
