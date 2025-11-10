import 'package:flutter/material.dart';
import '../models/feed_post.dart';
import '../services/feed_service.dart';
import '../services/user_session.dart';

/// 피드 포스트 카드 위젯
class FeedPostCard extends StatefulWidget {
  final FeedPost post;
  final VoidCallback? onDeleted;
  final VoidCallback? onLikeChanged;

  const FeedPostCard({
    super.key,
    required this.post,
    this.onDeleted,
    this.onLikeChanged,
  });

  @override
  State<FeedPostCard> createState() => _FeedPostCardState();
}

class _FeedPostCardState extends State<FeedPostCard> {
  late int _likesCount;
  late int _commentsCount;
  bool _isLiked = false;
  bool _showComments = false;
  List<Map<String, dynamic>> _comments = [];
  bool _isLoadingComments = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _likesCount = widget.post.likesCount;
    _commentsCount = widget.post.commentsCount;
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    final currentUserId = UserSession.userId;
    if (currentUserId == null) return;

    try {
      final isLiked = await FeedService.checkIfLiked(
        userId: currentUserId,
        postId: widget.post.id,
      );
      if (!mounted) return;
      setState(() {
        _isLiked = isLiked;
      });
    } catch (e) {
      print('Check If Liked Error: $e');
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _toggleLike() async {
    final currentUserId = UserSession.userId ?? '00000000-0000-0000-0000-000000000001';

    setState(() {
      _isLiked = !_isLiked;
      _likesCount += _isLiked ? 1 : -1;
    });

    try {
      if (_isLiked) {
        await FeedService.likePost(
          userId: currentUserId,
          postId: widget.post.id,
        );
      } else {
        await FeedService.unlikePost(
          userId: currentUserId,
          postId: widget.post.id,
        );
      }
      widget.onLikeChanged?.call();
    } catch (e) {
      // 에러 발생 시 원래대로 되돌리기
      setState(() {
        _isLiked = !_isLiked;
        _likesCount += _isLiked ? 1 : -1;
      });
      print('Toggle Like Error: $e');
    }
  }

  Future<void> _loadComments() async {
    if (_isLoadingComments) return;

    setState(() {
      _isLoadingComments = true;
      _showComments = !_showComments;
    });

    if (_showComments) {
      try {
        final comments = await FeedService.getComments(widget.post.id);
        if (!mounted) return;
        setState(() {
          _comments = comments;
          _isLoadingComments = false;
        });
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _isLoadingComments = false;
          _showComments = false;
        });
        print('Load Comments Error: $e');
      }
    } else {
      setState(() => _isLoadingComments = false);
    }
  }

  Future<void> _addComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    try {
      final comment = await FeedService.createComment(
        userId: UserSession.userId ?? '00000000-0000-0000-0000-000000000001',
        postId: widget.post.id,
        content: content,
      );

      if (!mounted) return;
      setState(() {
        _comments.add(comment);
        _commentsCount++;
        _commentController.clear();
      });
    } catch (e) {
      print('Add Comment Error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('댓글 작성 실패: $e')),
      );
    }
  }

  Future<void> _deletePost() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('포스트 삭제'),
        content: const Text('이 포스트를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await FeedService.deletePost(
        postId: widget.post.id,
        userId: UserSession.userId ?? '00000000-0000-0000-0000-000000000001',
      );

      if (!mounted) return;
      widget.onDeleted?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('포스트가 삭제되었습니다')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('삭제 실패: $e')),
      );
    }
  }

  Future<void> _showReportDialog() async {
    String? selectedReason;
    final TextEditingController descriptionController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('신고하기'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('신고 사유를 선택해주세요'),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                hint: const Text('사유 선택'),
                items: const [
                  DropdownMenuItem(value: 'spam', child: Text('스팸')),
                  DropdownMenuItem(value: 'harassment', child: Text('괴롭힘')),
                  DropdownMenuItem(value: 'hate_speech', child: Text('혐오 발언')),
                  DropdownMenuItem(value: 'inappropriate_content', child: Text('부적절한 콘텐츠')),
                  DropdownMenuItem(value: 'misinformation', child: Text('허위 정보')),
                  DropdownMenuItem(value: 'violence', child: Text('폭력적 콘텐츠')),
                  DropdownMenuItem(value: 'copyright', child: Text('저작권 침해')),
                  DropdownMenuItem(value: 'other', child: Text('기타')),
                ],
                onChanged: (value) {
                  selectedReason = value;
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '상세 설명 (선택사항)',
                  hintText: '신고 내용을 자세히 설명해주세요',
                  contentPadding: EdgeInsets.all(12),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.orange),
            child: const Text('신고'),
          ),
        ],
      ),
    );

    if (confirmed != true || selectedReason == null) {
      descriptionController.dispose();
      return;
    }

    try {
      await FeedService.reportContent(
        userId: UserSession.userId ?? '00000000-0000-0000-0000-000000000001',
        reportedItemType: 'post',
        reportedItemId: widget.post.id,
        reportedUserId: widget.post.userId,
        reason: selectedReason!,
        description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('신고가 접수되었습니다')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('신고 실패: $e')),
      );
    } finally {
      descriptionController.dispose();
    }
  }

  Future<void> _blockUser() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('사용자 차단'),
        content: Text('${widget.post.getUserDisplayName()} 님을 차단하시겠습니까?\n차단된 사용자의 게시글은 더 이상 표시되지 않습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('차단'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await FeedService.blockUser(
        userId: UserSession.userId ?? '00000000-0000-0000-0000-000000000001',
        blockedUserId: widget.post.userId,
      );

      if (!mounted) return;
      widget.onDeleted?.call(); // 차단 후 게시글 제거
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.post.getUserDisplayName()} 님을 차단했습니다')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('차단 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentUserId = UserSession.userId ?? '00000000-0000-0000-0000-000000000001';
    final isOwnPost = currentUserId == widget.post.userId;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      color: isDark ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더 (프로필 정보)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // 프로필 아바타
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF00E5FF),
                  child: Text(
                    widget.post.getUserDisplayName()[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // 사용자 정보
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.getUserDisplayName(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        widget.post.getTimeAgo(),
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                // 메뉴 버튼
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 본인 포스트: 삭제 옵션
                            if (isOwnPost)
                              ListTile(
                                leading: const Icon(Icons.delete, color: Colors.red),
                                title: const Text(
                                  '삭제',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  _deletePost();
                                },
                              ),
                            // 신고 & 차단 옵션 (Google Play 정책) - 모든 게시글에 표시
                            ListTile(
                              leading: const Icon(Icons.flag, color: Colors.orange),
                              title: const Text('신고하기'),
                              onTap: () {
                                Navigator.pop(context);
                                _showReportDialog();
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.block, color: Colors.red),
                              title: const Text('사용자 차단'),
                              onTap: () {
                                Navigator.pop(context);
                                _blockUser();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // 포스트 내용
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.post.content,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.white : Colors.black87,
                height: 1.5,
              ),
            ),
          ),

          // 코드 스니펫 (있는 경우)
          if (widget.post.codeSnippet != null) ...[
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF00E5FF).withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.post.language != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E5FF).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.post.language!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF00E5FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    widget.post.codeSnippet!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16),

          // 좋아요, 댓글 수
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '좋아요 $_likesCount개',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '댓글 $_commentsCount개',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 16),

          // 액션 버튼들
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _toggleLike,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isLiked ? Icons.favorite : Icons.favorite_border,
                            color: _isLiked ? Colors.red : (isDark ? Colors.grey[400] : Colors.grey[600]),
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '좋아요',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.grey[400] : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: _loadComments,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_outlined,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '댓글',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.grey[400] : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 댓글 섹션
          if (_showComments) ...[
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.all(16),
              color: isDark ? Colors.grey[850] : Colors.grey[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 댓글 리스트
                  if (_isLoadingComments)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(
                          color: Color(0xFF00E5FF),
                        ),
                      ),
                    )
                  else if (_comments.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          '첫 댓글을 작성해보세요!',
                          style: TextStyle(
                            color: isDark ? Colors.grey[600] : Colors.grey[500],
                          ),
                        ),
                      ),
                    )
                  else
                    ...List.generate(_comments.length, (index) {
                      final comment = _comments[index];
                      final profiles = comment['user_profiles'];
                      final displayName =
                          profiles?['display_name'] ?? profiles?['username'] ?? 'Anonymous';

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: const Color(0xFF00E5FF).withOpacity(0.3),
                              child: Text(
                                displayName[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    displayName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    comment['content'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                  const SizedBox(height: 12),

                  // 댓글 입력
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: '댓글 작성...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: isDark ? Colors.grey[800] : Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            isDense: true,
                          ),
                          onSubmitted: (_) => _addComment(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFF00E5FF)),
                        onPressed: _addComment,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
