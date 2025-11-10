import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../services/history_service.dart';

/// v2.7 히스토리 페이지
/// 필터(언어, 상태, 날짜), 페이지네이션, 상세보기, 재도전 지원
class HistoryPageV27 extends StatefulWidget {
  const HistoryPageV27({super.key});

  @override
  State<HistoryPageV27> createState() => _HistoryPageV27State();
}

class _HistoryPageV27State extends State<HistoryPageV27> {
  List<dynamic> _attempts = [];
  bool _isLoading = false;
  bool _hasMore = true;
  String _error = '';

  // 필터 상태
  String? _selectedLanguage;
  String? _selectedStatus;
  DateTimeRange? _dateRange;

  // 페이지네이션
  int _currentPage = 1;
  final int _limit = 20;
  int _totalPages = 1;

  final ScrollController _scrollController = ScrollController();

  // 지원 언어 목록
  static const List<String> _languages = [
    'python', 'javascript', 'typescript', 'dart', 'java',
    'go', 'c', 'cpp', 'csharp', 'kotlin', 'sql', 'html', 'css'
  ];

  // 상태 목록
  static const List<String> _statuses = ['passed', 'failed', 'partial'];

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 스크롤 리스너 (무한 스크롤)
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMore) {
        _loadMore();
      }
    }
  }

  /// 히스토리 로드
  Future<void> _loadHistory({bool reset = false}) async {
    if (reset) {
      setState(() {
        _currentPage = 1;
        _attempts = [];
        _hasMore = true;
      });
    }

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final result = await HistoryService.getHistory(
        language: _selectedLanguage,
        status: _selectedStatus,
        from: _dateRange?.start.toIso8601String(),
        to: _dateRange?.end.toIso8601String(),
        page: _currentPage,
        limit: _limit,
      );

      if (result['ok'] == true) {
        final attempts = result['attempts'] ?? [];
        final totalPages = result['totalPages'] ?? 1;

        setState(() {
          if (reset) {
            _attempts = attempts;
          } else {
            _attempts.addAll(attempts);
          }
          _totalPages = totalPages;
          _hasMore = _currentPage < _totalPages;
        });
      } else {
        setState(() {
          _error = result['error'] ?? '알 수 없는 오류';
        });
      }
    } catch (e) {
      setState(() {
        _error = '요청 실패: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 다음 페이지 로드
  Future<void> _loadMore() async {
    if (_currentPage >= _totalPages) return;

    setState(() {
      _currentPage++;
    });

    await _loadHistory();
  }

  /// 필터 다이얼로그
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String? tempLanguage = _selectedLanguage;
        String? tempStatus = _selectedStatus;
        DateTimeRange? tempDateRange = _dateRange;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: const Text(
                '필터 설정',
                style: TextStyle(color: Colors.tealAccent),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 언어 필터
                    const Text('언어', style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: tempLanguage,
                      hint: const Text('전체', style: TextStyle(color: Colors.white70)),
                      isExpanded: true,
                      dropdownColor: Colors.grey[850],
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('전체', style: TextStyle(color: Colors.white)),
                        ),
                        ..._languages.map((lang) => DropdownMenuItem(
                          value: lang,
                          child: Text(lang, style: const TextStyle(color: Colors.white)),
                        )),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          tempLanguage = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // 상태 필터
                    const Text('상태', style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: tempStatus,
                      hint: const Text('전체', style: TextStyle(color: Colors.white70)),
                      isExpanded: true,
                      dropdownColor: Colors.grey[850],
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('전체', style: TextStyle(color: Colors.white)),
                        ),
                        ..._statuses.map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(_getStatusLabel(status),
                            style: const TextStyle(color: Colors.white)),
                        )),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          tempStatus = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // 날짜 범위 필터
                    const Text('날짜 범위', style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final range = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          initialDateRange: tempDateRange,
                        );
                        if (range != null) {
                          setDialogState(() {
                            tempDateRange = range;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today, color: Colors.tealAccent),
                      label: Text(
                        tempDateRange == null
                            ? '전체 기간'
                            : '${_formatDate(tempDateRange!.start)} ~ ${_formatDate(tempDateRange!.end)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    if (tempDateRange != null)
                      TextButton(
                        onPressed: () {
                          setDialogState(() {
                            tempDateRange = null;
                          });
                        },
                        child: const Text('날짜 초기화'),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // 초기화
                    setState(() {
                      _selectedLanguage = null;
                      _selectedStatus = null;
                      _dateRange = null;
                    });
                    Navigator.pop(context);
                    _loadHistory(reset: true);
                  },
                  child: const Text('초기화'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedLanguage = tempLanguage;
                      _selectedStatus = tempStatus;
                      _dateRange = tempDateRange;
                    });
                    Navigator.pop(context);
                    _loadHistory(reset: true);
                  },
                  child: const Text('적용'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// 상세 보기 다이얼로그
  void _showDetailDialog(Map<String, dynamic> attempt) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.grey[900],
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 700),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 헤더
              Row(
                children: [
                  Icon(
                    _getStatusIcon(attempt['status']),
                    color: _getStatusColor(attempt['status']),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attempt['challenge_slug'] ?? 'Unknown',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.tealAccent,
                          ),
                        ),
                        Text(
                          _formatDateTime(attempt['created_at']),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: Colors.tealAccent),
              const SizedBox(height: 16),

              // 통계 정보
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildStatChip('언어', attempt['language'] ?? 'Unknown', Colors.blue),
                  _buildStatChip('난이도', _getDifficultyLabel(attempt['difficulty']), Colors.orange),
                  _buildStatChip('점수', '${attempt['score'] ?? 0}', Colors.green),
                  _buildStatChip('테스트', '${attempt['passed_tests']}/${attempt['total_tests']}', Colors.purple),
                  _buildStatChip('실행시간', '${attempt['runtime_ms']}ms', Colors.cyan),
                ],
              ),
              const SizedBox(height: 16),

              // 코드
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '제출한 코드',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy, size: 20),
                            color: Colors.tealAccent,
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: attempt['submitted_code'] ?? ''),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('코드 복사 완료!')),
                              );
                            },
                            tooltip: '코드 복사',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.tealAccent.withOpacity(0.3)),
                        ),
                        child: SelectableText(
                          attempt['submitted_code'] ?? '',
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // 메모
                      if (attempt['notes'] != null && attempt['notes'].toString().isNotEmpty) ...[
                        const SizedBox(height: 16),
                        const Text(
                          '메모',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            attempt['notes'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'passed':
        return '성공';
      case 'failed':
        return '실패';
      case 'partial':
        return '부분성공';
      default:
        return status;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'passed':
        return Icons.check_circle;
      case 'failed':
        return Icons.cancel;
      case 'partial':
        return Icons.check_circle_outline;
      default:
        return Icons.help;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'passed':
        return Colors.green;
      case 'failed':
        return Colors.red;
      case 'partial':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getDifficultyLabel(int? difficulty) {
    switch (difficulty) {
      case 1:
        return 'Easy';
      case 2:
        return 'Medium';
      case 3:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatDateTime(dynamic dateStr) {
    try {
      final date = DateTime.parse(dateStr.toString());
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return dateStr.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '히스토리',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.tealAccent,
          ),
        ),
        actions: [
          // 필터 버튼
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: (_selectedLanguage != null || _selectedStatus != null || _dateRange != null)
                  ? Colors.orange
                  : Colors.tealAccent,
            ),
            onPressed: _showFilterDialog,
            tooltip: '필터',
          ),
          // 새로고침
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.tealAccent),
            onPressed: () => _loadHistory(reset: true),
            tooltip: '새로고침',
          ),
        ],
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
            // 필터 요약
            if (_selectedLanguage != null || _selectedStatus != null || _dateRange != null)
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.tealAccent.withOpacity(0.1),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (_selectedLanguage != null)
                      Chip(
                        label: Text('언어: $_selectedLanguage'),
                        onDeleted: () {
                          setState(() => _selectedLanguage = null);
                          _loadHistory(reset: true);
                        },
                      ),
                    if (_selectedStatus != null)
                      Chip(
                        label: Text('상태: ${_getStatusLabel(_selectedStatus!)}'),
                        onDeleted: () {
                          setState(() => _selectedStatus = null);
                          _loadHistory(reset: true);
                        },
                      ),
                    if (_dateRange != null)
                      Chip(
                        label: Text('기간: ${_formatDate(_dateRange!.start)} ~ ${_formatDate(_dateRange!.end)}'),
                        onDeleted: () {
                          setState(() => _dateRange = null);
                          _loadHistory(reset: true);
                        },
                      ),
                  ],
                ),
              ),

            // 목록
            Expanded(
              child: _error.isNotEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                          const SizedBox(height: 16),
                          Text(_error, style: TextStyle(fontSize: 16, color: Colors.red[300])),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () => _loadHistory(reset: true),
                            icon: const Icon(Icons.refresh),
                            label: const Text('다시 시도'),
                          ),
                        ],
                      ),
                    )
                  : _attempts.isEmpty && !_isLoading
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.inbox, size: 80, color: Colors.grey[600]),
                              const SizedBox(height: 16),
                              Text(
                                '히스토리가 없습니다',
                                style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '챌린지를 풀고 제출해보세요!',
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: _attempts.length + (_hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _attempts.length) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final attempt = _attempts[index];
                            final status = attempt['status'] as String;

                            return Card(
                              color: Colors.grey[850],
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: _getStatusColor(status).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () => _showDetailDialog(attempt),
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      // 상태 아이콘
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(status).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          _getStatusIcon(status),
                                          color: _getStatusColor(status),
                                        ),
                                      ),
                                      const SizedBox(width: 16),

                                      // 정보
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              attempt['challenge_slug'] ?? 'Unknown',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(4),
                                                    border: Border.all(color: Colors.blue),
                                                  ),
                                                  child: Text(
                                                    attempt['language'] ?? 'Unknown',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '점수: ${attempt['score'] ?? 0}',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  _formatDateTime(attempt['created_at']),
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // 화살표
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: Colors.grey,
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
        ),
      ),
    );
  }
}
