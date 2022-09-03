import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff082659);
const Color secondaryColor = Color(0xff51eec2);
final appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    centerTitle: true,
  ),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: secondaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(
      color: primaryColor,
    ),
    iconColor: secondaryColor,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: secondaryColor,
      ),
      borderRadius: BorderRadius.circular(
        8.0,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: secondaryColor,
      ),
      borderRadius: BorderRadius.circular(
        8.0,
      ),
    ),
  ),
);
