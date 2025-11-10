import 'package:flutter/material.dart';

/// 결과 페이지
/// 챌린지 완료 후 결과 요약을 보여줌
class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '결과',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.tealAccent,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.grey[900]!,
              Colors.black,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.tealAccent.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.tealAccent.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 성공 아이콘
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.tealAccent.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.tealAccent,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: Colors.tealAccent,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 타이틀
                  const Text(
                    '축하합니다!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 설명
                  Text(
                    '챌린지를 성공적으로 완료했습니다',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[300],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // 결과 요약 (하드코딩된 예시)
                  _buildStatRow(
                    icon: Icons.stars,
                    label: '획득 포인트',
                    value: '100 P',
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 16),
                  _buildStatRow(
                    icon: Icons.grade,
                    label: '평가 점수',
                    value: '85/100',
                    color: Colors.tealAccent,
                  ),
                  const SizedBox(height: 16),
                  _buildStatRow(
                    icon: Icons.timer,
                    label: '소요 시간',
                    value: '12분 30초',
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildStatRow(
                    icon: Icons.check_circle,
                    label: '테스트 통과',
                    value: '2/2',
                    color: Colors.green,
                  ),

                  const SizedBox(height: 40),

                  // 버튼들
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/challenges',
                            );
                          },
                          icon: const Icon(Icons.list),
                          label: const Text('챌린지 목록'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // 공유 기능 (추후 구현)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('공유 기능은 추후 추가 예정입니다'),
                                backgroundColor: Colors.tealAccent,
                              ),
                            );
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('공유하기'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.tealAccent,
                            side: const BorderSide(color: Colors.tealAccent),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 통계 행 위젯
  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[300],
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
