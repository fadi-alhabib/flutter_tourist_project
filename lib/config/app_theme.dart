import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  primaryColor: const Color(0xFF00C853),
  scaffoldBackgroundColor: Colors.white,
  cardColor: const Color(0xFFF5F5F5),

  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00C853)),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black87),
    titleTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),

  iconTheme: const IconThemeData(color: Colors.black54),

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
    labelLarge: TextStyle(fontSize: 12, color: Colors.black38),
  ),

  dividerColor: Colors.black12,

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.green.shade800,
    selectedItemColor: Color(0xFF00C853),
    unselectedItemColor: Colors.black38,
    showUnselectedLabels: false,
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF00C853),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade400,
    hintStyle: const TextStyle(color: Colors.black38),
    labelStyle: const TextStyle(color: Colors.black87),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),

      borderSide: const BorderSide(color: Colors.black26),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: const BorderSide(color: Colors.black26),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: const BorderSide(color: Color(0xFF00C853)),
    ),
  ),
);
