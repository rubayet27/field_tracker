import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? borderColor;
  final double borderWidth;
  final double? borderRadius;
  final double? height;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final OutlinedBorder? shape;
  final Widget? icon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isLoading;
  final bool primary;
  final bool disable;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderColor,
    this.borderWidth = 0,
    this.height,
    this.buttonColor,
    this.buttonTextColor,
    this.shape,
    this.icon,
    this.fontSize,
    this.fontWeight,
    this.isLoading = false,
    this.primary = false,
    this.disable = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return isLoading
        ? const Center(
            child: SizedBox(
              height: 48,
              width: 48,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          )
        : GestureDetector(
            onTapDown: (_) {}, // Optional: can be used for further animation
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: height ?? 52,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: disable ? null : onPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: disable
                      ? Colors.grey.shade400
                      : buttonColor ?? theme.primaryColor,
                  foregroundColor: buttonTextColor ?? Colors.white,
                  side: BorderSide(
                    width: borderWidth,
                    color: disable
                        ? Colors.grey.shade400
                        : borderColor ?? theme.primaryColor,
                  ),
                  shape:
                      shape ??
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 12),
                      ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, const SizedBox(width: 8)],
                    Flexible(
                      child: TextWidget(
                        title,
                        fontSize: fontSize ?? 16,
                        fontWeight: fontWeight ?? FontWeight.w500,
                        color:
                            buttonTextColor ??
                            (isDarkMode ? AppColors.black : AppColors.white),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
