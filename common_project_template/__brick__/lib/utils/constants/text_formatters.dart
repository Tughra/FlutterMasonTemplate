import 'package:flutter/services.dart';

class InputFormatters {
  static final FilteringTextInputFormatter userNameFormatter =
      FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z_]'));
  static final FilteringTextInputFormatter userNameSurnameFormatter =
      FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z_ ]'));
}
