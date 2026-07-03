import 'package:flutter/material.dart';

enum DeviceType { phone, tablet, desktop }

DeviceType getDeviceType(BuildContext context) {
  if (_checkDevice(context) > 1200) {
    return DeviceType.desktop;
  } else if (_checkDevice(context) > 800) {
    return DeviceType.tablet;
  } else {
    return DeviceType.phone;
  }
}

double _checkDevice(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}


