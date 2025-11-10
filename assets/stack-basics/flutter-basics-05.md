# Chapter 5: 폼 & 사용자 입력 (Forms & User Input)

Flutter에서 사용자 입력을 받고 처리하는 다양한 방법을 배웁니다.

## 5.1 TextField - 기본 텍스트 입력

가장 기본적인 텍스트 입력 위젯입니다.

```dart
class SimpleTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TextField 예제')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(
            labelText: '이름',
            hintText: '이름을 입력하세요',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            print('입력된 값: $value');
          },
        ),
      ),
    );
  }
}
```

### TextField 옵션들

```dart
TextField(
  decoration: InputDecoration(
    labelText: '라벨',
    hintText: '힌트 텍스트',
    helperText: '도움말 텍스트',
    prefixIcon: Icon(Icons.person),
    suffixIcon: Icon(Icons.clear),
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.number,      // 숫자 키보드
  obscureText: true,                       // 비밀번호 (글자 숨김)
  maxLength: 20,                           // 최대 길이
  maxLines: 3,                             // 여러 줄
  textInputAction: TextInputAction.done,   // 키보드 완료 버튼
  autocorrect: false,                      // 자동 수정 끄기
)
```

### 키보드 타입들

```dart
TextInputType.text          // 일반 텍스트
TextInputType.number        // 숫자
TextInputType.phone         // 전화번호
TextInputType.emailAddress  // 이메일
TextInputType.url           // URL
TextInputType.multiline     // 여러 줄
TextInputType.datetime      // 날짜/시간
```

## 5.2 TextEditingController - 입력값 제어

TextField의 값을 읽고 제어할 수 있습니다.

