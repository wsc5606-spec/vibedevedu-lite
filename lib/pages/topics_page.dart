import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../services/api_config.dart';
import '../services/favorites_service.dart';
import '../widgets/difficulty_stars.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

/// 언어별 주제 목록 화면
/// category별로 문제를 필터링하여 표시
class TopicsPage extends StatefulWidget {
  final String language;
  final String category; // challenge, application, practice

  const TopicsPage({
    super.key,
    required this.language,
    required this.category,
  });

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  final Dio _dio = Dio();
  List<dynamic> _challenges = [];
  List<dynamic> _filteredChallenges = [];
  bool _isLoading = true;
  String? _error;

  // v1.9: 검색 및 필터 상태
  String _searchQuery = '';
  int? _selectedDifficulty;

  // v1.8: 하단 네비게이션 상태
  int _currentIndex = 0;

  // 즐겨찾기 상태
  Set<String> _favoriteSlugs = {};

  @override
  void initState() {
    super.initState();
    _loadChallenges();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavoritesService.getFavorites();
    setState(() {
      _favoriteSlugs = favorites;
    });
  }

  Future<void> _loadChallenges() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // API 엔드포인트: /challenges?language={lang}&category={category}
      final response = await _dio.get(
        '${ApiConfig.base}/challenges',
        queryParameters: {
          'language': widget.language,
          'category': widget.category,
        },
      );

      if (response.data['ok'] == true) {
        if (mounted) {
          setState(() {
            _challenges = response.data['challenges'] ?? [];
            _filteredChallenges = response.data['challenges'] ?? [];
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _error = response.data['error'] ?? '문제 목록을 불러올 수 없습니다.';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = '네트워크 오류: $e';
          _isLoading = false;
        });
      }
    }
  }

  String _getLanguageDisplayName() {
    switch (widget.language) {
      case 'python':
        return 'Python';
      case 'dart':
        return 'Dart';
      case 'go':
        return 'Go';
      case 'java':
        return 'Java';
      case 'supabase':
        return 'Supabase';
      case 'firebase':
        return 'Firebase';
      default:
        return widget.language.toUpperCase();
    }
  }

  String _getCategoryDisplayName() {
    switch (widget.category) {
      case 'challenge':
        return '도전 문제';
      case 'application':
        return '응용 문제';
      case 'practice':
        return '실전 문제';
      default:
        return widget.category;
    }
  }

  // v1.9: 검색 및 필터 적용 (1-3 별 체계)
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

        // 난이도 필터 (1-3 별)
        if (_selectedDifficulty != null) {
          final difficulty = challenge['difficulty'];
          int challengeDiff = 2; // 기본값 (중간)

          if (difficulty is int) {
            challengeDiff = difficulty.clamp(1, 3);
          } else if (difficulty is String) {
            // 문자열 또는 숫자 문자열을 1-3 숫자로 매핑
            final parsed = int.tryParse(difficulty);
            if (parsed != null) {
              challengeDiff = parsed.clamp(1, 3);
            } else {
              switch (difficulty.toLowerCase()) {
                case 'beginner':
                case 'easy':
                  challengeDiff = 1;
                  break;
                case 'intermediate':
                case 'medium':
                  challengeDiff = 2;
                  break;
                case 'advanced':
                case 'hard':
                  challengeDiff = 3;
                  break;
              }
            }
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: VibDevTopAppBar(
        title: '${_getLanguageDisplayName()} - ${_getCategoryDisplayName()}',
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: colorScheme.error),
                      const SizedBox(height: 16),
                      Text(_error!, style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: _loadChallenges,
                        icon: const Icon(Icons.refresh),
                        label: const Text('다시 시도'),
                      ),
                    ],
                  ),
                )
              : _buildChallengesList(context),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 0,
      ),
    );
  }

  Widget _buildChallengesList(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_challenges.isEmpty) {
      return Center(
        child: Text(
          '아직 문제가 없습니다.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // v1.9: 검색바
        SearchBarWidget(
          onSearch: _onSearch,
          hintText: '문제 검색...',
        ),
        const SizedBox(height: 16),

        // v1.9: 난이도 필터 (1-3 별) - 깔끔한 UI
        Row(
          children: [
            Text(
              '난이도:',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Wrap(
                spacing: 8,
                children: [
                  for (int i = 1; i <= 3; i++)
                    FilterChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          i,
                          (index) => const Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFFFD700),
                          ),
                        ),
                      ),
                      selected: _selectedDifficulty == i,
                      onSelected: (selected) {
                        _onDifficultyFilter(selected ? i : null);
                      },
                      selectedColor: colorScheme.primaryContainer,
                      checkmarkColor: colorScheme.primary,
                    ),
                  if (_selectedDifficulty != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: TextButton.icon(
                        onPressed: _clearFilters,
                        icon: const Icon(Icons.clear, size: 16),
                        label: const Text('초기화'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 문제 개수 표시
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '총 ${_filteredChallenges.length}개의 문제',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // 챌린지 카드들
        if (_filteredChallenges.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Text(
                '검색 결과가 없습니다',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          )
        else
          ..._filteredChallenges.asMap().entries.map((entry) {
            final index = entry.key;
            final challenge = entry.value;
            return _buildChallengeCard(context, challenge, index + 1);
          }),
      ],
    );
  }

  Widget _buildChallengeCard(BuildContext context, dynamic challenge, int order) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final title = challenge['title'] ?? '문제';
    final description = challenge['description'] ?? '';
    final difficultyRaw = challenge['difficulty'];

    // v1.9: 난이도를 1~3 정수로 변환
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

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // 챌린지 상세 페이지로 이동
          Navigator.pushNamed(
            context,
            '/challenge/${challenge['slug']}',
            arguments: challenge,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 번호 아이콘
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$order',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // 제목 및 설명
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    // v1.9: 난이도 별 표시
                    DifficultyStars(level: difficultyLevel, size: 16),
                  ],
                ),
              ),

              // 즐겨찾기 아이콘
              IconButton(
                icon: Icon(
                  _favoriteSlugs.contains(challenge['slug'])
                      ? Icons.star
                      : Icons.star_border,
                  color: _favoriteSlugs.contains(challenge['slug'])
                      ? Colors.amber
                      : colorScheme.onSurfaceVariant,
                ),
                onPressed: () async {
                  final slug = challenge['slug'] as String;
                  final isFavorite = await FavoritesService.toggleFavorite(slug);
                  setState(() {
                    if (isFavorite) {
                      _favoriteSlugs.add(slug);
                    } else {
                      _favoriteSlugs.remove(slug);
                    }
                  });
                },
                tooltip: _favoriteSlugs.contains(challenge['slug'])
                    ? '즐겨찾기 제거'
                    : '즐겨찾기 추가',
              ),

              // 화살표 아이콘
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
