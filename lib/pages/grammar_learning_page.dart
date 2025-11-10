import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/platform_utils.dart';
import '../services/grammar_service.dart';
import '../models/grammar_model.dart';

/// 문법 끝장내기 페이지
class GrammarLearningPage extends StatefulWidget {
  final String language;

  const GrammarLearningPage({
    super.key,
    required this.language,
  });

  @override
  State<GrammarLearningPage> createState() => _GrammarLearningPageState();
}

class _GrammarLearningPageState extends State<GrammarLearningPage> {
  final GrammarService _grammarService = GrammarService();

  // 현재 선택된 문법 챕터 인덱스
  int _selectedChapterIndex = 0;

  // 문법 콘텐츠 데이터
  GrammarContent? _grammarContent;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadChapters();
  }

  Future<void> _loadChapters() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final content = await _grammarService.loadGrammarContent(widget.language);
      setState(() {
        _grammarContent = content;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '문법 콘텐츠를 불러오는데 실패했습니다: $e';
        _isLoading = false;
      });
    }
  }

  String _getLanguageDisplayName() {
    // 스택과 개발도구 먼저 체크
    switch (widget.language) {
      case 'flutter':
        return 'Flutter';
      case 'react':
        return 'React';
      case 'supabase':
        return 'Supabase';
      case 'springboot':
        return 'Spring Boot';
      case 'nestjs':
        return 'NestJS';
      case 'git':
        return 'Git';
      case 'docker':
        return 'Docker';
      case 'vscode':
        return 'VS Code';
      case 'cicd':
        return 'CI/CD';
    }
    // 언어는 GrammarService에서 가져오기
    final langInfo = _grammarService.getLanguageInfo(widget.language);
    return langInfo?.name ?? widget.language.toUpperCase();
  }

  bool _isStack() {
    return _grammarService.isStack(widget.language);
  }

  bool _isDevtool() {
    return _grammarService.isDevtool(widget.language);
  }

  String _getLearningTitle() {
    if (_isStack() || _isDevtool()) {
      return '기초 끝장내기';
    }
    return '문법 끝장내기';
  }

  @override
  Widget build(BuildContext context) {
    final langName = _getLanguageDisplayName();
    final isTabletOrLarger = PlatformUtils.isTabletOrLarger(context);

    return Scaffold(
      appBar: VibDevTopAppBar(
        title: '$langName ${_getLearningTitle()}',
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
        child: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                )
              : _errorMessage != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.redAccent,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadChapters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent,
                              foregroundColor: Colors.black,
                            ),
                            child: const Text('다시 시도'),
                          ),
                        ],
                      ),
                    )
                  : isTabletOrLarger
                      ? _buildDesktopLayout()
                      : _buildMobileLayout(),
        ),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 0,
      ),
    );
  }

  // 데스크톱 레이아웃: 좌측 챕터 목록 + 우측 내용
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // 좌측: 챕터 목록
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            border: Border(
              right: BorderSide(
                color: Colors.grey[800]!,
                width: 1,
              ),
            ),
          ),
          child: _buildChapterList(),
        ),
        // 우측: 내용
        Expanded(
          child: _buildContentArea(),
        ),
      ],
    );
  }

  // 모바일 레이아웃: 드롭다운 + 내용
  Widget _buildMobileLayout() {
    return Column(
      children: [
        // 상단: 챕터 선택 드롭다운
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[800]!,
                width: 1,
              ),
            ),
          ),
          child: DropdownButtonFormField<int>(
            value: _selectedChapterIndex,
            dropdownColor: Colors.grey[900],
            decoration: InputDecoration(
              labelText: '챕터 선택',
              labelStyle: const TextStyle(color: Colors.tealAccent),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.tealAccent),
              ),
            ),
            items: _grammarContent?.chapters.asMap().entries.map((entry) {
              return DropdownMenuItem(
                value: entry.key,
                child: Text(
                  entry.value.title,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList() ?? [],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedChapterIndex = value;
                });
              }
            },
          ),
        ),
        // 내용
        Expanded(
          child: _buildContentArea(),
        ),
      ],
    );
  }

  // 챕터 목록 (데스크톱용)
  Widget _buildChapterList() {
    if (_grammarContent == null) return const SizedBox();

    return ListView.builder(
      itemCount: _grammarContent!.chapters.length,
      itemBuilder: (context, index) {
        final isSelected = index == _selectedChapterIndex;
        final chapter = _grammarContent!.chapters[index];

        return ListTile(
          selected: isSelected,
          selectedTileColor: Colors.tealAccent.withOpacity(0.2),
          leading: CircleAvatar(
            backgroundColor: isSelected
                ? Colors.tealAccent
                : Colors.grey[700],
            child: Text(
              '${chapter.chapterId}',
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            chapter.title,
            style: TextStyle(
              color: isSelected ? Colors.tealAccent : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onTap: () {
            setState(() {
              _selectedChapterIndex = index;
            });
          },
        );
      },
    );
  }

  // 내용 영역
  Widget _buildContentArea() {
    if (_grammarContent == null || _grammarContent!.chapters.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.tealAccent),
      );
    }

    final chapter = _grammarContent!.chapters[_selectedChapterIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.tealAccent.withOpacity(0.2),
                  Colors.tealAccent.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.tealAccent.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${chapter.chapterId}단원',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    chapter.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 마크다운 콘텐츠
          MarkdownBody(
            data: chapter.content,
            styleSheet: MarkdownStyleSheet(
              h1: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
              h2: const TextStyle(
                color: Colors.tealAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
              h3: const TextStyle(
                color: Colors.tealAccent,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
              p: TextStyle(
                color: Colors.grey[300],
                fontSize: 16,
                height: 1.8,
              ),
              listBullet: const TextStyle(
                color: Colors.tealAccent,
                fontSize: 16,
              ),
              code: const TextStyle(
                backgroundColor: Color(0xFF1A1F3A),
                color: Color(0xFF60A5FA),
                fontFamily: 'monospace',
                fontSize: 14,
              ),
              codeblockDecoration: BoxDecoration(
                color: const Color(0xFF1A1F3A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.tealAccent.withOpacity(0.3),
                ),
              ),
              codeblockPadding: const EdgeInsets.all(16),
              blockquote: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
              blockquoteDecoration: BoxDecoration(
                color: Colors.tealAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: const Border(
                  left: BorderSide(
                    color: Colors.tealAccent,
                    width: 4,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 48),

          // 네비게이션 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_selectedChapterIndex > 0)
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedChapterIndex--;
                    });
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('이전 챕터'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
              if (_selectedChapterIndex > 0)
                const SizedBox(width: 16),
              if (_selectedChapterIndex < _grammarContent!.chapters.length - 1)
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedChapterIndex++;
                    });
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('다음 챕터'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                )
              else
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check_circle),
                  label: const Text('완료'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
