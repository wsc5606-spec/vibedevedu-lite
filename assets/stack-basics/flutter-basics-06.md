# Chapter 6: 리스트 & 스크롤 (Lists & Scrolling)

Flutter에서 스크롤 가능한 리스트를 만들고 데이터를 효율적으로 표시하는 방법을 배웁니다.

## 6.1 ListView - 기본 리스트

스크롤 가능한 리스트를 만듭니다.

```dart
class SimpleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView 예제')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('홍길동'),
            subtitle: Text('개발자'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              print('홍길동 탭');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('김철수'),
            subtitle: Text('디자이너'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('이영희'),
            subtitle: Text('기획자'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
```

**언제 사용하나요?**
- 항목 개수가 적을 때 (10개 이하)
- 고정된 리스트

## 6.2 ListView.builder - 효율적인 리스트

많은 데이터를 효율적으로 표시합니다. 화면에 보이는 것만 렌더링합니다.

```dart
class BuilderListView extends StatelessWidget {
  final List<String> items = List.generate(100, (index) => '항목 $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView.builder')),
      body: ListView.builder(
        itemCount: items.length, // 항목 개수
        itemBuilder: (context, index) {
          // 각 항목을 빌드
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(items[index]),
            subtitle: Text('상세 설명 $index'),
            onTap: () {
              print('${items[index]} 탭');
            },
          );
        },
      ),
    );
  }
}
```

**언제 사용하나요?**
- 항목이 많을 때 (10개 이상)
- 동적 데이터
- 실무에서 가장 많이 사용

**장점:**
- 메모리 효율적
- 성능 좋음
- 스크롤 부드러움

## 6.3 ListView.separated - 구분선이 있는 리스트

항목 사이에 구분선을 자동으로 추가합니다.

```dart
class SeparatedListView extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => '항목 $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView.separated')),
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
        separatorBuilder: (context, index) {
          // 구분선
          return Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[300],
          );
        },
      ),
    );
  }
}
```

## 6.4 GridView - 그리드 레이아웃

항목을 격자 형태로 배치합니다.

### GridView.count - 열 개수 지정

```dart
class CountGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GridView.count')),
      body: GridView.count(
        crossAxisCount: 2, // 열 개수
        crossAxisSpacing: 10, // 가로 간격
        mainAxisSpacing: 10, // 세로 간격
        padding: EdgeInsets.all(10),
        children: List.generate(20, (index) {
          return Container(
            color: Colors.blue[100 * ((index % 9) + 1)],
            child: Center(
              child: Text(
                '항목 $index',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }),
      ),
    );
  }
}
```

### GridView.builder - 효율적인 그리드

```dart
class BuilderGridView extends StatelessWidget {
  final List<String> items = List.generate(100, (index) => '항목 $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GridView.builder')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 열 개수
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1, // 가로:세로 비율
        ),
        padding: EdgeInsets.all(10),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 48),
                  SizedBox(height: 8),
                  Text(items[index]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

### GridView.extent - 최대 너비 지정

```dart
GridView.extent(
  maxCrossAxisExtent: 200, // 각 항목의 최대 너비
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  padding: EdgeInsets.all(10),
  children: List.generate(20, (index) {
    return Card(
      child: Center(child: Text('항목 $index')),
    );
  }),
)
```

## 6.5 SingleChildScrollView - 단일 자식 스크롤

하나의 위젯을 스크롤 가능하게 만듭니다.

```dart
class SingleChildScrollExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SingleChildScrollView')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.red[100],
              child: Center(child: Text('섹션 1')),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              color: Colors.blue[100],
              child: Center(child: Text('섹션 2')),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              color: Colors.green[100],
              child: Center(child: Text('섹션 3')),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              color: Colors.yellow[100],
              child: Center(child: Text('섹션 4')),
            ),
          ],
        ),
      ),
    );
  }
}
```

**언제 사용하나요?**
- Column이나 Row가 화면을 넘어갈 때
- 폼이 길어서 스크롤이 필요할 때
- 단순한 스크롤이 필요할 때

**주의:** Column과 함께 사용할 때는 `shrinkWrap: true` 필요 없음!

## 6.6 RefreshIndicator - 당겨서 새로고침

```dart
class RefreshableListView extends StatefulWidget {
  @override
  _RefreshableListViewState createState() => _RefreshableListViewState();
}

class _RefreshableListViewState extends State<RefreshableListView> {
  List<String> items = List.generate(20, (index) => '항목 $index');

