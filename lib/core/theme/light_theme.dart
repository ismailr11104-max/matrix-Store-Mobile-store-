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
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF7B73F3), width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
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
