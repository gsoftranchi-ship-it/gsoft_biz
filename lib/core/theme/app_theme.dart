import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class AppTheme {
  AppTheme._();

  /// Primary application themes
  static ThemeData get darkTheme => DarkTheme.theme;

  static ThemeData get lightTheme => LightTheme.theme;

  /// Default theme for the ERP
  static ThemeData get defaultTheme => darkTheme;

  /// Helper
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Helper
  static ColorScheme colors(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  /// Helper
  static TextTheme text(BuildContext context) {
    return Theme.of(context).textTheme;
  }
}