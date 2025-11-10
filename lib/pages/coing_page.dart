import 'package:flutter/material.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

/// VibeDev v1.8 코잉(Co-ing) 페이지
/// 보상 시스템, 크레딧, 배지 등 표시
class CoingPage extends StatelessWidget {
  const CoingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const VibDevTopAppBar(
        title: '코잉',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '코잉 (Co-ing)',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '함께 성장하며 보상을 받아보세요',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // 크레딧 카드
          Card(
            color: colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: colorScheme.primary,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '내 크레딧',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '1,250',
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'credits',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 배지
          Text(
            '획득한 배지',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _BadgeCard(
                  icon: Icons.star,
                  title: '첫 챌린지',
                  color: Colors.amber,
                ),
                _BadgeCard(
                  icon: Icons.local_fire_department,
                  title: '3일 연속',
                  color: Colors.orange,
                ),
                _BadgeCard(
                  icon: Icons.emoji_events,
                  title: '10개 완료',
                  color: Colors.purple,
                ),
                _BadgeCard(
                  icon: Icons.rocket_launch,
                  title: '빠른 완료',
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 일일 미션
          Text(
            '일일 미션',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                _MissionItem(
                  title: '챌린지 1개 완료하기',
                  reward: '+100 크레딧',
                  isCompleted: true,
                ),
                const Divider(height: 1),
                _MissionItem(
                  title: '힌트 없이 완료하기',
                  reward: '+150 크레딧',
                  isCompleted: false,
                ),
                const Divider(height: 1),
                _MissionItem(
                  title: '친구 1명 추가하기',
                  reward: '+200 크레딧',
                  isCompleted: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 보상 사용
          Text(
            '크레딧 사용하기',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.lightbulb, color: Colors.amber),
                  title: const Text('힌트 보기'),
                  subtitle: const Text('50 크레딧'),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('사용'),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.code, color: Colors.blue),
                  title: const Text('AI 코드 분석'),
                  subtitle: const Text('100 크레딧'),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('사용'),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.school, color: Colors.green),
                  title: const Text('프리미엄 강의 잠금 해제'),
                  subtitle: const Text('500 크레딧'),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('사용'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 3, // 코잉
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _BadgeCard({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(right: 12),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _MissionItem extends StatelessWidget {
  final String title;
  final String reward;
  final bool isCompleted;

  const _MissionItem({
    required this.title,
    required this.reward,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        isCompleted ? Icons.check_circle : Icons.circle_outlined,
        color: isCompleted ? Colors.green : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          decoration: isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Text(
        reward,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
