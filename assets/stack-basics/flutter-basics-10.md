# Chapter 10: 패키지 사용법 (Using Packages)

Flutter 생태계의 수많은 패키지를 활용하는 방법을 배웁니다.

## 10.1 패키지란?

패키지는 다른 개발자들이 만든 재사용 가능한 코드입니다. 바퀴를 다시 발명하지 말고 검증된 패키지를 사용하세요!

**장점:**
- 개발 시간 단축
- 검증된 코드 사용
- 유지보수 용이
- 커뮤니티 지원

## 10.2 pub.dev - 패키지 찾기

[pub.dev](https://pub.dev)는 Flutter와 Dart의 공식 패키지 저장소입니다.

### 좋은 패키지 고르는 법

1. **Pub Points** 확인 (140점 만점)
   - 130점 이상: 아주 좋음
   - 100-130점: 좋음
   - 100점 미만: 주의

2. **인기도(Popularity)** 확인
   - 많은 사람들이 사용하는가?

3. **좋아요(Likes)** 수 확인
   - 개발자들의 추천

4. **최근 업데이트** 확인
   - 6개월 이내: 활발히 관리됨
   - 1년 이상: 주의 필요

5. **문서화** 확인
   - README가 잘 작성되어 있는가?
   - 예제 코드가 있는가?

6. **이슈와 PR** 확인
   - GitHub에서 활발한 관리가 되는가?

## 10.3 pubspec.yaml 이해하기

프로젝트의 설정과 의존성을 관리하는 파일입니다.

```yaml
name: my_app
description: A new Flutter project.

# 최소 SDK 버전
environment:
  sdk: '>=3.0.0 <4.0.0'

# 의존성 패키지들
dependencies:
  flutter:
    sdk: flutter

  # 버전 지정 방법들
  http: ^1.1.0              # ^: 1.1.0 이상 2.0.0 미만
  provider: '>=6.0.0 <7.0.0' # 명시적 범위
  shared_preferences: any    # 아무 버전 (권장하지 않음)
  intl: ^0.18.0

# 개발 시에만 사용하는 패키지
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

# 앱 아이콘, 이미지 등
flutter:
  uses-material-design: true

  assets:
    - images/
    - assets/icons/

  fonts:
    - family: Roboto
      fonts:
        - asset: fonts/Roboto-Regular.ttf
        - asset: fonts/Roboto-Bold.ttf
          weight: 700
```

## 10.4 패키지 설치하기

### 방법 1: 수동으로 추가

1. `pubspec.yaml` 파일 열기
2. `dependencies:` 섹션에 패키지 추가
3. 터미널에서 실행:

```bash
flutter pub get
```

### 방법 2: 명령어로 추가

```bash
flutter pub add http
flutter pub add provider
flutter pub add shared_preferences
```

자동으로 `pubspec.yaml`에 추가되고 설치됩니다!

### 개발 의존성 추가

```bash
flutter pub add dev:flutter_lints
```

## 10.5 패키지 import하기

```dart
// Flutter 기본 패키지
import 'package:flutter/material.dart';

// 설치한 패키지
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Dart 기본 라이브러리
import 'dart:convert';
import 'dart:async';
import 'dart:math';

// 내 프로젝트의 다른 파일
import 'package:my_app/screens/home_page.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/api_service.dart';

// 상대 경로 import
import '../widgets/custom_button.dart';
import '../../utils/constants.dart';
```

## 10.6 자주 사용하는 패키지들

### 1. http - HTTP 요청

```yaml
dependencies:
  http: ^1.1.0
```

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchData() async {
  final response = await http.get(
    Uri.parse('https://api.example.com/data'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data);
  }
}
```

### 2. provider - 상태관리

```yaml
dependencies:
  provider: ^6.0.0
```

```dart
import 'package:provider/provider.dart';

// 사용법은 Chapter 3 참고
```

### 3. shared_preferences - 로컬 저장소

```yaml
dependencies:
  shared_preferences: ^2.2.0
```

```dart
import 'package:shared_preferences/shared_preferences.dart';

// 사용법은 Chapter 8 참고
```

### 4. intl - 국제화 & 날짜 포맷

```yaml
dependencies:
  intl: ^0.18.0
```

```dart
import 'package:intl/intl.dart';

// 날짜 포맷
final now = DateTime.now();
final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
print(formatter.format(now)); // 2024-01-15 14:30:00

// 숫자 포맷
final number = 1234567.89;
final numberFormat = NumberFormat('#,###.##');
print(numberFormat.format(number)); // 1,234,567.89

// 통화 포맷
final currency = NumberFormat.currency(locale: 'ko_KR', symbol: '₩');
print(currency.format(10000)); // ₩10,000
```

### 5. dio - 고급 HTTP 클라이언트

```yaml
dependencies:
  dio: ^5.0.0
```

```dart
import 'package:dio/dio.dart';

final dio = Dio();

// GET 요청
final response = await dio.get('https://api.example.com/users');

// POST 요청
final response = await dio.post(
  'https://api.example.com/users',
  data: {'name': 'John', 'age': 30},
);

// 인터셉터 설정
dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) {
    options.headers['Authorization'] = 'Bearer token';
    return handler.next(options);
  },
  onError: (error, handler) {
    print('에러: ${error.message}');
    return handler.next(error);
  },
));
```

### 6. cached_network_image - 이미지 캐싱

```yaml
dependencies:
  cached_network_image: ^3.3.0
```

```dart
import 'package:cached_network_image/cached_network_image.dart';

CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### 7. image_picker - 이미지/비디오 선택

```yaml
dependencies:
  image_picker: ^1.0.0
```

