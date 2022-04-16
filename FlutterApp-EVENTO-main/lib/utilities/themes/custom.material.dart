import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToLight = MaterialColor(
    0xff20c0e8,
    <int, Color>{
      50: Color(0xff36c6ea), //10%
      100: Color(0xff4dcded), //20%
      200: Color(0xff63d3ef), //30%
      300: Color(0xff79d9f1), //40%
      400: Color(0xff90e0f4), //50%
      500: Color(0xffa6e6f6), //60%
      600: Color(0xffbcecf8), //70%
      700: Color(0xffd2f2fa), //80%
      800: Color(0xffe9f9fd), //90%
      900: Color(0xffffffff), //100%
    },
  );

  static const MaterialColor kToDark = MaterialColor(
    0xff20c0e8,
    <int, Color>{
      50: Color(0xff1dadd1), //10%
      100: Color(0xff1a9aba), //20%
      200: Color(0xff1686a2), //30%
      300: Color(0xff13738b), //40%
      400: Color(0xff106074), //50%
      500: Color(0xff0d4d5d), //60%
      600: Color(0xff0a3a46), //70%
      700: Color(0xff06262e), //80%
      800: Color(0xff031317), //90%
      900: Color(0xff000000), //100%
    },
  );
}
