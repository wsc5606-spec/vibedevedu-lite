import '../../../core/services/api_service.dart';
import '../models/user_stats.dart';

/// 통계 API 서비스
class StatsService {
  final ApiService _api;

  StatsService(this._api);

  /// 내 통계 가져오기
  Future<UserStats> getMyStats() async {
    try {
      final response = await _api.get('/stats/me');

      if (response.data['ok'] == true) {
        return UserStats.fromJson(response.data['stats']);
      }

      throw ApiException('Failed to fetch stats');
    } catch (e) {
      print('[StatsService] Error fetching my stats: $e');
      return UserStats.empty();
    }
  }

  /// 전역 통계 가져오기
  Future<GlobalStats> getGlobalStats() async {
    try {
      final response = await _api.get('/stats/global');

      if (response.data['ok'] == true) {
        return GlobalStats.fromJson(response.data['stats']);
      }

      throw ApiException('Failed to fetch global stats');
    } catch (e) {
      print('[StatsService] Error fetching global stats: $e');
      rethrow;
    }
  }
}
