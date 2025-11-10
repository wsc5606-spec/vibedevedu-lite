// Flutter UI Challenge Data - 50 problems
// Easy: 1-20, Medium: 21-35, Hard: 36-50

class UIChallengeData {
  final int id;
  final String title;
  final String description;
  final String difficulty;
  final String hint;
  final String expectedResult;
  final String sampleCode;

  const UIChallengeData({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.hint,
    required this.expectedResult,
    required this.sampleCode,
  });
}

final List<UIChallengeData> allUIChallenges = [
  // ========== EASY (1-20) ==========
  const UIChallengeData(
    id: 1,
    title: '프로필 카드 만들기',
    description: 'CircleAvatar, Row, Column을 사용하여 사용자 프로필 카드를 만드세요',
    difficulty: 'easy',
    hint: 'Card 위젯으로 감싸고, Row에 CircleAvatar와 Column(이름, 직업)을 배치하세요',
    expectedResult: '원형 프로필 이미지, 이름(굵게), 직업(회색) 텍스트가 가로로 배치된 카드',
    sampleCode: '''// TODO: Card 위젯을 사용하여 프로필 카드를 만드세요
// 힌트: Row 안에 CircleAvatar와 Column을 배치하세요
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        // TODO: CircleAvatar를 추가하세요
        // TODO: SizedBox로 간격을 주세요
        // TODO: Column을 추가하고 이름과 직업을 표시하세요
      ],
    ),
  ),
)''',
  ),

  const UIChallengeData(
    id: 2,
    title: '버튼 3개 가로 배치',
    description: 'Row를 사용하여 ElevatedButton 3개를 균등하게 배치하세요',
    difficulty: 'easy',
    hint: 'Row에 mainAxisAlignment: MainAxisAlignment.spaceEvenly를 사용하세요',
    expectedResult: '화면 가로로 균등하게 배치된 3개의 버튼',
    sampleCode: '''Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    ElevatedButton(onPressed: () {}, child: Text('버튼 1')),
    ElevatedButton(onPressed: () {}, child: Text('버튼 2')),
    ElevatedButton(onPressed: () {}, child: Text('버튼 3')),
  ],
)''',
  ),

  const UIChallengeData(
    id: 3,
    title: '리스트 타일 만들기',
    description: 'ListTile을 사용하여 아이콘, 제목, 부제목, trailing 아이콘이 있는 리스트 항목을 만드세요',
    difficulty: 'easy',
    hint: 'ListTile의 leading, title, subtitle, trailing 속성을 활용하세요',
    expectedResult: '왼쪽 아이콘, 제목과 부제목, 오른쪽 화살표 아이콘이 있는 리스트 항목',
    sampleCode: '''ListTile(
  leading: Icon(Icons.home, color: Colors.blue),
  title: Text('홈'),
  subtitle: Text('메인 화면으로 이동'),
  trailing: Icon(Icons.arrow_forward_ios, size: 16),
  onTap: () {},
)''',
  ),

  const UIChallengeData(
    id: 4,
    title: '텍스트 스타일링',
    description: 'Text 위젯에 다양한 스타일을 적용하세요',
    difficulty: 'easy',
    hint: 'TextStyle의 fontSize, fontWeight, color를 사용하세요',
    expectedResult: '큰 글씨, 굵은 글씨, 색상이 있는 텍스트',
    sampleCode: '''Text(
  'Hello Flutter!',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
)''',
  ),

  const UIChallengeData(
    id: 5,
    title: '아이콘과 텍스트 조합',
    description: 'Row를 사용하여 아이콘과 텍스트를 나란히 배치하세요',
    difficulty: 'easy',
    hint: 'Row에 Icon과 Text를 children으로 추가하고, SizedBox로 간격을 주세요',
    expectedResult: '아이콘과 텍스트가 가로로 배치됨',
    sampleCode: '''Row(
  children: [
    Icon(Icons.star, color: Colors.amber),
    SizedBox(width: 8),
    Text('즐겨찾기'),
  ],
)''',
  ),

  const UIChallengeData(
    id: 6,
    title: '컨테이너 꾸미기',
    description: 'Container에 색상, 패딩, 모서리 둥글게 처리하기',
    difficulty: 'easy',
    hint: 'decoration에 BoxDecoration을 사용하고, borderRadius를 추가하세요',
    expectedResult: '색상과 둥근 모서리가 있는 컨테이너',
    sampleCode: '''Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text('Hello', style: TextStyle(color: Colors.white)),
)''',
  ),

  const UIChallengeData(
    id: 7,
    title: '세로 버튼 목록',
    description: 'Column을 사용하여 버튼 3개를 세로로 배치하세요',
    difficulty: 'easy',
    hint: 'Column의 children에 ElevatedButton을 추가하고 SizedBox로 간격을 주세요',
    expectedResult: '세로로 배치된 3개의 버튼',
    sampleCode: '''Column(
  children: [
    ElevatedButton(onPressed: () {}, child: Text('버튼 1')),
    SizedBox(height: 12),
    ElevatedButton(onPressed: () {}, child: Text('버튼 2')),
    SizedBox(height: 12),
    ElevatedButton(onPressed: () {}, child: Text('버튼 3')),
  ],
)''',
  ),

  const UIChallengeData(
    id: 8,
    title: '중앙 정렬하기',
    description: 'Center 위젯을 사용하여 텍스트를 화면 중앙에 배치하세요',
    difficulty: 'easy',
    hint: 'Center 위젯으로 Text를 감싸세요',
    expectedResult: '화면 중앙에 텍스트가 표시됨',
    sampleCode: '''Center(
  child: Text(
    '중앙 정렬',
    style: TextStyle(fontSize: 24),
  ),
)''',
  ),

  const UIChallengeData(
    id: 9,
    title: '체크박스 만들기',
    description: 'Checkbox와 Text를 Row로 배치하세요',
    difficulty: 'easy',
    hint: 'Row에 Checkbox와 Text를 children으로 추가하세요',
    expectedResult: '체크박스와 라벨이 나란히 표시됨',
    sampleCode: '''bool _isChecked = false;

Row(
  children: [
    Checkbox(
      value: _isChecked,
      onChanged: (value) => setState(() => _isChecked = value!),
    ),
    Text('동의합니다'),
  ],
)''',
  ),

  const UIChallengeData(
    id: 10,
    title: '간단한 카드',
    description: 'Card 위젯에 제목과 설명을 추가하세요',
    difficulty: 'easy',
    hint: 'Card의 child에 Padding과 Column을 사용하세요',
    expectedResult: '제목과 설명이 있는 카드',
    sampleCode: '''Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('제목', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('설명 내용'),
      ],
    ),
  ),
)''',
  ),

  const UIChallengeData(
    id: 11,
    title: '경계선 있는 컨테이너',
    description: 'Container에 테두리를 추가하세요',
    difficulty: 'easy',
    hint: 'BoxDecoration의 border 속성을 사용하세요',
    expectedResult: '파란색 테두리가 있는 컨테이너',
    sampleCode: '''Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text('테두리 있는 박스'),
)''',
  ),

  const UIChallengeData(
    id: 12,
    title: '이미지 원형으로 자르기',
    description: 'ClipOval을 사용하여 이미지를 원형으로 표시하세요',
    difficulty: 'easy',
    hint: 'ClipOval로 Image.network를 감싸세요',
    expectedResult: '원형으로 잘린 이미지',
    sampleCode: '''ClipOval(
  child: Image.network(
    'https://via.placeholder.com/150',
    width: 100,
    height: 100,
    fit: BoxFit.cover,
  ),
)''',
  ),

  const UIChallengeData(
    id: 13,
    title: '아이콘 버튼 만들기',
    description: 'IconButton을 사용하여 아이콘 버튼을 만드세요',
    difficulty: 'easy',
    hint: 'IconButton 위젯에 icon 속성을 추가하세요',
    expectedResult: '클릭 가능한 아이콘 버튼',
    sampleCode: '''IconButton(
  icon: Icon(Icons.favorite, color: Colors.red),
  onPressed: () {
    print('좋아요!');
  },
)''',
  ),

  const UIChallengeData(
    id: 14,
    title: '텍스트 필드 기본',
    description: '기본 TextField를 만드세요',
    difficulty: 'easy',
    hint: 'TextField 위젯을 사용하고, decoration으로 힌트를 추가하세요',
    expectedResult: '입력 가능한 텍스트 필드',
    sampleCode: '''TextField(
  decoration: InputDecoration(
    hintText: '이름을 입력하세요',
    border: OutlineInputBorder(),
  ),
)''',
  ),

  const UIChallengeData(
    id: 15,
    title: 'Spacer로 공간 나누기',
    description: 'Row에서 Spacer를 사용하여 위젯을 양 끝에 배치하세요',
    difficulty: 'easy',
    hint: 'Row의 children에 위젯, Spacer(), 위젯 순서로 추가하세요',
    expectedResult: '왼쪽과 오른쪽 끝에 위젯이 배치됨',
    sampleCode: '''Row(
  children: [
    Text('왼쪽'),
    Spacer(),
    Text('오른쪽'),
  ],
)''',
  ),

  const UIChallengeData(
    id: 16,
    title: '그림자 효과',
    description: 'Container에 그림자를 추가하세요',
    difficulty: 'easy',
    hint: 'BoxDecoration의 boxShadow 속성을 사용하세요',
    expectedResult: '그림자가 있는 컨테이너',
    sampleCode: '''Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Text('그림자 효과'),
)''',
  ),

  const UIChallengeData(
    id: 17,
    title: '배지 만들기',
    description: '작은 원형 배지를 만드세요',
    difficulty: 'easy',
    hint: 'Container를 원형으로 만들고 숫자를 중앙에 배치하세요',
    expectedResult: '빨간 원형 배지에 숫자가 표시됨',
    sampleCode: '''Container(
  width: 24,
  height: 24,
  decoration: BoxDecoration(
    color: Colors.red,
    shape: BoxShape.circle,
  ),
  child: Center(
    child: Text('5', style: TextStyle(color: Colors.white, fontSize: 12)),
  ),
)''',
  ),

  const UIChallengeData(
    id: 18,
    title: 'Divider 사용하기',
    description: 'Column에서 Divider로 구분선을 추가하세요',
    difficulty: 'easy',
    hint: 'Column의 children에 Text, Divider, Text 순서로 추가하세요',
    expectedResult: '텍스트 사이에 구분선이 표시됨',
    sampleCode: '''Column(
  children: [
    Text('첫 번째 항목'),
    Divider(),
    Text('두 번째 항목'),
  ],
)''',
  ),

  const UIChallengeData(
    id: 19,
    title: 'Chip 만들기',
    description: 'Chip 위젯을 사용하여 태그를 만드세요',
    difficulty: 'easy',
    hint: 'Chip 위젯에 label을 추가하세요',
    expectedResult: '라벨이 있는 칩',
    sampleCode: '''Chip(
  label: Text('Flutter'),
  avatar: Icon(Icons.flutter_dash, size: 20),
  backgroundColor: Colors.blue[100],
)''',
  ),

  const UIChallengeData(
    id: 20,
    title: 'Expanded로 공간 채우기',
    description: 'Row에서 Expanded를 사용하여 남은 공간을 채우세요',
    difficulty: 'easy',
    hint: 'Row의 children에 Text, Expanded(child: Container(...))를 추가하세요',
    expectedResult: '텍스트 옆에 남은 공간을 채우는 컨테이너',
    sampleCode: '''Row(
  children: [
    Text('Label:'),
    SizedBox(width: 8),
    Expanded(
      child: Container(
        color: Colors.blue[100],
        height: 40,
      ),
    ),
  ],
)''',
  ),

  // ========== MEDIUM (21-35) ==========
  const UIChallengeData(
    id: 21,
    title: '로그인 폼 만들기',
    description: 'TextField 2개(이메일, 비밀번호)와 로그인 버튼을 세로로 배치하세요',
    difficulty: 'medium',
    hint: 'Column을 사용하고, TextField에 InputDecoration으로 라벨을 추가하세요',
    expectedResult: '이메일 입력, 비밀번호 입력(가려짐), 로그인 버튼이 세로로 배치',
    sampleCode: '''Column(
  children: [
    TextField(
      decoration: InputDecoration(
        labelText: '이메일',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),
    ),
    SizedBox(height: 16),
    TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: '비밀번호',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(),
      ),
    ),
    SizedBox(height: 24),
    ElevatedButton(
      onPressed: () {},
      child: Text('로그인'),
    ),
  ],
)''',
  ),

  const UIChallengeData(
    id: 22,
    title: '이미지 카드 만들기',
    description: 'Card에 이미지와 텍스트를 세로로 배치하세요',
    difficulty: 'medium',
    hint: 'Column을 사용하고, Image.network와 Text를 배치하세요',
    expectedResult: '상단에 이미지, 하단에 제목과 설명이 있는 카드',
    sampleCode: '''Card(
  clipBehavior: Clip.antiAlias,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.network(
        'https://via.placeholder.com/300x200',
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
      ),
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('제목', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('설명 텍스트'),
          ],
        ),
      ),
    ],
  ),
)''',
  ),

  const UIChallengeData(
    id: 23,
    title: '설정 스위치 만들기',
    description: 'SwitchListTile을 사용하여 설정 토글을 만드세요',
    difficulty: 'medium',
    hint: 'SwitchListTile의 title, subtitle, value, onChanged를 사용하세요',
    expectedResult: '제목, 설명, 오른쪽에 토글 스위치가 있는 설정 항목',
    sampleCode: '''bool _notifications = true;

SwitchListTile(
  title: Text('알림 설정'),
  subtitle: Text('푸시 알림 받기'),
  value: _notifications,
  onChanged: (bool value) {
    setState(() {
      _notifications = value;
    });
  },
  secondary: Icon(Icons.notifications),
)''',
  ),

  const UIChallengeData(
    id: 24,
    title: '프로그레스 바',
    description: 'LinearProgressIndicator를 사용하여 진행률 표시하기',
    difficulty: 'medium',
    hint: 'Column에 Text와 LinearProgressIndicator를 배치하세요',
    expectedResult: '진행률과 함께 프로그레스 바 표시',
    sampleCode: '''Column(
  children: [
    Text('진행률: 75%'),
    SizedBox(height: 8),
    LinearProgressIndicator(value: 0.75),
  ],
)''',
  ),

  const UIChallengeData(
    id: 25,
    title: '등급 별점 표시',
    description: 'Row에 별 아이콘 5개를 배치하여 평점을 표시하세요',
    difficulty: 'medium',
    hint: 'List.generate를 사용하여 Icon을 생성하세요',
    expectedResult: '5개의 별 아이콘 (일부는 채워진 별, 일부는 빈 별)',
    sampleCode: '''Row(
  children: List.generate(5, (index) {
    return Icon(
      index < 3 ? Icons.star : Icons.star_border,
      color: Colors.amber,
    );
  }),
)''',
  ),

  const UIChallengeData(
    id: 26,
    title: '뱃지가 있는 아이콘',
    description: 'Stack을 사용하여 아이콘 위에 알림 뱃지를 표시하세요',
    difficulty: 'medium',
    hint: 'Stack에 Icon과 Positioned를 사용하세요',
    expectedResult: '아이콘 오른쪽 상단에 빨간 점 표시',
    sampleCode: '''Stack(
  children: [
    Icon(Icons.notifications, size: 40),
    Positioned(
      right: 0,
      top: 0,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    ),
  ],
)''',
  ),

  const UIChallengeData(
    id: 27,
    title: '검색 바 만들기',
    description: 'TextField를 사용하여 검색 바를 만드세요',
    difficulty: 'medium',
    hint: 'InputDecoration에 prefixIcon과 suffixIcon을 추가하세요',
    expectedResult: '앞에 검색 아이콘, 뒤에 지우기 아이콘이 있는 검색 필드',
    sampleCode: '''TextField(
  decoration: InputDecoration(
    hintText: '검색...',
    prefixIcon: Icon(Icons.search),
    suffixIcon: Icon(Icons.clear),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  ),
)''',
  ),

  const UIChallengeData(
    id: 28,
    title: '드롭다운 메뉴',
    description: 'DropdownButton을 사용하여 선택 메뉴를 만드세요',
    difficulty: 'medium',
    hint: 'DropdownButton의 items에 DropdownMenuItem 리스트를 추가하세요',
    expectedResult: '드롭다운으로 항목을 선택할 수 있는 메뉴',
    sampleCode: '''String _selectedItem = 'Apple';

DropdownButton<String>(
  value: _selectedItem,
  items: ['Apple', 'Banana', 'Orange'].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  onChanged: (String? newValue) {
    setState(() {
      _selectedItem = newValue!;
    });
  },
)''',
  ),

  const UIChallengeData(
    id: 29,
    title: '탭 바 만들기',
    description: 'TabBar를 사용하여 탭 3개를 만드세요',
    difficulty: 'medium',
    hint: 'DefaultTabController, TabBar, TabBarView를 사용하세요',
    expectedResult: '탭을 선택하면 내용이 바뀌는 탭 바',
    sampleCode: '''DefaultTabController(
  length: 3,
  child: Column(
    children: [
      TabBar(
        tabs: [
          Tab(text: '홈'),
          Tab(text: '검색'),
          Tab(text: '설정'),
        ],
      ),
      Expanded(
        child: TabBarView(
          children: [
            Center(child: Text('홈 화면')),
            Center(child: Text('검색 화면')),
            Center(child: Text('설정 화면')),
          ],
        ),
      ),
    ],
  ),
)''',
  ),

  const UIChallengeData(
    id: 30,
    title: '알림 카드',
    description: '아이콘, 제목, 내용, 시간이 있는 알림 카드를 만드세요',
    difficulty: 'medium',
    hint: 'ListTile을 사용하고 leading, title, subtitle, trailing을 활용하세요',
    expectedResult: '알림 아이콘, 제목, 내용, 시간이 표시되는 카드',
    sampleCode: '''Card(
  child: ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.blue,
      child: Icon(Icons.notifications, color: Colors.white),
    ),
    title: Text('새 메시지'),
    subtitle: Text('안녕하세요! 확인해주세요.'),
    trailing: Text('10:30', style: TextStyle(color: Colors.grey)),
  ),
)''',
  ),

  const UIChallengeData(
    id: 31,
    title: '태그 목록',
    description: 'Wrap을 사용하여 여러 태그를 배치하세요',
    difficulty: 'medium',
    hint: 'Wrap 위젯의 children에 Chip을 여러 개 추가하세요',
    expectedResult: '자동으로 줄바꿈되는 태그 목록',
    sampleCode: '''Wrap(
  spacing: 8,
  runSpacing: 8,
  children: [
    Chip(label: Text('Flutter')),
    Chip(label: Text('Dart')),
    Chip(label: Text('Mobile')),
    Chip(label: Text('Development')),
    Chip(label: Text('UI/UX')),
  ],
)''',
  ),

  const UIChallengeData(
    id: 32,
    title: '슬라이더 만들기',
    description: 'Slider를 사용하여 값을 조절할 수 있는 슬라이더를 만드세요',
    difficulty: 'medium',
    hint: 'Slider 위젯에 value, onChanged를 설정하세요',
    expectedResult: '슬라이더로 값을 조절할 수 있음',
    sampleCode: '''double _value = 50;

Column(
  children: [
    Text('값: \${_value.round()}'),
    Slider(
      value: _value,
      min: 0,
      max: 100,
      divisions: 10,
      label: _value.round().toString(),
      onChanged: (double value) {
        setState(() {
          _value = value;
        });
      },
    ),
  ],
)''',
  ),

  const UIChallengeData(
    id: 33,
    title: '날짜 선택 버튼',
    description: 'TextButton을 눌러 DatePicker를 표시하세요',
    difficulty: 'medium',
    hint: 'showDatePicker를 사용하세요',
    expectedResult: '버튼을 누르면 날짜 선택 다이얼로그가 나타남',
    sampleCode: '''DateTime? _selectedDate;

TextButton(
  onPressed: () async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    setState(() {
      _selectedDate = date;
    });
  },
  child: Text(_selectedDate == null ? '날짜 선택' : '\${_selectedDate!.year}-\${_selectedDate!.month}-\${_selectedDate!.day}'),
)''',
  ),

  const UIChallengeData(
    id: 34,
    title: '스낵바 표시',
    description: 'SnackBar를 표시하는 버튼을 만드세요',
    difficulty: 'medium',
    hint: 'ScaffoldMessenger.of(context).showSnackBar를 사용하세요',
    expectedResult: '버튼을 누르면 하단에 메시지가 표시됨',
    sampleCode: '''ElevatedButton(
  onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('메시지가 전송되었습니다!'),
        action: SnackBarAction(
          label: '취소',
          onPressed: () {},
        ),
      ),
    );
  },
  child: Text('스낵바 표시'),
)''',
  ),

  const UIChallengeData(
    id: 35,
    title: '라디오 버튼 그룹',
    description: 'RadioListTile을 사용하여 라디오 버튼 그룹을 만드세요',
    difficulty: 'medium',
    hint: 'RadioListTile을 여러 개 만들고 같은 groupValue를 사용하세요',
    expectedResult: '하나만 선택 가능한 라디오 버튼 목록',
    sampleCode: '''int _selectedValue = 1;

Column(
  children: [
    RadioListTile<int>(
      title: Text('옵션 1'),
      value: 1,
      groupValue: _selectedValue,
      onChanged: (value) => setState(() => _selectedValue = value!),
    ),
    RadioListTile<int>(
      title: Text('옵션 2'),
      value: 2,
      groupValue: _selectedValue,
      onChanged: (value) => setState(() => _selectedValue = value!),
    ),
  ],
)''',
  ),

  // ========== HARD (36-50) ==========
  const UIChallengeData(
    id: 36,
    title: '2x2 그리드 뷰',
    description: 'GridView를 사용하여 4개의 카드를 2x2로 배치하세요',
    difficulty: 'hard',
    hint: 'GridView.count의 crossAxisCount: 2를 사용하세요',
    expectedResult: '2열로 배치된 4개의 카드',
    sampleCode: '''GridView.count(
  crossAxisCount: 2,
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
  padding: EdgeInsets.all(8),
  children: List.generate(4, (index) {
    return Card(
      child: Center(
        child: Text('카드 \${index + 1}', style: TextStyle(fontSize: 20)),
      ),
    );
  }),
)''',
  ),

  const UIChallengeData(
    id: 37,
    title: 'BottomNavigationBar 만들기',
    description: 'Scaffold의 bottomNavigationBar에 3개의 탭을 만드세요',
    difficulty: 'hard',
    hint: 'BottomNavigationBar의 items에 BottomNavigationBarItem을 추가하세요',
    expectedResult: '하단에 홈, 검색, 프로필 아이콘이 있는 네비게이션 바',
    sampleCode: '''int _selectedIndex = 0;

Scaffold(
  body: Center(child: Text('페이지 \$_selectedIndex')),
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: _selectedIndex,
    onTap: (index) => setState(() => _selectedIndex = index),
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
    ],
  ),
)''',
  ),

  const UIChallengeData(
    id: 38,
    title: 'AppBar with Actions',
    description: 'AppBar에 제목과 오른쪽에 아이콘 버튼 2개를 추가하세요',
    difficulty: 'hard',
    hint: 'AppBar의 actions 속성에 IconButton 리스트를 추가하세요',
    expectedResult: '제목과 오른쪽에 검색, 설정 아이콘이 있는 AppBar',
    sampleCode: '''AppBar(
  title: Text('내 앱'),
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
    IconButton(icon: Icon(Icons.settings), onPressed: () {}),
  ],
)''',
  ),

  const UIChallengeData(
    id: 39,
    title: 'Drawer 메뉴',
    description: 'Scaffold에 Drawer를 추가하여 사이드 메뉴를 만드세요',
    difficulty: 'hard',
    hint: 'Drawer 위젯에 ListView와 ListTile을 사용하세요',
    expectedResult: '왼쪽에서 나오는 사이드 메뉴',
    sampleCode: '''Scaffold(
  appBar: AppBar(title: Text('앱')),
  drawer: Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Text('메뉴', style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('홈'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('설정'),
          onTap: () {},
        ),
      ],
    ),
  ),
)''',
  ),

  const UIChallengeData(
    id: 40,
    title: 'PageView 슬라이더',
    description: 'PageView를 사용하여 좌우로 스와이프 가능한 페이지를 만드세요',
    difficulty: 'hard',
    hint: 'PageView의 children에 여러 페이지를 추가하세요',
    expectedResult: '좌우로 스와이프하여 페이지 전환 가능',
    sampleCode: '''PageView(
  children: [
    Container(
      color: Colors.red[100],
      child: Center(child: Text('페이지 1', style: TextStyle(fontSize: 32))),
    ),
    Container(
      color: Colors.blue[100],
      child: Center(child: Text('페이지 2', style: TextStyle(fontSize: 32))),
    ),
    Container(
      color: Colors.green[100],
      child: Center(child: Text('페이지 3', style: TextStyle(fontSize: 32))),
    ),
  ],
)''',
  ),

  const UIChallengeData(
    id: 41,
    title: 'ExpansionTile 확장 패널',
    description: 'ExpansionTile을 사용하여 확장 가능한 리스트를 만드세요',
    difficulty: 'hard',
    hint: 'ExpansionTile의 title과 children을 설정하세요',
    expectedResult: '클릭하면 확장되는 리스트 항목',
    sampleCode: '''ExpansionTile(
  title: Text('더 보기'),
  children: [
    ListTile(title: Text('항목 1')),
    ListTile(title: Text('항목 2')),
    ListTile(title: Text('항목 3')),
  ],
)''',
  ),

  const UIChallengeData(
    id: 42,
    title: 'AnimatedContainer',
    description: 'AnimatedContainer를 사용하여 애니메이션 효과를 만드세요',
    difficulty: 'hard',
    hint: 'AnimatedContainer의 속성을 변경하면 자동으로 애니메이션됩니다',
    expectedResult: '버튼을 누르면 크기와 색상이 변하는 컨테이너',
    sampleCode: '''bool _expanded = false;

Column(
  children: [
    AnimatedContainer(
      duration: Duration(seconds: 1),
      width: _expanded ? 200 : 100,
      height: _expanded ? 200 : 100,
      color: _expanded ? Colors.blue : Colors.red,
      curve: Curves.easeInOut,
      child: Center(child: Text('Tap me')),
    ),
    ElevatedButton(
      onPressed: () => setState(() => _expanded = !_expanded),
      child: Text('애니메이션'),
    ),
  ],
)''',
  ),

  const UIChallengeData(
    id: 43,
    title: 'Dismissible 스와이프 삭제',
    description: 'Dismissible을 사용하여 스와이프로 항목을 삭제하세요',
    difficulty: 'hard',
    hint: 'Dismissible로 ListTile을 감싸고 key와 onDismissed를 설정하세요',
    expectedResult: '좌우로 스와이프하여 항목 삭제 가능',
    sampleCode: '''List<String> _items = ['항목 1', '항목 2', '항목 3'];

ListView.builder(
  itemCount: _items.length,
  itemBuilder: (context, index) {
    return Dismissible(
      key: Key(_items[index]),
      onDismissed: (direction) {
        setState(() {
          _items.removeAt(index);
        });
      },
      background: Container(color: Colors.red),
      child: ListTile(title: Text(_items[index])),
    );
  },
)''',
  ),

  const UIChallengeData(
    id: 44,
    title: 'Hero 애니메이션',
    description: 'Hero 위젯을 사용하여 화면 전환 애니메이션을 만드세요',
    difficulty: 'hard',
    hint: '두 화면에 같은 tag를 가진 Hero 위젯을 배치하세요',
    expectedResult: '화면 전환 시 이미지가 부드럽게 이동',
    sampleCode: '''// 첫 화면
GestureDetector(
  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage())),
  child: Hero(
    tag: 'imageHero',
    child: Image.network('https://via.placeholder.com/150'),
  ),
)

// 두 번째 화면
Hero(
  tag: 'imageHero',
  child: Image.network('https://via.placeholder.com/400'),
)''',
  ),

  const UIChallengeData(
    id: 45,
    title: 'ReorderableListView',
    description: 'ReorderableListView를 사용하여 드래그로 순서를 변경하세요',
    difficulty: 'hard',
    hint: 'ReorderableListView의 onReorder를 구현하세요',
    expectedResult: '항목을 드래그하여 순서 변경 가능',
    sampleCode: '''List<String> _items = ['A', 'B', 'C', 'D'];

ReorderableListView(
  onReorder: (oldIndex, newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  },
  children: _items.map((item) => ListTile(
    key: Key(item),
    title: Text(item),
    trailing: Icon(Icons.drag_handle),
  )).toList(),
)''',
  ),

  const UIChallengeData(
    id: 46,
    title: '커스텀 스크롤 뷰',
    description: 'CustomScrollView와 Sliver를 사용하여 복잡한 스크롤 효과를 만드세요',
    difficulty: 'hard',
    hint: 'SliverAppBar, SliverList, SliverGrid를 사용하세요',
    expectedResult: '스크롤 시 접히는 AppBar와 리스트',
    sampleCode: '''CustomScrollView(
  slivers: [
    SliverAppBar(
      expandedHeight: 200,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Sliver AppBar'),
        background: Container(color: Colors.blue),
      ),
    ),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('항목 \$index')),
        childCount: 20,
      ),
    ),
  ],
)''',
  ),

  const UIChallengeData(
    id: 47,
    title: 'Form 유효성 검사',
    description: 'Form과 TextFormField를 사용하여 입력 유효성을 검사하세요',
    difficulty: 'hard',
    hint: 'GlobalKey<FormState>를 사용하고 validator를 추가하세요',
    expectedResult: '빈 값 또는 잘못된 입력 시 오류 메시지 표시',
    sampleCode: '''final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(labelText: '이메일'),
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
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('검증 성공!')),
            );
          }
        },
        child: Text('제출'),
      ),
    ],
  ),
)''',
  ),

  const UIChallengeData(
    id: 48,
    title: 'NestedScrollView',
    description: 'NestedScrollView를 사용하여 중첩 스크롤을 구현하세요',
    difficulty: 'hard',
    hint: 'headerSliverBuilder와 body를 설정하세요',
    expectedResult: '헤더와 바디가 함께 스크롤되는 레이아웃',
    sampleCode: '''NestedScrollView(
  headerSliverBuilder: (context, innerBoxIsScrolled) {
    return [
      SliverAppBar(
        title: Text('중첩 스크롤'),
        floating: true,
        snap: true,
      ),
    ];
  },
  body: ListView.builder(
    itemCount: 50,
    itemBuilder: (context, index) {
      return ListTile(title: Text('항목 \$index'));
    },
  ),
)''',
  ),

  const UIChallengeData(
    id: 49,
    title: 'BottomSheet 만들기',
    description: 'showModalBottomSheet를 사용하여 하단 시트를 만드세요',
    difficulty: 'hard',
    hint: 'showModalBottomSheet 함수를 호출하고 builder를 구현하세요',
    expectedResult: '버튼을 누르면 하단에서 올라오는 시트',
    sampleCode: '''ElevatedButton(
  onPressed: () {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.share),
                title: Text('공유'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('링크 복사'),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  },
  child: Text('Bottom Sheet'),
)''',
  ),

  const UIChallengeData(
    id: 50,
    title: 'TabBar with TabBarView',
    description: 'TabController를 사용하여 탭 3개와 각 탭의 내용을 만드세요',
    difficulty: 'hard',
    hint: 'DefaultTabController로 감싸고, TabBar와 TabBarView를 사용하세요',
    expectedResult: '상단에 탭 3개, 각 탭 클릭 시 다른 내용 표시',
    sampleCode: '''DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      title: Text('탭 예제'),
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.home), text: '홈'),
          Tab(icon: Icon(Icons.star), text: '즐겨찾기'),
          Tab(icon: Icon(Icons.settings), text: '설정'),
        ],
      ),
    ),
    body: TabBarView(
      children: [
        Center(child: Text('홈 화면')),
        Center(child: Text('즐겨찾기 화면')),
        Center(child: Text('설정 화면')),
      ],
    ),
  ),
)''',
  ),
];
