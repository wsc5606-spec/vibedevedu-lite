import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

/// v2.2: 알림 서비스
class NotificationService {
  /// 알림 목록 조회
  static Future<List<Map<String, dynamic>>> getNotifications(
    String userId, {
    int limit = 50,
  }) async {
    try {
      final res = await http.get(
        Uri.parse('${ApiConfig.base}/notifications/$userId?limit=$limit'),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return List<Map<String, dynamic>>.from(data['notifications'] ?? []);
      }
      return [];
    } catch (e) {
      print('Get Notifications Error: $e');
      return [];
    }
  }

  /// 읽지 않은 알림 개수
  static Future<int> getUnreadCount(String userId) async {
    try {
      final res = await http.get(
        Uri.parse('${ApiConfig.base}/notifications/$userId/unread'),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['count'] ?? 0;
      }
      return 0;
    } catch (e) {
      print('Get Unread Count Error: $e');
      return 0;
    }
  }

  /// 알림 읽음 처리
  static Future<bool> markAsRead({
    required String notificationId,
    required String userId,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ApiConfig.base}/notifications/read/$notificationId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      );

      return res.statusCode == 200;
    } catch (e) {
      print('Mark As Read Error: $e');
      return false;
    }
  }

  /// 모든 알림 읽음 처리
  static Future<bool> markAllAsRead(String userId) async {
    try {
      final res = await http.post(
        Uri.parse('${ApiConfig.base}/notifications/read-all'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      );

      return res.statusCode == 200;
    } catch (e) {
      print('Mark All As Read Error: $e');
      return false;
    }
  }

  /// 알림 삭제
  static Future<bool> deleteNotification({
    required String notificationId,
    required String userId,
  }) async {
    try {
      final res = await http.delete(
        Uri.parse(
            '${ApiConfig.base}/notifications/$notificationId?userId=$userId'),
      );

      return res.statusCode == 200;
    } catch (e) {
      print('Delete Notification Error: $e');
      return false;
    }
  }
}
