import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:flutter/material.dart';
import 'app.colors.dart';
import 'custom.material.dart';

AppColors _color = AppColors();

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    fontFamily: textFontFamily,
    primarySwatch: Palette.kToDark,
    // scaffoldBackgroundColor: _color.bgColor,
    // primaryColor: _color.primaryColor,
    // buttonTheme: ButtonThemeData(
    //   buttonColor: _color.primaryColor
    // ),
    // backgroundColor: _color.bgColor,
    // dividerColor: _color.dividerColor,
    // dialogBackgroundColor: _color.whiteColor,
    // canvasColor: _color.bgColor,
    // appBarTheme: AppBarTheme(color: _color.primaryColor),
    // iconTheme: IconThemeData(color: _color.textPrimaryColor),
    // cardColor: Colors.white,
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   backgroundColor: Colors.red,
    // ),
    textTheme: TextTheme(
      headline1: TextStyle(color: _color.textPrimaryColor),
      headline2: TextStyle(color: _color.textPrimaryColor),
      headline3: TextStyle(color: _color.textPrimaryColor),
      headline4: TextStyle(color: _color.textPrimaryColor),
      headline5: TextStyle(color: _color.textPrimaryColor),
      headline6: TextStyle(color: _color.textPrimaryColor),
      subtitle1: TextStyle(color: _color.textPrimaryColor),
      subtitle2: TextStyle(color: _color.textPrimaryColor),
      bodyText1: TextStyle(color: _color.textPrimaryColor),
      bodyText2: TextStyle(color: _color.textPrimaryColor),
      button: TextStyle(color: _color.buttonTextColor),
    ),
  );
}
