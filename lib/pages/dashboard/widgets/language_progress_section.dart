import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/stats/models/user_stats.dart';

/// 언어별 진행도 섹션
class LanguageProgressSection extends StatelessWidget {
  final UserStats stats;

  const LanguageProgressSection({super.key, required this.stats});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('언어별 진행도', style: AppTextStyles.h3),
          const SizedBox(height: 16),
          ...stats.languageProgress.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildLanguageProgress(
                entry.key,
                entry.value,
                stats.totalSolved,
              ),
            );
          }).toList(),
          if (stats.languageProgress.isEmpty)
            Text('아직 풀이한 문제가 없습니다', style: AppTextStyles.small),
        ],
      ),
    );
  }

  Widget _buildLanguageProgress(String language, int count, int total) {
    final percent = total > 0 ? (count / total) * 100 : 0.0;
    final color = _getLanguageColor(language);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language.toUpperCase(),
              style: AppTextStyles.smallBold.copyWith(color: color),
            ),
            Text(
              '$count개 (${percent.toStringAsFixed(1)}%)',
              style: AppTextStyles.small,
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: AppColors.divider,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'python':
        return AppColors.python;
      case 'javascript':
      case 'js':
        return AppColors.javascript;
      case 'dart':
        return AppColors.dart;
      case 'c':
        return AppColors.cLang;
      default:
        return AppColors.primary;
    }
  }
}
