# Chapter 2: 레이아웃 (Layout)

Flutter에서 레이아웃 위젯은 다른 위젯들을 배치하고 정렬하는 데 사용됩니다. 화면을 구성하는 핵심 요소입니다.

## 2.1 Column - 세로 배치

자식 위젯들을 세로로 나열합니다.

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center, // 세로 방향 정렬
  crossAxisAlignment: CrossAxisAlignment.start, // 가로 방향 정렬
  children: [
    Text('항목 1'),
    Text('항목 2'),
    Text('항목 3'),
  ],
)
```

**언제 사용하나요?**
- 위젯을 위에서 아래로 배치할 때
- 폼 필드를 세로로 나열할 때
- 리스트 같은 세로 구조가 필요할 때

## 2.2 Row - 가로 배치

자식 위젯들을 가로로 나열합니다.

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 가로 방향 정렬
  crossAxisAlignment: CrossAxisAlignment.center, // 세로 방향 정렬
  children: [
    Icon(Icons.star),
    Text('평점'),
    Text('4.5'),
  ],
)
```

**언제 사용하나요?**
- 위젯을 좌우로 배치할 때
- 아이콘과 텍스트를 나란히 놓을 때
- 버튼을 가로로 나열할 때

## 2.3 Stack - 겹쳐서 배치

위젯들을 겹쳐서 배치합니다. Z축 개념으로 생각하세요.

```dart
Stack(
  children: [
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),
    Positioned(
      top: 20,
      left: 20,
      child: Text('위에 겹친 텍스트'),
    ),
    Positioned(
      bottom: 10,
      right: 10,
      child: Icon(Icons.star),
    ),
  ],
)
```

**언제 사용하나요?**
- 이미지 위에 텍스트를 올릴 때
- 배지나 알림 아이콘을 표시할 때
- 커스텀 UI를 만들 때

## 2.4 Container - 만능 컨테이너

크기, 색상, 여백, 테두리 등을 설정할 수 있는 다목적 위젯입니다.

```dart
Container(
  width: 150,
  height: 150,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(vertical: 10),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
      ),
    ],
  ),
  child: Center(
    child: Text('Container'),
  ),
)
```

**언제 사용하나요?**
- 위젯에 크기를 지정할 때
- 배경색이나 테두리가 필요할 때
- 여백(padding, margin)을 추가할 때
- 그림자나 둥근 모서리가 필요할 때

## 2.5 Padding - 여백 추가

자식 위젯 주변에 여백을 추가합니다.

```dart
Padding(
  padding: EdgeInsets.all(16), // 모든 방향 16
  child: Text('여백이 있는 텍스트'),
)

// 다양한 EdgeInsets 옵션
EdgeInsets.all(16)              // 모든 방향
EdgeInsets.symmetric(horizontal: 16, vertical: 8)  // 가로/세로
EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16)  // 개별 지정
EdgeInsets.fromLTRB(8, 16, 8, 16)  // 좌, 상, 우, 하
```

**언제 사용하나요?**
- Container를 사용하지 않고 여백만 필요할 때
- 가볍게 간격을 조정하고 싶을 때

## 2.6 Align - 정렬

자식 위젯을 특정 위치에 정렬합니다.

```dart
Align(
  alignment: Alignment.topRight,
  child: Icon(Icons.close),
)

// 다양한 Alignment 옵션
Alignment.topLeft       // 왼쪽 상단
Alignment.topCenter     // 중앙 상단
Alignment.topRight      // 오른쪽 상단
Alignment.centerLeft    // 왼쪽 중앙
Alignment.center        // 정중앙
Alignment.centerRight   // 오른쪽 중앙
Alignment.bottomLeft    // 왼쪽 하단
Alignment.bottomCenter  // 중앙 하단
Alignment.bottomRight   // 오른쪽 하단
```

**언제 사용하나요?**
- 위젯을 특정 위치에 배치할 때
- 닫기 버튼을 우상단에 놓을 때

## 2.7 Center - 중앙 정렬

자식 위젯을 중앙에 배치합니다.

```dart
Center(
  child: Text('중앙에 배치'),
)
```

**언제 사용하나요?**
- 위젯을 화면 중앙에 놓을 때
- 로딩 스피너를 중앙에 표시할 때

## 2.8 Expanded - 공간 채우기

Row나 Column 내에서 남은 공간을 채웁니다.

