import 'package:field_tracker/core/extensions/routes_extensions.dart';
import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/routes/routes_list.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class RegisterTextWidget extends StatelessWidget {
  const RegisterTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget("Don't have an account?"),
        GestureDetector(
          onTap: () {
            Routes.registration.push();
          },
          child: TextWidget(
            " Register",
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.primaryDark : AppColors.primary,
          ),
        ),
      ],
    );
  }
}
