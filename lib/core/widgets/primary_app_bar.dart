import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/sizes/sizes.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class PrimaryAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const PrimaryAppBarWidget({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
    this.elevation = 0,
    this.titleStyle,
    this.centerTitle = false,
    this.leading,
  });

  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double elevation;
  final TextStyle? titleStyle;
  final bool centerTitle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      centerTitle: centerTitle,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading:
          leading ??
          (showBackButton
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap:
                        onBackPressed ??
                        () {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
                        },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.componentDark
                            : AppColors.componentLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black, // Will adapt better with theme
                      ),
                    ),
                  ),
                )
              : null),
      title: Padding(
        padding: Sizes.padding.po(
          left: showBackButton ? 0 : Dimensions.defaultPaddingSize * 0.8,
        ),
        child: TextWidget(
          title,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          style: titleStyle,
        ),
      ),
      actions: actions,
      toolbarHeight: kToolbarHeight,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
