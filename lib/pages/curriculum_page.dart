import 'package:flutter/material.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

/// v2.2: 커리큘럼 페이지
/// 14개 바이브 코딩 커리큘럼 과정
class CurriculumPage extends StatelessWidget {
  const CurriculumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const VibDevTopAppBar(
        title: '커리큘럼',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 헤더
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    '🎓 바이브 코딩 커리큘럼',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '14개의 전문 과정으로 개발자 성장하기',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 바이브 코딩 기초 이해 과정
            _buildCourseCard(
              context: context,
              title: '바이브 코딩 기초 이해 과정',
              subtitle: '프로그래밍의 첫 걸음, 기초 개념부터 탄탄하게',
              icon: Icons.school,
              color: Colors.blue,
              onTap: () => _showComingSoon(context, '바이브 코딩 기초 이해 과정'),
            ),
            const SizedBox(height: 12),

            // 앱개발 기초 과정
            _buildCourseCard(
              context: context,
              title: '앱개발 기초 과정 (Flutter)',
              subtitle: 'Flutter로 시작하는 모바일 앱 개발',
              icon: Icons.phone_android,
              color: Colors.cyan,
              onTap: () => _showComingSoon(context, '앱개발 기초 과정'),
            ),
            const SizedBox(height: 12),

            // 웹개발 기초 과정
            _buildCourseCard(
              context: context,
              title: '웹개발 기초 과정',
              subtitle: 'HTML, CSS, JavaScript로 만드는 웹사이트',
              icon: Icons.web,
              color: Colors.orange,
              onTap: () => _showComingSoon(context, '웹개발 기초 과정'),
            ),
            const SizedBox(height: 12),

            // 바이브 코딩 앱개발 한방과정
            _buildCourseCard(
              context: context,
              title: '바이브 코딩 앱개발 한방과정',
              subtitle: '기초부터 실전까지 앱개발 완전정복',
              icon: Icons.mobile_screen_share,
              color: Colors.purple,
              onTap: () => _showComingSoon(context, '바이브 코딩 앱개발 한방과정'),
            ),
            const SizedBox(height: 12),

            // 바이브 코딩 웹개발 한방과정
            _buildCourseCard(
              context: context,
              title: '바이브 코딩 웹개발 한방과정',
              subtitle: '프론트엔드부터 백엔드까지 웹 풀스택',
              icon: Icons.language,
              color: Colors.indigo,
              onTap: () => _showComingSoon(context, '바이브 코딩 웹개발 한방과정'),
            ),
            const SizedBox(height: 12),

            // 데이터베이스·API 완전정복 과정
            _buildCourseCard(
              context: context,
              title: '데이터베이스·API 완전정복 과정',
              subtitle: 'DB 설계부터 RESTful API 구축까지',
              icon: Icons.storage,
              color: Colors.green,
              onTap: () => _showComingSoon(context, '데이터베이스·API 완전정복 과정'),
            ),
            const SizedBox(height: 12),

            // 머신러닝·AI 공부하기
            _buildCourseCard(
              context: context,
              title: '머신러닝·AI 공부하기',
              subtitle: 'Python으로 시작하는 AI/ML 기초',
              icon: Icons.psychology,
              color: Colors.pink,
              onTap: () => _showComingSoon(context, '머신러닝·AI 공부하기'),
            ),
            const SizedBox(height: 12),

            // AI 튜터 이해하기
            _buildCourseCard(
              context: context,
              title: 'AI 튜터 이해하기',
              subtitle: 'AI와 함께 효율적으로 학습하는 방법',
              icon: Icons.chat,
              color: Colors.teal,
              onTap: () => _showComingSoon(context, 'AI 튜터 이해하기'),
            ),
            const SizedBox(height: 12),

            // AI 프로젝트 실전 과정
            _buildCourseCard(
              context: context,
              title: 'AI 프로젝트 실전 과정',
              subtitle: 'ChatGPT API로 실전 프로젝트 구축',
              icon: Icons.auto_awesome,
              color: Colors.amber,
              onTap: () => _showComingSoon(context, 'AI 프로젝트 실전 과정'),
            ),
            const SizedBox(height: 12),

            // VibeDev 창업·성장 트랙
            _buildCourseCard(
              context: context,
              title: 'VibeDev 창업·성장 트랙',
              subtitle: '개발자에서 창업가로, 스타트업 성장 전략',
              icon: Icons.rocket_launch,
              color: Colors.deepOrange,
              onTap: () => _showComingSoon(context, 'VibeDev 창업·성장 트랙'),
            ),
            const SizedBox(height: 12),

            // AI 코드리뷰 챌린지 코스
            _buildCourseCard(
              context: context,
              title: 'AI 코드리뷰 챌린지 코스',
              subtitle: 'AI 피드백으로 코드 품질 향상시키기',
              icon: Icons.code,
              color: Colors.blueGrey,
              onTap: () => _showComingSoon(context, 'AI 코드리뷰 챌린지 코스'),
            ),
            const SizedBox(height: 12),

            // Supabase 실전코스
            _buildCourseCard(
              context: context,
              title: 'Supabase 실전코스',
              subtitle: 'Firebase 대안, Supabase로 빠른 백엔드 구축',
              icon: Icons.cloud,
              color: Colors.lightGreen,
              onTap: () => _showComingSoon(context, 'Supabase 실전코스'),
            ),
            const SizedBox(height: 12),

            // Firebase Functions 자동화 코스
            _buildCourseCard(
              context: context,
              title: 'Firebase Functions 자동화 코스',
              subtitle: '서버리스 아키텍처로 자동화 시스템 구축',
              icon: Icons.functions,
              color: Colors.deepPurple,
              onTap: () => _showComingSoon(context, 'Firebase Functions 자동화 코스'),
            ),
            const SizedBox(height: 12),

            // Go 백엔드 마스터코스
            _buildCourseCard(
              context: context,
              title: 'Go 백엔드 마스터코스',
              subtitle: 'Go 언어로 고성능 백엔드 서버 개발',
              icon: Icons.speed,
              color: Colors.lightBlue,
              onTap: () => _showComingSoon(context, 'Go 백엔드 마스터코스'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 1, // 커리큘럼
      ),
    );
  }

  void _showComingSoon(BuildContext context, String courseName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$courseName 준비 중입니다 🚀'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildCourseCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 아이콘
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
