import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary palette - modern political blue
  static const Color primary = Color(0xFF1A237E);
  static const Color primaryDark = Color(0xFF0D1B6E);
  static const Color primaryLight = Color(0xFF3949AB);

  // Accent - Jordanian flag inspired teal/green
  static const Color accent = Color(0xFF00897B);
  static const Color accentLight = Color(0xFF4DB6AC);

  // Result classification colors
  static const Color lowAwareness = Color(0xFFE53935);
  static const Color mediumAwareness = Color(0xFFFB8C00);
  static const Color highAwareness = Color(0xFF43A047);
  static const Color expertAwareness = Color(0xFF1565C0);

  // Background shades
  static const Color background = Color(0xFFF0F2F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Option button states
  static const Color optionDefault = Color(0xFFFFFFFF);
  static const Color optionSelected = Color(0xFF3949AB);
  static const Color optionBorder = Color(0xFFBDBDBD);

  // Gradient colors
  static const Color gradientStart = Color(0xFF1A237E);
  static const Color gradientEnd = Color(0xFF283593);

  // Progress bar
  static const Color progressBackground = Color(0xFFE0E0E0);
  static const Color progressFill = Color(0xFF00897B);
}
