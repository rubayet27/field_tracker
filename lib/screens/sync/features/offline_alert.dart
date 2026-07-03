import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../utils/sizes/sizes.dart';

class OfflineAlert extends StatelessWidget {
  const OfflineAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Sizes.padding.p12,
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.wifi_off_rounded,
            color: AppColors.warning,
            size: Dimensions.iconXl,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "Youre Offline",
                  fontSize: Dimensions.titleMedium,
                  fontWeight: FontWeight.w600,
                  color: AppColors.warning,
                ),

                TextWidget(
                  "Changes are saved on this device",
                  fontSize: Dimensions.bodyMedium,
                  color: AppColors.disableLight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
