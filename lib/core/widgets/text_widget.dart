import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    super.key,
    this.textAlign,
    this.textOverflow,
    this.padding = EdgeInsets.zero,
    this.opacity = 1.0,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.style,
    this.onTap,
  });

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final EdgeInsetsGeometry padding;
  final double opacity;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextStyle? style;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Default color based on dark/light mode
    final defaultColor = color ?? (isDarkMode ? Colors.white : Colors.black87);

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Opacity(
        opacity: opacity,
        child: Padding(
          padding: padding,
          child: Text(
            text,
            style:
                style?.copyWith(
                  color: defaultColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ) ??
                TextStyle(
                  color: defaultColor,
                  fontSize: fontSize ?? 14,
                  fontWeight: fontWeight ?? FontWeight.w400,
                ),
            textAlign: textAlign,
            overflow: textOverflow,
            maxLines: maxLines,
          ),
        ),
      ),
    );
  }
}
