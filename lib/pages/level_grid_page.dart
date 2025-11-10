import 'package:flutter/material.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/difficulty_stars.dart';
import '../widgets/search_bar_widget.dart';
import '../services/challenge_service.dart';

/// 레벨 그리드 페이지 - 숫자 아이콘으로 단계별 표시 (v1.8: 상단바/하단바 추가)
class LevelGridPage extends StatefulWidget {
  final String language;
  final String kind;
  final int? chapterId;  // 챕터 ID (옵션)

  const LevelGridPage({
    super.key,
    required this.language,
    required this.kind,
    this.chapterId,
  });

  @override
  State<LevelGridPage> createState() => _LevelGridPageState();
}

class _LevelGridPageState extends State<LevelGridPage> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> _challenges = [];
  List<Map<String, dynamic>> _filteredChallenges = [];
  bool _isLoading = true;
  String? _error;
  String _searchQuery = '';
  int? _selectedDifficulty; // 난이도 필터 (1~5)

  @override
  void initState() {
    super.initState();
    _loadChallenges();
  }

  Future<void> _loadChallenges() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 백엔드 API에서 직접 필터링된 챌린지 가져오기
      final challenges = await ChallengeService.fetchAll(
        language: widget.language,
        unit: widget.chapterId,
      );

      print('📊 [DEBUG] Challenges fetched: ${challenges.length}');
      if (widget.chapterId != null) {
        print('📊 [DEBUG] Unit ${widget.chapterId}: ${challenges.length} challenges');
      }

      setState(() {
        _challenges = challenges;
        _filteredChallenges = challenges;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredChallenges = _challenges.where((challenge) {
        // 검색어 필터
        if (_searchQuery.isNotEmpty) {
          final title = (challenge['title'] as String? ?? '').toLowerCase();
          final description = (challenge['description'] as String? ?? '').toLowerCase();
          final searchLower = _searchQuery.toLowerCase();
          if (!title.contains(searchLower) && !description.contains(searchLower)) {
            return false;
          }
        }

        // 난이도 필터
        if (_selectedDifficulty != null) {
          final difficultyRaw = challenge['difficulty'];
          int difficultyLevel = 3; // 기본값
          if (difficultyRaw is int) {
            difficultyLevel = difficultyRaw.clamp(1, 5);
          } else if (difficultyRaw is String) {
            difficultyLevel = int.tryParse(difficultyRaw) ?? 3;
          }
          if (difficultyLevel != _selectedDifficulty) {
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

  void _onDifficultyFilter(int? difficulty) {
    setState(() {
      _selectedDifficulty = difficulty;
    });
    _applyFilters();
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _selectedDifficulty = null;
      _filteredChallenges = _challenges;
    });
  }

  String _getLanguageDisplayName(String lang) {
    switch (lang.toLowerCase()) {
      case 'python':
        return 'Python';
      case 'javascript':
        return 'JavaScript';
      case 'dart':
        return 'Dart';
      case 'c':
        return 'C';
      case 'cpp':
        return 'C++';
      case 'csharp':
        return 'C#';
      case 'java':
        return 'Java';
      case 'kotlin':
        return 'Kotlin';
      case 'go':
        return 'Go';
      case 'typescript':
        return 'TypeScript';
      case 'sql':
        return 'SQL';
      case 'html':
        return 'HTML';
      case 'css':
        return 'CSS';
      default:
        return lang.toUpperCase();
    }
  }

  String _getModeDisplayName(String mode) {
    switch (mode) {
      case 'challenge':
        return '챌린지';
      case 'practice':
        return '실전 챌린지';
      default:
        return mode;
    }
  }

  Color _getLanguageColor(String lang) {
    switch (lang.toLowerCase()) {
      case 'python':
        return const Color(0xFF00E5FF);
      case 'javascript':
        return const Color(0xFFF7DF1E);
      case 'typescript':
        return const Color(0xFF3178C6);
      case 'dart':
        return const Color(0xFF1DE9B6);
      case 'c':
        return const Color(0xFF555555);
      case 'cpp':
        return const Color(0xFF00599C);
      case 'csharp':
        return const Color(0xFF239120);
      case 'java':
        return const Color(0xFFFF6B35);
      case 'kotlin':
        return const Color(0xFF7F52FF);
      case 'go':
        return const Color(0xFF00ADD8);
      case 'sql':
        return const Color(0xFF00758F);
      case 'html':
        return const Color(0xFFE34F26);
      case 'css':
        return const Color(0xFF1572B6);
      default:
        return Colors.grey;
    }
  }

  String _getChapterName(int? chapterId) {
    if (chapterId == null) return '';
    final chapters = [
      '출력과 주석',
      '변수와 자료형',
      '연산자',
      '조건문',
      '반복문',
      '함수',
      '리스트·배열·컬렉션',
      '딕셔너리·맵·세트',
      '입출력',
      '예외처리·오류 관리',
    ];
    return chapterId > 0 && chapterId <= chapters.length
        ? '${chapterId}단원: ${chapters[chapterId - 1]}'
        : '';
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _getLanguageDisplayName(widget.language);
    final modeName = _getModeDisplayName(widget.kind);
    final chapterName = _getChapterName(widget.chapterId);
    final color = _getLanguageColor(widget.language);

    String title = '$displayName - $modeName';
    if (chapterName.isNotEmpty) {
      title = '$displayName - $chapterName';
    }

    return Scaffold(
      appBar: VibDevTopAppBar(
        title: title,
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
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.tealAccent),
              )
            : _error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 64),
                        const SizedBox(height: 16),
                        Text(
                          '챌린지를 불러올 수 없습니다',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _error!,
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _loadChallenges,
                          child: const Text('다시 시도'),
                        ),
                      ],
                    ),
                  )
                : _challenges.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, color: Colors.grey[400], size: 64),
                            const SizedBox(height: 16),
                            Text(
                              '챌린지가 없습니다',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '이 언어와 레벨에 맞는 챌린지를 준비 중입니다',
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.all(16.0),
                        children: [
                          // 검색바
                          SearchBarWidget(
                            onSearch: _onSearch,
                            hintText: '챌린지 검색...',
                          ),
                          const SizedBox(height: 16),

                          // 난이도 필터
                          _buildDifficultyFilter(),
                          const SizedBox(height: 16),

                          // 헤더
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
                                if (_selectedDifficulty != null)
                                  TextButton(
                                    onPressed: _clearFilters,
                                    child: const Text('필터 초기화'),
                                  ),
                              ],
                            ),
                          ),

                          // 챌린지 목록
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
                          else
                            ..._filteredChallenges.map((challenge) => _buildChallengeCard(
                                  context,
                                  challenge: challenge,
                                  color: color,
                                )),
                        ],
                      ),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 0,
      ),
    );
  }

  Widget _buildDifficultyFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [1, 2, 3, 4, 5].map((difficulty) {
        final isSelected = _selectedDifficulty == difficulty;
        return FilterChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(
                difficulty,
                (_) => const Icon(Icons.star, size: 14, color: Colors.amber),
              ),
            ],
          ),
          selected: isSelected,
          onSelected: (selected) {
            _onDifficultyFilter(selected ? difficulty : null);
          },
          backgroundColor: Colors.white10,
          selectedColor: Colors.amber.withOpacity(0.3),
          checkmarkColor: Colors.amber,
          labelStyle: TextStyle(
            color: isSelected ? Colors.amber : Colors.grey[400],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          side: BorderSide(
            color: isSelected ? Colors.amber : Colors.grey[700]!,
            width: isSelected ? 2 : 1,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChallengeCard(
    BuildContext context, {
    required Map<String, dynamic> challenge,
    required Color color,
  }) {
    final slug = challenge['slug'] as String? ?? '';
    final title = challenge['title'] as String? ?? '제목 없음';
    final description = challenge['description'] as String? ?? '';
    final level = challenge['level'] ?? 0;
    final difficultyRaw = challenge['difficulty'];

    // 난이도를 1~5 정수로 변환
    int difficultyLevel = 3; // 기본값
    if (difficultyRaw is int) {
      difficultyLevel = difficultyRaw.clamp(1, 5);
    } else if (difficultyRaw is String) {
      difficultyLevel = int.tryParse(difficultyRaw) ?? 3;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
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
                // 상단: 레벨, 난이도
                Row(
                  children: [
                    // 레벨 뱃지
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: color,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'LEVEL $level',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // 난이도 별 표시
                    DifficultyStars(level: difficultyLevel, size: 14),

                    const Spacer(),

                    // 포인트
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
