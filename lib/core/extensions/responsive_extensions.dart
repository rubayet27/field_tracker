

import '../../utils/screen_scaler.dart';

extension ResponsiveExtensions on double {
  double setHeight() {
    return ScreenScaler.scaleHeight(this);
  }

  double setWidth() {
    return ScreenScaler.scaleWidth(this);
  }

  double setPadding() {
    return ScreenScaler.scalePadding(this);
  }

  double setMargin() {
    return ScreenScaler.scaleMargin(this);
  }

  double setFontSize() {
    return ScreenScaler.scaleFont(this);
  }
}