```dart
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final ImagePicker _picker = ImagePicker();

// 갤러리에서 이미지 선택
final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

// 카메라로 사진 촬영
final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

if (image != null) {
  setState(() {
    _imageFile = File(image.path);
  });
}
```

### 8. url_launcher - URL, 전화, 이메일 열기

```yaml
dependencies:
  url_launcher: ^6.2.0
```

```dart
import 'package:url_launcher/url_launcher.dart';

// 웹사이트 열기
Future<void> _launchURL() async {
  final Uri url = Uri.parse('https://flutter.dev');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

// 전화 걸기
Future<void> _makePhoneCall() async {
  final Uri phoneUri = Uri(scheme: 'tel', path: '01012345678');
  if (!await launchUrl(phoneUri)) {
    throw Exception('Could not launch $phoneUri');
  }
}

// 이메일 보내기
Future<void> _sendEmail() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'example@example.com',
    query: 'subject=Hello&body=This is a test',
  );
  if (!await launchUrl(emailUri)) {
    throw Exception('Could not launch $emailUri');
  }
}
```

### 9. uuid - 고유 ID 생성

```yaml
dependencies:
  uuid: ^4.0.0
```

```dart
import 'package:uuid/uuid.dart';

var uuid = Uuid();

// UUID 생성
String id = uuid.v4(); // 예: 110ec58a-a0f2-4ac4-8393-c866d813b8d1
print('고유 ID: $id');
```

### 10. flutter_svg - SVG 이미지 렌더링

```yaml
dependencies:
  flutter_svg: ^2.0.0
```

```dart
import 'package:flutter_svg/flutter_svg.dart';

// SVG 이미지 표시
SvgPicture.asset(
  'assets/images/logo.svg',
  width: 100,
  height: 100,
  color: Colors.blue,
)
```

## 10.7 패키지 업데이트하기

```bash
# 모든 패키지 업데이트
flutter pub upgrade

# 특정 패키지만 업데이트
flutter pub upgrade http

# 주요 버전 업데이트 (주의 필요)
flutter pub upgrade --major-versions
```

## 10.8 패키지 제거하기

### 방법 1: 수동 제거
1. `pubspec.yaml`에서 해당 줄 삭제
2. `flutter pub get` 실행

### 방법 2: 명령어 사용
```bash
flutter pub remove http
```

## 10.9 패키지 충돌 해결

### 버전 충돌

```yaml
# 충돌 발생
dependencies:
  package_a: ^1.0.0  # http ^0.13.0 필요
  package_b: ^2.0.0  # http ^1.0.0 필요
```

**해결 방법:**
1. 두 패키지 모두 업데이트
2. 한 패키지를 다른 버전으로 변경
3. `dependency_overrides` 사용 (최후의 수단)

```yaml
dependency_overrides:
  http: ^1.0.0
```

## 10.10 실전 예제: 패키지 조합

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  http: ^1.1.0
  shared_preferences: ^2.2.0
  intl: ^0.18.0
  cached_network_image: ^3.3.0
  url_launcher: ^6.2.0
```

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MaterialApp(
        title: '뉴스 앱',
        home: NewsListPage(),
      ),
    );
  }
}

class NewsProvider extends ChangeNotifier {
  List<News> _news = [];
  bool _isLoading = false;

  List<News> get news => _news;
  bool get isLoading => _isLoading;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://api.example.com/news'),
      );

      if (response.statusCode == 200) {
        // JSON 파싱 로직
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class News {
  final String title;
  final String imageUrl;
  final String url;
  final DateTime publishedAt;

  News({
    required this.title,
    required this.imageUrl,
    required this.url,
    required this.publishedAt,
  });
}

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('뉴스')),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: newsProvider.news.length,
            itemBuilder: (context, index) {
              final news = newsProvider.news[index];
              final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: news.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  ),
                  title: Text(news.title),
                  subtitle: Text(dateFormat.format(news.publishedAt)),
                  onTap: () async {
                    final Uri url = Uri.parse(news.url);
                    if (!await launchUrl(url)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('URL을 열 수 없습니다')),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
```

## 10.11 유용한 명령어 모음

```bash
# 패키지 정보 확인
flutter pub deps

# 사용하지 않는 패키지 찾기
flutter pub deps --no-dev | grep "^[a-z]"

# 패키지 캐시 삭제
flutter pub cache clean

# pubspec.lock 재생성
flutter pub get --offline
```

## 연습 문제

1. pub.dev에서 좋은 패키지를 고르는 기준 3가지는?
2. dependencies와 dev_dependencies의 차이는?
3. intl 패키지로 현재 날짜를 포맷해보세요.
4. image_picker로 갤러리에서 이미지를 선택하는 앱을 만들어보세요.
5. 여러 패키지를 조합해서 Todo 앱을 만들어보세요 (provider + shared_preferences + intl).

## 핵심 정리

- **pub.dev**: 공식 패키지 저장소
- **pubspec.yaml**: 패키지 관리 파일
- **flutter pub add**: 패키지 추가
- **flutter pub get**: 패키지 다운로드
- **import**: 패키지 가져오기
- **자주 사용하는 패키지**: http, provider, shared_preferences, intl, dio
- **버전 관리**: ^로 호환 가능한 버전 지정
- **패키지 선택**: Pub Points, 인기도, 최근 업데이트 확인

## 축하합니다!

Flutter 기초 끝장내기 10개 챕터를 모두 완료했습니다! 🎉

이제 다음 단계로 넘어갈 준비가 되었습니다:
- 고급 상태관리 (Riverpod, Bloc)
- Firebase 통합
- 네이티브 기능 연동
- 앱 배포 (iOS, Android)
- 성능 최적화
- 테스트 작성

계속해서 프로젝트를 만들면서 실력을 키워나가세요! 💪
