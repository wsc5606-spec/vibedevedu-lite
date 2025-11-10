import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../features/stats/providers/stats_provider.dart';
import 'widgets/user_stat_card.dart';
import 'widgets/language_progress_section.dart';

/// Dashboard 탭 - 사용자 통계 대시보드
class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatsProvider>().fetchMyStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('성장 대시보드'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<StatsProvider>().refresh();
            },
          ),
        ],
      ),
      body: Consumer<StatsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.myStats == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null && provider.myStats == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 64, color: AppColors.textHint),
                  const SizedBox(height: 16),
                  Text('데이터를 불러올 수 없습니다', style: AppTextStyles.body),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => provider.fetchMyStats(),
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            );
          }

          final stats = provider.myStats!;

          return RefreshIndicator(
            onRefresh: () => provider.refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. 개인 통계 카드
                  UserStatCard(stats: stats),
                  const SizedBox(height: 16),

                  // 2. 언어별 진행도
                  LanguageProgressSection(stats: stats),
                  const SizedBox(height: 16),

                  // 3. 난이도 분포
                  _buildDifficultySection(stats),
                  const SizedBox(height: 16),

                  // 4. 최근 활동
                  _buildRecentActivity(stats),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDifficultySection(stats) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('난이도별 분포', style: AppTextStyles.h3),
          const SizedBox(height: 16),
          _buildDifficultyBar('쉬움', stats.difficultyBreakdown['easy'] ?? 0,
              AppColors.easy),
          const SizedBox(height: 8),
          _buildDifficultyBar('보통', stats.difficultyBreakdown['medium'] ?? 0,
              AppColors.medium),
          const SizedBox(height: 8),
          _buildDifficultyBar('어려움', stats.difficultyBreakdown['hard'] ?? 0,
              AppColors.hard),
        ],
      ),
    );
  }

  Widget _buildDifficultyBar(String label, int count, Color color) {
    final total = (context.read<StatsProvider>().myStats?.totalSolved ?? 1);
    final percent = total > 0 ? (count / total) * 100 : 0.0;

    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(label, style: AppTextStyles.small),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent / 100,
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 50,
          child: Text(
            '$count개',
            style: AppTextStyles.small,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(stats) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('최근 활동', style: AppTextStyles.h3),
          const SizedBox(height: 12),
          if (stats.lastSolvedAt != null) ...[
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(
                  '마지막 활동: ${_formatDate(stats.lastSolvedAt!)}',
                  style: AppTextStyles.small,
                ),
              ],
            ),
          ] else ...[
            Text('아직 활동 기록이 없습니다', style: AppTextStyles.small),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays > 0) {
      return '${diff.inDays}일 전';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}시간 전';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}
