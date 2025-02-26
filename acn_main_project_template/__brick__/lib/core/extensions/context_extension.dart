import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;
  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;
  double get bottomBarHeight => MediaQuery.of(this).viewPadding.bottom;

  Color get primaryColor => Theme.of(this).primaryColor;
  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];

  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  T reading<T>() {
    return Provider.of<T>(this, listen: false);
  }
  double get titleSize => (maxScreenWidth(width)*.05>24?24:(maxScreenWidth(width)*.05));
  double get padding {
    final double screenAspectRatio = MediaQuery.of(this).size.aspectRatio;
    if(screenAspectRatio>=.7){
      return (width-(width*.8))/2;
    }
    return 16.0;
  }
  double get buttonPadding {
    // final double screenAspectRatio = MediaQuery.of(this).size.aspectRatio;
    return (width-(width*.8))/2;
  }
  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

}

extension TextThemeExtension on BuildContext {
  TextStyle? get displayLarge => textTheme.displayLarge;

  TextStyle? get displayMedium => textTheme.displayMedium;

  TextStyle? get displaySmall => textTheme.displaySmall;

  TextStyle? get headlineLarge => textTheme.headlineLarge;

  TextStyle? get headlineMedium => textTheme.headlineMedium;

  TextStyle? get headlineSmall => textTheme.headlineSmall;

  TextStyle? get titleLarge => textTheme.titleLarge;

  TextStyle? get titleMedium => textTheme.titleMedium;

  TextStyle? get titleSmall => textTheme.titleSmall;

  TextStyle? get bodyLarge => textTheme.bodyLarge;

  TextStyle? get bodyMedium => textTheme.bodyMedium;

  TextStyle? get bodySmall => textTheme.bodySmall;

  TextStyle? get labelLarge => textTheme.labelLarge;

  TextStyle? get labelSmall => textTheme.labelSmall;
}
