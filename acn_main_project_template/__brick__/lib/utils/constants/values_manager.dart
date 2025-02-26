import 'package:flutter/services.dart';


double maxScreenWidth(double width){
  return width>=600?600:width;
}
bool isWideScreen(double width){
  return width>=600;
}
class AppMargin {
  static const double m8 = 8.0;
  static const double m12 = 12.0;
  static const double m14 = 14.0;
  static const double m16 = 16.0;
  static const double m18 = 18.0;
  static const double m20 = 20.0;
}

class AppPadding {
  static const double standardMinBody = 12.0;
  static const double standardNormalBody = 24.0;
  static const double standardHighBody = 36.0;
}

class AppSize {
  static const double s0 = 0;
  static const double s1 = 1;
  static const int s2 = 2;
  static const double s1_5 = 1.5;
  static const double s4 = 4.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s28 = 28.0;
  static const double s40 = 40.0;
  static const double s60 = 60.0;
  static const double s80 = 80.0;
  static const double s90 = 90.0;
  static const double s100 = 100.0;
  static const double s120 = 120.0;
  static const double s140 = 140.0;
  static const double s160 = 160.0;
  static const double s190 = 190.0;
}

class ButtonSize {
  static const double small = 16.0;
  static const double middle = 24.0;
  static const double standard = 32.0;
  static const double standardBig = 38.0;
  static const double standardBigger = 42.0;
}
class ButtonRadius {
  static const double smallest = 8.0;
  static const double small = 12.0;
  static const double middle = 16.0;
  static const double standard = 32.0;
  static const double standardBig = 38.0;
  static const double standardBigger = 42.0;
}

class ButtonStyles {
  static const double splashRadius = 18;
}

class WidgetSize {
  static const double smallSize = 40;
  static const double regularSize = 36;
  static const double circleImageSize = 60;
  static const double headerIconHandSize = 16;
  static const double headerIconSize = 20;
}

class AppColor {
  static const Color secondaryColor = Color.fromRGBO(52, 60, 106, 1);
  static const Color primaryColor = Color.fromRGBO(247, 93, 95, 1);
  static const Color greenColor = Color.fromRGBO(134, 204, 120, 1);
  static const Color greenDarkColor = Color.fromRGBO(20, 107, 43, 1);
  static const Color errorColor = Color.fromRGBO(196, 12, 12, 1.0);
}
