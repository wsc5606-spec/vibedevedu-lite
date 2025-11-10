import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'user_session.dart';

/// v2.7 히스토리 서비스
class HistoryService {
  /// 히스토리 목록 조회
  static Future<Map<String, dynamic>> getHistory({
    String? language,
    String? status,
    String? from,
    String? to,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final userId = UserSession.userId;
      if (userId == null) {
        return {'ok': false, 'error': '로그인이 필요합니다'};
      }

      final queryParams = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
      };
      if (language != null) queryParams['language'] = language;
      if (status != null) queryParams['status'] = status;
      if (from != null) queryParams['from'] = from;
      if (to != null) queryParams['to'] = to;

      final uri = Uri.parse('${ApiConfig.base}/history')
          .replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $userId'},
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

  /// 특정 시도 상세 조회
  static Future<Map<String, dynamic>> getAttempt(String attemptId) async {
    try {
      final userId = UserSession.userId;
      if (userId == null) {
        return {'ok': false, 'error': '로그인이 필요합니다'};
      }

      final response = await http.get(
        Uri.parse('${ApiConfig.base}/history/$attemptId'),
        headers: {'Authorization': 'Bearer $userId'},
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

  /// 챌린지 시도 저장
  static Future<Map<String, dynamic>> saveAttempt({
    required String challengeSlug,
    required String language,
    required int difficulty,
    required String status,
    required int passedTests,
    required int totalTests,
    required int runtimeMs,
    required String submittedCode,
    String? notes,
  }) async {
    try {
      final userId = UserSession.userId;
      if (userId == null) {
        return {'ok': false, 'error': '로그인이 필요합니다'};
      }

      final response = await http.post(
        Uri.parse('${ApiConfig.base}/history/attempt'),
        headers: {
          'Authorization': 'Bearer $userId',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'challengeSlug': challengeSlug,
          'language': language,
          'difficulty': difficulty,
          'status': status,
          'passedTests': passedTests,
          'totalTests': totalTests,
          'runtimeMs': runtimeMs,
          'submittedCode': submittedCode,
          if (notes != null) 'notes': notes,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  /// 재도전용 이전 코드 가져오기
  static Future<Map<String, dynamic>> getRedoCode({
    required String challengeSlug,
    String baseOn = 'latest_success',
  }) async {
    try {
      final userId = UserSession.userId;
      if (userId == null) {
        return {'ok': false, 'error': '로그인이 필요합니다'};
      }

      final response = await http.post(
        Uri.parse('${ApiConfig.base}/history/redo'),
        headers: {
          'Authorization': 'Bearer $userId',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'challengeSlug': challengeSlug,
          'baseOn': baseOn,
        }),
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

  /// 메모 업데이트
  static Future<Map<String, dynamic>> updateNotes({
    required String attemptId,
    required String notes,
  }) async {
    try {
      final userId = UserSession.userId;
      if (userId == null) {
        return {'ok': false, 'error': '로그인이 필요합니다'};
      }

      final response = await http.patch(
        Uri.parse('${ApiConfig.base}/history/$attemptId/notes'),
        headers: {
          'Authorization': 'Bearer $userId',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'notes': notes}),
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

  /// 사용자 통계 조회
  static Future<Map<String, dynamic>> getUserStats() async {
    try {
      final userId = UserSession.userId;
      if (userId == null) {
        return {'ok': false, 'error': '로그인이 필요합니다'};
      }

      final response = await http.get(
        Uri.parse('${ApiConfig.base}/history/stats'),
        headers: {'Authorization': 'Bearer $userId'},
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

  /// 언어별 통계 조회
  static Future<Map<String, dynamic>> getUserLangStats() async {
    try {
      final userId = UserSession.userId;
      if (userId == null) {
        return {'ok': false, 'error': '로그인이 필요합니다'};
      }

      final response = await http.get(
        Uri.parse('${ApiConfig.base}/history/stats/languages'),
        headers: {'Authorization': 'Bearer $userId'},
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
