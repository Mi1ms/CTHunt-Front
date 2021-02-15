import 'package:flutter/material.dart';

class DefaultColors {
  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFFFFCF6),
      100: Color(0xFFFFF8ED),
      200: Color(0xFFFFEED3),
      300: Color(0xFFFFE3B8),
      400: Color(0xFFFFCF82),
      500: Color(_primaryValue),
      600: Color(0xFFE6A745),
      700: Color(0xFFBF8C3A),
      800: Color(0xFF99702E),
      900: Color(0xFF7D5B26),
    },
  );
  static const int _primaryValue = 0xFFFFBA4D;
}