class Friend {
  final String userId;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final int solvedTotal;
  final int currentStreak;
  final String status; // 'pending', 'accepted', 'blocked'

  Friend({
    required this.userId,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    required this.solvedTotal,
    required this.currentStreak,
    required this.status,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      userId: json['userId'] as String,
      username: json['username'] as String? ?? 'anonymous',
      displayName: json['displayName'] as String? ?? 'Anonymous User',
      avatarUrl: json['avatarUrl'] as String?,
      solvedTotal: json['solvedTotal'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      status: json['status'] as String? ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'solvedTotal': solvedTotal,
      'currentStreak': currentStreak,
      'status': status,
    };
  }

  bool get isAccepted => status == 'accepted';
  bool get isPending => status == 'pending';
  bool get isBlocked => status == 'blocked';
}

class FriendRequest {
  final String friendshipId;
  final String userId;
  final String username;
  final String displayName;
  final DateTime requestedAt;

  FriendRequest({
    required this.friendshipId,
    required this.userId,
    required this.username,
    required this.displayName,
    required this.requestedAt,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      friendshipId: json['friendshipId'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String? ?? 'anonymous',
      displayName: json['displayName'] as String? ?? 'Anonymous User',
      requestedAt: DateTime.parse(json['requestedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'friendshipId': friendshipId,
      'userId': userId,
      'username': username,
      'displayName': displayName,
      'requestedAt': requestedAt.toIso8601String(),
    };
  }
}

class FriendsList {
  final List<Friend> friends;
  final List<FriendRequest> pending;

  FriendsList({
    required this.friends,
    required this.pending,
  });

  factory FriendsList.fromJson(Map<String, dynamic> json) {
    return FriendsList(
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => Friend.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pending: (json['pending'] as List<dynamic>?)
              ?.map((e) => FriendRequest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'friends': friends.map((e) => e.toJson()).toList(),
      'pending': pending.map((e) => e.toJson()).toList(),
    };
  }
}
