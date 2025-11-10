import 'package:flutter/material.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

/// VIBE톡톡 페이지 - 개발 꿀팁, 추천 영상 등을 공유하는 커뮤니티 + AI 기능
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedCategory = 'all';

  // 더미 게시글 데이터
  final List<StoryPost> _posts = [
    StoryPost(
      id: '1',
      author: 'DevMaster',
      authorAvatar: '👨‍💻',
      category: 'youtube',
      title: '코딩 테스트 완벽 대비! 알고리즘 핵심 강의',
      content: '이번 주 추천 영상입니다. 백준 알고리즘 문제 풀이부터 코딩테스트 합격 전략까지!',
      youtubeUrl: 'https://youtube.com/watch?v=example',
      likes: 42,
      comments: 8,
      timeAgo: '2시간 전',
    ),
    StoryPost(
      id: '2',
      author: 'FlutterQueen',
      authorAvatar: '👩‍💻',
      category: 'tip',
      title: 'Flutter 위젯 성능 최적화 꿀팁 5가지',
      content: '''
1. const 생성자 적극 활용하기
2. ListView.builder 사용하기
3. 불필요한 rebuild 방지
4. 이미지 캐싱 활용
5. DevTools로 성능 측정하기

이 팁들로 앱 성능이 2배 향상되었어요!
''',
      likes: 127,
      comments: 23,
      timeAgo: '5시간 전',
    ),
    StoryPost(
      id: '3',
      author: 'PythonNinja',
      authorAvatar: '🐍',
      category: 'tip',
      title: 'Python 리스트 컴프리헨션 마스터하기',
      content: '''
기존 코드:
result = []
for i in range(10):
    if i % 2 == 0:
        result.append(i * 2)

개선 코드:
result = [i * 2 for i in range(10) if i % 2 == 0]

한 줄로 깔끔하게!
''',
      likes: 89,
      comments: 15,
      timeAgo: '1일 전',
    ),
    StoryPost(
      id: '4',
      author: 'CodeNewbie',
      authorAvatar: '🌱',
      category: 'youtube',
      title: '초보자를 위한 Git 완벽 가이드',
      content: 'Git 처음 배우시는 분들께 강력 추천! 커밋, 브랜치, 머지까지 쉽게 설명해주는 영상입니다.',
      youtubeUrl: 'https://youtube.com/watch?v=example2',
      likes: 156,
      comments: 31,
      timeAgo: '1일 전',
    ),
    StoryPost(
      id: '5',
      author: 'WebDev',
      authorAvatar: '🌐',
      category: 'tip',
      title: 'CSS Flexbox vs Grid 언제 뭘 써야 할까?',
      content: '''
Flexbox: 1차원 레이아웃 (가로 또는 세로)
- 네비게이션 바
- 카드 정렬
- 버튼 그룹

Grid: 2차원 레이아웃 (가로와 세로)
- 대시보드 레이아웃
- 갤러리
- 복잡한 페이지 구조
''',
      likes: 94,
      comments: 12,
      timeAgo: '2일 전',
    ),
  ];

  List<StoryPost> get filteredPosts {
    if (_selectedCategory == 'all') return _posts;
    return _posts.where((post) => post.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const VibDevTopAppBar(
        title: 'VIBE톡톡',
      ),
      body: Column(
        children: [
          // 카테고리 필터
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            child: Row(
              children: [
                Text(
                  '카테고리:',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryChip('all', '전체', Icons.apps, colorScheme),
                        const SizedBox(width: 8),
                        _buildCategoryChip('youtube', '유튜브', Icons.play_circle, colorScheme),
                        const SizedBox(width: 8),
                        _buildCategoryChip('tip', '꿀팁', Icons.lightbulb, colorScheme),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 게시글 목록
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // TODO: 실제 데이터 로드
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredPosts.length,
                itemBuilder: (context, index) {
                  return _buildPostCard(filteredPosts[index], theme, colorScheme);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 0, // STORY (이전 대시보드)
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('게시글 작성 기능 준비 중입니다')),
          );
        },
        icon: const Icon(Icons.edit),
        label: const Text('글쓰기'),
      ),
    );
  }

  Widget _buildCategoryChip(String id, String label, IconData icon, ColorScheme colorScheme) {
    final isSelected = _selectedCategory == id;

    return FilterChip(
      avatar: Icon(
        icon,
        size: 18,
        color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
      ),
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedCategory = id;
        });
      },
      selectedColor: colorScheme.primary,
      checkmarkColor: colorScheme.onPrimary,
      labelStyle: TextStyle(
        color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildPostCard(StoryPost post, ThemeData theme, ColorScheme colorScheme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // TODO: 게시글 상세 페이지로 이동
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${post.title} 상세 보기')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 작성자 정보
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      post.authorAvatar,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.author,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          post.timeAgo,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildCategoryBadge(post.category, colorScheme),
                ],
              ),
              const SizedBox(height: 16),

              // 제목
              Text(
                post.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // 내용
              Text(
                post.content,
                style: theme.textTheme.bodyMedium,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              // 유튜브 링크 (있는 경우)
              if (post.youtubeUrl != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.play_circle, color: Colors.red, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'YouTube 영상 보기',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(Icons.open_in_new, color: Colors.red, size: 18),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 16),

              // 좋아요, 댓글
              Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post.likes}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 20,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post.comments}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(String category, ColorScheme colorScheme) {
    final config = category == 'youtube'
        ? (icon: Icons.play_circle, label: '유튜브', color: Colors.red)
        : (icon: Icons.lightbulb, label: '꿀팁', color: Colors.amber);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: config.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: config.color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 14, color: config.color),
          const SizedBox(width: 4),
          Text(
            config.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: config.color,
            ),
          ),
        ],
      ),
    );
  }

}

// 게시글 모델
class StoryPost {
  final String id;
  final String author;
  final String authorAvatar;
  final String category; // 'youtube', 'tip', 'question', etc.
  final String title;
  final String content;
  final String? youtubeUrl;
  final int likes;
  final int comments;
  final String timeAgo;

  StoryPost({
    required this.id,
    required this.author,
    required this.authorAvatar,
    required this.category,
    required this.title,
    required this.content,
    this.youtubeUrl,
    required this.likes,
    required this.comments,
    required this.timeAgo,
  });
}
