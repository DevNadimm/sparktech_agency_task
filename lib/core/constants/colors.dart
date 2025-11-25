import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Base Colors
  static const Color backgroundColor = Color(0xFFF5F9F7);
  static const Color cardColor = Color(0xFFFFFFFF);

  /// Primary Theme Colors - Based on Logo
  static const Color primaryColor = Color(0xFF9FD356); // Lime green from logo
  static const Color primaryDark = Color(0xFF0D2F2F); // Dark teal from logo background
  static const Color primaryLight = Color(0xFFB8E986); // Lighter lime green
  static const Color accentColor = Color(0xFFC4E538); // Bright yellow-green

  static const Color buttonFontColor = Color(0xFF0D2F2F); // Dark text on lime buttons
  static const Color primaryFontColor = Color(0xFF1A1A1A);
  static const Color secondaryFontColor = Color(0xFF4A4A4A);

  /// Additional Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  /// Status Colors
  static const Color success = Color(0xFF9FD356); // Use primary green for success
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF2196F3);

  /// Transparent Variants
  static const Color primaryColorTransparent = Color(0x809FD356);
  static const Color cardOverlay = Color(0x110D2F2F);
  static const Color dividerColor = Color(0xFFE0E0E0);

  /// Input Border Color
  static const Color inputBorderColor = Color(0xFFCCCCCC);
  static const Color inputBorderFocusedColor = primaryColor;
}