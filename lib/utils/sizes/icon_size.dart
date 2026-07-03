import '../dimensions.dart';
import '../screen_scaler.dart';

class IconSize {
  IconSize._();

  static double get xs => ScreenScaler.scaleWidth(Dimensions.iconXs);

  static double get sm => ScreenScaler.scaleWidth(Dimensions.iconSm);

  static double get md => ScreenScaler.scaleWidth(Dimensions.iconMd);

  static double get lg => ScreenScaler.scaleWidth(Dimensions.iconLg);

  static double get xl => ScreenScaler.scaleWidth(Dimensions.iconXl);

  static double get xxl => ScreenScaler.scaleWidth(Dimensions.iconXxl);

  static double custom(double size) => ScreenScaler.scaleWidth(size);
}
