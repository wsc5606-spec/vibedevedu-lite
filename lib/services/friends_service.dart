import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/friend.dart';
import '../models/leaderboard.dart';

class FriendsService {
  static const String baseUrl = 'http://localhost:8080';

  /// Get list of friends and pending requests
  static Future<FriendsList?> getFriends(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/friends'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['ok'] == true) {
          return FriendsList.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching friends: $e');
      return null;
    }
  }

  /// Send a friend request
  static Future<bool> sendFriendRequest(String token, String username) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/friends/request'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'username': username}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['ok'] == true && data['success'] == true;
      }
      return false;
    } catch (e) {
      print('Error sending friend request: $e');
      return false;
    }
  }

  /// Accept a friend request
  static Future<bool> acceptFriendRequest(
      String token, String friendshipId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/friends/accept/$friendshipId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['ok'] == true && data['success'] == true;
      }
      return false;
    } catch (e) {
      print('Error accepting friend request: $e');
      return false;
    }
  }

  /// Delete a friendship
  static Future<bool> deleteFriend(String token, String friendshipId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/friends/$friendshipId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['ok'] == true && data['success'] == true;
      }
      return false;
    } catch (e) {
      print('Error deleting friend: $e');
      return false;
    }
  }

  /// Get friends leaderboard
  static Future<Leaderboard?> getLeaderboard(
    String token, {
    String metric = 'solved_total',
    int limit = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/friends/leaderboard?metric=$metric&limit=$limit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['ok'] == true) {
          return Leaderboard.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching leaderboard: $e');
      return null;
    }
  }

  /// Search users by username
  static Future<List<Map<String, dynamic>>> searchUsers(
      String token, String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/friends/search?q=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['ok'] == true && data['users'] != null) {
          return List<Map<String, dynamic>>.from(data['users']);
        }
      }
      return [];
    } catch (e) {
      print('Error searching users: $e');
      return [];
    }
  }

  /// Mock data for development
  static Future<FriendsList> getMockFriendsList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return FriendsList(
      friends: [
        Friend(
          userId: 'friend-1',
          username: 'alice',
          displayName: 'Alice Johnson',
          solvedTotal: 45,
          currentStreak: 7,
          status: 'accepted',
        ),
        Friend(
          userId: 'friend-2',
          username: 'bob',
          displayName: 'Bob Smith',
          avatarUrl: null,
          solvedTotal: 32,
          currentStreak: 3,
          status: 'accepted',
        ),
      ],
      pending: [
        FriendRequest(
          friendshipId: 'req-1',
          userId: 'user-3',
          username: 'charlie',
          displayName: 'Charlie Brown',
          requestedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ],
    );
  }

  static Future<Leaderboard> getMockLeaderboard() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Leaderboard(
      entries: [
        LeaderboardEntry(
          rank: 1,
          userId: 'friend-1',
          username: 'alice',
          displayName: 'Alice Johnson',
          solvedTotal: 52,
          currentStreak: 8,
          isMe: false,
        ),
        LeaderboardEntry(
          rank: 2,
          userId: 'me',
          username: 'me',
          displayName: 'Me',
          solvedTotal: 37,
          currentStreak: 5,
          isMe: true,
        ),
        LeaderboardEntry(
          rank: 3,
          userId: 'friend-2',
          username: 'bob',
          displayName: 'Bob Smith',
          solvedTotal: 32,
          currentStreak: 3,
          isMe: false,
        ),
      ],
      myRank: 2,
      totalFriends: 5,
    );
  }
}
