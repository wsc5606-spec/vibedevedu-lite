import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../services/challenge_service.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/difficulty_stars.dart';

/// 즐겨찾기 문제 목록 페이지
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _currentIndex = 0;
  Set<String> _favoriteSlugs = {};
  List<Map<String, dynamic>> _favoriteChallenges = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final slugs = await FavoritesService.getFavorites();
      final challenges = <Map<String, dynamic>>[];

      // 각 슬러그에 대한 챌린지 정보 로드
      for (final slug in slugs) {
        try {
          final challenge = await ChallengeService.fetchOne(slug);
          if (challenge != null) {
            challenges.add(challenge);
          }
        } catch (e) {
          print('Failed to load challenge $slug: $e');
        }
      }

      setState(() {
        _favoriteSlugs = slugs;
        _favoriteChallenges = challenges;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _removeFavorite(String slug) async {
    await FavoritesService.removeFavorite(slug);
    await _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VibDevTopAppBar(
        title: '즐겨찾기 문제',
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 0,
      ),
    );
  }

  Widget _buildBody() {
    if (_favoriteChallenges.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_border,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '즐겨찾기한 문제가 없습니다',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '문제 카드의 별 아이콘을 눌러\n즐겨찾기에 추가하세요',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _favoriteChallenges.length,
      itemBuilder: (context, index) {
        final challenge = _favoriteChallenges[index];
        return _buildChallengeCard(challenge);
      },
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge) {
    final slug = challenge['slug'] as String? ?? '';
    final title = challenge['title'] as String? ?? '제목 없음';
    final description = challenge['description'] as String? ?? '';
    final language = challenge['language'] as String? ?? 'unknown';
    final difficultyRaw = challenge['difficulty'];

    // 난이도를 1~3 정수로 변환
    int difficultyLevel = 2; // 기본값 (중간)
    if (difficultyRaw is int) {
      difficultyLevel = difficultyRaw.clamp(1, 3);
    } else if (difficultyRaw is String) {
      // 문자열 또는 숫자 문자열을 1-3 숫자로 매핑
      final parsed = int.tryParse(difficultyRaw);
      if (parsed != null) {
        difficultyLevel = parsed.clamp(1, 3);
      } else {
        switch (difficultyRaw.toLowerCase()) {
          case 'beginner':
          case 'easy':
            difficultyLevel = 1;
            break;
          case 'intermediate':
          case 'medium':
            difficultyLevel = 2;
            break;
          case 'advanced':
          case 'hard':
            difficultyLevel = 3;
            break;
        }
      }
    }

    // 언어별 색상
    Color getLanguageColor(String lang) {
      switch (lang.toLowerCase()) {
        case 'python':
          return Colors.blue;
        case 'javascript':
          return Colors.yellow;
        case 'dart':
          return Colors.cyan;
        case 'java':
          return Colors.orange;
        case 'go':
          return Colors.tealAccent;
        default:
          return Colors.grey;
      }
    }

    final languageColor = getLanguageColor(language);

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.tealAccent.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.pushNamed(context, '/challenge/$slug');
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단: 언어 뱃지, 난이도, 즐겨찾기 버튼
                Row(
                  children: [
                    // 언어 뱃지
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: languageColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: languageColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        language.toUpperCase(),
                        style: TextStyle(
                          color: languageColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // 난이도 별 표시
                    DifficultyStars(level: difficultyLevel, size: 14),

                    const Spacer(),

                    // 즐겨찾기 제거 버튼
                    IconButton(
                      icon: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onPressed: () => _removeFavorite(slug),
                      tooltip: '즐겨찾기 제거',
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 타이틀
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                // 설명
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 16),

                // 도전하기 버튼
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/challenge/$slug');
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('도전하기'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.tealAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
