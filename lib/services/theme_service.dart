import 'package:flutter/material.dart';
import '../core/color_palette.dart';

/// v2.3: 테마 서비스
class ThemeService extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  Color _accentColor = VibePalette.primary;

  ThemeMode get mode => _mode;
  Color get accentColor => _accentColor;

  /// 테마 모드 토글 (light <-> dark)
  void toggleMode() {
    if (_mode == ThemeMode.light) {
      _mode = ThemeMode.dark;
    } else if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
    } else {
      // system인 경우 light로
      _mode = ThemeMode.light;
    }
    notifyListeners();
  }

  /// 테마 모드 설정
  void setMode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  /// 액센트 컬러 변경
  void setAccentColor(Color color) {
    _accentColor = color;
    notifyListeners();
  }

  /// Light Theme
  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: _accentColor,
        scaffoldBackgroundColor: VibePalette.bgLight,
        cardColor: VibePalette.bgLightCard,
        colorScheme: ColorScheme.light(
          primary: _accentColor,
          secondary: _accentColor,
          surface: VibePalette.bgLightSurface,
          background: VibePalette.bgLight,
          error: VibePalette.error,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: VibePalette.bgLightCard,
          foregroundColor: VibePalette.textLight,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardTheme(
          color: VibePalette.bgLightCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _accentColor,
            foregroundColor: Colors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: _accentColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: VibePalette.bgLightSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _accentColor, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      );

  /// Dark Theme
  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: _accentColor,
        scaffoldBackgroundColor: VibePalette.bgDark,
        cardColor: VibePalette.bgDarkCard,
        colorScheme: ColorScheme.dark(
          primary: _accentColor,
          secondary: _accentColor,
          surface: VibePalette.bgDarkSurface,
          background: VibePalette.bgDark,
          error: VibePalette.error,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: VibePalette.bgDarkCard,
          foregroundColor: VibePalette.textDark,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardTheme(
          color: VibePalette.bgDarkCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _accentColor,
            foregroundColor: Colors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: _accentColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: VibePalette.bgDarkSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _accentColor, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      );
}