```dart
class ControlledTextField extends StatefulWidget {
  @override
  _ControlledTextFieldState createState() => _ControlledTextFieldState();
}

class _ControlledTextFieldState extends State<ControlledTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Controller 예제')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '메시지',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // 값 읽기
                      print('입력된 값: ${_controller.text}');
                    },
                    child: Text('값 읽기'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // 값 설정
                      _controller.text = '안녕하세요!';
                    },
                    child: Text('값 설정'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // 값 지우기
                      _controller.clear();
                    },
                    child: Text('지우기'),
                  ),
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

### Controller 리스너

```dart
@override
void initState() {
  super.initState();

  // 값이 변경될 때마다 호출
  _controller.addListener(() {
    print('현재 값: ${_controller.text}');
  });
}
```

## 5.3 Form - 여러 입력 필드 관리

여러 입력 필드를 한 번에 검증하고 관리합니다.

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    // 폼 검증
    if (_formKey.currentState!.validate()) {
      // 검증 성공
      print('이메일: ${_emailController.text}');
      print('비밀번호: ${_passwordController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 성공!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이메일을 입력하세요';
                  }
                  if (!value.contains('@')) {
                    return '올바른 이메일 형식이 아닙니다';
                  }
                  return null; // 검증 성공
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력하세요';
                  }
                  if (value.length < 6) {
                    return '비밀번호는 최소 6자 이상이어야 합니다';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text('로그인'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 5.4 Checkbox - 체크박스

```dart
class CheckboxExample extends StatefulWidget {
  @override
  _CheckboxExampleState createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkbox 예제')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CheckboxListTile(
              title: Text('이용약관에 동의합니다'),
              subtitle: Text('필수 동의 항목입니다'),
              value: _agreedToTerms,
              onChanged: (value) {
                setState(() {
                  _agreedToTerms = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading, // 체크박스 위치
            ),
            SizedBox(height: 16),
            // 간단한 Checkbox
            Row(
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value ?? false;
                    });
                  },
                ),
                Text('동의합니다'),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _agreedToTerms ? () {
                print('다음 단계로!');
              } : null, // 비활성화
              child: Text('다음'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 여러 체크박스 관리

```dart
class MultiCheckboxExample extends StatefulWidget {
  @override
  _MultiCheckboxExampleState createState() => _MultiCheckboxExampleState();
}

class _MultiCheckboxExampleState extends State<MultiCheckboxExample> {
  Map<String, bool> _hobbies = {
    '독서': false,
    '운동': false,
    '음악': false,
    '영화': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('취미 선택')),
      body: Column(
        children: [
          ..._hobbies.keys.map((hobby) {
            return CheckboxListTile(
              title: Text(hobby),
              value: _hobbies[hobby],
              onChanged: (value) {
                setState(() {
                  _hobbies[hobby] = value ?? false;
                });
              },
            );
          }).toList(),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final selected = _hobbies.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList();
              print('선택된 취미: $selected');
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }
}
```

## 5.5 Radio - 라디오 버튼

여러 옵션 중 하나만 선택할 수 있습니다.

```dart
class RadioExample extends StatefulWidget {
  @override
  _RadioExampleState createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Radio 예제')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('성별을 선택하세요', style: TextStyle(fontSize: 18)),
            RadioListTile<String>(
              title: Text('남성'),
              value: 'male',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('여성'),
              value: 'female',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('기타'),
              value: 'other',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            SizedBox(height: 16),
            Text('선택된 값: $_selectedGender'),
          ],
        ),
      ),
    );
  }
}
```

## 5.6 Switch - 스위치

켜기/끄기 토글입니다.

```dart
class SwitchExample extends StatefulWidget {
  @override
  _SwitchExampleState createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('설정')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('알림 받기'),
            subtitle: Text('새로운 소식을 알려드립니다'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            secondary: Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: Text('다크 모드'),
            subtitle: Text('어두운 테마를 사용합니다'),
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
            },
            secondary: Icon(Icons.dark_mode),
          ),
        ],
      ),
    );
  }
}
```

## 5.7 Slider - 슬라이더

범위 내에서 값을 선택합니다.

```dart
class SliderExample extends StatefulWidget {
  @override
  _SliderExampleState createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _volume = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Slider 예제')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('볼륨: ${_volume.round()}', style: TextStyle(fontSize: 24)),
            Slider(
              value: _volume,
              min: 0,
              max: 100,
              divisions: 10, // 10단계로 나눔
              label: _volume.round().toString(),
              onChanged: (value) {
                setState(() {
                  _volume = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## 실전 예제: 회원가입 폼

```dart
class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _gender = 'male';
  bool _agreedToTerms = false;
  bool _agreedToPrivacy = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_agreedToTerms || !_agreedToPrivacy) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('약관에 동의해주세요')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      print('이름: ${_nameController.text}');
      print('이메일: ${_emailController.text}');
      print('성별: $_gender');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 완료!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // 이름
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이름을 입력하세요';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // 이메일
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일을 입력하세요';
                }
                if (!value.contains('@')) {
                  return '올바른 이메일 형식이 아닙니다';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // 비밀번호
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력하세요';
                }
                if (value.length < 8) {
                  return '비밀번호는 최소 8자 이상이어야 합니다';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // 비밀번호 확인
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
              validator: (value) {
                if (value != _passwordController.text) {
                  return '비밀번호가 일치하지 않습니다';
                }
                return null;
              },
            ),
            SizedBox(height: 24),

            // 성별
            Text('성별', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('남성'),
                    value: 'male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('여성'),
                    value: 'female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 약관 동의
            CheckboxListTile(
              title: Text('이용약관 동의 (필수)'),
              value: _agreedToTerms,
              onChanged: (value) {
                setState(() {
                  _agreedToTerms = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('개인정보처리방침 동의 (필수)'),
              value: _agreedToPrivacy,
              onChanged: (value) {
                setState(() {
                  _agreedToPrivacy = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(height: 24),

            // 가입 버튼
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text('가입하기', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 연습 문제

1. TextEditingController는 왜 필요한가요?
2. Form의 validator는 언제 실행되나요?
3. Checkbox, Radio, Switch의 차이점은?
4. 간단한 로그인 폼을 만들어보세요 (이메일, 비밀번호 검증 포함).
5. 설문조사 폼을 만들어보세요 (이름, 나이, 성별, 취미 선택).

## 핵심 정리

- **TextField**: 기본 텍스트 입력
- **TextEditingController**: 입력값 읽기/제어
- **Form & TextFormField**: 여러 입력 검증
- **validator**: 입력값 검증
- **Checkbox**: 여러 개 선택 가능
- **Radio**: 하나만 선택
- **Switch**: 켜기/끄기
- **Slider**: 범위 내 값 선택

## 다음 단계

다음 챕터에서는 **리스트 & 스크롤**을 배워봅시다! ListView부터 GridView까지! 📜
