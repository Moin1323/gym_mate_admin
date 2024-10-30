import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';

class AppThemes {
  static void setStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: AppColors.background,
    ));
  }

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.secondary,
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.primary,
        textStyle: TextStyle(
          fontSize: 20,
          color: AppColors.secondary,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.withOpacity(0.3),
      filled: true,
      contentPadding: const EdgeInsets.all(15),
      hintStyle: const TextStyle(color: Colors.white),
      labelStyle: const TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.withOpacity(.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary),
      ),
    ),
  );
}
