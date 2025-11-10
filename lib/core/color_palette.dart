import 'package:flutter/material.dart';

/// v2.3: VibeDev 컬러 팔레트
class VibePalette {
  // Primary Colors
  static const Color primary = Color(0xFF00FFC8); // TealAccent
  static const Color primaryDark = Color(0xFF00CCa0);
  static const Color primaryLight = Color(0xFF66FFE0);

  // Background Colors - Light Theme
  static const Color bgLight = Color(0xFFF5F5F5);
  static const Color bgLightCard = Color(0xFFFFFFFF);
  static const Color bgLightSurface = Color(0xFFFAFAFA);

  // Background Colors - Dark Theme
  static const Color bgDark = Color(0xFF121212);
  static const Color bgDarkCard = Color(0xFF1E1E1E);
  static const Color bgDarkSurface = Color(0xFF2C2C2C);

  // Text Colors - Light Theme
  static const Color textLight = Color(0xFF212121);
  static const Color textLightSecondary = Color(0xFF757575);
  static const Color textLightDisabled = Color(0xFFBDBDBD);

  // Text Colors - Dark Theme
  static const Color textDark = Color(0xFFFFFFFF);
  static const Color textDarkSecondary = Color(0xFFB0B0B0);
  static const Color textDarkDisabled = Color(0xFF6B6B6B);

  // Accent Colors
  static const Color accent = Color(0xFF00FFC8);
  static const Color accentRed = Color(0xFFFF5252);
  static const Color accentYellow = Color(0xFFFFEB3B);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentBlue = Color(0xFF2196F3);
  static const Color accentPurple = Color(0xFF9C27B0);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Gray Scale
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Shadows
  static List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> shadowStrong = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 30,
      offset: const Offset(0, 12),
    ),
  ];

  // Neumorphic Effect
  static List<BoxShadow> neumorphicLight = [
    BoxShadow(
      color: Colors.white.withOpacity(0.7),
      blurRadius: 15,
      offset: const Offset(-5, -5),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 15,
      offset: const Offset(5, 5),
    ),
  ];

  static List<BoxShadow> neumorphicDark = [
    BoxShadow(
      color: Colors.white.withOpacity(0.05),
      blurRadius: 15,
      offset: const Offset(-5, -5),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 15,
      offset: const Offset(5, 5),
    ),
  ];
}
