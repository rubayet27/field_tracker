

import '../dimensions.dart';
import '../screen_scaler.dart';

class FontSize {
  FontSize._();

  static double get displayLarge =>
      ScreenScaler.scaleFont(Dimensions.displayLarge);

  static double get displayMedium =>
      ScreenScaler.scaleFont(Dimensions.displayMedium);

  static double get displaySmall =>
      ScreenScaler.scaleFont(Dimensions.displaySmall);

  static double get headlineLarge =>
      ScreenScaler.scaleFont(Dimensions.headlineLarge);

  static double get headlineMedium =>
      ScreenScaler.scaleFont(Dimensions.headlineMedium);

  static double get headlineSmall =>
      ScreenScaler.scaleFont(Dimensions.headlineSmall);

  static double get titleLarge => ScreenScaler.scaleFont(Dimensions.titleLarge);

  static double get titleMedium =>
      ScreenScaler.scaleFont(Dimensions.titleMedium);

  static double get titleSmall => ScreenScaler.scaleFont(Dimensions.titleSmall);

  static double get bodyLarge => ScreenScaler.scaleFont(Dimensions.bodyLarge);

  static double get bodyMedium => ScreenScaler.scaleFont(Dimensions.bodyMedium);

  static double get bodySmall => ScreenScaler.scaleFont(Dimensions.bodySmall);

  static double get labelLarge => ScreenScaler.scaleFont(Dimensions.labelLarge);

  static double get labelMedium =>
      ScreenScaler.scaleFont(Dimensions.labelMedium);

  static double get labelSmall => ScreenScaler.scaleFont(Dimensions.labelSmall);

  static double custom(double fs) => ScreenScaler.scaleFont(fs);
}
