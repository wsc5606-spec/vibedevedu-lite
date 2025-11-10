import 'package:flutter/material.dart';

/// VibeDev v1.9 언어 선택 칩 위젯
/// 멀티 선택이 가능한 언어 칩 리스트
class LanguageChipSelector extends StatelessWidget {
  final List<String> availableLanguages;
  final List<String> selectedLanguages;
  final Function(String) onLanguageToggle;

  const LanguageChipSelector({
    super.key,
    required this.availableLanguages,
    required this.selectedLanguages,
    required this.onLanguageToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: availableLanguages.map((language) {
        final isSelected = selectedLanguages.contains(language);
        return FilterChip(
          label: Text(language.toUpperCase()),
          selected: isSelected,
          onSelected: (_) => onLanguageToggle(language),
          selectedColor: const Color(0xFF00E5FF).withOpacity(0.3),
          checkmarkColor: const Color(0xFF00E5FF),
        );
      }).toList(),
    );
  }
}
