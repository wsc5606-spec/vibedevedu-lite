import 'package:flutter/material.dart';

/// 코드 에디터 위젯 (추후 구현 예정)
///
/// 향후 다음 기능 추가 가능:
/// - 구문 강조 (Syntax Highlighting)
/// - 자동 완성
/// - 코드 포맷팅
/// - 라인 번호 표시
///
/// 추천 라이브러리:
/// - flutter_code_editor: https://pub.dev/packages/flutter_code_editor
/// - code_text_field: https://pub.dev/packages/code_text_field
/// - highlight: https://pub.dev/packages/highlight

class CodeEditor extends StatefulWidget {
  final String initialCode;
  final String language;
  final Function(String)? onCodeChanged;

  const CodeEditor({
    super.key,
    this.initialCode = '',
    this.language = 'python',
    this.onCodeChanged,
  });

  @override
  State<CodeEditor> createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialCode);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 고급 코드 에디터 기능 구현
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.tealAccent.withOpacity(0.2),
        ),
      ),
      child: TextField(
        controller: _controller,
        maxLines: null,
        style: const TextStyle(
          fontFamily: 'Courier',
          fontSize: 14,
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '코드를 작성하세요...',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        onChanged: widget.onCodeChanged,
      ),
    );
  }
}
