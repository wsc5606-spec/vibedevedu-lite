import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_config.dart';

/// VIBE톡톡 피드 서비스 - v2.6 실제 백엔드 연동
class FeedService {
  static String get _baseUrl => ApiConfig.base;

  // ============================================================================
  // POSTS
  // ============================================================================

  /// 전체 공개 피드 조회 (전체 게시글 - 최신순)
  static Future<List<Map<String, dynamic>>> getGlobalFeed({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/posts?page=$page&limit=$limit&sortBy=recent'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['data'] ?? []);
        }
        throw Exception('API returned success: false');
      } else {
        throw Exception('Failed to load global feed: ${response.statusCode}');
      }
    } catch (e) {
      print('Get Global Feed Error: $e');
      rethrow;
    }
  }

  /// 인기 피드 조회 (좋아요 많은 순 상위 3개)
  static Future<List<Map<String, dynamic>>> getPopularFeed() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/posts?sortBy=popular'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['data'] ?? []);
        }
        throw Exception('API returned success: false');
      } else {
        throw Exception('Failed to load popular feed: ${response.statusCode}');
      }
    } catch (e) {
      print('Get Popular Feed Error: $e');
      rethrow;
    }
  }

  /// 팔로잉 피드 조회 (팔로우한 사용자들의 게시글)
  static Future<List<Map<String, dynamic>>> getFollowingFeed({
    required String userId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/posts/following/$userId?page=$page&limit=$limit'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['data'] ?? []);
        }
        throw Exception('API returned success: false');
      } else {
        throw Exception('Failed to load following feed: ${response.statusCode}');
      }
    } catch (e) {
      print('Get Following Feed Error: $e');
      rethrow;
    }
  }

  /// 단일 포스트 조회
  static Future<Map<String, dynamic>> getPost(String postId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/posts/$postId'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
        throw Exception('API returned success: false');
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      print('Get Post Error: $e');
      rethrow;
    }
  }

  /// 포스트 작성
  static Future<Map<String, dynamic>> createPost({
    required String userId,
    required String content,
    String? imageUrl,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'content': content,
          if (imageUrl != null) 'imageUrl': imageUrl,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
        throw Exception('API returned success: false');
      } else {
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      print('Create Post Error: $e');
      rethrow;
    }
  }

  /// 포스트 수정
  static Future<Map<String, dynamic>> updatePost({
    required String postId,
    required String userId,
    required String content,
    String? imageUrl,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/posts/$postId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'content': content,
          if (imageUrl != null) 'imageUrl': imageUrl,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
        throw Exception('API returned success: false');
      } else {
        throw Exception('Failed to update post: ${response.statusCode}');
      }
    } catch (e) {
      print('Update Post Error: $e');
      rethrow;
    }
  }

  /// 포스트 삭제
  static Future<void> deletePost({
    required String postId,
    required String userId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/posts/$postId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to delete post: ${response.statusCode}');
      }
    } catch (e) {
      print('Delete Post Error: $e');
      rethrow;
    }
  }

  // ============================================================================
  // LIKES
  // ============================================================================

  /// 포스트 좋아요
  static Future<void> likePost({
    required String userId,
    required String postId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/posts/$postId/like'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to like post: ${response.statusCode}');
      }
    } catch (e) {
      print('Like Post Error: $e');
      rethrow;
    }
  }

  /// 포스트 좋아요 취소
  static Future<void> unlikePost({
    required String userId,
    required String postId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/posts/$postId/like'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to unlike post: ${response.statusCode}');
      }
    } catch (e) {
      print('Unlike Post Error: $e');
      rethrow;
    }
  }

  /// 좋아요 여부 확인
  static Future<bool> checkIfLiked({
    required String userId,
    required String postId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/posts/$postId/liked?userId=$userId'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['isLiked'] ?? false;
        }
        return false;
      } else {
        return false;
      }
    } catch (e) {
      print('Check If Liked Error: $e');
      return false;
    }
  }

  // ============================================================================
  // COMMENTS
  // ============================================================================

  /// 댓글 목록 조회
  static Future<List<Map<String, dynamic>>> getComments(
    String postId, {
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/comments/post/$postId?page=$page&limit=$limit'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['data'] ?? []);
        }
        throw Exception('API returned success: false');
      } else {
        throw Exception('Failed to load comments: ${response.statusCode}');
      }
    } catch (e) {
      print('Get Comments Error: $e');
      rethrow;
    }
  }

  /// 댓글 작성
  static Future<Map<String, dynamic>> createComment({
    required String userId,
    required String postId,
    required String content,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/comments'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'postId': postId,
          'content': content,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
        // 에러 메시지 상세히 출력
        print('Create Comment API Error: ${data['error']}');
        throw Exception('API returned success: false - ${data['error'] ?? 'Unknown error'}');
      } else {
        print('Create Comment HTTP Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to create comment: ${response.statusCode}');
      }
    } catch (e) {
      print('Create Comment Error: $e');
      rethrow;
    }
  }

  /// 댓글 수정
  static Future<Map<String, dynamic>> updateComment({
    required String commentId,
    required String userId,
    required String content,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/comments/$commentId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'content': content,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
        throw Exception('API returned success: false');
      } else {
        throw Exception('Failed to update comment: ${response.statusCode}');
      }
    } catch (e) {
      print('Update Comment Error: $e');
      rethrow;
    }
  }

  /// 댓글 삭제
  static Future<void> deleteComment({
    required String commentId,
    required String userId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/comments/$commentId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to delete comment: ${response.statusCode}');
      }
    } catch (e) {
      print('Delete Comment Error: $e');
      rethrow;
    }
  }

  /// 댓글 좋아요
  static Future<void> likeComment({
    required String userId,
    required String commentId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/comments/$commentId/like'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to like comment: ${response.statusCode}');
      }
    } catch (e) {
      print('Like Comment Error: $e');
      rethrow;
    }
  }

  /// 댓글 좋아요 취소
  static Future<void> unlikeComment({
    required String userId,
    required String commentId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/comments/$commentId/like'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to unlike comment: ${response.statusCode}');
      }
    } catch (e) {
      print('Unlike Comment Error: $e');
      rethrow;
    }
  }

  // ============================================================================
  // REPORTS - Google Play UGC Policy Compliance
  // ============================================================================

  /// 신고하기
  static Future<void> reportContent({
    required String userId,
    required String reportedItemType, // 'post', 'comment', 'user'
    String? reportedItemId,
    required String reportedUserId,
    required String reason,
    String? description,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/reports'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'reportedItemType': reportedItemType,
          'reportedItemId': reportedItemId,
          'reportedUserId': reportedUserId,
          'reason': reason,
          'description': description,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to report content: ${response.statusCode}');
      }
    } catch (e) {
      print('Report Content Error: $e');
      rethrow;
    }
  }

  // ============================================================================
  // BLOCKS - Google Play UGC Policy Compliance
  // ============================================================================

  /// 사용자 차단
  static Future<void> blockUser({
    required String userId,
    required String blockedUserId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/blocks'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'blockedUserId': blockedUserId,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to block user: ${response.statusCode}');
      }
    } catch (e) {
      print('Block User Error: $e');
      rethrow;
    }
  }

  /// 사용자 차단 해제
  static Future<void> unblockUser({
    required String userId,
    required String blockedUserId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/blocks/$blockedUserId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to unblock user: ${response.statusCode}');
      }
    } catch (e) {
      print('Unblock User Error: $e');
      rethrow;
    }
  }

  /// 차단한 사용자 목록 조회
  static Future<List<Map<String, dynamic>>> getBlockedUsers(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/blocks?userId=$userId'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['data'] ?? []);
        }
        throw Exception('API returned success: false');
      } else {
        throw Exception('Failed to load blocked users: ${response.statusCode}');
      }
    } catch (e) {
      print('Get Blocked Users Error: $e');
      rethrow;
    }
  }

  /// 차단 여부 확인
  static Future<bool> checkIfBlocked({
    required String userId,
    required String blockedUserId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/blocks/check?userId=$userId&blockedUserId=$blockedUserId'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['isBlocked'] ?? false;
        }
        return false;
      } else {
        return false;
      }
    } catch (e) {
      print('Check If Blocked Error: $e');
      return false;
    }
  }
}
