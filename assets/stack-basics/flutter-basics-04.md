# Chapter 4: 네비게이션 & 라우팅 (Navigation & Routing)

Flutter에서 화면을 전환하고 데이터를 주고받는 방법을 배웁니다.

## 4.1 Navigator.push - 새 화면으로 이동

가장 기본적인 화면 전환 방법입니다.

```dart
// 현재 화면
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('홈')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 새 화면으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(),
              ),
            );
          },
          child: Text('상세 페이지로 이동'),
        ),
      ),
    );
  }
}

// 이동할 화면
class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('상세')),
      body: Center(
        child: Text('상세 페이지입니다'),
      ),
    );
  }
}
```

**언제 사용하나요?**
- 간단한 화면 전환
- 상세 페이지로 이동
- 일회성 화면 이동

## 4.2 Navigator.pop - 이전 화면으로 돌아가기

```dart
class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('상세')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 이전 화면으로 돌아가기
            Navigator.pop(context);
          },
          child: Text('뒤로 가기'),
        ),
      ),
    );
  }
}
```

**참고**: AppBar의 뒤로가기 버튼은 자동으로 `Navigator.pop()`을 호출합니다.

## 4.3 데이터 전달하기

### 다음 화면으로 데이터 전달

```dart
class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}

// 1. 데이터를 전달하며 이동
class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Product(
      name: '노트북',
      price: 1500000,
      image: 'laptop.jpg',
    );

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Text('상품 보기'),
        ),
      ),
    );
  }
}

// 2. 데이터를 받는 화면
class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('상품명: ${product.name}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text('가격: ${product.price}원', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
```

### 이전 화면으로 데이터 반환

```dart
// 1. 데이터를 받을 화면
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _result = '결과 없음';

  void _navigateAndGetResult() async {
    // await으로 결과를 기다림
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectionPage(),
      ),
    );

    if (result != null) {
      setState(() {
        _result = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('홈')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('선택된 항목: $_result', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _navigateAndGetResult,
              child: Text('선택하기'),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. 데이터를 반환하는 화면
class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('선택')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, '사과');
              },
              child: Text('사과'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, '바나나');
              },
              child: Text('바나나'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, '딸기');
              },
              child: Text('딸기'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 4.4 Named Routes - 라우트 이름 지정

복잡한 앱에서는 라우트에 이름을 붙여 관리하는 것이 좋습니다.

```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 초기 라우트 설정
      initialRoute: '/',
      // 라우트 정의
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => DetailPage(),
        '/settings': (context) => SettingsPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

// Named route로 이동
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('홈')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/detail');
              },
              child: Text('상세 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: Text('설정'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Text('프로필'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Named Routes로 데이터 전달

```dart
// 1. MaterialApp 설정
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          // arguments로 전달된 데이터 받기
          final product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) => DetailPage(product: product),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}

// 2. 데이터를 전달하며 이동
Navigator.pushNamed(
  context,
  '/detail',
  arguments: Product(name: '노트북', price: 1500000),
);
```

## 4.5 다양한 네비게이션 메서드

### pushReplacement - 현재 화면 대체

```dart
// 뒤로가기 해도 이전 화면으로 안 감
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => NewPage()),
);
```

**언제 사용하나요?**
- 로그인 후 홈 화면으로 이동 (로그인 화면으로 다시 못 가게)
- 온보딩 완료 후 메인 화면

### pushAndRemoveUntil - 특정 화면까지 모두 제거

```dart
// 모든 이전 화면 제거하고 홈으로
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => HomePage()),
  (route) => false, // false면 모두 제거
);

// 특정 라우트까지만 제거
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => DetailPage()),
  ModalRoute.withName('/home'), // /home까지는 유지
);
```

**언제 사용하나요?**
- 로그아웃 후 로그인 화면으로
- 주문 완료 후 홈으로

### popUntil - 특정 화면까지 뒤로가기

```dart
// 홈 화면이 나올 때까지 뒤로가기
Navigator.popUntil(context, ModalRoute.withName('/'));
```

### canPop - 뒤로갈 수 있는지 확인

```dart
if (Navigator.canPop(context)) {
  Navigator.pop(context);
} else {
  // 이미 첫 화면임
  print('더 이상 뒤로 갈 수 없습니다');
}
```

## 4.6 화면 전환 애니메이션

### 슬라이드 애니메이션

```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DetailPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // 오른쪽에서 시작
      const end = Offset.zero; // 제자리
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ),
);
```

### 페이드 애니메이션

```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DetailPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
);
```

## 실전 예제: 쇼핑몰 네비게이션

```dart
void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/cart': (context) => CartPage(),
        '/checkout': (context) => CheckoutPage(),
        '/order-complete': (context) => OrderCompletePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('쇼핑몰'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('상품 ${index + 1}'),
            subtitle: Text('${(index + 1) * 10000}원'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    productId: index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('장바구니')),
      body: Column(
        children: [
          Expanded(
            child: Center(child: Text('장바구니 항목들...')),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/checkout');
              },
              child: Text('주문하기'),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('주문하기')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 주문 완료 후 모든 화면 제거하고 홈으로
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/order-complete',
              (route) => false,
            );
          },
          child: Text('결제하기'),
        ),
      ),
    );
  }
}

class OrderCompletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주문 완료'),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨김
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 100, color: Colors.green),
            SizedBox(height: 16),
            Text('주문이 완료되었습니다!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              child: Text('홈으로 가기'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 실전 예제: 탭 네비게이션

```dart
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '즐겨찾기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
```

## 연습 문제

1. push와 pushReplacement의 차이점은?
2. Named routes의 장점은 무엇인가요?
3. 다음 화면으로 데이터를 전달하고 돌아올 때 결과를 받는 앱을 만들어보세요.
4. 로그인 → 홈 → 상세 → 로그아웃 플로우를 구현해보세요. (로그아웃하면 모든 화면 제거)
5. BottomNavigationBar를 사용해서 3개의 탭이 있는 앱을 만들어보세요.

## 핵심 정리

- **Navigator.push()**: 새 화면으로 이동
- **Navigator.pop()**: 이전 화면으로
- **Navigator.pushReplacement()**: 현재 화면 대체
- **Navigator.pushAndRemoveUntil()**: 특정 화면까지 제거
- **Named Routes**: 라우트에 이름 붙이기
- **arguments**: 화면 간 데이터 전달
- **await Navigator.push()**: 결과 받기
- **BottomNavigationBar**: 탭 네비게이션

## 다음 단계

다음 챕터에서는 **폼 & 사용자 입력**을 배워봅시다! TextField부터 Form까지! ✍️
