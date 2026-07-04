import 'package:field_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Border Side Style Enum
enum BSS {
  enabledBorder,
  b,
  disableBorder,
  focusedBorder,
  errorBorder,
  focusedErrorBorder,
}

enum BorderStyle { outline, underline, none }

class PrimaryInputWidget extends StatefulWidget {
  final String hintText;
  final String phoneCode;
  final String? label;
  final String? optionalText;
  final String? prefixIconPath;
  final int maxLines;
  final bool isValidator;
  final bool isPasswordField;
  final bool autoFocus;
  final bool readOnly;
  final bool outerLabel;
  final bool isFilled;
  final bool showBorderSide;
  final bool showShape;
  final bool skipEnterText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? padding;
  final double? radius;
  final double borderWidth;
  final Color? fillColor;
  final Color? shadowColor;
  final Function(String)? onChanged;
  final Decoration? customShapeDecoration;
  final EdgeInsetsGeometry? customPadding;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final AlignmentGeometry? alignment;
  final EdgeInsets? suffixIconPadding;
  final BorderStyle borderStyle;
  final TextStyle? labelTextStyle;
  final String? Function(String?)? validatorFunction;

  const PrimaryInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIconPath = "",
    this.phoneCode = "",
    this.isValidator = true,
    this.isPasswordField = false,
    this.isFilled = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.skipEnterText = false,
    this.showShape = true,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.borderWidth = 1.0,
    this.radius,
    this.customPadding,
    this.padding,
    this.label,
    this.optionalText,
    this.textInputType,
    this.inputFormatters,
    this.alignment,
    this.shadowColor,
    this.borderStyle = BorderStyle.outline,
    this.fillColor,
    this.validatorFunction,
    this.showBorderSide = true,
    this.customShapeDecoration,
    this.onChanged,
    this.suffixIconPadding,
    this.labelTextStyle,
    this.outerLabel = false,
  });

  @override
  State<PrimaryInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<PrimaryInputWidget> {
  late FocusNode focusNode;
  bool isVisibility = true;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment!,
            child: _buildTextFormFieldWidget(context),
          )
        : _buildTextFormFieldWidget(context);
  }

  Widget _buildTextFormFieldWidget(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.outerLabel) _buildTitle(context),
        TextFormField(
          readOnly: widget.readOnly,
          controller: widget.controller,
          focusNode: focusNode,
          autofocus: widget.autoFocus,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: isDark ? AppColors.white : AppColors.black,
          ),
          inputFormatters: widget.inputFormatters,
          obscureText: widget.isPasswordField ? isVisibility : false,
          textInputAction: TextInputAction.next,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines,
          decoration: _buildDecoration(context),
          validator: widget.validatorFunction ?? _setValidator,
          cursorColor: isDark ? AppColors.white : AppColors.black,
          onChanged: widget.onChanged,
          onTap: () {
            if (!widget.readOnly) {
              focusNode.unfocus();
              focusNode.requestFocus();
            }
          },
          onFieldSubmitted: (_) => focusNode.unfocus(),
          onEditingComplete: () => focusNode.unfocus(),
          onTapOutside: (_) => focusNode.unfocus(),
        ),
      ],
    );
  }

  InputDecoration _buildDecoration(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InputDecoration(
      hintText: widget.skipEnterText
          ? widget.hintText
          : "Enter ${widget.hintText}",
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: isDarkMode ? Colors.grey[400] : const Color(0xff6C6E7C),
      ),
      label: _buildLabel(context),
      alignLabelWithHint: true,
      border: _setBorderStyle(BSS.b, context),
      enabledBorder: _setBorderStyle(BSS.enabledBorder, context),
      focusedBorder: _setBorderStyle(BSS.focusedBorder, context),
      disabledBorder: _setBorderStyle(BSS.disableBorder, context),
      errorBorder: _setBorderStyle(BSS.errorBorder, context),
      focusedErrorBorder: _setBorderStyle(BSS.focusedErrorBorder, context),
      prefixIcon: _setPrefixIcon(context),
      fillColor: widget.fillColor ?? Theme.of(context).colorScheme.surface,
      filled: widget.isFilled,
      isDense: true,
      contentPadding:
          widget.customPadding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      suffixIcon: _setSuffixIcon(context),
    );
  }

  Widget? _buildLabel(BuildContext context) {
    if (widget.outerLabel) return null;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Text(
      focusNode.hasFocus
          ? (widget.label ?? "")
          : widget.readOnly
          ? widget.label ?? ""
          : widget.skipEnterText
          ? widget.hintText
          : "Enter ${widget.hintText}",
      style: focusNode.hasFocus
          ? (widget.labelTextStyle ??
                TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                ))
          : TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.grey[300] : const Color(0xff949595),
            ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (widget.label == null) return const SizedBox.shrink();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label!,
            style:
                widget.labelTextStyle ??
                TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
          ),
          if (widget.optionalText?.isNotEmpty == true) ...[
            const SizedBox(width: 6),
            Text(
              widget.optionalText!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isDarkMode ? Colors.grey[400] : Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }

  BorderSide _setBorderSide(BSS borderSideStyle, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    switch (borderSideStyle) {
      case BSS.enabledBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: isDarkMode ? AppColors.disableDark : AppColors.disableLight,
        );
      case BSS.b:
      case BSS.disableBorder:
        return BorderSide(width: widget.borderWidth, color: Colors.transparent);
      case BSS.focusedBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: isDarkMode ? AppColors.primaryDark : AppColors.primary,
        );
      case BSS.errorBorder:
      case BSS.focusedErrorBorder:
        return BorderSide(width: widget.borderWidth, color: Colors.red);
    }
  }

  InputBorder _setBorderStyle(BSS borderSideStyle, BuildContext context) {
    final borderSide = widget.showBorderSide
        ? _setBorderSide(borderSideStyle, context)
        : BorderSide.none;

    final radius = widget.radius ?? 12.0;

    switch (widget.borderStyle) {
      case BorderStyle.outline:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: borderSide,
        );
      case BorderStyle.underline:
        return UnderlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: borderSide,
        );
      case BorderStyle.none:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: borderSide,
        );
    }
  }

  Widget? _setPrefixIcon(BuildContext context) {
    if (widget.prefixIcon != null) return widget.prefixIcon;
    if (widget.prefixIconPath!.isEmpty) return null;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            widget.prefixIconPath!,
            height: 24,
            width: 24,
            color: focusNode.hasFocus || widget.controller.text.isNotEmpty
                ? Theme.of(context).primaryColor
                : isDarkMode
                ? Colors.white
                : Colors.grey,
          ),
          if (widget.phoneCode.isNotEmpty) ...[
            const SizedBox(width: 6),
            Text(
              widget.phoneCode,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: focusNode.hasFocus
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              height: 24,
              width: 1,
              color: focusNode.hasFocus
                  ? Theme.of(context).primaryColor
                  : Colors.grey.withOpacity(0.3),
            ),
          ],
        ],
      ),
    );
  }

  Widget? _setSuffixIcon(BuildContext context) {
    if (widget.suffixIcon != null) return widget.suffixIcon;
    if (!widget.isPasswordField) return null;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      icon: Icon(
        isVisibility ? Icons.visibility_off : Icons.visibility,
        color: focusNode.hasFocus
            ? Theme.of(context).primaryColor
            : isDarkMode
            ? Colors.white.withOpacity(0.6)
            : Colors.grey,
        size: 22,
      ),
      onPressed: () {
        setState(() => isVisibility = !isVisibility);
      },
    );
  }

  String? _setValidator(String? value) {
    if (!widget.isValidator) return null;
    if (value == null || value.trim().isEmpty) {
      return "Please fill out this field";
    }
    return null;
  }
}
