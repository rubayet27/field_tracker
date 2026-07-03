import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/sizes/border_radius.dart';
import 'package:field_tracker/utils/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.showTitle = true});
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          padding: Sizes.padding.pSym16,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            color: isDark ? AppColors.primaryDark : AppColors.primary,
          ),
          child: SvgPicture.asset("assets/icons/location.svg"),
        ),
        Sizes.height.h12,
        showTitle
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    "Field",
                    style: TextStyle(
                      fontSize: Dimensions.titleLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextWidget(
                    "Track",
                    fontSize: Dimensions.titleLarge,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.primaryDark : AppColors.primary,
                  ),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
