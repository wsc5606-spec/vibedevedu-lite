/// VIBE톡톡 피드 포스트 모델
class FeedPost {
  final String id;
  final String userId;
  final String content;
  final String postType;
  final String? challengeSlug;
  final String? codeSnippet;
  final String? language;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  // 사용자 정보 (profiles join)
  final String? username;
  final String? displayName;
  final String? avatarUrl;

  FeedPost({
    required this.id,
    required this.userId,
    required this.content,
    required this.postType,
    this.challengeSlug,
    this.codeSnippet,
    this.language,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.updatedAt,
    this.username,
    this.displayName,
    this.avatarUrl,
  });

  factory FeedPost.fromJson(Map<String, dynamic> json) {
    // 백엔드 응답: 'profiles' 또는 'user_profiles' 모두 지원
    final profiles = json['user_profiles'] ?? json['profiles'];

    return FeedPost(
      id: json['post_id'] ?? json['id'],
      userId: json['user_id'],
      content: json['content'],
      postType: json['post_type'] ?? 'text',
      challengeSlug: json['challenge_slug'],
      codeSnippet: json['code_snippet'],
      language: json['language'],
      likesCount: json['like_count'] ?? json['likes_count'] ?? 0,
      commentsCount: json['comment_count'] ?? json['comments_count'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      username: profiles?['username'] ?? profiles?['email'],
      displayName: profiles?['display_name'],
      avatarUrl: profiles?['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'content': content,
      'post_type': postType,
      'challenge_slug': challengeSlug,
      'code_snippet': codeSnippet,
      'language': language,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String getUserDisplayName() {
    return displayName ?? username ?? 'Anonymous';
  }

  String getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}년 전';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}개월 전';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}
