import 'package:http/http.dart' as http;
import 'dart:convert';

/// AI 챗봇 서비스
/// OpenAI API 또는 자체 백엔드와 연동
class AiChatbotService {
  static const String _baseUrl = 'http://127.0.0.1:8080'; // 백엔드 URL
  static const String _apiEndpoint = '/ai/chat'; // AI 챗봇 엔드포인트

  /// AI 챗봇에게 메시지 전송
  ///
  /// [message]: 사용자 메시지
  /// Returns: AI의 응답 텍스트
  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$_apiEndpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': message,
          'model': 'gpt-3.5-turbo', // 또는 다른 모델
          'temperature': 0.7,
          'max_tokens': 500,
        }),
      ).timeout(
        const Duration(seconds: 30),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? data['message'] ?? '응답을 받지 못했습니다.';
      } else {
        throw Exception('API 오류: ${response.statusCode}');
      }
    } catch (e) {
      print('[AiChatbotService] Error: $e');
      rethrow;
    }
  }

  /// 대화 기록과 함께 메시지 전송 (컨텍스트 유지)
  ///
  /// [messages]: 이전 대화 기록
  /// Returns: AI의 응답 텍스트
  static Future<String> sendMessageWithContext(
    List<Map<String, String>> messages,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$_apiEndpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'messages': messages,
          'model': 'gpt-3.5-turbo',
          'temperature': 0.7,
          'max_tokens': 500,
        }),
      ).timeout(
        const Duration(seconds: 30),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? data['message'] ?? '응답을 받지 못했습니다.';
      } else {
        throw Exception('API 오류: ${response.statusCode}');
      }
    } catch (e) {
      print('[AiChatbotService] Error: $e');
      rethrow;
    }
  }

  /// 코드 리뷰 요청
  ///
  /// [code]: 리뷰할 코드
  /// [language]: 프로그래밍 언어
  /// Returns: AI의 코드 리뷰 결과
  static Future<String> requestCodeReview(String code, String language) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/ai/code-review'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'code': code,
          'language': language,
        }),
      ).timeout(
        const Duration(seconds: 30),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['review'] ?? '리뷰를 받지 못했습니다.';
      } else {
        throw Exception('API 오류: ${response.statusCode}');
      }
    } catch (e) {
      print('[AiChatbotService] Code Review Error: $e');
      rethrow;
    }
  }

  /// 코드 설명 요청
  ///
  /// [code]: 설명이 필요한 코드
  /// [language]: 프로그래밍 언어
  /// Returns: AI의 코드 설명
  static Future<String> requestCodeExplanation(
    String code,
    String language,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/ai/explain'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'code': code,
          'language': language,
        }),
      ).timeout(
        const Duration(seconds: 30),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['explanation'] ?? '설명을 받지 못했습니다.';
      } else {
        throw Exception('API 오류: ${response.statusCode}');
      }
    } catch (e) {
      print('[AiChatbotService] Explanation Error: $e');
      rethrow;
    }
  }

  /// 힌트 요청
  ///
  /// [challengeSlug]: 챌린지 슬러그
  /// [userCode]: 사용자가 작성한 코드 (선택)
  /// Returns: AI가 생성한 힌트
  static Future<String> requestHint(
    String challengeSlug, [
    String? userCode,
  ]) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/ai/hint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'challengeSlug': challengeSlug,
          if (userCode != null) 'userCode': userCode,
        }),
      ).timeout(
        const Duration(seconds: 30),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['hint'] ?? '힌트를 받지 못했습니다.';
      } else {
        throw Exception('API 오류: ${response.statusCode}');
      }
    } catch (e) {
      print('[AiChatbotService] Hint Error: $e');
      rethrow;
    }
  }
}
