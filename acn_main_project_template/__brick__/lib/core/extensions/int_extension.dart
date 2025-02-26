import 'package:flutter/material.dart';

extension IntExtensions on int {
  /// return SizedBox(height: [this])
  Widget get heightIntMargin {
    // ignore: unnecessary_this
    return SizedBox(height: this.toDouble());
  }

  /// return SizedBox(width: [this])
  Widget get widthIntMargin {
    // ignore: unnecessary_this
    return SizedBox(width: this.toDouble());
  }
}

extension DoubleExtensions on double {
  /// return SizedBox(height: [this])
  Widget get heightDoubleMargin {
    // ignore: unnecessary_this
    return SizedBox(height: this);
  }

  /// return SizedBox(width: [this])
  Widget get widthDoubleMargin {
    // ignore: unnecessary_this
    return SizedBox(width: this);
  }
  bool get isTabletWidth {
    //tablet max 1024 - 1366
    return this>=500;
  }
}
