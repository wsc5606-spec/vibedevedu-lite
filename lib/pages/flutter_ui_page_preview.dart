import 'package:flutter/material.dart';

/// Preview widget builder for UI challenges
class FlutterUIPreview {
  static Widget buildPreview(int challengeId) {
    switch (challengeId) {
      case 1: // 프로필 카드
        return _buildPhoneFrame(
          Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.deepPurple,
                          child: Icon(Icons.person, color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('홍길동', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('Flutter 개발자', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

      case 2: // 버튼 3개 가로 배치
        return _buildPhoneFrame(
          Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      child: const Text('버튼 1'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      child: const Text('버튼 2'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      child: const Text('버튼 3'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

      case 3: // 리스트 타일
        return _buildPhoneFrame(
          Scaffold(
            body: Center(
              child: const ListTile(
                leading: Icon(Icons.home, color: Colors.blue, size: 32),
                title: Text('홈', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('메인 화면으로 이동'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ),
        );

      case 4: // 로그인 폼
        return _buildPhoneFrame(
          Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: '이메일',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('로그인', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

      case 5: // 이미지 카드
        return _buildPhoneFrame(
          Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 280,
                        height: 160,
                        color: Colors.deepPurple[100],
                        child: const Icon(Icons.image, size: 48, color: Colors.deepPurple),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('제목', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('설명 텍스트', style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

      case 6: // 설정 스위치
        return _buildPhoneFrame(
          Scaffold(
            body: Center(
              child: SwitchListTile(
                title: const Text('알림 설정', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('푸시 알림 받기'),
                value: true,
                onChanged: null,
                secondary: const Icon(Icons.notifications, size: 32),
              ),
            ),
          ),
        );

      case 7: // 2x2 그리드 뷰
        return _buildPhoneFrame(
          Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: List.generate(4, (index) {
                  return Card(
                    color: Colors.deepPurple[50],
                    child: Center(
                      child: Text(
                        '카드 ${index + 1}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        );

      case 8: // BottomNavigationBar
        return _buildPhoneFrame(
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[100],
                  child: const Center(child: Text('페이지 0', style: TextStyle(fontSize: 16))),
                ),
              ),
              BottomNavigationBar(
                currentIndex: 0,
                selectedItemColor: Colors.deepPurple,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
                  BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
                ],
              ),
            ],
          ),
        );

      case 9: // AppBar with Actions
        return _buildPhoneFrame(
          Scaffold(
            appBar: AppBar(
              title: const Text('내 앱'),
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              actions: [
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
              ],
            ),
            body: const Center(child: Text('앱 내용')),
          ),
        );

      case 10: // TabBar with TabBarView
        return _buildPhoneFrame(
          DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('탭 예제'),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                bottom: const TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(icon: Icon(Icons.home), text: '홈'),
                    Tab(icon: Icon(Icons.star), text: '즐겨찾기'),
                    Tab(icon: Icon(Icons.settings), text: '설정'),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  Center(child: Text('홈 화면', style: TextStyle(fontSize: 18))),
                  Center(child: Text('즐겨찾기 화면', style: TextStyle(fontSize: 18))),
                  Center(child: Text('설정 화면', style: TextStyle(fontSize: 18))),
                ],
              ),
            ),
          ),
        );

      default:
        return _buildPhoneFrame(
          Container(
            color: Colors.grey[200],
            child: const Center(
              child: Icon(Icons.widgets_outlined, size: 64, color: Colors.grey),
            ),
          ),
        );
    }
  }

  static Widget _buildPhoneFrame(Widget child) {
    return Container(
      width: 320,
      height: 600,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Phone notch
          Container(
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Center(
              child: Container(
                width: 120,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          // Phone screen
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: child,
              ),
            ),
          ),
          // Phone bottom
          Container(
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
