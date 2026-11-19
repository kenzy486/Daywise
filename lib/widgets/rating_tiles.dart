import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class RatingTiles extends StatelessWidget {
  final int value;
  final int count;
  final ValueChanged<int> onChanged;
  final List<String>? labels;
  final bool showIcons;

  const RatingTiles({
    super.key,
    required this.value,
    required this.count,
    required this.onChanged,
    this.labels,
    this.showIcons = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            count,
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < count - 1 ? 8 : 0,
                ),
                child: _buildTile(index + 1),
              ),
            ),
          ),
        ),
        if (labels != null && labels!.length >= 2) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  labels![0],
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: Text(
                  labels![1],
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildTile(int number) {
    final isSelected = value == number;
    return InkWell(
      onTap: () => onChanged(number),
      borderRadius: BorderRadius.circular(AppTheme.innerRadius),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.sage,
          borderRadius: BorderRadius.circular(AppTheme.innerRadius),
        ),
        child: Center(
          child: showIcons
              ? _getFaceIcon(number, isSelected)
              : Text(
                  number.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.muted,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _getFaceIcon(int number, bool isSelected) {
    IconData icon;
    switch (number) {
      case 1:
        icon = Icons.sentiment_very_dissatisfied;
        break;
      case 2:
        icon = Icons.sentiment_dissatisfied;
        break;
      case 3:
        icon = Icons.sentiment_neutral;
        break;
      case 4:
        icon = Icons.sentiment_satisfied;
        break;
      case 5:
        icon = Icons.sentiment_very_satisfied;
        break;
      default:
        icon = Icons.sentiment_neutral;
    }
    return Icon(icon, color: isSelected ? Colors.white : AppColors.muted, size: 28);
  }
}
