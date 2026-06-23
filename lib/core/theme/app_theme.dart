import 'package:flutter/material.dart';
import 'package:my_taxi/core/theme/dark_theme.dart';
import 'package:my_taxi/core/theme/light_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light(Locale locale) => LightTheme.lightTheme(locale);

  static ThemeData dark(Locale locale) => DarkTheme.darkTheme(locale);
}
