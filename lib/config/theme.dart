import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFFFF5700),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFF5700),
        primary: const Color(0xFFFF5700),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFFFF5700),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
