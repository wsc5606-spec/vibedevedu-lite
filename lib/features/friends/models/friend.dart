/// 친구 모델
class Friend {
  final String userId;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final int solvedCount;
  final double accuracy;
  final int currentStreak;
  final String status; // 'accepted', 'pending', 'requested'
  final DateTime createdAt;

  Friend({
    required this.userId,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    required this.solvedCount,
    required this.accuracy,
    required this.currentStreak,
    required this.status,
    required this.createdAt,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      userId: json['user_id'] ?? json['userId'] ?? '',
      username: json['username'] ?? 'Unknown',
      displayName: json['display_name'] ?? json['displayName'] ?? 'Unknown',
      avatarUrl: json['avatar_url'] ?? json['avatarUrl'],
      solvedCount: json['solved_count'] ?? json['solvedCount'] ?? 0,
      accuracy: (json['accuracy'] ?? 0.0).toDouble(),
      currentStreak: json['current_streak'] ?? json['currentStreak'] ?? 0,
      status: json['status'] ?? 'accepted',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'solved_count': solvedCount,
      'accuracy': accuracy,
      'current_streak': currentStreak,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// 친구 요청 대기 중인지
  bool get isPending => status == 'pending';

  /// 친구 요청을 보낸 상태인지
  bool get isRequested => status == 'requested';

  /// 친구 상태인지
  bool get isAccepted => status == 'accepted';
}

/// 친구 리더보드 엔트리
class FriendLeaderboardEntry {
  final int rank;
  final Friend friend;
  final bool isCurrentUser;

  FriendLeaderboardEntry({
    required this.rank,
    required this.friend,
    this.isCurrentUser = false,
  });

  factory FriendLeaderboardEntry.fromJson(Map<String, dynamic> json, int rank) {
    return FriendLeaderboardEntry(
      rank: rank,
      friend: Friend.fromJson(json),
      isCurrentUser: json['is_current_user'] ?? false,
    );
  }
}
