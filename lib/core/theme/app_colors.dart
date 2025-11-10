import 'package:flutter/material.dart';

/// VibeDevEdu 앱 컬러 시스템
/// Material 3 디자인 가이드 기반
class AppColors {
  // ============ Primary Colors ============
  static const primary = Color(0xFF4F8EF7);
  static const primaryDark = Color(0xFF2E5BB8);
  static const primaryLight = Color(0xFF7FB3FF);

  // ============ Light Mode Colors ============
  // Background Colors (Light)
  static const bgPrimary = Color(0xFFF5F5F5); // Gray tone
  static const bgSecondary = Color(0xFFFFFFFF);
  static const bgCard = Color(0xFFFFFFFF);

  // Text Colors (Light)
  static const textPrimary = Color(0xFF2D3748);
  static const textSecondary = Color(0xFF718096);
  static const textHint = Color(0xFFA0AEC0);
  static const textInverse = Color(0xFFFFFFFF);

  // ============ Dark Mode Colors ============
  // Background Colors (Dark)
  static const bgDark = Color(0xFF0A0A0A); // 더 진한 배경
  static const bgDarkSecondary = Color(0xFF1A1A1A); // 세컨더리 배경
  static const bgDarkCard = Color(0xFF242424); // 카드 배경
  static const bgDarkElevated = Color(0xFF2E2E2E); // 살짝 띄워진 요소

  // Text Colors (Dark)
  static const textDarkPrimary = Color(0xFFE8E8E8); // 밝은 텍스트
  static const textDarkSecondary = Color(0xFFB0B0B0); // 세컨더리 텍스트
  static const textDarkHint = Color(0xFF707070); // 힌트 텍스트
  static const textDarkInverse = Color(0xFF1A1A1A); // 역전 텍스트

  // Status Colors
  static const success = Color(0xFF48BB78);
  static const warning = Color(0xFFED8936);
  static const error = Color(0xFFF56565);
  static const info = Color(0xFF4299E1);

  // Difficulty Colors
  static const easy = Color(0xFF48BB78); // Green
  static const medium = Color(0xFFF6AD55); // Orange
  static const hard = Color(0xFFFC8181); // Red

  // Trophy Colors (for leaderboard)
  static const gold = Color(0xFFFFD700);
  static const silver = Color(0xFFC0C0C0);
  static const bronze = Color(0xFFCD7F32);

  // Semantic Colors
  static const divider = Color(0xFFE2E8F0);
  static const shadow = Color(0x1A000000);
  static const overlay = Color(0x80000000);

  // Language Colors
  static const python = Color(0xFF3776AB);
  static const javascript = Color(0xFFF7DF1E);
  static const dart = Color(0xFF0175C2);
  static const go = Color(0xFF00ADD8);
  static const java = Color(0xFFFF6B35);
  static const cLang = Color(0xFFA8B9CC);
  static const supabase = Color(0xFF3ECF8E);
  static const firebase = Color(0xFFFFCA28);
}
