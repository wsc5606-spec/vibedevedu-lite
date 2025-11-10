import 'package:flutter/material.dart';
import '../services/challenge_service.dart';
import '../widgets/difficulty_stars.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/platform_utils.dart';

/// 챌린지 목록 페이지 (v1.9: 검색, 필터, 난이도 별 추가)
/// 사용 가능한 코딩 챌린지 리스트를 DB에서 동적으로 로드하여 보여줌
class ChallengeListPage extends StatefulWidget {
  const ChallengeListPage({super.key});

  @override
  State<ChallengeListPage> createState() => _ChallengeListPageState();
}

class _ChallengeListPageState extends State<ChallengeListPage> {
  List<Map<String, dynamic>> _challenges = [];
  List<Map<String, dynamic>> _filteredChallenges = [];
  bool _loading = true;
  String? _error;

  // v1.9: 검색 및 필터 상태
  String _searchQuery = '';
  String? _selectedLanguage;
  String? _selectedCategory;
  int? _selectedDifficulty;

  // v1.8: 하단 네비게이션 상태
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadChallenges();
  }

  Future<void> _loadChallenges() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final challenges = await ChallengeService.fetchAll();
      setState(() {
        _challenges = challenges;
        _filteredChallenges = challenges;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  // v1.9: 검색 및 필터 적용
  void _applyFilters() {
    setState(() {
      _filteredChallenges = _challenges.where((challenge) {
        // 검색어 필터
        if (_searchQuery.isNotEmpty) {
          final title = (challenge['title'] as String? ?? '').toLowerCase();
          final description = (challenge['description'] as String? ?? '').toLowerCase();
          final query = _searchQuery.toLowerCase();
          if (!title.contains(query) && !description.contains(query)) {
            return false;
          }
        }

        // 언어 필터
        if (_selectedLanguage != null) {
          final language = (challenge['language'] as String? ?? '').toLowerCase();
          if (language != _selectedLanguage!.toLowerCase()) {
            return false;
          }
        }

        // 카테고리 필터
        if (_selectedCategory != null) {
          final category = (challenge['category'] as String? ?? '').toLowerCase();
          if (category != _selectedCategory!.toLowerCase()) {
            return false;
          }
        }

        // 난이도 필터
        if (_selectedDifficulty != null) {
          final difficulty = challenge['difficulty'];
          int challengeDiff = 3; // 기본값
          if (difficulty is int) {
            challengeDiff = difficulty;
          } else if (difficulty is String) {
            challengeDiff = int.tryParse(difficulty) ?? 3;
          }
          if (challengeDiff != _selectedDifficulty) {
            return false;
          }
        }

        return true;
      }).toList();
    });
  }

  void _onSearch(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _onLanguageFilter(String? language) {
    setState(() {
      _selectedLanguage = language;
    });
    _applyFilters();
  }

  void _onCategoryFilter(String? category) {
    setState(() {
      _selectedCategory = category;
    });
    _applyFilters();
  }

  void _onDifficultyFilter(int? difficulty) {
    setState(() {
      _selectedDifficulty = difficulty;
    });
    _applyFilters();
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _selectedLanguage = null;
      _selectedCategory = null;
      _selectedDifficulty = null;
      _filteredChallenges = _challenges;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VibDevTopAppBar(
        title: 'VIBEDEV 챌린지',
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey[900]!,
            ],
          ),
        ),
        child: _buildBody(),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 0,
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.tealAccent),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            Text(
              '오류 발생',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: TextStyle(color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadChallenges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
              ),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (_challenges.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox, color: Colors.grey, size: 80),
            const SizedBox(height: 16),
            Text(
              '등록된 챌린지가 없습니다',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Supabase에서 챌린지를 추가해주세요',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
      );
    }

    final padding = PlatformUtils.responsivePadding(context);
    final screenType = PlatformUtils.getScreenType(context);
    final isTabletOrLarger = PlatformUtils.isTabletOrLarger(context);

    return ListView(
      padding: padding,
      children: [
        // v1.9: 검색바
        SearchBarWidget(
          onSearch: _onSearch,
          hintText: '챌린지 검색...',
        ),
        const SizedBox(height: 16),

        // v1.9: 필터 칩
        _buildFilterChips(),
        const SizedBox(height: 16),

        // 페이지 헤더
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '총 ${_filteredChallenges.length}개의 챌린지',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_selectedLanguage != null ||
                  _selectedCategory != null ||
                  _selectedDifficulty != null)
                TextButton(
                  onPressed: _clearFilters,
                  child: const Text('필터 초기화'),
                ),
            ],
          ),
        ),

        // 챌린지 카드들 (반응형 그리드)
        if (_filteredChallenges.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Text(
                '검색 결과가 없습니다',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
            ),
          )
        else if (isTabletOrLarger)
          // 태블릿/데스크톱: 그리드 레이아웃
          _buildChallengeGrid(context, _filteredChallenges, screenType)
        else
          // 모바일: 리스트 레이아웃
          ..._filteredChallenges.map((challenge) => _buildChallengeCard(
                context,
                challenge: challenge,
              )),
      ],
    );
  }

  // 반응형 그리드 레이아웃 (태블릿/데스크톱용)
  Widget _buildChallengeGrid(
    BuildContext context,
    List<Map<String, dynamic>> challenges,
    ScreenType screenType,
  ) {
    int columns;
    switch (screenType) {
      case ScreenType.desktop:
        columns = 3; // 데스크톱: 3열
        break;
      case ScreenType.tablet:
        columns = 2; // 태블릿: 2열
        break;
      default:
        columns = 1;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2, // 카드 비율
      ),
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        return _buildChallengeCard(context, challenge: challenges[index]);
      },
    );
  }

  // v1.9: 필터 칩 위젯
  Widget _buildFilterChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // 언어 필터
        DropdownButton<String>(
          value: _selectedLanguage,
          hint: const Text('언어', style: TextStyle(color: Colors.white)),
          dropdownColor: Colors.grey[900],
          items: ['python', 'javascript', 'dart', 'java', 'go'].map((lang) {
            return DropdownMenuItem(value: lang, child: Text(lang.toUpperCase()));
          }).toList(),
          onChanged: _onLanguageFilter,
        ),
        // 카테고리 필터
        DropdownButton<String>(
          value: _selectedCategory,
          hint: const Text('유형', style: TextStyle(color: Colors.white)),
          dropdownColor: Colors.grey[900],
          items: ['challenge', 'practice', 'advanced'].map((cat) {
            return DropdownMenuItem(value: cat, child: Text(cat.toUpperCase()));
          }).toList(),
          onChanged: _onCategoryFilter,
        ),
        // 난이도 필터
        DropdownButton<int>(
          value: _selectedDifficulty,
          hint: const Text('난이도', style: TextStyle(color: Colors.white)),
          dropdownColor: Colors.grey[900],
          items: [1, 2, 3, 4, 5].map((diff) {
            return DropdownMenuItem(value: diff, child: Text('$diff ★'));
          }).toList(),
          onChanged: _onDifficultyFilter,
        ),
      ],
    );
  }

  /// 챌린지 카드 위젯 생성
  Widget _buildChallengeCard(
    BuildContext context, {
    required Map<String, dynamic> challenge,
  }) {
    final slug = challenge['slug'] as String? ?? '';
    final title = challenge['title'] as String? ?? '제목 없음';
    final description = challenge['description'] as String? ?? '';
    final language = challenge['language'] as String? ?? 'unknown';
    final difficultyRaw = challenge['difficulty'];

    // v1.9: 난이도를 1~5 정수로 변환
    int difficultyLevel = 3; // 기본값
    if (difficultyRaw is int) {
      difficultyLevel = difficultyRaw.clamp(1, 5);
    } else if (difficultyRaw is String) {
      // 기존 문자열 난이도를 숫자로 매핑
      switch (difficultyRaw.toLowerCase()) {
        case 'beginner':
        case 'easy':
          difficultyLevel = 1;
          break;
        case 'intermediate':
        case 'medium':
          difficultyLevel = 3;
          break;
        case 'advanced':
        case 'hard':
          difficultyLevel = 5;
          break;
        default:
          difficultyLevel = int.tryParse(difficultyRaw) ?? 3;
      }
    }

    // 언어별 색상 매핑
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
        case 'cpp':
        case 'c++':
          return Colors.purple;
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
            // 챌린지 상세 페이지로 이동
            Navigator.pushNamed(context, '/challenge/$slug');
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단: 언어 뱃지, 난이도
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

                    // v1.9: 난이도 별 표시
                    DifficultyStars(level: difficultyLevel, size: 14),

                    const Spacer(),

                    // 포인트 (임시로 100점 고정)
                    Row(
                      children: const [
                        Icon(
                          Icons.stars,
                          color: Colors.tealAccent,
                          size: 20,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '100 P',
                          style: TextStyle(
                            color: Colors.tealAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
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

                // 시작하기 버튼
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
