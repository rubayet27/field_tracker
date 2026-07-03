import 'package:field_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;

  const BottomButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected
                ? isDark
                      ? AppColors.primaryDark
                      : AppColors.primary
                : isDark
                ? AppColors.disableDark
                : AppColors.disableLight,
            size: 23,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? isDark
                        ? AppColors.primaryDark
                        : AppColors.primary
                  : isDark
                  ? AppColors.disableDark
                  : AppColors.disableLight,
            ),
          ),
        ],
      ),
    );
  }
}
