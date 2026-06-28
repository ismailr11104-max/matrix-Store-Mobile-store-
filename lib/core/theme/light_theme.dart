import 'package:flutter/material.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/theme/light_color.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(),
  brightness: Brightness.light,
  primaryColor: LightColor.primary,
  scaffoldBackgroundColor: LightColor.background,
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xFF000000)),
    titleTextStyle: TextStyle(
      color: Color(0xFF141414),
      fontSize: AppSized.sp16,
      fontWeight: FontWeight.w700,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColor.primary,
      foregroundColor: LightColor.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: LightColor.background,
      side: BorderSide(strokeAlign: 1, color: Color(0xFFD8DADC)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    hintStyle: TextStyle(color: Color(0xFF363636)),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightColor.background,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: LightColor.primary,
    unselectedItemColor: Color(0xFF191A1C),
    showUnselectedLabels: true,
  ),
  splashFactory: NoSplash.splashFactory,
);
