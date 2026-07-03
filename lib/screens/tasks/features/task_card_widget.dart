import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/sizes/border_radius.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/sizes/sizes.dart';
import '../model/task_model.dart';

class TaskCard extends StatelessWidget {
  final Datum task;
  final ValueChanged<bool>? onCheckboxChanged;

  const TaskCard({super.key, required this.task, this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final statusColor = task.isCompleted == true
        ? AppColors.success
        : AppColors.warning;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDark
          ? AppColors.componentDark
          : task.isCompleted
          ? AppColors.disableDark
          : AppColors.componentLight,
      child: Padding(
        padding: Sizes.padding.p10,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.3,
              child: Checkbox(
                value: task.isCompleted,
                onChanged: (value) => onCheckboxChanged?.call(value ?? false),
                activeColor: AppColors.success,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm * 0.5),
                ),
              ),
            ),
            Sizes.width.w12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isCompleted ? Colors.grey[600] : Colors.black,
                    ),
                  ),
                  Sizes.height.h8,
                  TextWidget(task.description, maxLines: 2),
                  Sizes.height.h8,
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      Sizes.width.w8,
                      TextWidget(formatTime(task.dueAt)),
                      Sizes.width.w16,
                      Container(
                        padding: Sizes.padding.ph8 + Sizes.padding.pv8 * 0.3,
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: TextWidget(
                          formatStatus(task.isCompleted),
                          fontSize: Dimensions.labelMedium,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  String formatStatus(bool status) {
    if (status) {
      return "Completed";
    }
    return "Pending";
  }
}
