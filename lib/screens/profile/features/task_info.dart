import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/sizes/border_radius.dart';
import '../../../utils/sizes/sizes.dart';

class TaskInfo extends StatelessWidget {
  const TaskInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _cardWidget(context, data: "1/5", details: "Tasks done today"),
        ),
        Sizes.width.w16,
        Expanded(
          child: _cardWidget(context, data: "3", details: "Active locations"),
        ),
      ],
    );
  }

  Card _cardWidget(BuildContext context, {String? data, String? details}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      color: isDark ? AppColors.componentDark : AppColors.componentLight,
      child: Padding(
        padding: Sizes.padding.ph16 + Sizes.padding.pv12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              data ?? "",
              fontSize: Dimensions.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            TextWidget(
              details ?? "",
              fontSize: Dimensions.labelMedium,
              color: !isDark ? AppColors.black : AppColors.disableDark,
            ),
          ],
        ),
      ),
    );
  }
}
