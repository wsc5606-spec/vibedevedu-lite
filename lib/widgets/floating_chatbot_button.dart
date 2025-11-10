import 'package:flutter/material.dart';
import '../pages/ai_chatbot_page.dart';

/// 플로팅 챗봇 버튼 위젯
/// 화면 우측 하단에 고정되어 항상 표시됨
class FloatingChatbotButton extends StatelessWidget {
  const FloatingChatbotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 16,
      child: FloatingActionButton.extended(
        onPressed: () {
          // 챗봇 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AiChatbotPage(),
            ),
          );
        },
        backgroundColor: const Color(0xFF00E5FF),
        foregroundColor: Colors.black,
        icon: const Icon(Icons.smart_toy_rounded),
        label: const Text(
          'AI 챗봇',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        elevation: 6,
        highlightElevation: 12,
      ),
    );
  }
}
