import 'package:flutter/material.dart';
import 'app_colors.dart';

/// VibeDevEdu 타이포그래피 시스템
class AppTextStyles {
  static const String baseFont = 'Pretendard';

  // Headings
  static const h1 = TextStyle(
    fontFamily: baseFont,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.3,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const h2 = TextStyle(
    fontFamily: baseFont,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static const h3 = TextStyle(
    fontFamily: baseFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static const h4 = TextStyle(
    fontFamily: baseFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  // Body Text
  static const body = TextStyle(
    fontFamily: baseFont,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static const bodyBold = TextStyle(
    fontFamily: baseFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  // Small Text
  static const small = TextStyle(
    fontFamily: baseFont,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  static const smallBold = TextStyle(
    fontFamily: baseFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  // Tiny Text
  static const tiny = TextStyle(
    fontFamily: baseFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textHint,
  );

  // Button Text
  static const button = TextStyle(
    fontFamily: baseFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.2,
  );

  // Caption Text
  static const caption = TextStyle(
    fontFamily: baseFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.3,
    color: AppColors.textSecondary,
  );

  // Code Text (monospace)
  static const code = TextStyle(
    fontFamily: 'Monaco',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textPrimary,
  );
}
