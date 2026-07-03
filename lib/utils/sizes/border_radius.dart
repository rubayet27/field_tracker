import '../dimensions.dart';
import '../screen_scaler.dart';

class AppRadius {
  AppRadius._();

  static double get xs => ScreenScaler.scaleWidth(Dimensions.radiusXs);

  static double get sm => ScreenScaler.scaleWidth(Dimensions.radiusSm);

  static double get md => ScreenScaler.scaleWidth(Dimensions.radiusMd);

  static double get lg => ScreenScaler.scaleWidth(Dimensions.radiusLg);

  static double get xl => ScreenScaler.scaleWidth(Dimensions.radiusXl);

  static double get xxl => ScreenScaler.scaleWidth(Dimensions.radiusXxl);

  static double custom(double value) => ScreenScaler.scaleWidth(value);
}
