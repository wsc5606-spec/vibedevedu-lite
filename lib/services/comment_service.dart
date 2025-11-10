import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

/// v2.2: 댓글 서비스
class CommentService {
  /// 특정 챌린지의 댓글 조회
  static Future<List<Map<String, dynamic>>> getComments(
      String challengeId) async {
    try {
      final res = await http.get(
        Uri.parse('${ApiConfig.base}/comments/$challengeId'),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return List<Map<String, dynamic>>.from(data['comments'] ?? []);
      }
      return [];
    } catch (e) {
      print('Get Comments Error: $e');
      return [];
    }
  }

  /// 댓글 작성
  static Future<bool> createComment({
    required String userId,
    required String challengeId,
    required String content,
    String? parentId,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ApiConfig.base}/comments'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'challengeId': challengeId,
          'content': content,
          if (parentId != null) 'parentId': parentId,
        }),
      );

      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      print('Create Comment Error: $e');
      return false;
    }
  }

  /// 댓글 수정
  static Future<bool> updateComment({
    required String commentId,
    required String userId,
    required String content,
  }) async {
    try {
      final res = await http.put(
        Uri.parse('${ApiConfig.base}/comments/$commentId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'content': content,
        }),
      );

      return res.statusCode == 200;
    } catch (e) {
      print('Update Comment Error: $e');
      return false;
    }
  }

  /// 댓글 삭제
  static Future<bool> deleteComment({
    required String commentId,
    required String userId,
  }) async {
    try {
      final res = await http.delete(
        Uri.parse('${ApiConfig.base}/comments/$commentId?userId=$userId'),
      );

      return res.statusCode == 200;
    } catch (e) {
      print('Delete Comment Error: $e');
      return false;
    }
  }

  /// 댓글 추천
  static Future<bool> upvoteComment(String commentId) async {
    try {
      final res = await http.post(
        Uri.parse('${ApiConfig.base}/comments/$commentId/upvote'),
      );

      return res.statusCode == 200;
    } catch (e) {
      print('Upvote Comment Error: $e');
      return false;
    }
  }
}
