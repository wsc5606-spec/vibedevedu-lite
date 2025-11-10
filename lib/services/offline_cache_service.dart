import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// v2.4: 오프라인 캐시 서비스
class OfflineCacheService {
  static const _cachePrefix = 'offline:';
  static const _maxCacheAgeSeconds = 3600; // 1시간

  /// 데이터 저장
  static Future<bool> set(String key, dynamic data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = '$_cachePrefix$key';
      final cacheData = {
        'data': data,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      return await prefs.setString(cacheKey, jsonEncode(cacheData));
    } catch (e) {
      print('Cache Set Error: $e');
      return false;
    }
  }

  /// 데이터 조회
  static Future<dynamic> get(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = '$_cachePrefix$key';
      final cacheString = prefs.getString(cacheKey);

      if (cacheString == null) return null;

      final cacheData = jsonDecode(cacheString);
      final timestamp = cacheData['timestamp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch;

      // 만료 확인
      if (now - timestamp > _maxCacheAgeSeconds * 1000) {
        await prefs.remove(cacheKey);
        return null;
      }

      return cacheData['data'];
    } catch (e) {
      print('Cache Get Error: $e');
      return null;
    }
  }

  /// 데이터 삭제
  static Future<bool> remove(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = '$_cachePrefix$key';
      return await prefs.remove(cacheKey);
    } catch (e) {
      print('Cache Remove Error: $e');
      return false;
    }
  }

  /// 모든 캐시 삭제
  static Future<bool> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().where((k) => k.startsWith(_cachePrefix));
      for (final key in keys) {
        await prefs.remove(key);
      }
      return true;
    } catch (e) {
      print('Cache Clear Error: $e');
      return false;
    }
  }

  /// 캐시 크기 확인
  static Future<int> getCacheSize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().where((k) => k.startsWith(_cachePrefix));
      return keys.length;
    } catch (e) {
      print('Cache Size Error: $e');
      return 0;
    }
  }

  /// 특정 패턴으로 캐시 조회
  static Future<Map<String, dynamic>> getByPattern(String pattern) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().where((k) => k.startsWith('$_cachePrefix$pattern'));
      final results = <String, dynamic>{};

      for (final key in keys) {
        final data = await get(key.substring(_cachePrefix.length));
        if (data != null) {
          results[key] = data;
        }
      }

      return results;
    } catch (e) {
      print('Cache Get By Pattern Error: $e');
      return {};
    }
  }
}
