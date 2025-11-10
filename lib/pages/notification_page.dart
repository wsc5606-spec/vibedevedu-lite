import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../services/user_session.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

/// v2.2: 알림 페이지
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = true;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() => _isLoading = true);
    try {
      final userId = UserSession.email ?? 'guest';
      final results = await Future.wait([
        NotificationService.getNotifications(userId),
        NotificationService.getUnreadCount(userId),
      ]);

      setState(() {
        _notifications = results[0] as List<Map<String, dynamic>>;
        _unreadCount = results[1] as int;
      });
    } catch (e) {
      print('Load Notifications Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _markAsRead(String notificationId) async {
    final success = await NotificationService.markAsRead(
      notificationId: notificationId,
      userId: UserSession.email ?? 'guest',
    );

    if (success) {
      await _loadNotifications();
    }
  }

  Future<void> _markAllAsRead() async {
    final success = await NotificationService.markAllAsRead(
      UserSession.email ?? 'guest',
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 알림을 읽음 처리했습니다')),
      );
      await _loadNotifications();
    }
  }

  Future<void> _deleteNotification(String notificationId) async {
    final success = await NotificationService.deleteNotification(
      notificationId: notificationId,
      userId: UserSession.email ?? 'guest',
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('알림이 삭제되었습니다')),
      );
      await _loadNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VibDevTopAppBar(
        title: '알림',
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey[900]!],
          ),
        ),
        child: Column(
          children: [
            if (_unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey[850],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '읽지 않은 알림 $_unreadCount개',
                      style: const TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: _markAllAsRead,
                      child: const Text(
                        '모두 읽음',
                        style: TextStyle(color: Colors.tealAccent),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.tealAccent),
                    )
                  : _notifications.isEmpty
                      ? _buildEmptyState()
                      : RefreshIndicator(
                          onRefresh: _loadNotifications,
                          color: Colors.tealAccent,
                          child: _buildNotificationList(),
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80, color: Colors.grey[700]),
          const SizedBox(height: 20),
          const Text(
            '알림이 없습니다',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 12),
          Text(
            '새로운 알림이 도착하면 여기에 표시됩니다',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        return _buildNotificationItem(_notifications[index]);
      },
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final id = notification['id'] ?? '';
    final type = notification['type'] ?? '';
    final title = notification['title'] ?? '';
    final content = notification['content'] ?? '';
    final isRead = notification['is_read'] ?? false;
    final createdAt = notification['created_at'] ?? '';

    IconData icon;
    Color iconColor;

    switch (type) {
      case 'comment':
        icon = Icons.chat_bubble;
        iconColor = Colors.blue;
        break;
      case 'follow':
        icon = Icons.person_add;
        iconColor = Colors.green;
        break;
      case 'like':
        icon = Icons.favorite;
        iconColor = Colors.red;
        break;
      case 'level_up':
        icon = Icons.trending_up;
        iconColor = Colors.amber;
        break;
      case 'badge':
        icon = Icons.emoji_events;
        iconColor = Colors.orange;
        break;
      case 'system':
        icon = Icons.info;
        iconColor = Colors.tealAccent;
        break;
      default:
        icon = Icons.notifications;
        iconColor = Colors.grey;
    }

    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _deleteNotification(id),
      child: Card(
        color: isRead ? Colors.grey[900] : Colors.grey[850],
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isRead
                ? Colors.grey.withOpacity(0.2)
                : Colors.tealAccent.withOpacity(0.3),
            width: isRead ? 1 : 2,
          ),
        ),
        child: InkWell(
          onTap: () {
            if (!isRead) {
              _markAsRead(id);
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 아이콘
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),

                // 내용
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                          ),
                          if (!isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.tealAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        content,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatTime(createdAt),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(String timestamp) {
    try {
      final date = DateTime.parse(timestamp);
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inMinutes < 1) return '방금 전';
      if (diff.inHours < 1) return '${diff.inMinutes}분 전';
      if (diff.inDays < 1) return '${diff.inHours}시간 전';
      if (diff.inDays < 7) return '${diff.inDays}일 전';
      return '${date.year}.${date.month}.${date.day}';
    } catch (e) {
      return timestamp;
    }
  }
}
