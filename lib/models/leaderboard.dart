class LeaderboardEntry {
  final int rank;
  final String userId;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final int solvedTotal;
  final int currentStreak;
  final bool isMe;

  LeaderboardEntry({
    required this.rank,
    required this.userId,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    required this.solvedTotal,
    required this.currentStreak,
    required this.isMe,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      rank: json['rank'] as int,
      userId: json['userId'] as String,
      username: json['username'] as String? ?? 'anonymous',
      displayName: json['displayName'] as String? ?? 'Anonymous User',
      avatarUrl: json['avatarUrl'] as String?,
      solvedTotal: json['solvedTotal'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      isMe: json['isMe'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'userId': userId,
      'username': username,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'solvedTotal': solvedTotal,
      'currentStreak': currentStreak,
      'isMe': isMe,
    };
  }
}

class Leaderboard {
  final List<LeaderboardEntry> entries;
  final int myRank;
  final int totalFriends;

  Leaderboard({
    required this.entries,
    required this.myRank,
    required this.totalFriends,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      entries: (json['leaderboard'] as List<dynamic>?)
              ?.map((e) => LeaderboardEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      myRank: json['myRank'] as int? ?? 0,
      totalFriends: json['totalFriends'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'leaderboard': entries.map((e) => e.toJson()).toList(),
      'myRank': myRank,
      'totalFriends': totalFriends,
    };
  }

  LeaderboardEntry? get myEntry => entries.firstWhere(
        (e) => e.isMe,
        orElse: () => LeaderboardEntry(
          rank: myRank,
          userId: '',
          username: 'me',
          displayName: 'Me',
          solvedTotal: 0,
          currentStreak: 0,
          isMe: true,
        ),
      );
}

// Global Leaderboard Entry (v1.1)
class GlobalLeaderboardEntry {
  final int rank;
  final String userEmail;
  final String username;
  final String displayName;
  final int totalScore;
  final int totalCorrect;
  final double avgAccuracy;

  GlobalLeaderboardEntry({
    required this.rank,
    required this.userEmail,
    required this.username,
    required this.displayName,
    required this.totalScore,
    required this.totalCorrect,
    required this.avgAccuracy,
  });

  factory GlobalLeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return GlobalLeaderboardEntry(
      rank: json['rank'] as int,
      userEmail: json['userEmail'] as String,
      username: json['username'] as String? ?? 'anonymous',
      displayName: json['displayName'] as String? ?? 'Anonymous User',
      totalScore: json['totalScore'] as int? ?? 0,
      totalCorrect: json['totalCorrect'] as int? ?? 0,
      avgAccuracy: (json['avgAccuracy'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'userEmail': userEmail,
      'username': username,
      'displayName': displayName,
      'totalScore': totalScore,
      'totalCorrect': totalCorrect,
      'avgAccuracy': avgAccuracy,
    };
  }
}

// Weekly Leaderboard Entry (v1.1)
class WeeklyLeaderboardEntry {
  final int rank;
  final String userEmail;
  final String username;
  final String displayName;
  final int scoreThisWeek;
  final int correctThisWeek;

  WeeklyLeaderboardEntry({
    required this.rank,
    required this.userEmail,
    required this.username,
    required this.displayName,
    required this.scoreThisWeek,
    required this.correctThisWeek,
  });

  factory WeeklyLeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return WeeklyLeaderboardEntry(
      rank: json['rank'] as int,
      userEmail: json['userEmail'] as String,
      username: json['username'] as String? ?? 'anonymous',
      displayName: json['displayName'] as String? ?? 'Anonymous User',
      scoreThisWeek: json['scoreThisWeek'] as int? ?? 0,
      correctThisWeek: json['correctThisWeek'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'userEmail': userEmail,
      'username': username,
      'displayName': displayName,
      'scoreThisWeek': scoreThisWeek,
      'correctThisWeek': correctThisWeek,
    };
  }
}
