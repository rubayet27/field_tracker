import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:flutter/material.dart';

class PendingChangesCard extends StatelessWidget {
  final int count;
  final String lastSyncTime;

  const PendingChangesCard({
    super.key,
    required this.count,
    required this.lastSyncTime,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDark ? AppColors.componentDark : AppColors.componentLight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : AppColors.primaryDark.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.sync,
                color: isDark ? AppColors.primaryDark : AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    '$count changes pending',
                    fontSize: Dimensions.titleMedium * 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                  TextWidget(
                    'Last synced today, $lastSyncTime',
                    fontSize: Dimensions.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
