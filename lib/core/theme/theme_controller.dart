import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTextScale { sm, md, lg }
extension AppTextScaleX on AppTextScale {
  double get factor => switch (this) { AppTextScale.sm => 0.9, AppTextScale.md => 1.0, AppTextScale.lg => 1.15 };
  static AppTextScale fromString(String? s) =>
      switch (s) { 'sm' => AppTextScale.sm, 'lg' => AppTextScale.lg, _ => AppTextScale.md };
  String get key => switch (this) { AppTextScale.sm => 'sm', AppTextScale.md => 'md', AppTextScale.lg => 'lg' };
}

class ThemeController extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.dark; // 🌙 기본값을 다크모드로 변경
  AppTextScale _textScale = AppTextScale.md;
  bool _highContrast = false;
  bool _reduceMotion = false;
  bool get ready => _ready;
  bool _ready = false;

  ThemeMode get mode => _mode;
  AppTextScale get textScale => _textScale;
  bool get highContrast => _highContrast;
  bool get reduceMotion => _reduceMotion;

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    _mode = switch (sp.getString('pref.theme')) {
      'light' => ThemeMode.light,
      'system' => ThemeMode.system,
      _ => ThemeMode.dark // 🌙 기본값을 다크모드로 변경
    };
    _textScale = AppTextScaleX.fromString(sp.getString('pref.textScale'));
    _highContrast = sp.getBool('pref.highContrast') ?? false;
    _reduceMotion = sp.getBool('pref.reduceMotion') ?? false;
    _ready = true;
    notifyListeners();
  }

  Future<void> setMode(ThemeMode m) async {
    _mode = m;
    final sp = await SharedPreferences.getInstance();
    await sp.setString('pref.theme', switch (m) { ThemeMode.dark => 'dark', ThemeMode.system => 'system', _ => 'light' });
    notifyListeners();
  }

  Future<void> setTextScale(AppTextScale s) async {
    _textScale = s;
    final sp = await SharedPreferences.getInstance();
    await sp.setString('pref.textScale', s.key);
    notifyListeners();
  }

  Future<void> setHighContrast(bool v) async {
    _highContrast = v;
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('pref.highContrast', v);
    notifyListeners();
  }

  Future<void> setReduceMotion(bool v) async {
    _reduceMotion = v;
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('pref.reduceMotion', v);
    notifyListeners();
  }
}
