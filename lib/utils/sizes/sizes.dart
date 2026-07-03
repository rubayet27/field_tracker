import 'package:flutter/material.dart';

import '../dimensions.dart';
import '../screen_scaler.dart';

class Sizes {
  Sizes._();
  static const height = _Height();
  static const width = _Width();
  static const padding = _Padding();
  static const margin = _Margin();
}

class _Height {
  const _Height();

  Widget get h8 => SizedBox(height: ScreenScaler.scaleHeight(8));
  Widget get h10 => SizedBox(height: ScreenScaler.scaleHeight(10));
  Widget get h12 => SizedBox(height: ScreenScaler.scaleHeight(12));
  Widget get h16 => SizedBox(height: ScreenScaler.scaleHeight(16));
  Widget get h20 => SizedBox(height: ScreenScaler.scaleHeight(20));
  Widget get h24 => SizedBox(height: ScreenScaler.scaleHeight(24));
  Widget get h32 => SizedBox(height: ScreenScaler.scaleHeight(32));
  Widget get h40 => SizedBox(height: ScreenScaler.scaleHeight(40));
  Widget addHeight(double h) => SizedBox(height: ScreenScaler.scaleHeight(h));
}

class _Width {
  const _Width();
  Widget get w8 => SizedBox(width: ScreenScaler.scaleWidth(8));
  Widget get w10 => SizedBox(width: ScreenScaler.scaleWidth(10));
  Widget get w12 => SizedBox(width: ScreenScaler.scaleWidth(12));
  Widget get w16 => SizedBox(width: ScreenScaler.scaleWidth(16));
  Widget get w20 => SizedBox(width: ScreenScaler.scaleWidth(20));
  Widget get w24 => SizedBox(width: ScreenScaler.scaleWidth(24));
  Widget get w32 => SizedBox(width: ScreenScaler.scaleWidth(32));
  Widget get w40 => SizedBox(width: ScreenScaler.scaleWidth(40));
  Widget addWidth(double w) => SizedBox(height: ScreenScaler.scaleWidth(w));
}

class _Padding {
  const _Padding();

  EdgeInsets get p4 => all(4);
  EdgeInsets get p8 => all(8);
  EdgeInsets get p10 => all(10);
  EdgeInsets get p12 => all(12);
  EdgeInsets get p16 => all(16);
  EdgeInsets get p20 => all(20);
  EdgeInsets get p24 => all(24);
  EdgeInsets get pdef => all(Dimensions.defaultPaddingSize);

  EdgeInsets get ph8 => h(8);
  EdgeInsets get ph12 => h(12);
  EdgeInsets get ph16 => h(16);
  EdgeInsets get ph20 => h(20);
  EdgeInsets get phdef => h(Dimensions.defaultPaddingSize);

  EdgeInsets get pv8 => v(8);
  EdgeInsets get pv12 => v(12);
  EdgeInsets get pv10 => v(10);
  EdgeInsets get pv16 => v(16);
  EdgeInsets get pv20 => v(20);
  EdgeInsets get pvdef => v(Dimensions.defaultPaddingSize);

  EdgeInsets get pSym16 => EdgeInsets.symmetric(
    horizontal: ScreenScaler.scalePadding(16),
    vertical: ScreenScaler.scalePadding(16),
  );

  EdgeInsets psym({double h = 0, double v = 0}) => EdgeInsets.symmetric(
    horizontal: ScreenScaler.scalePadding(h),
    vertical: ScreenScaler.scalePadding(v),
  );

  EdgeInsets po({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
    top: ScreenScaler.scalePadding(top),
    left: ScreenScaler.scalePadding(left),
    right: ScreenScaler.scalePadding(right),
    bottom: ScreenScaler.scalePadding(bottom),
  );

  EdgeInsets all(double value) =>
      EdgeInsets.all(ScreenScaler.scalePadding(value));

  EdgeInsets h(double value) =>
      EdgeInsets.symmetric(horizontal: ScreenScaler.scalePadding(value));

  EdgeInsets v(double value) =>
      EdgeInsets.symmetric(vertical: ScreenScaler.scalePadding(value));
}

class _Margin {
  const _Margin();

  EdgeInsets get m4 => all(4);
  EdgeInsets get m8 => all(8);
  EdgeInsets get m10 => all(10);
  EdgeInsets get m12 => all(12);
  EdgeInsets get m16 => all(16);
  EdgeInsets get m20 => all(20);
  EdgeInsets get m24 => all(24);

  EdgeInsets get mh8 => h(8);
  EdgeInsets get mh12 => h(12);
  EdgeInsets get mh16 => h(16);
  EdgeInsets get mh20 => h(20);

  EdgeInsets get mv8 => v(8);
  EdgeInsets get mv12 => v(12);
  EdgeInsets get mv16 => v(16);
  EdgeInsets get mv20 => v(20);

  EdgeInsets all(double value) =>
      EdgeInsets.all(ScreenScaler.scaleMargin(value));

  EdgeInsets h(double value) =>
      EdgeInsets.symmetric(horizontal: ScreenScaler.scaleMargin(value));

  EdgeInsets v(double value) =>
      EdgeInsets.symmetric(vertical: ScreenScaler.scaleMargin(value));

  EdgeInsets msym({double h = 0, double v = 0}) => EdgeInsets.symmetric(
    horizontal: ScreenScaler.scaleMargin(h),
    vertical: ScreenScaler.scaleMargin(v),
  );

  EdgeInsets mo({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
    top: ScreenScaler.scaleMargin(top),
    left: ScreenScaler.scaleMargin(left),
    right: ScreenScaler.scaleMargin(right),
    bottom: ScreenScaler.scaleMargin(bottom),
  );
}