```dart
Row(
  children: [
    Icon(Icons.star),
    Expanded(
      child: Text('이 텍스트가 남은 공간을 모두 차지합니다'),
    ),
    Icon(Icons.more_vert),
  ],
)

// flex 속성으로 비율 조정
Row(
  children: [
    Expanded(
      flex: 2,  // 2/3 공간 차지
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1,  // 1/3 공간 차지
      child: Container(color: Colors.blue),
    ),
  ],
)
```

**언제 사용하나요?**
- Row나 Column에서 공간을 효율적으로 분배할 때
- 반응형 레이아웃을 만들 때
- 여러 위젯 간 비율을 조정할 때

## 2.9 Flexible - 유연한 공간

Expanded와 비슷하지만, 자식 크기만큼만 차지할 수도 있습니다.

```dart
Row(
  children: [
    Flexible(
      fit: FlexFit.tight,  // Expanded처럼 작동
      child: Container(color: Colors.red),
    ),
    Flexible(
      fit: FlexFit.loose,  // 필요한 만큼만 차지
      child: Container(color: Colors.blue, width: 50),
    ),
  ],
)
```

**언제 사용하나요?**
- Expanded보다 더 세밀한 제어가 필요할 때
- 자식이 오버플로우 되지 않게 하면서도 필요한 만큼만 공간을 차지하게 할 때

## 2.10 MainAxisAlignment vs CrossAxisAlignment

**MainAxisAlignment** - 주축 방향 정렬
- Column: 세로 방향
- Row: 가로 방향

```dart
MainAxisAlignment.start        // 시작점 정렬
MainAxisAlignment.end          // 끝점 정렬
MainAxisAlignment.center       // 중앙 정렬
MainAxisAlignment.spaceBetween // 사이에 균등 배치
MainAxisAlignment.spaceAround  // 주변에 균등 배치
MainAxisAlignment.spaceEvenly  // 완전 균등 배치
```

**CrossAxisAlignment** - 교차축 방향 정렬
- Column: 가로 방향
- Row: 세로 방향

```dart
CrossAxisAlignment.start    // 시작점 정렬
CrossAxisAlignment.end      // 끝점 정렬
CrossAxisAlignment.center   // 중앙 정렬
CrossAxisAlignment.stretch  // 늘려서 채우기
CrossAxisAlignment.baseline // 텍스트 베이스라인 정렬
```

## 실전 예제: 프로필 카드

```dart
class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          // 프로필 이미지
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: Colors.white, size: 32),
          ),
          SizedBox(width: 16),
          // 이름과 이메일
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '홍길동',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'hong@example.com',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // 더보기 버튼
          Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
```

## 실전 예제: SNS 게시물

```dart
class PostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 헤더
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://...'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('사용자 이름', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('2시간 전', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Icon(Icons.more_horiz),
            ],
          ),
        ),
        // 이미지
        Container(
          height: 300,
          color: Colors.grey[300],
          child: Center(child: Icon(Icons.image, size: 64)),
        ),
        // 액션 버튼
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.favorite_border),
              SizedBox(width: 16),
              Icon(Icons.chat_bubble_outline),
              SizedBox(width: 16),
              Icon(Icons.send),
              Spacer(),
              Icon(Icons.bookmark_border),
            ],
          ),
        ),
        // 좋아요 수
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('좋아요 127개', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        // 내용
        Padding(
          padding: EdgeInsets.all(12),
          child: Text('여기에 게시물 내용이 들어갑니다...'),
        ),
      ],
    );
  }
}
```

## 연습 문제

1. Column과 Row의 차이점은 무엇인가요?
2. Expanded와 Flexible의 차이점을 설명하세요.
3. Stack을 사용해서 이미지 위에 텍스트를 겹치는 카드를 만들어보세요.
4. Row 안에 Expanded를 사용해서 2:1 비율의 레이아웃을 만들어보세요.
5. 프로필 카드 예제를 참고해서 나만의 카드 UI를 만들어보세요!

## 핵심 정리

- **Column**: 세로 배치
- **Row**: 가로 배치
- **Stack**: 겹쳐서 배치
- **Container**: 크기, 색상, 여백 설정
- **Padding**: 여백만 추가
- **Align/Center**: 정렬
- **Expanded**: 남은 공간 채우기
- **Flexible**: 유연한 공간 분배

## 다음 단계

다음 챕터에서는 **상태관리 기초**를 배워봅시다! setState를 넘어 Provider까지! 🚀
