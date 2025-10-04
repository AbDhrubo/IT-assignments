import 'package:flutter/material.dart';

/// Global color scheme for the app
/// Index 0 = Light mode colors
/// Index 1 = Dark mode colors
class AppColors {
  // Background colors
  static const background = [
    Color(0xFFFAFAFA), // Light: grey[50]
    Color(0xFF212121), // Dark: grey[900]
  ];

  static const surface = [
    Color(0xFFFFFFFF), // Light: white
    Color(0xFF303030), // Dark: grey[850]
  ];

  // Text colors
  static const textPrimary = [
    Color(0xFF212121), // Light: black87
    Color(0xFFFFFFFF), // Dark: white
  ];

  static const textSecondary = [
    Color(0xFF757575), // Light: grey[600]
    Color(0xFFBDBDBD), // Dark: grey[400]
  ];

  static const textHint = [
    Color(0xFF9E9E9E), // Light: grey[500]
    Color(0xFF757575), // Dark: grey[600]
  ];

  // Icon colors
  static const iconPrimary = [
    Color(0xFF212121), // Light: black87
    Color(0xFFFFFFFF), // Dark: white
  ];

  // Accent color (same for both themes)
  static const accent = Color(0xFF212121);

  /// Helper method to get color based on theme
  static Color get(List<Color> colorPair, bool isDark) {
    return colorPair[isDark ? 1 : 0];
  }
}