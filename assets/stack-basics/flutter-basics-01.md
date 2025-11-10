# Chapter 1: 위젯 기초 (Widget Basics)

Flutter의 모든 것은 **위젯(Widget)**입니다. 화면에 보이는 모든 요소가 위젯으로 구성됩니다.

## 1.1 위젯이란?

위젯은 UI를 구성하는 기본 단위입니다. 버튼, 텍스트, 이미지 등 모든 것이 위젯입니다.

```dart
// 간단한 텍스트 위젯
Text('안녕하세요, Flutter!')
```

## 1.2 StatelessWidget

상태가 없는 위젯입니다. 한번 생성되면 변하지 않습니다.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('첫 앱')),
        body: Center(
          child: Text('Hello, Flutter!'),
        ),
      ),
    );
  }
}
```

**언제 사용하나요?**
- 정적인 화면
- 사용자 입력이 필요 없는 경우
- 화면이 변하지 않는 경우

## 1.3 StatefulWidget

상태가 있는 위젯입니다. 사용자 입력이나 데이터 변화에 따라 화면이 바뀝니다.

```dart
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('카운트: $count'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Text('증가'),
        ),
      ],
    );
  }
}
```

**언제 사용하나요?**
- 사용자 입력이 있는 경우
- 화면이 동적으로 변하는 경우
- 카운터, 폼, 애니메이션 등

## 1.4 setState()의 중요성

`setState()`를 호출해야 화면이 다시 그려집니다.

```dart
// ❌ 잘못된 방법
onPressed: () {
  count++;  // 화면이 업데이트되지 않음
}

// ✅ 올바른 방법
onPressed: () {
  setState(() {
    count++;  // 화면이 업데이트됨
  });
}
```

## 1.5 기본 위젯들

### Text 위젯
```dart
Text(
  '스타일이 적용된 텍스트',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
)
```

### Container 위젯
```dart
Container(
  width: 100,
  height: 100,
  color: Colors.blue,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  child: Text('컨테이너'),
)
```

### ElevatedButton 위젯
```dart
ElevatedButton(
  onPressed: () {
    print('버튼 클릭!');
  },
  child: Text('클릭하세요'),
)
```

## 1.6 위젯 트리 (Widget Tree)

Flutter 앱은 위젯들이 트리 구조로 구성됩니다.

```dart
MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text('제목'),
    ),
    body: Center(
      child: Column(
        children: [
          Text('항목 1'),
          Text('항목 2'),
          ElevatedButton(
            child: Text('버튼'),
            onPressed: () {},
          ),
        ],
      ),
    ),
  ),
)
```

## 연습 문제

1. StatelessWidget과 StatefulWidget의 차이점은?
2. setState()는 왜 필요한가요?
3. 간단한 카운터 앱을 만들어보세요!

## 다음 단계

다음 챕터에서는 **레이아웃 위젯**을 배워봅시다! 🎨
