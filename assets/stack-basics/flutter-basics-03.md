# Chapter 3: 상태관리 기초 (State Management)

Flutter 앱에서 데이터를 관리하고 화면을 업데이트하는 방법을 배웁니다.

## 3.1 setState() - 기본 상태관리

StatefulWidget에서 상태를 업데이트하는 가장 기본적인 방법입니다.

```dart
class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;
  String _message = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
      _message = '카운트: $_counter';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter', style: TextStyle(fontSize: 48)),
            SizedBox(height: 16),
            Text(_message),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

**언제 사용하나요?**
- 단순한 상태 변화
- 한 위젯 내에서만 사용되는 데이터
- 카운터, 토글, 폼 입력 등

**장점:**
- 간단하고 직관적
- Flutter 기본 기능
- 별도 패키지 불필요

**단점:**
- 여러 위젯 간 데이터 공유 어려움
- 깊은 위젯 트리에서 비효율적
- 복잡한 앱에서는 관리 힘듦

## 3.2 위젯 간 데이터 전달

### 부모 → 자식: Constructor

```dart
class ParentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChildWidget(
      title: '제목',
      count: 10,
      onTap: () {
        print('탭됨!');
      },
    );
  }
}

class ChildWidget extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onTap;

  ChildWidget({
    required this.title,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text('$title: $count'),
    );
  }
}
```

### 자식 → 부모: Callback

```dart
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  String _data = '';

  void _handleDataFromChild(String data) {
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('받은 데이터: $_data'),
        ChildWidget(onDataChanged: _handleDataFromChild),
      ],
    );
  }
}

class ChildWidget extends StatelessWidget {
  final Function(String) onDataChanged;

  ChildWidget({required this.onDataChanged});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onDataChanged('안녕하세요!');
      },
      child: Text('데이터 전송'),
    );
  }
}
```

## 3.3 InheritedWidget - 위젯 트리 전체에 데이터 공유

여러 자식 위젯들이 같은 데이터에 접근할 수 있게 해줍니다.

```dart
// 1. InheritedWidget 정의
class UserData extends InheritedWidget {
  final String username;
  final int age;

  UserData({
    required this.username,
    required this.age,
    required Widget child,
  }) : super(child: child);

  // 하위 위젯에서 이 메서드로 데이터 접근
  static UserData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserData>();
  }

  // 데이터가 변경되었을 때 알림 여부 결정
  @override
  bool updateShouldNotify(UserData oldWidget) {
    return username != oldWidget.username || age != oldWidget.age;
  }
}

// 2. 데이터 제공
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserData(
      username: '홍길동',
      age: 25,
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

// 3. 데이터 사용
class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = UserData.of(context);

    return Text('${userData?.username} (${userData?.age}세)');
  }
}
```

**언제 사용하나요?**
- 테마 데이터
- 사용자 정보
- 앱 설정
- 여러 위젯에서 공유하는 데이터

**장점:**
- 효율적인 데이터 공유
- Flutter의 기본 메커니즘

**단점:**
- 직접 사용하기엔 복잡함
- 불변(immutable) 데이터만 권장
- Provider가 이를 더 쉽게 만들어줌

## 3.4 Provider - 실무에서 가장 많이 사용

Provider는 InheritedWidget을 쉽게 사용할 수 있게 해주는 패키지입니다.

### 설치

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
```

### ChangeNotifier 모델 만들기

```dart
import 'package:flutter/foundation.dart';

class Counter extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // 리스너들에게 변경 알림
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}
```

### Provider 제공하기

```dart
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Provider 제공
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}
```

### Provider 사용하기

```dart
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 방법 1: Consumer로 감싸기
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: Consumer<Counter>(
          builder: (context, counter, child) {
            return Text(
              '${counter.count}',
              style: TextStyle(fontSize: 48),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // 방법 2: context.read()로 메서드 호출
              context.read<Counter>().increment();
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () {
              context.read<Counter>().decrement();
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
```

### Provider 사용법 3가지

```dart
// 1. Consumer - 데이터가 변경될 때마다 rebuild
Consumer<Counter>(
  builder: (context, counter, child) {
    return Text('${counter.count}');
  },
)

// 2. Provider.of - Consumer와 비슷하지만 더 간단
final counter = Provider.of<Counter>(context);
return Text('${counter.count}');

// 3. context.watch() - 가장 간결
final counter = context.watch<Counter>();
return Text('${counter.count}');

// 4. context.read() - 값만 읽고 rebuild 안 함 (메서드 호출용)
context.read<Counter>().increment();
```

## 3.5 여러 Provider 사용하기

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Counter()),
        ChangeNotifierProvider(create: (context) => UserProfile()),
        ChangeNotifierProvider(create: (context) => ShoppingCart()),
      ],
      child: MyApp(),
    ),
  );
}
```

## 실전 예제: Todo 앱

```dart
// 1. 모델
class Todo {
  String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});
}

// 2. Provider
class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  int get totalCount => _todos.length;
  int get doneCount => _todos.where((todo) => todo.isDone).length;

  void addTodo(String title) {
    _todos.add(Todo(title: title));
    notifyListeners();
  }

  void toggleTodo(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}

// 3. UI
class TodoPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Column(
        children: [
          // 입력 필드
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '할 일을 입력하세요',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      context.read<TodoProvider>().addTodo(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          // 통계
          Consumer<TodoProvider>(
            builder: (context, todoProvider, child) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '완료: ${todoProvider.doneCount} / ${todoProvider.totalCount}',
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          ),
          // 리스트
          Expanded(
            child: Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return ListView.builder(
                  itemCount: todoProvider.todos.length,
                  itemBuilder: (context, index) {
                    final todo = todoProvider.todos[index];
                    return ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          context.read<TodoProvider>().toggleTodo(index);
                        },
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<TodoProvider>().removeTodo(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

## 실전 예제: 쇼핑몰 장바구니

```dart
class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
```

## 연습 문제

1. setState()와 Provider의 차이점은 무엇인가요?
2. context.read()와 context.watch()의 차이는?
3. Counter 앱을 Provider로 만들어보세요.
4. Todo 앱에 '전체 삭제' 기능을 추가해보세요.
5. 좋아하는 영화 리스트를 관리하는 Provider를 만들어보세요.

## 핵심 정리

- **setState()**: 단순한 로컬 상태 관리
- **Constructor & Callback**: 부모-자식 간 데이터 전달
- **InheritedWidget**: 위젯 트리 전체에 데이터 공유
- **Provider**: 실무에서 가장 많이 사용하는 상태관리
- **ChangeNotifier**: 데이터 변경 알림
- **Consumer**: 데이터 변경 시 UI 업데이트
- **context.read()**: 메서드 호출용
- **context.watch()**: 값 읽기 및 자동 업데이트

## 다음 단계

다음 챕터에서는 **네비게이션 & 라우팅**을 배워봅시다! 화면 전환의 모든 것! 🧭
