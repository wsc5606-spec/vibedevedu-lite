# Chapter 9: 애니메이션 기초 (Animation Basics)

Flutter에서 UI에 생동감을 주는 다양한 애니메이션 기법을 배웁니다.

## 9.1 암시적 애니메이션 (Implicit Animations)

코드 몇 줄로 부드러운 애니메이션을 만들 수 있습니다.

### AnimatedContainer

Container의 속성이 변할 때 자동으로 애니메이션됩니다.

```dart
class AnimatedContainerExample extends StatefulWidget {
  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimatedContainer')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 1), // 애니메이션 시간
            curve: Curves.easeInOut, // 애니메이션 곡선
            width: _isExpanded ? 300 : 100,
            height: _isExpanded ? 300 : 100,
            color: _isExpanded ? Colors.blue : Colors.red,
            child: Center(
              child: Text(
                '탭하세요',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

**언제 사용하나요?**
- 크기, 색상, 위치 변화
- 간단한 애니메이션
- 빠른 프로토타이핑

### AnimatedOpacity

투명도 애니메이션입니다.

```dart
class AnimatedOpacityExample extends StatefulWidget {
  @override
  _AnimatedOpacityExampleState createState() =>
      _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimatedOpacity')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: Center(
                  child: Text('페이드 인/아웃', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: Text(_isVisible ? '숨기기' : '보이기'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### AnimatedPositioned

Stack 안에서 위치를 애니메이션합니다.

```dart
class AnimatedPositionedExample extends StatefulWidget {
  @override
  _AnimatedPositionedExampleState createState() =>
      _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
  bool _isTop = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimatedPositioned')),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.bounceOut,
            top: _isTop ? 50 : 300,
            left: _isTop ? 50 : 200,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isTop = !_isTop;
                });
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Text('탭', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 기타 암시적 애니메이션 위젯들

```dart
// 텍스트 스타일 애니메이션
AnimatedDefaultTextStyle(
  duration: Duration(seconds: 1),
  style: TextStyle(
    fontSize: _isBig ? 32 : 16,
    color: _isBig ? Colors.blue : Colors.red,
  ),
  child: Text('애니메이션 텍스트'),
)

// 패딩 애니메이션
AnimatedPadding(
  duration: Duration(seconds: 1),
  padding: EdgeInsets.all(_isExpanded ? 32 : 8),
  child: Text('패딩 변화'),
)

// 정렬 애니메이션
AnimatedAlign(
  duration: Duration(seconds: 1),
  alignment: _isLeft ? Alignment.centerLeft : Alignment.centerRight,
  child: Container(width: 100, height: 100, color: Colors.blue),
)
```

## 9.2 Curve - 애니메이션 곡선

애니메이션의 속도 변화를 제어합니다.

```dart
// 자주 사용하는 Curve들
Curves.linear          // 일정한 속도
Curves.easeIn          // 천천히 시작
Curves.easeOut         // 천천히 끝남
Curves.easeInOut       // 천천히 시작하고 끝남
Curves.bounceOut       // 튕기는 효과
Curves.elasticOut      // 탄성 효과
Curves.fastOutSlowIn   // Material Design 기본
```

```dart
class CurveExample extends StatefulWidget {
  @override
  _CurveExampleState createState() => _CurveExampleState();
}

class _CurveExampleState extends State<CurveExample> {
  bool _isExpanded = false;

  Widget _buildAnimatedBox(String label, Curve curve) {
    return Column(
      children: [
        Text(label),
        SizedBox(height: 8),
        AnimatedContainer(
          duration: Duration(seconds: 2),
          curve: curve,
          width: _isExpanded ? 200 : 50,
          height: 50,
          color: Colors.blue,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Curve 비교')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text('애니메이션 시작'),
            ),
            SizedBox(height: 32),
            _buildAnimatedBox('linear', Curves.linear),
            SizedBox(height: 16),
            _buildAnimatedBox('easeIn', Curves.easeIn),
            SizedBox(height: 16),
            _buildAnimatedBox('easeOut', Curves.easeOut),
            SizedBox(height: 16),
            _buildAnimatedBox('bounceOut', Curves.bounceOut),
            SizedBox(height: 16),
            _buildAnimatedBox('elasticOut', Curves.elasticOut),
          ],
        ),
      ),
    );
  }
}
```

## 9.3 명시적 애니메이션 (Explicit Animations)

더 세밀한 제어가 필요할 때 사용합니다.

### AnimationController

애니메이션의 재생, 정지, 역재생 등을 제어합니다.

```dart
class ExplicitAnimationExample extends StatefulWidget {
  @override
  _ExplicitAnimationExampleState createState() =>
      _ExplicitAnimationExampleState();
}

class _ExplicitAnimationExampleState extends State<ExplicitAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 컨트롤러 생성
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this, // SingleTickerProviderStateMixin 필요
    );

    // 애니메이션 정의 (0.0 → 1.0)
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // 애니메이션 시작
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explicit Animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation.value,
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        '${(_animation.value * 100).toInt()}%',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.forward(); // 재생
                  },
                  child: Text('재생'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    _controller.reverse(); // 역재생
                  },
                  child: Text('역재생'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    _controller.reset(); // 리셋
                  },
                  child: Text('리셋'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### Tween - 값의 범위 정의

```dart
// 숫자 범위
Tween<double>(begin: 0.0, end: 300.0)

// 색상 범위
ColorTween(begin: Colors.red, end: Colors.blue)

// 크기 범위
Tween<Size>(begin: Size(50, 50), end: Size(200, 200))

// 오프셋 범위
Tween<Offset>(begin: Offset.zero, end: Offset(1.0, 0.0))
```

### 실전 예제: 회전하는 로딩 스피너

```dart
class RotatingSpinner extends StatefulWidget {
  @override
  _RotatingSpinnerState createState() => _RotatingSpinnerState();
}

class _RotatingSpinnerState extends State<RotatingSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(); // 무한 반복
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회전 애니메이션')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * 3.14159, // 360도 회전
              child: child,
            );
          },
          child: Icon(Icons.refresh, size: 100, color: Colors.blue),
        ),
      ),
    );
  }
}
```

## 9.4 실전 예제: 좋아요 버튼 애니메이션

```dart
class LikeButton extends StatefulWidget {
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });

    if (_isLiked) {
      _controller.forward().then((_) {
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('좋아요 애니메이션')),
      body: Center(
        child: GestureDetector(
          onTap: _toggleLike,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 100,
                  color: _isLiked ? Colors.red : Colors.grey,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

## 9.5 실전 예제: 스플래시 화면

```dart
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    // 2초 후 다음 화면으로
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flutter_dash, size: 100, color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'My App',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

## 9.6 실전 예제: 슬라이드 인 리스트

```dart
class SlideInListView extends StatefulWidget {
  @override
  _SlideInListViewState createState() => _SlideInListViewState();
}

class _SlideInListViewState extends State<SlideInListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> items = List.generate(10, (index) => '항목 ${index + 1}');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('슬라이드 인 리스트')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final interval = Interval(
            index / items.length,
            (index + 1) / items.length,
            curve: Curves.easeOut,
          );

          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1, 0), // 오른쪽에서 시작
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _controller,
                curve: interval,
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: interval,
                ),
              ),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(items[index]),
                  subtitle: Text('상세 설명'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
```

## 9.7 Hero 애니메이션

화면 전환 시 위젯이 이동하는 애니메이션입니다.

```dart
// 첫 번째 화면
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('첫 번째 화면')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPage()),
            );
          },
          child: Hero(
            tag: 'hero-image', // 고유 태그
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.image, size: 50, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// 두 번째 화면
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('두 번째 화면')),
      body: Center(
        child: Hero(
          tag: 'hero-image', // 같은 태그
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.image, size: 150, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
```

## 연습 문제

1. 암시적 애니메이션과 명시적 애니메이션의 차이는?
2. AnimationController는 왜 dispose()가 필요한가요?
3. AnimatedContainer로 크기가 변하는 박스를 만들어보세요.
4. 회전하면서 커지는 애니메이션을 만들어보세요.
5. Hero 애니메이션으로 이미지 갤러리를 만들어보세요.

## 핵심 정리

### 암시적 애니메이션
- **AnimatedContainer**: 크기, 색상, 위치 등
- **AnimatedOpacity**: 투명도
- **AnimatedPositioned**: Stack 내 위치
- 간단하고 빠르게 구현
- duration과 curve만 지정

### 명시적 애니메이션
- **AnimationController**: 애니메이션 제어
- **Tween**: 값의 범위 정의
- **AnimatedBuilder**: 애니메이션 위젯 빌드
- 세밀한 제어 가능
- SingleTickerProviderStateMixin 필요

### 기타
- **Curve**: 애니메이션 곡선
- **Hero**: 화면 전환 애니메이션
- **dispose()**: 메모리 관리 필수

## 다음 단계

다음 챕터에서는 **패키지 사용법**을 배워봅시다! pub.dev 완전 정복! 📦
