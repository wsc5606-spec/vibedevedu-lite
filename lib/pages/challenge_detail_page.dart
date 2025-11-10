import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import '../services/user_session.dart';
import '../services/api_config.dart';
import '../services/challenge_service.dart';
import '../services/recommend_service.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/platform_utils.dart';

/// 챌린지 상세 페이지
/// 코드 작성 + 실행 + AI 리뷰
class ChallengeDetailPage extends StatefulWidget {
  final String slug;

  const ChallengeDetailPage({
    super.key,
    required this.slug,
  });

  @override
  State<ChallengeDetailPage> createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {
  late CodeController _codeController;
  String _execResult = '';
  String _reviewResult = '';
  String _saveResult = '';
  bool _isExecuting = false;
  bool _isReviewing = false;
  bool _isLoading = false;
  bool _isLoadingChallenge = true;
  String? _loadError;

  // 챌린지 정보 (DB에서 동적 로드)
  Map<String, dynamic> challengeData = {};

  // v1.8: 하단 네비게이션 상태
  int _currentIndex = 0;

  // v2.2: 정답보기 기능
  int _failedAttempts = 0;
  bool _showingSolution = false;

  // v2.5: 코드 에디터 플레이스홀더 관리
  bool _showPlaceholder = true;
  final FocusNode _editorFocusNode = FocusNode();

  // v1.9: 언어별 하이라이트 매핑
  dynamic _getLanguageMode(String language) {
    switch (language.toLowerCase()) {
      case 'python':
        return python;
      case 'dart':
        return dart;
      case 'javascript':
      case 'js':
        return javascript;
      case 'java':
        return java;
      case 'cpp':
      case 'c++':
        return cpp;
      default:
        return python;
    }
  }

  @override
  void initState() {
    super.initState();
    // v1.9: 초기화는 _loadChallengeData에서 진행
    _codeController = CodeController(
      text: '',
      language: python,
    );
    _loadChallengeData();

    // v2.5: 코드 변경 감지 - 코드가 비어있으면 플레이스홀더 표시
    _codeController.addListener(() {
      final shouldShow = _codeController.text.trim().isEmpty;
      if (_showPlaceholder != shouldShow) {
        setState(() {
          _showPlaceholder = shouldShow;
        });
      }
    });

    // v2.5: 포커스 감지 - 처음 클릭하면 플레이스홀더 숨김
    _editorFocusNode.addListener(() {
      if (_editorFocusNode.hasFocus && _showPlaceholder) {
        setState(() {
          _showPlaceholder = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  /// 챌린지 데이터 로드 (DB에서 동적 로드)
  Future<void> _loadChallengeData() async {
    setState(() {
      _isLoadingChallenge = true;
      _loadError = null;
    });

    try {
      final data = await ChallengeService.fetchOne(widget.slug);

      if (data == null) {
        setState(() {
          _loadError = '챌린지를 찾을 수 없습니다';
          _isLoadingChallenge = false;
        });
        return;
      }

      setState(() {
        challengeData = data;
        final language = _getLanguageMode(data['language'] ?? 'python');
        final templateCode = data['template_code'] ?? '';
        _codeController = CodeController(
          text: templateCode,
          language: language,
        );
        // v2.5: template_code가 있으면 플레이스홀더 숨김
        _showPlaceholder = templateCode.trim().isEmpty;
        _isLoadingChallenge = false;
      });
    } catch (e) {
      setState(() {
        _loadError = '챌린지 로드 실패: $e';
        _isLoadingChallenge = false;
      });
    }
  }

  /// v1.9: 코드 실행 + AI 리뷰 동시 실행
  Future<void> _executeCode() async {
    setState(() {
      _isExecuting = true;
      _isReviewing = true;
      _execResult = '';
      _reviewResult = '';
    });

    try {
      final language = challengeData['language'].toString().toLowerCase();
      final code = _codeController.text;

      // 코드 실행과 AI 리뷰를 동시에 실행
      final results = await Future.wait([
        _executeCodeInternal(language, code),
        _requestAIReviewInternal(language, code),
      ]);

      setState(() {
        _execResult = results[0];
        _reviewResult = results[1];

        // v2.2: 실패 여부 체크 (exit_code != 0 또는 에러 포함)
        if (_execResult.contains('❌') || _execResult.contains('실행 실패') || _execResult.contains('오류')) {
          _failedAttempts++;
        } else if (_execResult.contains('✅')) {
          // 성공 시 실패 횟수 리셋
          _failedAttempts = 0;
        }
      });
    } catch (e) {
      setState(() {
        _execResult = '❌ 요청 실패: $e';
        _reviewResult = '❌ 요청 실패: $e';
        _failedAttempts++;
      });
    } finally {
      setState(() {
        _isExecuting = false;
        _isReviewing = false;
      });
    }
  }

  /// 코드 실행 내부 메서드
  Future<String> _executeCodeInternal(String language, String code) async {
    try {
      final res = await http.post(
        Uri.parse('${ApiConfig.base}/execute'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'language': language, 'code': code}),
      );

      // JSON 파싱 및 포맷팅
      try {
        final result = jsonDecode(res.body);
        final status = result['status'] ?? 'unknown';
        final stdout = result['stdout'] ?? '';
        final stderr = result['stderr'] ?? '';
        final exitCode = result['exit_code'] ?? -1;
        final execTime = result['execution_time'] ?? '0ms';

        String formatted = '';
        if (status == 'ok') {
          formatted = '✅ 코드 실행 완료!\n\n';
          formatted += '[출력 결과]\n';
          formatted += stdout.isEmpty ? '(출력 없음)\n' : '$stdout\n';
          if (stderr.isNotEmpty) {
            formatted += '\n[경고]\n$stderr\n';
          }
          formatted += '\n실행 시간: $execTime';
        } else {
          formatted = '❌ 실행 실패!\n\n';
          formatted += '[오류 메시지]\n';
          formatted += stderr.isEmpty ? '알 수 없는 오류' : stderr;
          formatted += '\n\nExit Code: $exitCode\n';
          formatted += '실행 시간: $execTime';
        }

        return formatted;
      } catch (parseError) {
        return res.body; // 파싱 실패 시 raw 출력
      }
    } catch (e) {
      return '❌ 요청 실패: $e';
    }
  }

  /// v1.9: AI 리뷰 (별도 버튼용 - 이제 실행 버튼과 통합됨)
  Future<void> _requestAIReview() async {
    setState(() {
      _isReviewing = true;
      _reviewResult = '';
    });

    try {
      final language = challengeData['language'].toString().toLowerCase();
      final code = _codeController.text;
      final result = await _requestAIReviewInternal(language, code);

      setState(() {
        _reviewResult = result;
      });
    } catch (e) {
      setState(() {
        _reviewResult = '❌ 요청 실패: $e';
      });
    } finally {
      setState(() {
        _isReviewing = false;
      });
    }
  }

  /// AI 리뷰 내부 메서드
  Future<String> _requestAIReviewInternal(String language, String code) async {
    try {
      // execLog를 위해 원본 JSON 파싱
      Map<String, dynamic>? log;
      try {
        final res = await http.post(
          Uri.parse('${ApiConfig.base}/execute'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'language': language, 'code': code}),
        );
        log = jsonDecode(res.body);
      } catch (_) {
        log = null;
      }

      final res = await http.post(
        Uri.parse('${ApiConfig.base}/ai/review'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': 'guest',
          'challengeId': challengeData['slug'] ?? '',
          'language': language,
          'code': code,
          'problemDescription': challengeData['description'] ?? '문제 설명 없음',
          'execLog': log ?? {},
        }),
      );

      // JSON 파싱 및 포맷팅
      try {
        final response = jsonDecode(res.body);
        final reviewData = response['review'];

        // OpenAI API 응답 형식: { score: { accuracy, efficiency, readability }, feedback, suggestions }
        final scoreData = reviewData['score'] ?? {};
        final accuracy = scoreData['accuracy'] ?? 0;
        final efficiency = scoreData['efficiency'] ?? 0;
        final readability = scoreData['readability'] ?? 0;
        final avgScore = ((accuracy + efficiency + readability) / 3).round();

        final feedback = reviewData['feedback'] ?? '피드백을 받을 수 없습니다.';
        final suggestions = reviewData['suggestions'] as List? ?? [];

        String formatted = '🤖 AI 코드 리뷰\n\n';
        formatted += '[종합 평가]\n';
        formatted += '점수: $avgScore/100 ';
        formatted += '⭐' * (avgScore ~/ 20) + '\n\n';

        formatted += '[세부 평가]\n';
        formatted += '  • 정확성: $accuracy/100\n';
        formatted += '  • 효율성: $efficiency/100\n';
        formatted += '  • 가독성: $readability/100\n\n';

        formatted += '[상세 피드백]\n$feedback\n\n';

        if (suggestions.isNotEmpty) {
          formatted += '[개선 제안]\n';
          for (int i = 0; i < suggestions.length; i++) {
            formatted += '  ${i + 1}. ${suggestions[i]}\n';
          }
        }

        return formatted;
      } catch (parseError) {
        return res.body; // 파싱 실패 시 raw 출력
      }
    } catch (e) {
      return '❌ 요청 실패: $e';
    }
  }

  /// Rubric 키를 한글로 변환
  String _translateRubricKey(String key) {
    switch (key) {
      case 'correctness':
        return '정확성';
      case 'readability':
        return '가독성';
      case 'efficiency':
        return '효율성';
      case 'edge_cases':
        return '엣지 케이스';
      default:
        return key;
    }
  }

  /// 클립보드에 텍스트 복사
  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label 복사되었습니다!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// v2.2: 정답 보기 함수
  void _showSolution() {
    setState(() {
      _showingSolution = true;
      final solutionCode = challengeData['solution_code'] ?? challengeData['template_code'] ?? '';
      _codeController.text = solutionCode;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('💡 정답 코드가 로드되었습니다. 참고하여 학습하세요!'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.orange,
      ),
    );
  }

  /// 제출 저장 (백엔드 /submit API)
  Future<void> _submitSolution() async {
    setState(() {
      _isLoading = true;
      _saveResult = '';
    });

    final email = UserSession.email ?? 'guest@vibedev.app';
    Map<String, dynamic>? execLogJson;
    try {
      execLogJson = jsonDecode(_execResult);
    } catch (_) {
      execLogJson = null;
    }

    Map<String, dynamic>? reviewJson;
    try {
      reviewJson = jsonDecode(_reviewResult);
    } catch (_) {
      reviewJson = null;
    }

    final body = {
      'user_email': email,
      'challenge_slug': widget.slug,
      'language': challengeData['language'],
      'code': _codeController.text,
      'exec_log': execLogJson,
      'review': reviewJson,
    };

    try {
      final res = await http.post(
        Uri.parse('${ApiConfig.base}/submit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          _saveResult = const JsonEncoder.withIndent('  ').convert(data);
        });
      } else {
        setState(() {
          _saveResult = '❌ 저장 실패 (${res.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _saveResult = '❌ 저장 요청 오류: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 유사 문제 추천 다이얼로그 표시
  Future<void> _showSemanticRecommendations() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.tealAccent.withOpacity(0.3)),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
          padding: const EdgeInsets.all(24),
          child: FutureBuilder<SemanticRecommendData?>(
            future: RecommendService.fetchSemantic(widget.slug),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                );
              }

              if (snapshot.hasError || snapshot.data == null) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 64),
                    const SizedBox(height: 16),
                    const Text(
                      '유사 문제를 불러올 수 없습니다',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('닫기'),
                    ),
                  ],
                );
              }

              final data = snapshot.data!;
              final recommendations = data.recommendations;

              if (recommendations.isEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lightbulb_outline,
                        color: Colors.grey, size: 64),
                    const SizedBox(height: 16),
                    const Text(
                      '유사한 문제를 찾을 수 없습니다',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '더 많은 문제를 추가해보세요!',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('닫기'),
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 헤더
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome,
                          color: Colors.tealAccent, size: 28),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          '이 문제와 비슷한 문제',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'AI가 분석한 의미적으로 유사한 문제들입니다',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  const SizedBox(height: 24),

                  // 유사 문제 리스트
                  Expanded(
                    child: ListView.builder(
                      itemCount: recommendations.length,
                      itemBuilder: (context, index) {
                        final rec = recommendations[index];
                        final similarity = rec.similarity ?? 0.0;
                        final similarityPercent = (similarity * 100).toStringAsFixed(0);

                        return Card(
                          color: Colors.white10,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.tealAccent.withOpacity(0.2),
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                context,
                                '/challenge/${rec.slug}',
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // 언어 뱃지
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: Colors.blue),
                                        ),
                                        child: Text(
                                          rec.language.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      // 유사도
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.compare_arrows,
                                              color: Colors.green,
                                              size: 14,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '$similarityPercent% 유사',
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),

                                  // 제목
                                  Text(
                                    rec.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),

                                  if (rec.description != null) ...[
                                    const SizedBox(height: 6),
                                    Text(
                                      rec.description!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],

                                  const SizedBox(height: 8),

                                  // 도전하기 버튼
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '도전하기 →',
                                      style: TextStyle(
                                        color: Colors.tealAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// 문제 설명 전체 보기 다이얼로그
  void _showProblemDescriptionDialog() {
    final description = challengeData['description'] ?? '문제 설명이 없습니다.';
    final title = challengeData['title'] ?? '문제';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.tealAccent.withOpacity(0.3)),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700, maxHeight: 600),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 헤더
              Row(
                children: [
                  const Icon(Icons.description, color: Colors.tealAccent, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(color: Colors.tealAccent),
              const SizedBox(height: 16),

              // 문제 설명 내용
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                      height: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 닫기 버튼
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  foregroundColor: Colors.black,
                ),
                child: const Text('확인'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 힌트 다이얼로그 표시
  void _showHintDialog() {
    final hint = challengeData['hint'] ?? '힌트를 불러올 수 없습니다.';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.orange.withOpacity(0.3)),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 헤더
              Row(
                children: [
                  const Icon(Icons.lightbulb, color: Colors.orange, size: 28),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      '힌트',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(color: Colors.orange),
              const SizedBox(height: 16),

              // 힌트 내용
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    hint,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                      height: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 닫기 버튼
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                ),
                child: const Text('확인'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VibDevTopAppBar(
        title: challengeData['title'] ?? 'VIBEDEV',
      ),
      body: _isLoadingChallenge
          ? _buildLoadingState()
          : _loadError != null
              ? _buildErrorState()
              : Container(
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
        child: Builder(
          builder: (context) {
            // 반응형 레이아웃: PlatformUtils를 사용하여 화면 크기 감지
            final isTabletOrLarger = PlatformUtils.isTabletOrLarger(context);
            final screenType = PlatformUtils.getScreenType(context);

            if (isTabletOrLarger) {
              // 태블릿/데스크톱: 좌우 분할 레이아웃
              int leftFlex = 3;
              int rightFlex = 2;

              // 데스크톱에서는 더 넓은 코드 에디터
              if (screenType == ScreenType.desktop) {
                leftFlex = 5;
                rightFlex = 3;
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 왼쪽: 문제 설명 + 코드 에디터
                  Expanded(
                    flex: leftFlex,
                    child: _buildLeftPanel(useExpanded: true),
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  // 오른쪽: 실행 결과 + AI 리뷰
                  Expanded(
                    flex: rightFlex,
                    child: _buildRightPanel(useExpanded: true),
                  ),
                ],
              );
            } else {
              // 모바일: 세로 스크롤 레이아웃
              return SingleChildScrollView(
                padding: PlatformUtils.responsivePadding(context),
                child: Column(
                  children: [
                    _buildLeftPanel(useExpanded: false),
                    const SizedBox(height: 16),
                    _buildRightPanel(useExpanded: false),
                  ],
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 0,
      ),
    );
  }

  /// 왼쪽 패널: 문제 설명 + 코드 에디터 + 버튼
  Widget _buildLeftPanel({required bool useExpanded}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 문제 설명
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.tealAccent.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(
                        challengeData['language'] ?? '',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // 힌트 버튼 (has_hint가 true일 때만 표시)
                    if (challengeData['has_hint'] == true)
                      OutlinedButton.icon(
                        onPressed: _showHintDialog,
                        icon: const Icon(Icons.lightbulb_outline, size: 16),
                        label: const Text('힌트 보기'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.orange,
                          side: const BorderSide(color: Colors.orange),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                // 문제 설명
                Container(
                  constraints: BoxConstraints(maxHeight: 150),
                  child: SingleChildScrollView(
                    child: Text(
                      challengeData['description'] ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[300],
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // 전체 보기 버튼
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    onPressed: _showProblemDescriptionDialog,
                    icon: const Icon(Icons.open_in_full, size: 16),
                    label: const Text('전체 보기'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.tealAccent,
                      side: const BorderSide(color: Colors.tealAccent),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // v1.9: 코드 에디터 (줄 번호 + 하이라이팅)
          if (useExpanded)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.tealAccent.withOpacity(0.2),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      CodeTheme(
                        data: CodeThemeData(styles: monokaiSublimeTheme),
                        child: SingleChildScrollView(
                          child: CodeField(
                            controller: _codeController,
                            focusNode: _editorFocusNode,
                            textStyle: const TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      // v2.5: 플레이스홀더 오버레이
                      if (_showPlaceholder)
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () {
                              _editorFocusNode.requestFocus();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              color: Colors.transparent,
                              child: Text(
                                '코드를 작성하세요...\n\n클릭하여 시작하기',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          else
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.tealAccent.withOpacity(0.2),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    CodeTheme(
                      data: CodeThemeData(styles: monokaiSublimeTheme),
                      child: SingleChildScrollView(
                        child: CodeField(
                          controller: _codeController,
                          focusNode: _editorFocusNode,
                          textStyle: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    // v2.5: 플레이스홀더 오버레이
                    if (_showPlaceholder)
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () {
                            _editorFocusNode.requestFocus();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            color: Colors.transparent,
                            child: Text(
                              '코드를 작성하세요...\n\n클릭하여 시작하기',
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 14,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 16),

          // v1.9: 실행(+AI 리뷰 자동) & 제출 버튼
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: (_isExecuting || _isReviewing) ? null : _executeCode,
                  icon: (_isExecuting || _isReviewing)
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : const Icon(Icons.play_arrow),
                  label: Text(
                    (_isExecuting || _isReviewing)
                        ? '실행 + AI 분석 중...'
                        : '실행 + AI 리뷰'
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _submitSolution,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send),
                  label: Text(_isLoading ? '저장 중...' : '제출'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),

          // v2.2: 정답보기 버튼 (3번 이상 오답 시 표시)
          if (_failedAttempts >= 3 && !_showingSolution) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showSolution,
                icon: const Icon(Icons.lightbulb, size: 20),
                label: const Text('💡 정답 보기 (3번 오답)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 오른쪽 패널: 실행 결과 + AI 리뷰 + 제출 결과
  Widget _buildRightPanel({required bool useExpanded}) {
    Widget buildResultContainer({
      required String title,
      required IconData icon,
      required Color color,
      required String content,
      bool isEmpty = false,
    }) {
      final scrollContent = SingleChildScrollView(
        child: SelectableText(
          content,
          style: TextStyle(
            fontFamily: title == '실행 결과' || title == '제출 결과' ? 'Courier' : null,
            fontSize: 14,
            color: isEmpty ? Colors.grey[500] : Colors.white,
            height: title == 'AI 코드 리뷰' ? 1.5 : null,
          ),
        ),
      );

      final containerChild = Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const Spacer(),
                if (content.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    color: color,
                    onPressed: () => _copyToClipboard(content, title),
                    tooltip: '복사',
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (useExpanded)
              Expanded(child: scrollContent)
            else
              SizedBox(height: 250, child: scrollContent),
          ],
        ),
      );

      return useExpanded ? Expanded(child: containerChild) : containerChild;
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 실행 결과
          buildResultContainer(
            title: '실행 결과',
            icon: Icons.terminal,
            color: Colors.tealAccent,
            content: _execResult.isEmpty ? '코드를 실행하면 여기에 결과가 표시됩니다.' : _execResult,
            isEmpty: _execResult.isEmpty,
          ),

          const SizedBox(height: 16),

          // AI 리뷰
          buildResultContainer(
            title: 'AI 코드 리뷰',
            icon: Icons.auto_awesome,
            color: Colors.purple,
            content: _reviewResult.isEmpty ? 'AI 리뷰를 요청하면 여기에 피드백이 표시됩니다.' : _reviewResult,
            isEmpty: _reviewResult.isEmpty,
          ),

          const SizedBox(height: 16),

          // 제출 결과
          buildResultContainer(
            title: '제출 결과',
            icon: Icons.send,
            color: Colors.green,
            content: _saveResult.isEmpty ? '제출 버튼을 누르면 여기에 저장 결과가 표시됩니다.' : _saveResult,
            isEmpty: _saveResult.isEmpty,
          ),
        ],
      ),
    );
  }

  Widget _old_buildRightPanel_backup() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 실행 결과
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.tealAccent.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.terminal, color: Colors.tealAccent),
                      const SizedBox(width: 8),
                      const Text(
                        '실행 결과',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      const Spacer(),
                      if (_execResult.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.copy, size: 20),
                          color: Colors.tealAccent,
                          onPressed: () => _copyToClipboard(_execResult, '실행 결과'),
                          tooltip: '복사',
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SelectableText(
                        _execResult.isEmpty
                            ? '코드를 실행하면 여기에 결과가 표시됩니다.'
                            : _execResult,
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 14,
                          color: _execResult.isEmpty
                              ? Colors.grey[500]
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // AI 리뷰
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.purple.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: Colors.purple),
                      const SizedBox(width: 8),
                      const Text(
                        'AI 코드 리뷰',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      const Spacer(),
                      if (_reviewResult.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.copy, size: 20),
                          color: Colors.purple,
                          onPressed: () => _copyToClipboard(_reviewResult, 'AI 리뷰'),
                          tooltip: '복사',
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SelectableText(
                        _reviewResult.isEmpty
                            ? 'AI 리뷰를 요청하면 여기에 피드백이 표시됩니다.'
                            : _reviewResult,
                        style: TextStyle(
                          fontSize: 14,
                          color: _reviewResult.isEmpty
                              ? Colors.grey[500]
                              : Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 제출 결과
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.send, color: Colors.green),
                      const SizedBox(width: 8),
                      const Text(
                        '제출 결과',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const Spacer(),
                      if (_saveResult.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.copy, size: 20),
                          color: Colors.green,
                          onPressed: () => _copyToClipboard(_saveResult, '제출 결과'),
                          tooltip: '복사',
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SelectableText(
                        _saveResult.isEmpty
                            ? '제출 버튼을 누르면 여기에 저장 결과가 표시됩니다.'
                            : _saveResult,
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 14,
                          color: _saveResult.isEmpty
                              ? Colors.grey[500]
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 로딩 상태 위젯
  Widget _buildLoadingState() {
    return Container(
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
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.tealAccent),
            SizedBox(height: 16),
            Text(
              '챌린지 로딩 중...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 에러 상태 위젯
  Widget _buildErrorState() {
    return Container(
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
      child: Center(
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
              _loadError ?? '알 수 없는 오류',
              style: TextStyle(color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadChallengeData,
              icon: const Icon(Icons.refresh),
              label: const Text('다시 시도'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                '목록으로 돌아가기',
                style: TextStyle(color: Colors.tealAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
