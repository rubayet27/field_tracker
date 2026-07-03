import 'package:flutter/material.dart';

double setWidgetHeight(BuildContext context, height) {
  double screenHeight = MediaQuery.sizeOf(context).height;
  return (height / 812) * screenHeight;
}

double setWidgetWidth(BuildContext context, width) {
  double screenWidth = MediaQuery.sizeOf(context).width;
  return (width / 375) * screenWidth;
}
