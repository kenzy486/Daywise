import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class StepperRow extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final int step;
  final String unit;
  final String? helper;
  final ValueChanged<int> onChanged;

  const StepperRow({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    required this.unit,
    this.helper,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildButton(
              icon: Icons.remove,
              onPressed: value > min ? () => onChanged(value - step) : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    value.toString(),
                    style: GoogleFonts.newsreader(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: AppColors.ink,
                    ),
                  ),
                  if (unit != null)
                    Text(
                      unit!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            _buildButton(
              icon: Icons.add,
              onPressed: value < max ? () => onChanged(value + step) : null,
            ),
          ],
        ),
        if (helper != null) ...[
          const SizedBox(height: 8),
          Text(
            helper!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }

  Widget _buildButton({required IconData icon, VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: onPressed == null ? AppColors.sage : AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: onPressed == null ? AppColors.muted : Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
