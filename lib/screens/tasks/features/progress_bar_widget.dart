import 'package:field_tracker/core/extensions/responsive_extensions.dart';
import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/sizes/border_radius.dart';
import 'package:flutter/material.dart';

import '../../../utils/sizes/sizes.dart';

class ProgressCard extends StatelessWidget {
  final int completed;
  final int total;

  const ProgressCard({super.key, required this.completed, required this.total});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isDark ? AppColors.componentDark : AppColors.componentLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Padding(
        padding: Sizes.padding.p16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  'Today\'s progress',
                  fontSize: Dimensions.titleMedium,
                  fontWeight: FontWeight.bold,
                ),
                TextWidget(
                  '$completed of $total done',
                  color: isDark ? AppColors.primaryDark : AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.titleMedium,
                ),
              ],
            ),
            Sizes.height.h8,
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: double.infinity,
                height: 10.00.setHeight(),
                child: LinearProgressIndicator(
                  value: completed / total,
                  backgroundColor: isDark
                      ? AppColors.disableDark
                      : AppColors.disableDark,
                  valueColor: AlwaysStoppedAnimation(
                    isDark ? AppColors.primaryDark : AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
