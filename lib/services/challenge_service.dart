import 'package:supabase_flutter/supabase_flutter.dart';

class ChallengeService {
  // Supabase 클라이언트
  static final _supabase = Supabase.instance.client;

  // 로컬 캐시 (성능 향상)
  static List<Map<String, dynamic>>? _cachedChallenges;
  static DateTime? _cacheTime;
  static const _cacheDuration = Duration(minutes: 30);

  /// 전체 챌린지 목록 조회
  static Future<List<Map<String, dynamic>>> fetchAll({
    String? language,
    String? category,
    int? unit,
    bool forceRefresh = false,
  }) async {
    try {
      // 캐시 체크 (30분 이내면 캐시 사용)
      if (!forceRefresh &&
          _cachedChallenges != null &&
          _cacheTime != null &&
          DateTime.now().difference(_cacheTime!) < _cacheDuration) {
        print('📦 [CACHE] Using cached challenges');
        return _filterChallenges(_cachedChallenges!, language, category, unit);
      }

      // Supabase에서 데이터 가져오기
      print('🌐 [FETCH] Fetching challenges from Supabase...');

      var query = _supabase.from('challenges').select();

      // 언어 필터
      if (language != null) {
        query = query.eq('language', language);
      }

      // 카테고리 필터
      if (category != null) {
        query = query.eq('category', category);
      }

      // Unit 필터 (level 기반)
      if (unit != null) {
        final startLevel = (unit - 1) * 5 + 1;
        final endLevel = unit * 5;
        query = query.gte('level', startLevel).lte('level', endLevel);
      }

      // 정렬 및 실행
      final response = await query.order('level', ascending: true) as List<dynamic>;

      final challenges = response.cast<Map<String, dynamic>>();

      // 필터링 없이 전체 조회했으면 캐시에 저장
      if (language == null && category == null && unit == null) {
        _cachedChallenges = challenges;
        _cacheTime = DateTime.now();
        print('💾 [CACHE] Saved ${challenges.length} challenges to cache');
      }

      print('✅ [SUCCESS] Fetched ${challenges.length} challenges');
      return challenges;
    } catch (e) {
      print('❌ [ERROR] Failed to fetch challenges: $e');

      // 에러 시 캐시 반환 (있으면)
      if (_cachedChallenges != null) {
        print('📦 [FALLBACK] Using cached challenges due to error');
        return _filterChallenges(_cachedChallenges!, language, category, unit);
      }

      return [];
    }
  }

  /// 캐시된 데이터 필터링
  static List<Map<String, dynamic>> _filterChallenges(
    List<Map<String, dynamic>> challenges,
    String? language,
    String? category,
    int? unit,
  ) {
    var filtered = challenges;

    if (language != null) {
      filtered = filtered.where((c) => c['language'] == language).toList();
    }

    if (category != null) {
      filtered = filtered.where((c) => c['category'] == category).toList();
    }

    if (unit != null) {
      final startLevel = (unit - 1) * 5 + 1;
      final endLevel = unit * 5;
      filtered = filtered.where((c) {
        final level = c['level'];
        return level != null && level >= startLevel && level <= endLevel;
      }).toList();
    }

    print('🔍 [FILTER] Filtered to ${filtered.length} challenges');
    return filtered;
  }

  /// 특정 챌린지 상세 조회
  static Future<Map<String, dynamic>?> fetchOne(String slug) async {
    try {
      print('🔍 [FETCH] Fetching challenge: $slug');

      // 먼저 캐시에서 찾기
      if (_cachedChallenges != null) {
        final cached = _cachedChallenges!.firstWhere(
          (c) => c['slug'] == slug,
          orElse: () => {},
        );

        if (cached.isNotEmpty) {
          print('📦 [CACHE] Found challenge in cache');
          return cached;
        }
      }

      // Supabase에서 조회
      final response = await _supabase
          .from('challenges')
          .select()
          .eq('slug', slug)
          .maybeSingle();

      if (response == null) {
        print('❌ [NOT FOUND] Challenge not found: $slug');
        return null;
      }

      print('✅ [SUCCESS] Fetched challenge: $slug');
      return response as Map<String, dynamic>;
    } catch (e) {
      print('❌ [ERROR] Failed to fetch challenge $slug: $e');
      return null;
    }
  }

  /// 언어별 챌린지 개수 조회
  static Future<Map<String, int>> getCountsByLanguage() async {
    try {
      print('📊 [STATS] Fetching challenge counts by language...');

      final response = await _supabase.from('challenges').select('language');

      final challenges = (response as List<dynamic>).cast<Map<String, dynamic>>();

      final counts = <String, int>{};
      for (var challenge in challenges) {
        final lang = challenge['language'] as String;
        counts[lang] = (counts[lang] ?? 0) + 1;
      }

      print('✅ [STATS] Language counts: $counts');
      return counts;
    } catch (e) {
      print('❌ [ERROR] Failed to fetch counts: $e');
      return {};
    }
  }

  /// 캐시 초기화
  static void clearCache() {
    _cachedChallenges = null;
    _cacheTime = null;
    print('🗑️ [CACHE] Cache cleared');
  }

  /// 캐시 프리로드 (앱 시작 시 호출 권장)
  static Future<void> preloadCache() async {
    print('⏳ [PRELOAD] Preloading challenges...');
    await fetchAll();
    print('✅ [PRELOAD] Challenges preloaded');
  }
}
