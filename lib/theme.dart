import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CustomTheme {
  const CustomTheme();

  static const Color loginGradientStart = Color(0xFF1e3d8d);
  static const Color loginGradientEnd = Color(0xFF029b93);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
