import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/sizes/border_radius.dart';
import 'package:flutter/material.dart';

import '../../../utils/sizes/sizes.dart';
import 'card_widget.dart';

class MenuOptions extends StatelessWidget {
  const MenuOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 2,

      color: isDark ? AppColors.componentDark : AppColors.componentLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Padding(
        padding: Sizes.padding.ph12 + Sizes.padding.pv12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CardWidget(
              icon: Icons.person_outline,
              title: 'Edit profile',
              onTap: () {},
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            CardWidget(
              icon: Icons.notifications_none,
              title: 'Notifications',
              onTap: () {},
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            CardWidget(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            CardWidget(
              icon: Icons.help_outline,
              title: 'Help & support',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
