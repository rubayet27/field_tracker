import 'dart:math';

import 'package:flutter/material.dart';

import 'device_type.dart';
import 'dimensions.dart';

class ScreenScaler {
  static late double _heightScale;
  static late double _widthScale;
  static late double _paddingScale;
  static late double _marginScale;
  static late double _fontScale;

  static void init(BuildContext context, BoxConstraints constraints) {
    var deviceType = getDeviceType(context);
    var designHeight = deviceType == DeviceType.phone
        ? Dimensions.phoneHeight
        : deviceType == DeviceType.tablet
        ? Dimensions.tabletHeight
        : Dimensions.desktopHeight;
    var designWidth = deviceType == DeviceType.phone
        ? Dimensions.phoneWidth
        : deviceType == DeviceType.tablet
        ? Dimensions.tabletWidth
        : Dimensions.desktopWidth;

    _heightScale = constraints.maxHeight / designHeight;
    _widthScale = constraints.maxWidth / designWidth;
    _paddingScale = constraints.maxWidth / designWidth;
    _marginScale = constraints.maxWidth / designWidth;
    _fontScale = min(_widthScale, _heightScale);
  }

  static double scaleHeight(double h) => h * _heightScale;
  static double scaleWidth(double w) => w * _widthScale;
  static double scalePadding(double p) => p * _paddingScale;
  static double scaleMargin(double m) => m * _marginScale;
  static double scaleFont(double f) => f * _fontScale;
}