  Future<void> _refresh() async {
    // 데이터 새로고침 시뮬레이션
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      items = List.generate(20, (index) => '새 항목 $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('새로고침')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
      ),
    );
  }
}
```

## 6.7 무한 스크롤 (Infinite Scroll)

스크롤 끝에 도달하면 더 많은 데이터를 로드합니다.

```dart
class InfiniteScrollList extends StatefulWidget {
  @override
  _InfiniteScrollListState createState() => _InfiniteScrollListState();
}

class _InfiniteScrollListState extends State<InfiniteScrollList> {
  final ScrollController _scrollController = ScrollController();
  List<String> items = List.generate(20, (index) => '항목 $index');
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    // 데이터 로딩 시뮬레이션
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      final newItems = List.generate(
        20,
        (index) => '항목 ${items.length + index}',
      );
      items.addAll(newItems);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('무한 스크롤')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == items.length) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}
```

## 실전 예제: 연락처 앱

```dart
class Contact {
  final String name;
  final String phone;
  final String email;

  Contact({required this.name, required this.phone, required this.email});
}

class ContactListPage extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(name: '홍길동', phone: '010-1234-5678', email: 'hong@example.com'),
    Contact(name: '김철수', phone: '010-2345-6789', email: 'kim@example.com'),
    Contact(name: '이영희', phone: '010-3456-7890', email: 'lee@example.com'),
    Contact(name: '박민수', phone: '010-4567-8901', email: 'park@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('연락처'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print('연락처 추가');
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(contact.name[0]),
            ),
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () {
                print('전화: ${contact.phone}');
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailPage(contact: contact),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1);
        },
      ),
    );
  }
}

class ContactDetailPage extends StatelessWidget {
  final Contact contact;

  ContactDetailPage({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(contact.name)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                child: Text(
                  contact.name[0],
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('이름'),
              subtitle: Text(contact.name),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('전화번호'),
              subtitle: Text(contact.phone),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('이메일'),
              subtitle: Text(contact.email),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 실전 예제: 이미지 갤러리

```dart
class GalleryPage extends StatelessWidget {
  final List<String> imageUrls = List.generate(
    20,
    (index) => 'https://picsum.photos/200?random=$index',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('갤러리')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailPage(
                    imageUrl: imageUrls[index],
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.grey[300],
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageDetailPage extends StatelessWidget {
  final String imageUrl;

  ImageDetailPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
```

## 실전 예제: 카테고리별 상품 리스트

```dart
class Product {
  final String name;
  final double price;
  final String category;

  Product({required this.name, required this.price, required this.category});
}

class ProductListPage extends StatelessWidget {
  final List<Product> products = [
    Product(name: '노트북', price: 1500000, category: '전자제품'),
    Product(name: '마우스', price: 30000, category: '전자제품'),
    Product(name: '키보드', price: 80000, category: '전자제품'),
    Product(name: '티셔츠', price: 25000, category: '의류'),
    Product(name: '청바지', price: 60000, category: '의류'),
    Product(name: '운동화', price: 85000, category: '신발'),
  ];

  @override
  Widget build(BuildContext context) {
    // 카테고리별로 그룹화
    final Map<String, List<Product>> groupedProducts = {};
    for (var product in products) {
      if (!groupedProducts.containsKey(product.category)) {
        groupedProducts[product.category] = [];
      }
      groupedProducts[product.category]!.add(product);
    }

    return Scaffold(
      appBar: AppBar(title: Text('상품 목록')),
      body: ListView.builder(
        itemCount: groupedProducts.length,
        itemBuilder: (context, categoryIndex) {
          final category = groupedProducts.keys.elementAt(categoryIndex);
          final categoryProducts = groupedProducts[category]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...categoryProducts.map((product) {
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('${product.price}원'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                );
              }).toList(),
              Divider(thickness: 8, color: Colors.grey[200]),
            ],
          );
        },
      ),
    );
  }
}
```

## 연습 문제

1. ListView와 ListView.builder의 차이점은?
2. GridView에서 열 개수를 3개로 만들려면?
3. 연락처 리스트를 만들어보세요 (이름, 전화번호 표시).
4. 2열 그리드 이미지 갤러리를 만들어보세요.
5. 무한 스크롤을 구현해보세요.

## 핵심 정리

- **ListView**: 기본 리스트 (항목 적을 때)
- **ListView.builder**: 효율적인 리스트 (항목 많을 때)
- **ListView.separated**: 구분선 있는 리스트
- **GridView.count**: 열 개수로 그리드
- **GridView.builder**: 효율적인 그리드
- **SingleChildScrollView**: 단일 위젯 스크롤
- **RefreshIndicator**: 당겨서 새로고침
- **ScrollController**: 스크롤 제어
- **무한 스크롤**: 끝에 도달하면 더 로드

## 다음 단계

다음 챕터에서는 **네트워킹**을 배워봅시다! API 통신의 모든 것! 🌐
