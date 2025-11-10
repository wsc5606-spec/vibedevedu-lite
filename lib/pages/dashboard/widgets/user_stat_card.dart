import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/stats/models/user_stats.dart';

/// 사용자 통계 카드
class UserStatCard extends StatelessWidget {
  final UserStats stats;

  const UserStatCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                icon: Icons.check_circle,
                label: '해결한 문제',
                value: '${stats.totalSolved}',
                color: AppColors.success,
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.divider,
              ),
              _buildStatItem(
                icon: Icons.trending_up,
                label: '정확도',
                value: '${stats.accuracy.toStringAsFixed(1)}%',
                color: AppColors.primary,
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.divider,
              ),
              _buildStatItem(
                icon: Icons.local_fire_department,
                label: '연속 일수',
                value: '${stats.currentStreak}일',
                color: AppColors.warning,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyles.h3.copyWith(color: color)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.tiny),
      ],
    );
  }
}
