import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK, CUSTOM }

class MyThemes {
  static final ThemeData lightTheme = ThemeData.light();

  static final ThemeData darkTheme = ThemeData.dark();

  static final ThemeData customTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.purple[800],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.yellowAccent,
      ));

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      case MyThemeKeys.CUSTOM:
        return customTheme;
      default:
        return lightTheme;
    }
  }
}
