import 'package:flutter/material.dart';

import 'screen_scaler.dart';

class LayoutManager extends StatelessWidget {
  const LayoutManager({
    super.key,
    required this.phoneLayout,
    this.tabletLayout,
    this.desktopLayout,
  });
  final Widget phoneLayout;
  final Widget? tabletLayout;
  final Widget? desktopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenScaler.init(context, constraints);
        if (constraints.maxWidth > 1200) {
          return desktopLayout ?? phoneLayout;
        } else if (constraints.maxWidth > 800) {
          return tabletLayout ?? phoneLayout;
        } else {
          return phoneLayout;
        }
      },
    );
  }
}
