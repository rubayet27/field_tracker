import 'package:flutter/material.dart';

import '../../../core/extensions/routes_extensions.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../routes/routes_list.dart';
import '../../../utils/app_colors.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget("Already have an account?"),
        GestureDetector(
          onTap: () {
            Routes.login.push();
          },
          child: TextWidget(
            " Sign in",
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.primaryDark : AppColors.primary,
          ),
        ),
      ],
    );
  }
}
