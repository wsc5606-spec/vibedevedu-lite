import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/config/feature_flags.dart';
import '../core/theme/theme_controller.dart';
import '../models/user_profile.dart';
import '../services/local_profile_service.dart';

/// v2.2 설정(Settings) 페이지
/// 프로필, 테마, 텍스트 크기, 접근성 등을 설정
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  UserProfile? _userProfile;
  bool _isLoadingProfile = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoadingProfile = true);
    final profile = await LocalProfileService.loadProfile();
    setState(() {
      _userProfile = profile;
      _isLoadingProfile = false;
    });
  }

  Future<void> _navigateToProfileEdit() async {
    // 프로필 편집 기능은 곧 제공될 예정입니다
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('프로필 편집 기능은 곧 제공될 예정입니다'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final tc = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 프로필 섹션
          _buildSectionHeader(context, '프로필', Icons.person),
          const SizedBox(height: 8),
          _buildProfileCard(context),

          const SizedBox(height: 24),

          // 디스플레이 섹션
          _buildSectionHeader(context, '디스플레이', Icons.brightness_6),
          const SizedBox(height: 8),
          _buildThemeCard(context, tc),
          const SizedBox(height: 12),
          _buildTextScaleCard(context, tc),

          const SizedBox(height: 24),

          // 접근성 섹션
          _buildSectionHeader(context, '접근성', Icons.accessibility_new),
          const SizedBox(height: 8),
          _buildAccessibilityCard(context, tc),

          const SizedBox(height: 24),

          // 정보 섹션
          _buildSectionHeader(context, '정보', Icons.info_outline),
          const SizedBox(height: 8),
          _buildInfoCard(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    if (_isLoadingProfile) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                _userProfile?.nickname.isNotEmpty == true
                    ? _userProfile!.nickname[0].toUpperCase()
                    : '?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userProfile?.nickname ?? '프로필 없음',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_userProfile?.email?.isNotEmpty == true) ...[
                    const SizedBox(height: 4),
                    Text(
                      _userProfile!.email!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _navigateToProfileEdit,
              tooltip: '프로필 수정',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeCard(BuildContext context, ThemeController tc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '테마 (현재: ${_getThemeModeName(tc.mode)})',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('라이트'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('다크'),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('시스템'),
                  icon: Icon(Icons.brightness_auto),
                ),
              ],
              selected: {tc.mode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                tc.setMode(newSelection.first);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('테마가 ${_getThemeModeName(newSelection.first)}(으)로 변경되었습니다'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextScaleCard(BuildContext context, ThemeController tc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '텍스트 크기',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SegmentedButton<AppTextScale>(
              segments: const [
                ButtonSegment(
                  value: AppTextScale.sm,
                  label: Text('작게'),
                  icon: Icon(Icons.text_fields, size: 16),
                ),
                ButtonSegment(
                  value: AppTextScale.md,
                  label: Text('보통'),
                  icon: Icon(Icons.text_fields, size: 20),
                ),
                ButtonSegment(
                  value: AppTextScale.lg,
                  label: Text('크게'),
                  icon: Icon(Icons.text_fields, size: 24),
                ),
              ],
              selected: {tc.textScale},
              onSelectionChanged: (Set<AppTextScale> newSelection) {
                tc.setTextScale(newSelection.first);
              },
            ),
            const SizedBox(height: 12),
            Text(
              '미리보기: ${(tc.textScale.factor * 100).round()}% 크기의 텍스트입니다',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilityCard(BuildContext context, ThemeController tc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('고대비 모드'),
              subtitle: const Text('색상 대비를 높여 가독성을 향상시킵니다'),
              value: tc.highContrast,
              onChanged: (value) {
                tc.setHighContrast(value);
              },
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('애니메이션 감소'),
              subtitle: const Text('화면 전환 애니메이션을 줄입니다'),
              value: tc.reduceMotion,
              onChanged: (value) {
                tc.setReduceMotion(value);
              },
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(context, '버전', 'v2.5.0'),
            const SizedBox(height: 8),
            _buildInfoRow(context, '빌드', 'Prototype'),
            const SizedBox(height: 8),
            _buildInfoRow(context, '프로토타입 모드', FeatureFlags.prototypeMode ? '활성' : '비활성'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return '라이트';
      case ThemeMode.dark:
        return '다크';
      case ThemeMode.system:
        return '시스템';
    }
  }
}
