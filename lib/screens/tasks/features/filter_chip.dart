import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/sizes/sizes.dart';
import 'package:flutter/material.dart';

class FilterChipButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final int index;

  const FilterChipButton({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Sizes.padding.ph20 + Sizes.padding.pv8,
        margin: Sizes.margin.mo(right: Dimensions.marginSizeHorizontal * 0.3),
        decoration: BoxDecoration(
          color: isSelected
              ? isDark
                    ? AppColors.primaryDark
                    : AppColors.primary
              : AppColors.disableDark,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextWidget(
          label,
          fontWeight: FontWeight.w600,
          color: isSelected
              ? isDark
                    ? AppColors.black
                    : AppColors.white
              : AppColors.disableLight,
        ),
      ),
    );
  }
}
