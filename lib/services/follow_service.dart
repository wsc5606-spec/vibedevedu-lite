import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

/// v2.6: 팔로우 서비스 - 실제 백엔드 연동
class FollowService {
  static String get _baseUrl => ApiConfig.baseUrl;

  /// 팔로우
  static Future<bool> followUser({
    required String followerId,
    required String followingId,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$_baseUrl/follows'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'followerId': followerId,
          'followingId': followingId,
        }),
      ).timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print('Follow User Error: $e');
      return false;
    }
  }

  /// 언팔로우
  static Future<bool> unfollowUser({
    required String followerId,
    required String followingId,
  }) async {
    try {
      final res = await http.delete(
        Uri.parse('$_baseUrl/follows'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'followerId': followerId,
          'followingId': followingId,
        }),
      ).timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print('Unfollow User Error: $e');
      return false;
    }
  }

  /// 팔로워 목록
  static Future<List<Map<String, dynamic>>> getFollowers(
    String userId, {
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final res = await http.get(
        Uri.parse('$_baseUrl/follows/followers/$userId?page=$page&limit=$limit'),
      ).timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['data'] ?? []);
        }
      }
      return [];
    } catch (e) {
      print('Get Followers Error: $e');
      return [];
    }
  }

  /// 팔로잉 목록
  static Future<List<Map<String, dynamic>>> getFollowing(
    String userId, {
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final res = await http.get(
        Uri.parse('$_baseUrl/follows/following/$userId?page=$page&limit=$limit'),
      ).timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['data'] ?? []);
        }
      }
      return [];
    } catch (e) {
      print('Get Following Error: $e');
      return [];
    }
  }

  /// 팔로우 여부 확인
  static Future<bool> isFollowing({
    required String followerId,
    required String followingId,
  }) async {
    try {
      final res = await http.get(
        Uri.parse('$_baseUrl/follows/check?followerId=$followerId&followingId=$followingId'),
      ).timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true) {
          return data['isFollowing'] ?? false;
        }
      }
      return false;
    } catch (e) {
      print('Check Follow Error: $e');
      return false;
    }
  }
}
