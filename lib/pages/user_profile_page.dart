import 'package:flutter/material.dart';
import '../services/follow_service.dart';
import '../services/user_session.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

/// v2.2: 사용자 프로필 페이지 (팔로우 기능 포함)
class UserProfilePage extends StatefulWidget {
  final String userId;

  const UserProfilePage({super.key, required this.userId});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  bool _isFollowing = false;
  int _followerCount = 0;
  int _followingCount = 0;
  List<Map<String, dynamic>> _followers = [];
  List<Map<String, dynamic>> _following = [];

  bool get _isMyProfile => widget.userId == (UserSession.email ?? '');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadProfileData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadProfileData() async {
    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        FollowService.getFollowCounts(widget.userId),
        FollowService.getFollowers(widget.userId),
        FollowService.getFollowing(widget.userId),
        if (!_isMyProfile)
          FollowService.isFollowing(
            followerId: UserSession.email ?? 'guest',
            followingId: widget.userId,
          ),
      ]);

      final counts = results[0] as Map<String, int>;
      setState(() {
        _followerCount = counts['followerCount'] ?? 0;
        _followingCount = counts['followingCount'] ?? 0;
        _followers = results[1] as List<Map<String, dynamic>>;
        _following = results[2] as List<Map<String, dynamic>>;
        if (!_isMyProfile) {
          _isFollowing = results[3] as bool;
        }
      });
    } catch (e) {
      print('Load Profile Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleFollow() async {
    final currentUserId = UserSession.email ?? 'guest';
    if (currentUserId == 'guest') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인이 필요합니다')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      bool success;
      if (_isFollowing) {
        success = await FollowService.unfollowUser(
          followerId: currentUserId,
          followingId: widget.userId,
        );
      } else {
        success = await FollowService.followUser(
          followerId: currentUserId,
          followingId: widget.userId,
        );
      }

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isFollowing ? '언팔로우했습니다' : '팔로우했습니다'),
          ),
        );
        await _loadProfileData();
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VibDevTopAppBar(title: widget.userId),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey[900]!],
          ),
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.tealAccent),
              )
            : Column(
                children: [
                  // 프로필 헤더
                  _buildProfileHeader(),

                  // 팔로워/팔로잉 탭
                  Container(
                    color: Colors.grey[900],
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.tealAccent,
                      labelColor: Colors.tealAccent,
                      unselectedLabelColor: Colors.grey[500],
                      tabs: [
                        Tab(text: '팔로워 $_followerCount'),
                        Tab(text: '팔로잉 $_followingCount'),
                      ],
                    ),
                  ),

                  // 탭 뷰
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildUserList(_followers),
                        _buildUserList(_following),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 아바타
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.tealAccent.withOpacity(0.2),
            child: Text(
              widget.userId.isNotEmpty ? widget.userId[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.tealAccent,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 사용자명
          Text(
            widget.userId,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // 팔로우 통계
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatItem('팔로워', _followerCount),
              const SizedBox(width: 40),
              _buildStatItem('팔로잉', _followingCount),
            ],
          ),

          // 팔로우 버튼
          if (!_isMyProfile) ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _toggleFollow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFollowing ? Colors.grey[800] : Colors.tealAccent,
                  foregroundColor: _isFollowing ? Colors.white : Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: _isFollowing
                        ? BorderSide(color: Colors.grey.withOpacity(0.3))
                        : BorderSide.none,
                  ),
                ),
                child: Text(
                  _isFollowing ? '팔로잉' : '팔로우',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildUserList(List<Map<String, dynamic>> users) {
    if (users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 80, color: Colors.grey[700]),
            const SizedBox(height: 20),
            const Text(
              '아직 없습니다',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final userId = user['follower_email'] ?? user['following_email'] ?? '';

        return Card(
          color: Colors.grey[900],
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.tealAccent.withOpacity(0.2),
              child: Text(
                userId.isNotEmpty ? userId[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              userId,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.tealAccent,
              size: 16,
            ),
            onTap: () {
              if (userId != widget.userId) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserProfilePage(userId: userId),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
