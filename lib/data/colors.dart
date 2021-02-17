import 'package:flutter/material.dart';

class DefaultColors {
  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFF8F7FF),
      100: Color(0xFFF0EFFF),
      200: Color(0xFFDAD8FF),
      300: Color(0xFFC4C1FF),
      400: Color(0xFF9892FF),
      500: Color(_primaryValue),
      600: Color(0xFF6159E6),
      700: Color(0xFF514ABF),
      800: Color(0xFF413B99),
      900: Color(0xFF35317D),
    },
  );

  static const MaterialColor dark = MaterialColor(
    _darkValue,
    <int, Color>{
      50: Color(0xFFF5F5F6),
      100: Color(0xFFEAEAEC),
      200: Color(0xFFCBCBD0),
      300: Color(0xFFACABB3),
      400: Color(0xFF6D6D7A),
      500: Color(_darkValue),
      600: Color(0xFF2A293B),
      700: Color(0xFF232331),
      800: Color(0xFF1C1C27),
      900: Color(0xFF171720),
    },
  );

  static const int _primaryValue = 0xFF6C63FF;
  static const int _darkValue = 0xFF2F2E41;
}