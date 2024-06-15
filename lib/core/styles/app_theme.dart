import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData halvesTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color(0xFF8378A1),
      ),
      // login\signup button
      titleLarge: TextStyle(
        fontFamily: 'IBMPlexSansDevanagari',
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Colors.white,
      ),
      // below login\signup button
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      // login  title
      displayLarge: TextStyle(
        letterSpacing: 6,
        fontFamily: 'IBMPlexSansDevanagari',
        fontWeight: FontWeight.w700,
        fontSize: 36,
        color: Colors.white,
      ),
      // login  subtitle
      displayMedium: TextStyle(
        letterSpacing: 2,
        fontFamily: 'IBMPlexSansDevanagari',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: Colors.white,
      ),
      // sign up title
      bodyLarge: TextStyle(
        fontFamily: 'IBMPlexSansDevanagari',
        fontWeight: FontWeight.w700,
        fontSize: 36,
        color: Colors.white,
      ),
      // sign up subtitle
      bodyMedium: TextStyle(
        fontFamily: 'IBMPlexSansDevanagari',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.white,
      ),
      // (email\pass) hint
      labelMedium: TextStyle(
        letterSpacing: 1,
        color: Colors.white,
        fontFamily: 'IBMPlexSansDevanagari',
        fontWeight: FontWeight.w700,
        fontSize: 17,
      ),
    ),
  );
  static ThemeData authTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
  );
}
