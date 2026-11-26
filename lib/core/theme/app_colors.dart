import 'package:flutter/material.dart';

class AppColors {
  // Brand & Accent Colors
  static const Color primaryNavy = Color(0xFF14264F);
  static const Color primaryBlue = Color(0xFF286BE8);
  static const Color accentCyan = Color(0xFF50CBE0);
  static const Color paleBlueBackground = Color(0xFFEAF2FF);
  static const Color backgroundWhite = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF14264F);
  static const Color textSecondary = Color(0xFF536584);
  static const Color textMuted = Color(0xFF7485A3);

  // Border & Surface Colors
  static const Color borderLight = Color(0xFFD6E2F5);
  static const Color inputBorder = Color(0xFFD6E2F5);
  static const Color cardBorder = Color(0xFFD6E2F5);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA000);
  static const Color info = Color(0xFF286BE8);

  // Gradients
  static const LinearGradient screenBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFEAF2FF),
      Color(0xFFF9FBFF),
      Color(0xFFFFFFFF),
    ],
    stops: [0.0, 0.35, 1.0],
  );
}
