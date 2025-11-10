import 'package:flutter/material.dart';
import '../services/feed_service.dart';
import '../services/user_session.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/create_post_dialog.dart';
import '../widgets/feed_post_card.dart';
import '../models/feed_post.dart';

/// VIBE톡 - SNS 피드 페이지
class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<FeedPost> _friendsFeed = [];
  List<FeedPost> _globalFeed = [];
  List<FeedPost> _recommendedFeed = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging && mounted) {
        setState(() {});
      }
    });
    _loadFeeds();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadFeeds() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final results = await Future.wait([
        FeedService.getFollowingFeed(
          userId: UserSession.userId ?? '00000000-0000-0000-0000-000000000000',
          limit: 50,
        ),
        FeedService.getGlobalFeed(limit: 50),
        FeedService.getPopularFeed(), // 인기 상위 몇 개
      ]);

      if (!mounted) return;
      setState(() {
        _friendsFeed = results[0].map((json) => FeedPost.fromJson(json)).toList();
        _globalFeed = results[1].map((json) => FeedPost.fromJson(json)).toList();
        _recommendedFeed = results[2].map((json) => FeedPost.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Load Feeds Error: $e');
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _showCreatePostDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const CreatePostDialog(),
    );

    if (result == true) {
      _loadFeeds();
    }
  }

  void _onPostDeleted() {
    _loadFeeds();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: VibDevTopAppBar(
        title: 'VIBE톡',
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _showCreatePostDialog,
            tooltip: '게시글 작성',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    const Color(0xFF000000),
                    const Color(0xFF121212),
                  ]
                : [
                    Colors.grey[50]!,
                    Colors.grey[100]!,
                  ],
          ),
        ),
        child: Column(
          children: [
            Container(
              color: isDark ? Colors.grey[900] : Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF00E5FF),
                labelColor: const Color(0xFF00E5FF),
                unselectedLabelColor: isDark ? Colors.grey[500] : Colors.grey[600],
                tabs: const [
                  Tab(text: '팔로잉'),
                  Tab(text: '전체'),
                  Tab(text: '인기'),
                ],
              ),
            ),

            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF00E5FF),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadFeeds,
                      color: const Color(0xFF00E5FF),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildFeedList(_friendsFeed, 'following'),
                          _buildFeedList(_globalFeed, 'global'),
                          _buildFeedList(_recommendedFeed, 'popular'),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(currentIndex: 1), // Feed index 1
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePostDialog,
        backgroundColor: const Color(0xFF00E5FF),
        foregroundColor: Colors.black,
        child: const Icon(Icons.edit, size: 28),
      ),
    );
  }

  Widget _buildFeedList(List<FeedPost> feed, String type) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (feed.isEmpty) {
      final isFollowing = type == 'following';
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFollowing ? Icons.people_outline : Icons.explore_outlined,
              size: 80,
              color: isDark ? Colors.grey[700] : Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              isFollowing ? '팔로잉한 사용자의 활동이 없습니다' : '게시글이 없습니다',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isFollowing
                  ? '다른 사용자를 팔로우하고 활동을 확인하세요'
                  : '지금 첫 게시글을 만들어보세요!',
              style: TextStyle(
                color: isDark ? Colors.grey[500] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _showCreatePostDialog,
              icon: const Icon(Icons.edit),
              label: const Text('게시글 작성'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E5FF),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: feed.length,
      itemBuilder: (context, index) {
        return FeedPostCard(
          post: feed[index],
          onDeleted: _onPostDeleted,
          onLikeChanged: () {
            // like state changed
          },
        );
      },
    );
  }
}

