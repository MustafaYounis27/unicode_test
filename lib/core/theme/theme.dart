import 'package:flutter/material.dart';
import 'package:unicode_test/utils/extension/ui_ext.dart';

import 'colors.dart';

class AppTheme {
  AppTheme._();

  static String fontFamily = 'Lato';

  static ThemeData theme = ThemeData(
    primaryColor: ColorsPalletes.primaryBlack,
    primarySwatch: ColorsPalletes.kPrimarySwatch,
    fontFamily: AppTheme.fontFamily,
    scaffoldBackgroundColor: ColorsPalletes.white,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
    )),
    appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: ColorsPalletes.white),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorsPalletes.secondry600,
      selectionColor: ColorsPalletes.primaryGreen.withOpacity(.45),
      selectionHandleColor: ColorsPalletes.primaryGreen,
    ),
    splashFactory: NoSplash.splashFactory,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: ColorsPalletes.primaryGreen,
        shape: RoundedRectangleBorder(borderRadius: 10.br),
        elevation: 0,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    cardTheme: const CardTheme(elevation: 0),
    colorScheme: const ColorScheme.light(primary: ColorsPalletes.primaryGreen, onPrimary: ColorsPalletes.white),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    useMaterial3: true,
  );
}
