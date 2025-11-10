import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'user_session.dart';

/// v2.7 랭킹 서비스
class RankingsService {
  /// 전체 랭킹 조회
  static Future<Map<String, dynamic>> getGlobalRankings({int limit = 100}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.base}/rankings/global?limit=$limit'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'ok': false,
          'error': '서버 오류 (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'ok': false, 'error': '요청 실패: $e'};
    }
  }

  /// 일간 랭킹 조회
  static Future<Map<String, dynamic>> getDailyRankings({int limit = 100}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.base}/rankings/daily?limit=$limit'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'ok': false,
          'error': '서버 오류 (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'ok': false, 'error': '요청 실패: $e'};
    }
  }

  /// 주간 랭킹 조회
  static Future<Map<String, dynamic>> getWeeklyRankings({int limit = 100}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.base}/rankings/weekly?limit=$limit'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'ok': false,
          'error': '서버 오류 (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'ok': false, 'error': '요청 실패: $e'};
    }
  }

  /// 언어별 랭킹 조회
  static Future<Map<String, dynamic>> getLanguageRankings({
    required String language,
    int limit = 100,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.base}/rankings/lang/$language?limit=$limit'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'ok': false,
          'error': '서버 오류 (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'ok': false, 'error': '요청 실패: $e'};
    }
  }

  /// 사용자 랭킹 위치 조회
  static Future<Map<String, dynamic>> getUserRank(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.base}/rankings/user/$userId'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'ok': false,
          'error': '서버 오류 (${response.statusCode})',
        };
      }
    } catch (e) {
      return {'ok': false, 'error': '요청 실패: $e'};
    }
  }
}
