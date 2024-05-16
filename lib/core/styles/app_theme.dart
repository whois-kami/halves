import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData onBoardingTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
  );
  static ThemeData onBoardingTextTheme = ThemeData(
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: Colors.red,
        fontSize: 24,
        fontFamily: 'IBMPlexSansDevanagari',
      ),
    ),
  );
}
