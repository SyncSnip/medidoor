import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryLight = Color(0xFF81C784);
  static const Color primary = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF388E3C);

  // Secondary Colors
  static const Color secondaryLight = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFFF5F5F5);
  static const Color secondaryDark = Color(0xFFE0E0E0);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    primary,
    primaryLight,
  ];

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Status Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFFA000);
  static const Color info = Color(0xFF1976D2);

  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.1);
  static Color shadowMedium = Colors.black.withOpacity(0.15);
  static Color shadowDark = Colors.black.withOpacity(0.2);
}
