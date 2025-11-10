import 'package:shared_preferences/shared_preferences.dart';

/// 즐겨찾기 관리 서비스
class FavoritesService {
  static const String _favoritesKey = 'vibedev_favorites';

  /// 즐겨찾기 목록 가져오기
  static Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];
    return favoritesJson.toSet();
  }

  /// 즐겨찾기 추가
  static Future<void> addFavorite(String challengeSlug) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.add(challengeSlug);
    await prefs.setStringList(_favoritesKey, favorites.toList());
  }

  /// 즐겨찾기 제거
  static Future<void> removeFavorite(String challengeSlug) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.remove(challengeSlug);
    await prefs.setStringList(_favoritesKey, favorites.toList());
  }

  /// 즐겨찾기 토글
  static Future<bool> toggleFavorite(String challengeSlug) async {
    final favorites = await getFavorites();
    if (favorites.contains(challengeSlug)) {
      await removeFavorite(challengeSlug);
      return false;
    } else {
      await addFavorite(challengeSlug);
      return true;
    }
  }

  /// 즐겨찾기 여부 확인
  static Future<bool> isFavorite(String challengeSlug) async {
    final favorites = await getFavorites();
    return favorites.contains(challengeSlug);
  }
}
