# Chapter 7: 네트워킹 (Networking)

Flutter에서 HTTP 요청으로 서버와 통신하고 JSON 데이터를 처리하는 방법을 배웁니다.

## 7.1 http 패키지 설치

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```

터미널에서 실행:
```bash
flutter pub get
```

## 7.2 GET 요청 - 데이터 가져오기

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class SimpleGetRequest extends StatefulWidget {
  @override
  _SimpleGetRequestState createState() => _SimpleGetRequestState();
}

class _SimpleGetRequestState extends State<SimpleGetRequest> {
  String _data = '데이터 없음';
  bool _isLoading = false;

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // GET 요청
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      );

      if (response.statusCode == 200) {
        // 성공
        final data = json.decode(response.body);
        setState(() {
          _data = data['title'];
          _isLoading = false;
        });
      } else {
        // 실패
        setState(() {
          _data = '오류: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _data = '오류 발생: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GET 요청')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              CircularProgressIndicator()
            else
              Text(_data, textAlign: TextAlign.center),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchData,
              child: Text('데이터 가져오기'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 7.3 JSON 파싱 - 모델 클래스 사용

### 1. 모델 클래스 정의

```dart
class Post {
  final int id;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.title,
    required this.body,
  });

  // JSON → Dart 객체
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  // Dart 객체 → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
```

### 2. API 서비스 클래스

```dart
class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // 단일 게시물 가져오기
  static Future<Post> fetchPost(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts/$id'),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('게시물을 불러오는데 실패했습니다');
    }
  }

  // 여러 게시물 가져오기
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('게시물 목록을 불러오는데 실패했습니다');
    }
  }
}
```

### 3. UI에서 사용

```dart
class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final posts = await ApiService.fetchPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('게시물 목록')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('오류 발생: $_error'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPosts,
              child: Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(
            post.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            // 상세 페이지로 이동
          },
        );
      },
    );
  }
}
```

## 7.4 POST 요청 - 데이터 전송하기

```dart
class ApiService {
  // 게시물 생성
  static Future<Post> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'title': title,
        'body': body,
        'userId': 1,
      }),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('게시물 생성에 실패했습니다');
    }
  }

  // 게시물 수정
  static Future<Post> updatePost(int id, String title, String body) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'id': id,
        'title': title,
        'body': body,
        'userId': 1,
      }),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('게시물 수정에 실패했습니다');
    }
  }

  // 게시물 삭제
  static Future<void> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/posts/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('게시물 삭제에 실패했습니다');
    }
  }
}
```

## 7.5 FutureBuilder - 비동기 데이터 표시

Future를 직접 사용해서 UI를 구성합니다.

```dart
class FutureBuilderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FutureBuilder')),
      body: FutureBuilder<List<Post>>(
        future: ApiService.fetchPosts(), // Future 전달
        builder: (context, snapshot) {
          // 로딩 중
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // 오류 발생
          if (snapshot.hasError) {
            return Center(
              child: Text('오류: ${snapshot.error}'),
            );
          }

          // 데이터 없음
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('데이터가 없습니다'));
          }

          // 데이터 표시
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body, maxLines: 2),
              );
            },
          );
        },
      ),
    );
  }
}
```

**언제 사용하나요?**
- 화면이 열릴 때 한 번만 데이터를 로드
- 새로고침이 필요 없는 경우
- 간단한 데이터 표시

## 7.6 헤더와 인증

```dart
class ApiService {
  static const String token = 'your_api_token';

  // 인증 헤더 포함
  static Future<List<Post>> fetchPostsWithAuth() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('인증 실패');
    } else {
      throw Exception('데이터 로드 실패');
    }
  }
}
```

## 7.7 쿼리 파라미터

```dart
// URL: https://api.example.com/posts?userId=1&page=2
Future<List<Post>> fetchPostsByUser(int userId, int page) async {
  final uri = Uri.parse('$baseUrl/posts').replace(
    queryParameters: {
      'userId': userId.toString(),
      'page': page.toString(),
    },
  );

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception('데이터 로드 실패');
  }
}
```

## 실전 예제: 날씨 앱

```dart
class Weather {
  final String city;
  final double temperature;
  final String description;
  final String icon;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}

class WeatherService {
  static const String apiKey = 'your_api_key';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  static Future<Weather> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric&lang=kr'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('날씨 정보를 불러올 수 없습니다');
    }
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather;
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchWeather() async {
    if (_cityController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final weather = await WeatherService.fetchWeather(_cityController.text);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('날씨 앱')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: '도시 이름',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _fetchWeather(),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _fetchWeather,
                  child: Text('검색'),
                ),
              ],
            ),
            SizedBox(height: 32),
            if (_isLoading)
              CircularProgressIndicator()
            else if (_error != null)
              Text('오류: $_error', style: TextStyle(color: Colors.red))
            else if (_weather != null)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        _weather!.city,
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '${_weather!.temperature.toStringAsFixed(1)}°C',
                        style: TextStyle(fontSize: 48),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _weather!.description,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
```

## 실전 예제: Todo API

```dart
class Todo {
  final int? id;
  final String title;
  final bool completed;

  Todo({this.id, required this.title, this.completed = false});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }
}

class TodoApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.take(10).map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Todo 목록 로드 실패');
    }
  }

  static Future<Todo> createTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Todo 생성 실패');
    }
  }

  static Future<void> updateTodo(int id, bool completed) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'completed': completed}),
    );

    if (response.statusCode != 200) {
      throw Exception('Todo 수정 실패');
    }
  }

  static Future<void> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/todos/$id'));

    if (response.statusCode != 200) {
      throw Exception('Todo 삭제 실패');
    }
  }
}

class TodoApiPage extends StatefulWidget {
  @override
  _TodoApiPageState createState() => _TodoApiPageState();
}

class _TodoApiPageState extends State<TodoApiPage> {
  List<Todo> _todos = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    setState(() => _isLoading = true);

    try {
      final todos = await TodoApiService.getTodos();
      setState(() {
        _todos = todos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류: $e')),
      );
    }
  }

  Future<void> _addTodo(String title) async {
    try {
      final newTodo = await TodoApiService.createTodo(
        Todo(title: title),
      );
      setState(() {
        _todos.insert(0, newTodo);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Todo 추가됨')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo API')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadTodos,
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  return CheckboxListTile(
                    title: Text(todo.title),
                    value: todo.completed,
                    onChanged: (value) {
                      // 체크박스 토글
                    },
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Todo 추가 다이얼로그
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

## 연습 문제

1. GET과 POST의 차이점은?
2. JSON 파싱은 왜 필요한가요?
3. FutureBuilder의 장단점은?
4. 간단한 API를 호출해서 데이터를 표시해보세요.
5. Todo 앱을 만들고 API와 연동해보세요.

## 핵심 정리

- **http 패키지**: HTTP 요청 라이브러리
- **GET**: 데이터 가져오기
- **POST**: 데이터 전송/생성
- **PUT/PATCH**: 데이터 수정
- **DELETE**: 데이터 삭제
- **json.decode()**: JSON → Dart 객체
- **json.encode()**: Dart 객체 → JSON
- **FutureBuilder**: 비동기 데이터 UI 표시
- **try-catch**: 에러 처리
- **헤더**: 인증, Content-Type 등

## 다음 단계

다음 챕터에서는 **로컬 저장소**를 배워봅시다! 데이터를 기기에 저장하기! 💾
