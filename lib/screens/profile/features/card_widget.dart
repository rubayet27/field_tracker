import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/sizes/border_radius.dart';
import 'package:flutter/material.dart';

import '../../../utils/sizes/sizes.dart';

class CardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const CardWidget({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Container(
              padding: Sizes.padding.p10,
              decoration: BoxDecoration(
                color: !isDark ? AppColors.disableDark : AppColors.disableLight,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(
                icon,
                size: Dimensions.iconMd,
                color: !isDark ? AppColors.disableLight : AppColors.disableDark,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(child: TextWidget(title, fontSize: 16.0)),
            Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
