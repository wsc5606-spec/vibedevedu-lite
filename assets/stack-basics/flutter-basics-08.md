# Chapter 8: 로컬 저장소 (Local Storage)

Flutter에서 데이터를 기기에 저장하고 불러오는 방법을 배웁니다.

## 8.1 shared_preferences 패키지 설치

간단한 키-값 쌍 데이터를 저장하는 가장 쉬운 방법입니다.

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.0
```

터미널에서 실행:
```bash
flutter pub get
```

## 8.2 데이터 저장하기

```dart
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // 문자열 저장
  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // 숫자 저장
  static Future<void> saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  // 실수 저장
  static Future<void> saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  // 불리언 저장
  static Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // 리스트 저장 (문자열 리스트만 가능)
  static Future<void> saveStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }
}
```

## 8.3 데이터 불러오기

```dart
class StorageService {
  // 문자열 불러오기
  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // 숫자 불러오기
  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  // 실수 불러오기
  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  // 불리언 불러오기
  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // 리스트 불러오기
  static Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  // 기본값과 함께 불러오기
  static Future<String> getStringWithDefault(
    String key,
    String defaultValue,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? defaultValue;
  }
}
```

## 8.4 데이터 삭제하기

```dart
class StorageService {
  // 특정 키 삭제
  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // 모든 데이터 삭제
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // 키가 존재하는지 확인
  static Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  // 모든 키 가져오기
  static Future<Set<String>> getAllKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }
}
```

## 8.5 실전 예제: 사용자 설정

```dart
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  String _language = 'ko';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // 설정 불러오기
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
      _darkMode = prefs.getBool('darkMode') ?? false;
      _language = prefs.getString('language') ?? 'ko';
    });
  }

  // 알림 설정 저장
  Future<void> _saveNotificationSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', value);
    setState(() {
      _notificationsEnabled = value;
    });
  }

  // 다크 모드 설정 저장
  Future<void> _saveDarkModeSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    setState(() {
      _darkMode = value;
    });
  }

  // 언어 설정 저장
  Future<void> _saveLanguageSetting(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', value);
    setState(() {
      _language = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('설정')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('알림'),
            subtitle: Text('푸시 알림 받기'),
            value: _notificationsEnabled,
            onChanged: _saveNotificationSetting,
          ),
          SwitchListTile(
            title: Text('다크 모드'),
            subtitle: Text('어두운 테마 사용'),
            value: _darkMode,
            onChanged: _saveDarkModeSetting,
          ),
          ListTile(
            title: Text('언어'),
            subtitle: Text(_language == 'ko' ? '한국어' : 'English'),
            trailing: DropdownButton<String>(
              value: _language,
              items: [
                DropdownMenuItem(value: 'ko', child: Text('한국어')),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
              onChanged: (value) {
                if (value != null) {
                  _saveLanguageSetting(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

## 8.6 실전 예제: 로그인 상태 유지

```dart
class AuthService {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUsername = 'username';
  static const String _keyToken = 'token';

  // 로그인
  static Future<void> login(String username, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyToken, token);
  }

  // 로그아웃
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyToken);
  }

  // 로그인 상태 확인
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // 사용자 이름 가져오기
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  // 토큰 가져오기
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }
}

// 앱 시작 시 로그인 상태 확인
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // 스플래시 화면 표시

    final isLoggedIn = await AuthService.isLoggedIn();

    if (isLoggedIn) {
      // 로그인 됨 → 홈으로
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // 로그인 안 됨 → 로그인 화면으로
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
```

## 8.7 실전 예제: 최근 검색어

```dart
class SearchHistoryService {
  static const String _key = 'searchHistory';
  static const int _maxItems = 10;

  // 검색어 추가
  static Future<void> addSearchTerm(String term) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_key) ?? [];

    // 중복 제거
    history.remove(term);

    // 맨 앞에 추가
    history.insert(0, term);

    // 최대 개수 제한
    if (history.length > _maxItems) {
      history = history.sublist(0, _maxItems);
    }

    await prefs.setStringList(_key, history);
  }

  // 검색 기록 가져오기
  static Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  // 특정 검색어 삭제
  static Future<void> removeSearchTerm(String term) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_key) ?? [];
    history.remove(term);
    await prefs.setStringList(_key, history);
  }

  // 전체 기록 삭제
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final history = await SearchHistoryService.getSearchHistory();
    setState(() {
      _searchHistory = history;
    });
  }

  Future<void> _search(String term) async {
    if (term.isEmpty) return;

    await SearchHistoryService.addSearchTerm(term);
    await _loadSearchHistory();

    // 실제 검색 수행
    print('검색: $term');
  }

  Future<void> _deleteHistoryItem(String term) async {
    await SearchHistoryService.removeSearchTerm(term);
    await _loadSearchHistory();
  }

  Future<void> _clearAllHistory() async {
    await SearchHistoryService.clearHistory();
    await _loadSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: '검색...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
          onSubmitted: _search,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _search(_searchController.text),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_searchHistory.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '최근 검색어',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: _clearAllHistory,
                    child: Text('전체 삭제'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchHistory.length,
                itemBuilder: (context, index) {
                  final term = _searchHistory[index];
                  return ListTile(
                    leading: Icon(Icons.history),
                    title: Text(term),
                    trailing: IconButton(
                      icon: Icon(Icons.close, size: 20),
                      onPressed: () => _deleteHistoryItem(term),
                    ),
                    onTap: () {
                      _searchController.text = term;
                      _search(term);
                    },
                  );
                },
              ),
            ),
          ] else
            Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('최근 검색어가 없습니다'),
              ),
            ),
        ],
      ),
    );
  }
}
```

## 8.8 실전 예제: 즐겨찾기

```dart
class FavoritesService {
  static const String _key = 'favorites';

  // 즐겨찾기 추가
  static Future<void> addFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_key) ?? [];

    if (!favorites.contains(id.toString())) {
      favorites.add(id.toString());
      await prefs.setStringList(_key, favorites);
    }
  }

  // 즐겨찾기 제거
  static Future<void> removeFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_key) ?? [];
    favorites.remove(id.toString());
    await prefs.setStringList(_key, favorites);
  }

  // 즐겨찾기 여부 확인
  static Future<bool> isFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_key) ?? [];
    return favorites.contains(id.toString());
  }

  // 모든 즐겨찾기 가져오기
  static Future<List<int>> getAllFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_key) ?? [];
    return favorites.map((id) => int.parse(id)).toList();
  }

  // 즐겨찾기 토글
  static Future<bool> toggleFavorite(int id) async {
    final isFav = await isFavorite(id);
    if (isFav) {
      await removeFavorite(id);
      return false;
    } else {
      await addFavorite(id);
      return true;
    }
  }
}

class ProductCard extends StatefulWidget {
  final int productId;
  final String productName;

  ProductCard({required this.productId, required this.productName});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    final isFav = await FavoritesService.isFavorite(widget.productId);
    setState(() {
      _isFavorite = isFav;
    });
  }

  Future<void> _toggleFavorite() async {
    final isFav = await FavoritesService.toggleFavorite(widget.productId);
    setState(() {
      _isFavorite = isFav;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFav ? '즐겨찾기에 추가됨' : '즐겨찾기에서 제거됨'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.productName),
        trailing: IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : null,
          ),
          onPressed: _toggleFavorite,
        ),
      ),
    );
  }
}
```

## 8.9 복잡한 객체 저장하기 (JSON 활용)

```dart
import 'dart:convert';

class User {
  final String name;
  final String email;
  final int age;

  User({required this.name, required this.email, required this.age});

  // JSON → User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      age: json['age'],
    );
  }

  // User → JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
    };
  }
}

class UserService {
  static const String _key = 'user';

  // 사용자 저장
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(user.toJson());
    await prefs.setString(_key, jsonString);
  }

  // 사용자 불러오기
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return null;

    final jsonMap = json.decode(jsonString);
    return User.fromJson(jsonMap);
  }

  // 사용자 삭제
  static Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
```

## 연습 문제

1. SharedPreferences는 무엇인가요?
2. 어떤 종류의 데이터를 저장할 수 있나요?
3. 로그인/로그아웃 기능을 만들고 상태를 유지해보세요.
4. 최근 본 항목 리스트를 저장하고 표시해보세요.
5. 앱 설정(다크모드, 알림 등)을 저장하는 기능을 만들어보세요.

## 핵심 정리

- **SharedPreferences**: 간단한 키-값 데이터 저장
- **setString/Int/Bool/Double**: 기본 타입 저장
- **getString/Int/Bool/Double**: 데이터 불러오기
- **setStringList**: 문자열 리스트 저장
- **remove**: 특정 키 삭제
- **clear**: 모든 데이터 삭제
- **JSON 활용**: 복잡한 객체도 저장 가능
- **사용 사례**: 설정, 로그인 상태, 검색 기록, 즐겨찾기

## 다음 단계

다음 챕터에서는 **애니메이션 기초**를 배워봅시다! 앱에 생동감을! ✨
