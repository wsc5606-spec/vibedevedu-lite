import 'package:flutter/material.dart';
import '../models/friend.dart';
import '../models/leaderboard.dart';
import '../services/friends_service.dart';
import '../services/user_session.dart';
import '../widgets/top_app_bar.dart';

/// v1.9: 친구 페이지 개편
/// 3개 탭: 친구목록 / 친구랭킹 / DEV랭킹
class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  FriendsList? _friendsList;
  Leaderboard? _leaderboard;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      // Load token if not already loaded (v1.2 will handle proper auth)
      if (UserSession.token == null) {
        await UserSession.setMockToken();
      }

      final token = UserSession.token!;
      final friends = await FriendsService.getFriends(token);
      final leaderboard = await FriendsService.getLeaderboard(token);

      setState(() {
        _friendsList = friends;
        _leaderboard = leaderboard;
        _isLoading = false;
      });

      // Fallback to mock data if API fails
      if (friends == null || leaderboard == null) {
        final mockFriends = await FriendsService.getMockFriendsList();
        final mockLeaderboard = await FriendsService.getMockLeaderboard();
        setState(() {
          _friendsList = mockFriends;
          _leaderboard = mockLeaderboard;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading friends data: $e');
      // Use mock data as fallback
      final mockFriends = await FriendsService.getMockFriendsList();
      final mockLeaderboard = await FriendsService.getMockLeaderboard();
      setState(() {
        _friendsList = mockFriends;
        _leaderboard = mockLeaderboard;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const VibDevTopAppBar(
        title: '친구',
      ),
      body: Column(
        children: [
          // 탭바
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: '친구목록'),
                Tab(text: '친구랭킹'),
                Tab(text: 'DEV랭킹'),
              ],
            ),
          ),

          // 탭 내용
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildFriendsListTab(),
                      _buildFriendRankingTab(),
                      _buildLeaderboardTab(),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddFriendDialog,
        icon: const Icon(Icons.person_add),
        label: const Text('친구 추가'),
      ),
    );
  }

  Widget _buildLeaderboardTab() {
    if (_leaderboard == null || _leaderboard!.entries.isEmpty) {
      return const Center(
        child: Text('리더보드 데이터가 없습니다'),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _leaderboard!.entries.length,
        itemBuilder: (context, index) {
          final entry = _leaderboard!.entries[index];
          return _buildLeaderboardCard(entry);
        },
      ),
    );
  }

  Widget _buildLeaderboardCard(LeaderboardEntry entry) {
    final isMe = entry.isMe;
    final rankColor = entry.rank == 1
        ? Colors.amber
        : entry.rank == 2
            ? Colors.grey[400]
            : entry.rank == 3
                ? Colors.brown[300]
                : Colors.blue;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isMe ? Colors.blue[50] : null,
      elevation: isMe ? 4 : 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: rankColor,
          child: Text(
            '#${entry.rank}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          entry.displayName,
          style: TextStyle(
            fontWeight: isMe ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Text('@${entry.username}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${entry.solvedTotal}개 해결',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(
              '${entry.currentStreak}일 연속',
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendRankingTab() {
    if (_friendsList == null || _friendsList!.friends.isEmpty) {
      return const Center(
        child: Text('친구 목록이 비어있습니다'),
      );
    }

    // 친구들을 크레딧 기준으로 정렬하여 랭킹 생성
    final friendRanking = List<Friend>.from(_friendsList!.friends)
      ..sort((a, b) => b.solvedTotal.compareTo(a.solvedTotal));

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: friendRanking.length,
        itemBuilder: (context, index) {
          final friend = friendRanking[index];
          final rank = index + 1;
          final rankColor = rank == 1
              ? Colors.amber
              : rank == 2
                  ? Colors.grey[400]
                  : rank == 3
                      ? Colors.brown[300]
                      : Colors.blue;

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: rankColor,
                child: Text(
                  '#$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: friend.avatarUrl != null
                        ? NetworkImage(friend.avatarUrl!)
                        : null,
                    child: friend.avatarUrl == null
                        ? const Icon(Icons.person, size: 12)
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      friend.displayName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              subtitle: Text('@${friend.username}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${friend.solvedTotal}개 해결',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${friend.currentStreak}일 연속',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFriendsListTab() {
    if (_friendsList == null) {
      return const Center(
        child: Text('친구 목록을 불러오지 못했습니다'),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // Pending requests section
          if (_friendsList!.pending.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                '대기 중인 요청',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ..._friendsList!.pending
                .map((request) => _buildPendingRequestCard(request)),
            const Divider(height: 32),
          ],

          // Friends list section
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              '친구 (${_friendsList!.friends.length}명)',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (_friendsList!.friends.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Text(
                  '아직 친구가 없습니다. 친구를 추가해보세요!',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ..._friendsList!.friends.map((friend) => _buildFriendCard(friend)),
        ],
      ),
    );
  }

  Widget _buildPendingRequestCard(FriendRequest request) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.orange[50],
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(request.displayName),
        subtitle: Text('@${request.username}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () => _acceptFriend(request.friendshipId),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () => _rejectFriend(request.friendshipId),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendCard(Friend friend) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: friend.avatarUrl != null
              ? NetworkImage(friend.avatarUrl!)
              : null,
          child: friend.avatarUrl == null
              ? const Icon(Icons.person)
              : null,
        ),
        title: Text(friend.displayName),
        subtitle: Text('@${friend.username}'),
        trailing: Text(
          '${friend.solvedTotal}개 해결',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () => _viewFriendProfile(friend),
      ),
    );
  }

  Future<void> _showAddFriendDialog() async {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('친구 추가'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '사용자 이름 입력',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () async {
              final username = controller.text.trim();
              if (username.isEmpty) {
                return;
              }

              Navigator.pop(context);

              // Send friend request via API
              final token = UserSession.token!;
              final success =
                  await FriendsService.sendFriendRequest(token, username);

              if (!mounted) return;

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('친구 요청을 보냈습니다!'),
                    backgroundColor: Colors.green,
                  ),
                );
                _loadData();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('친구 요청을 보내지 못했습니다'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('요청 보내기'),
          ),
        ],
      ),
    );
  }

  Future<void> _acceptFriend(String friendshipId) async {
    final token = UserSession.token!;
    final success = await FriendsService.acceptFriendRequest(token, friendshipId);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('친구 요청을 수락했습니다!'),
          backgroundColor: Colors.green,
        ),
      );
      _loadData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('친구 요청을 수락하지 못했습니다'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _rejectFriend(String friendshipId) async {
    final token = UserSession.token!;
    final success = await FriendsService.deleteFriend(token, friendshipId);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('친구 요청을 거절했습니다'),
          backgroundColor: Colors.orange,
        ),
      );
      _loadData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('친구 요청을 거절하지 못했습니다'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _viewFriendProfile(Friend friend) {
    // TODO: Navigate to friend profile page
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(friend.displayName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('사용자 이름: @${friend.username}'),
            Text('해결: ${friend.solvedTotal}개 챌린지'),
            Text('현재 연속: ${friend.currentStreak}일'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }
}
