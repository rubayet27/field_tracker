import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/screens/sync/model/pending_todo_change.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/sizes/border_radius.dart';
import '../../../utils/sizes/sizes.dart';

class SyncItemCard extends StatelessWidget {
  final PendingTodoChange item;

  const SyncItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDark ? AppColors.componentDark : AppColors.componentLight,
      child: Padding(
        padding: Sizes.padding.p16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: Sizes.padding.p10,
              decoration: BoxDecoration(
                color: isDark ? AppColors.disableLight : AppColors.disableDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.sync,
                color: !isDark ? AppColors.disableLight : AppColors.disableDark,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.isCompleted ? "Checked" : "Unchecked"} · ${_formatTime(item.changedAt)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Container(
              padding: Sizes.padding.ph8 + Sizes.padding.pv8 * 0.3,
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: TextWidget(
                "Pending",
                fontSize: Dimensions.labelMedium,
                fontWeight: FontWeight.bold,
                color: AppColors.warning,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }
}
