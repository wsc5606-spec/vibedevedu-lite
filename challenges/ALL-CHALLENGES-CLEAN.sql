-- ============================================================================
-- 전체 언어 챌린지 통합 파일
-- ============================================================================
-- 13개 언어 × 40문제 = 총 520개 챌린지
-- 생성일: 2025-11-10
-- ============================================================================
-- 언어 목록:
-- 1. HTML (40 challenges)
-- 2. CSS (40 challenges)
-- 3. JavaScript (40 challenges)
-- 4. TypeScript (40 challenges)
-- 5. Python (40 challenges)
-- 6. Dart (40 challenges)
-- 7. Kotlin (40 challenges)
-- 8. C# (40 challenges)
-- 9. Java (40 challenges)
-- 10. Go (40 challenges)
-- 11. C (40 challenges)
-- 12. C++ (40 challenges)
-- 13. SQL (40 challenges)
-- ============================================================================

-- 기존 챌린지 삭제 (선택사항 - 필요시 주석 해제)
-- DELETE FROM challenges;

-- ============================================================================
-- HTML Language Challenges (Merged)
-- ============================================================================
-- Total: 40 challenges
-- Distribution: 4 challenges per unit (10 units)
-- ============================================================================


-- ============================================================================
-- Unit 1 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-basic-structure$$, $$html$$, $$syntax$$, 1, $$기본 HTML 문서$$, $$첫 HTML 문서 작성$$, $$challenge$$, 1,
$$가장 기본적인 HTML 문서 구조를 작성하세요.$$,
$$- <!DOCTYPE html> 선언\n- html, head, body 태그 사용$$,
$$[{"input": "", "output": "기본 HTML 구조"}]$$,
$$<!-- HTML 기본 구조를 작성하세요 -->\n$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My First Page</title>\n</head>\n<body>\n    <h1>Hello, World!</h1>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "valid html structure"}]$$,
$$["DOCTYPE는 HTML5를 의미합니다", "html 태그가 모든 것을 감싸야 합니다"]$$,
$$["basics", "structure"]$$, 5),

($$html-title-tag$$, $$html$$, $$syntax$$, 2, $$페이지 제목$$, $$title 태그 사용$$, $$challenge$$, 1,
$$페이지 제목을 "My Website"로 설정하세요.$$,
$$- <title> 태그는 head 안에\n- 브라우저 탭에 표시되는 제목$$,
$$[{"input": "", "output": "페이지 제목 설정"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <!-- 여기에 title 태그를 추가하세요 -->\n</head>\n<body>\n</body>\n</html>$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Website</title>\n</head>\n<body>\n</body>\n</html>$$,
$$[{"input": "", "expected": "title is My Website"}]$$,
$$["title 태그는 head 섹션에 위치합니다"]$$,
$$["basics", "title"]$$, 5),

($$html-meta-charset$$, $$html$$, $$syntax$$, 3, $$문자 인코딩$$, $$meta charset 설정$$, $$challenge$$, 1,
$$UTF-8 문자 인코딩을 설정하세요.$$,
$$- <meta charset="UTF-8">\n- head 태그 안에 위치$$,
$$[{"input": "", "output": "UTF-8 인코딩 설정"}]$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <!-- 여기에 meta charset을 추가하세요 -->\n</head>\n<body>\n</body>\n</html>$func$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <meta charset="UTF-8">\n</head>\n<body>\n</body>\n</html>$$,
$$[{"input": "", "expected": "charset utf-8"}]$$,
$$["meta 태그는 self-closing입니다"]$$,
$$["basics", "meta"]$$, 5),

($$html-viewport$$, $$html$$, $$syntax$$, 4, $$뷰포트 설정$$, $$반응형 메타 태그$$, $$challenge$$, 1,
$$반응형 웹을 위한 viewport 메타 태그를 추가하세요.$$,
$$- name="viewport"\n- content="width=device-width, initial-scale=1.0"$$,
$$[{"input": "", "output": "viewport 설정"}]$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <meta charset="UTF-8">\n    <!-- viewport meta 태그를 추가하세요 -->\n</head>\n<body>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <meta charset="UTF-8">\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\n</head>\n<body>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "responsive viewport"}]$$,
$$["viewport는 모바일 반응형에 필수입니다"]$$,
$$["basics", "viewport", "responsive"]$$, 5),

($$html-comment$$, $$html$$, $$syntax$$, 5, $$HTML 주석$$, $$주석 작성$$, $$challenge$$, 1,
$$"This is a comment"라는 주석을 추가하세요.$$,
$$- <!-- 주석 내용 -->\n- 브라우저에 표시되지 않음$$,
$$[{"input": "", "output": "주석 추가"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- 여기에 주석을 작성하세요 -->\n</body>\n</html>$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- This is a comment -->\n</body>\n</html>$$,
$$[{"input": "", "expected": "comment exists"}]$$,
$$["주석은 <!-- 로 시작하고 -->로 끝납니다"]$$,
$$["basics", "comment"]$$, 3);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-video$$, $$html$$, $$syntax$$, 51, $$video 태그$$, $$비디오 삽입$$, $$challenge$$, 2,
$$controls와 여러 소스를 가진 비디오를 삽입하세요.$$,
$$- <video> 태그\n- controls, width, height\n- 여러 source 태그$$,
$$[{"input": "", "output": "비디오 플레이어"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- video 태그를 추가하세요 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <video width="640" height="360" controls>\n        <source src="video.mp4" type="video/mp4">\n        <source src="video.webm" type="video/webm">\n        Your browser does not support the video tag.\n    </video>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "video with controls"}]$$,
$$["여러 포맷을 제공하면 브라우저가 지원하는 것을 선택합니다"]$$,
$$["multimedia", "video"]$$, 10),

($$html-audio$$, $$html$$, $$syntax$$, 52, $$audio 태그$$, $$오디오 삽입$$, $$challenge$$, 2,
$$autoplay와 loop가 있는 오디오를 삽입하세요.$$,
$$- <audio> 태그\n- controls, autoplay, loop$$,
$$[{"input": "", "output": "오디오 플레이어"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- audio 태그 추가 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <audio controls autoplay loop>\n        <source src="audio.mp3" type="audio/mpeg">\n        <source src="audio.ogg" type="audio/ogg">\n        Your browser does not support the audio element.\n    </audio>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "audio with autoplay"}]$$,
$$["autoplay는 사용자 경험상 신중히 사용해야 합니다"]$$,
$$["multimedia", "audio"]$$, 10),

($$html-iframe$$, $$html$$, $$syntax$$, 53, $$iframe$$, $$외부 콘텐츠 임베드$$, $$challenge$$, 2,
$$YouTube 비디오를 iframe으로 삽입하세요.$$,
$$- <iframe> 태그\n- src, width, height\n- frameborder, allowfullscreen$$,
$$[{"input": "", "output": "임베디드 비디오"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- YouTube iframe 추가 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <iframe width="560" height="315"\n        src="https://www.youtube.com/embed/VIDEO_ID"\n        frameborder="0"\n        allowfullscreen>\n    </iframe>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "youtube iframe"}]$$,
$$["iframe은 다른 HTML 페이지은 삽입할 수 있습니다"]$$,
$$["multimedia", "iframe"]$$, 12),

($$html-figure-figcaption$$, $$html$$, $$syntax$$, 54, $$figure와 figcaption$$, $$이미지 캡션$$, $$challenge$$, 2,
$$이미지에 캡션을 추가하세요.$$,
$$- <figure> 태그\n- <figcaption> 설명$$,
$$[{"input": "", "output": "캡션 있는 이미지"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <img src="photo.jpg" alt="Photo">\n    <p>Photo description</p>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <figure>\n        <img src="photo.jpg" alt="Photo">\n        <figcaption>Photo description</figcaption>\n    </figure>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "figure with figcaption"}]$$,
$$["figure는 이미지, 다이어그램, 코드 등을 감쌉니다"]$$,
$$["multimedia", "figure"]$$, 10),

($$html-picture$$, $$html$$, $$syntax$$, 55, $$picture 태그$$, $$반응형 이미지$$, $$challenge$$, 2,
$$화면 크기에 따라 다른 이미지를 보여주세요.$$,
$$- <picture> 태그\n- <source> media 쿼리\n- <img> 폴백$$,
$$[{"input": "", "output": "반응형 이미지"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- picture 태그로 반응형 이미지 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <picture>\n        <source media="(min-width: 800px)" srcset="large.jpg">\n        <source media="(min-width: 400px)" srcset="medium.jpg">\n        <img src="small.jpg" alt="Responsive image">\n    </picture>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "responsive picture"}]$$,
$$["picture는 아트 디렉션과 해상도 전환에 사용됩니다"]$$,
$$["multimedia", "picture", "responsive"]$$, 15);




-- ============================================================================
-- Unit 2 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-heading-h1$$, $$html$$, $$syntax$$, 6, $$제목 태그$$, $$h1 태그 사용$$, $$challenge$$, 1,
$$"Welcome"이라는 h1 제목을 만드세요.$$,
$$- <h1> 태그 사용\n- 가장 중요한 제목$$,
$$[{"input": "", "output": "h1 제목"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- h1 태그로 Welcome을 작성하세요 -->\n</body>\n</html>$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <h1>Welcome</h1>\n</body>\n</html>$$,
$$[{"input": "", "expected": "h1 with Welcome"}]$$,
$$["h1은 한 페이지에 하나만 사용하는 것이 좋습니다"]$$,
$$["text", "heading"]$$, 5),

($$html-multiple-headings$$, $$html$$, $$syntax$$, 7, $$여러 제목 레레벨$$, $$h1~h6 계층$$, $$challenge$$, 1,
$$h1부터 h3까지 제목을 만드세요.$$,
$$- h1: "Main Title"\n- h2: "Subtitle"\n- h3: "Section"$$,
$$[{"input": "", "output": "제목 계층 구조"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- h1, h2, h3은 순서대로 작성하세요 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <h1>Main Title</h1>\n    <h2>Subtitle</h2>\n    <h3>Section</h3>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "h1 h2 h3 hierarchy"}]$$,
$$["제목은 h1부터 h6까지 있으며, 숫자가 클수록 작습니다"]$$,
$$["text", "heading"]$$, 5),

($$html-paragraph$$, $$html$$, $$syntax$$, 8, $$문단 태그$$, $$p 태그 사용$$, $$challenge$$, 1,
$$"This is a paragraph."라는 문단을 만드세요.$$,
$$- <p> 태그 사용\n- 텍스트 블록 표현$$,
$$[{"input": "", "output": "p 태그로 문단"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- p 태그로 문단을 작성하세요 -->\n</body>\n</html>$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <p>This is a paragraph.</p>\n</body>\n</html>$$,
$$[{"input": "", "expected": "paragraph element"}]$$,
$$["p 태그는 자동으로 위아래 여백을 만듭니다"]$$,
$$["text", "paragraph"]$$, 5),

($$html-line-break$$, $$html$$, $$syntax$$, 9, $$줄바꿈$$, $$br 태그$$, $$challenge$$, 1,
$$트 줄의 텍스트를 br 태그로 구분하세요.$$,
$$- <br> 태그 사용\n- self-closing 태그$$,
$$[{"input": "", "output": "줄바꿈"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <p>\n        First line\n        <!-- br 태그를 추가하세요 -->\n        Second line\n    </p>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <p>\n        First line<br>\n        Second line\n    </p>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "line break"}]$$,
$$["br 태그는 닫는 태그가 없습니다"]$$,
$$["text", "line-break"]$$, 5),

($$html-horizontal-rule$$, $$html$$, $$syntax$$, 10, $$수평선$$, $$hr 태그$$, $$challenge$$, 1,
$$트 문단 사이에 수평선을 추가하세요.$$,
$$- <hr> 태그 사용\n- 콘텐츠 구분선$$,
$$[{"input": "", "output": "수평선"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <p>Above the line</p>\n    <!-- hr 태그를 추가하세요 -->\n    <p>Below the line</p>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <p>Above the line</p>\n    <hr>\n    <p>Below the line</p>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "horizontal rule"}]$$,
$$["hr은 테마적 구분을 나타냅니다"]$$,
$$["text", "hr"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-input-range$$, $$html$$, $$syntax$$, 56, $$범위 슬라이더$$, $$input type=range$$, $$challenge$$, 2,
$$0-100 범위의 슬라이더를 만드세요.$$,
$$- type="range"\n- min, max, value, step$$,
$$[{"input": "", "output": "슬라이더"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <label>Volume:</label>\n    <!-- range input -->\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <label>Volume:</label>\n    <input type="range" name="volume" min="0" max="100" value="50" step="5">\n</body>\n</html>$func$,
$$[{"input": "", "expected": "range slider"}]$$,
$$["step으로 증가 단위은 조절할 수 있습니다"]$$,
$$["form", "input", "range"]$$, 10),

($$html-input-color$$, $$html$$, $$syntax$$, 57, $$색상 선택$$, $$input type=color$$, $$challenge$$, 2,
$$색상 선택기를 만드세요.$$,
$$- type="color"\n- value는 hex 색상$$,
$$[{"input": "", "output": "색상 선택기"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <label>Pick a color:</label>\n    <!-- color input -->\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <label>Pick a color:</label>\n    <input type="color" name="color" value="#ff0000">\n</body>\n</html>$func$,
$$[{"input": "", "expected": "color picker"}]$$,
$$["color 타삽입은 색상 선택 UI은 제공합니다"]$$,
$$["form", "input", "color"]$$, 10),

($$html-datalist$$, $$html$$, $$syntax$$, 58, $$datalist$$, $$자동완성 목록$$, $$challenge$$, 2,
$$자동완성이 있는 삽입력 필드를 만드세요.$$,
$$- <datalist> 태그\n- input의 list 작성과 연결$$,
$$[{"input": "", "output": "자동완성"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <input type="text" name="browser">\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <input type="text" name="browser" list="browsers">\n    <datalist id="browsers">\n        <option value="Chrome">\n        <option value="Firefox">\n        <option value="Safari">\n        <option value="Edge">\n    </datalist>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "input with datalist"}]$$,
$$["datalist는 추천 옵션을 제공하지만 다른 값도 삽입력 가능합니다"]$$,
$$["form", "datalist"]$$, 12),

($$html-input-file$$, $$html$$, $$syntax$$, 59, $$파일 업로드$$, $$input type=file$$, $$challenge$$, 2,
$$여러 이미지 파일을 업로드할 수 있는 삽입력을 만드세요.$$,
$$- type="file"\n- accept, multiple 작성$$,
$$[{"input": "", "output": "파일 선택"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Upload images:</label>\n        <!-- file input -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Upload images:</label>\n        <input type="file" name="images" accept="image/*" multiple>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "file input with accept"}]$$,
$$["accept로 파일 유형을, multiple로 여러 파일 선택을 허사용합니다"]$$,
$$["form", "input", "file"]$$, 10),

($$html-input-search$$, $$html$$, $$syntax$$, 60, $$검색 삽입력$$, $$input type=search$$, $$challenge$$, 2,
$$검색창을 만드세요.$$,
$$- type="search"\n- placeholder, autocomplete$$,
$$[{"input": "", "output": "검색창"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <!-- search input -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="search" name="q" placeholder="Search..." autocomplete="off">\n        <button type="submit">Search</button>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "search input"}]$$,
$$["search 타삽입은 검색 의도를 명시하고 X 버튼을 제공합니다"]$$,
$$["form", "input", "search"]$$, 10);




-- ============================================================================
-- Unit 3 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-bold$$, $$html$$, $$syntax$$, 11, $$굵은 텍스트$$, $$strong 태그$$, $$challenge$$, 1,
$$"Important"은 굵게 표시하세요.$$,
$$- <strong> 태그 사용\n- 의미적으로 중요한 텍스트$$,
$$[{"input": "", "output": "굵은 텍스트"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <p>This is <strong>important</strong>.</p>\n</body>\n</html>$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <p>This is <strong>Important</strong>.</p>\n</body>\n</html>$$,
$$[{"input": "", "expected": "strong tag"}]$$,
$$["strong은 의미적 중요도은, b는 단순 스타일삽입니다"]$$,
$$["text", "formatting", "strong"]$$, 5),

($$html-italic$$, $$html$$, $$syntax$$, 12, $$이탤릭 텍스트$$, $$em 태그$$, $$challenge$$, 1,
$$"emphasized"은 이탤릭으로 표시하세요.$$,
$$- <em> 태그 사용\n- 강조 의미$$,
$$[{"input": "", "output": "이탤릭 텍스트"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <p>This is <!-- em 태그로 감싸세요 -->emphasized.</p>\n</body>\n</html>$func$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <p>This is <em>emphasized</em>.</p>\n</body>\n</html>$$,
$$[{"input": "", "expected": "em tag"}]$$,
$$["em은 강조은, i는 단순 스타일삽입니다"]$$,
$$["text", "formatting", "em"]$$, 5),

($$html-mark$$, $$html$$, $$syntax$$, 13, $$하이라이트$$, $$mark 태그$$, $$challenge$$, 1,
$$"highlighted"은 하이라이트 표시하세요.$$,
$$- <mark> 태그 사용\n- 배경색이 있는 강조$$,
$$[{"input": "", "output": "하이라이트"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <p>This is <!-- mark 태그 -->highlighted text.</p>\n</body>\n</html>$func$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <p>This is <mark>highlighted</mark> text.</p>\n</body>\n</html>$$,
$$[{"input": "", "expected": "mark tag"}]$$,
$$["mark는 주로 노란 배경색으로 표시됩니다"]$$,
$$["text", "formatting", "mark"]$$, 5),

($$html-small$$, $$html$$, $$syntax$$, 14, $$작은 텍스트$$, $$small 태그$$, $$challenge$$, 1,
$$부가 정보은 small 태그로 표시하세요.$$,
$$- <small> 태그 사용\n- 더 작은 글씨$$,
$$[{"input": "", "output": "작은 텍스트"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <p>Regular text <small>small print</small></p>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <p>Regular text <small>small print</small></p>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "small tag"}]$$,
$$["small은 법적 고지나 저작권 표시에 자주 사용됩니다"]$$,
$$["text", "formatting", "small"]$$, 5),

($$html-del-ins$$, $$html$$, $$syntax$$, 15, $$삭제/삽입$$, $$del과 ins 태그$$, $$challenge$$, 1,
$$삭제된 텍스트와 삽입된 텍스트를 표시하세요.$$,
$$- <del> 삭제선\n- <ins> 밑줄$$,
$$[{"input": "", "output": "del, ins 태그"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <p>Price: <del>$100</del> <ins>$80</ins></p>\n</body>\n</html>$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <p>Price: <del>$100</del> <ins>$80</ins></p>\n</body>\n</html>$$,
$$[{"input": "", "expected": "del and ins tags"}]$$,
$$["del은 삭제선, ins는 밑줄로 표시됩니다"]$$,
$$["text", "formatting", "del", "ins"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-required$$, $$html$$, $$syntax$$, 61, $$필수 삽입력$$, $$required 작성$$, $$challenge$$, 2,
$$필수 삽입력 필드를 만드세요.$$,
$$- required 작성\n- 제출 시 자동 검증$$,
$$[{"input": "", "output": "필수 필드"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="text" name="name">\n        <button type="submit">Submit</button>\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="text" name="name" required>\n        <button type="submit">Submit</button>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "required field"}]$$,
$$["required 필드가 비어있으면 폼 제출이 차단됩니다"]$$,
$$["form", "validation", "required"]$$, 8),

($$html-pattern$$, $$html$$, $$syntax$$, 62, $$정규식 검증$$, $$pattern 작성$$, $$challenge$$, 2,
$$전화번호 형식을 정규식으로 검증하세요.$$,
$$- pattern 작성\n- 정규식 사용$$,
$$[{"input": "", "output": "패턴 검증"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="tel" name="phone">\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="tel" name="phone"\n               pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"\n               placeholder="010-1234-5678"\n               required>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "phone pattern"}]$$,
$$["pattern으로 삽입력 형식을 제한할 수 있습니다"]$$,
$$["form", "validation", "pattern"]$$, 12),

($$html-minlength-maxlength$$, $$html$$, $$syntax$$, 63, $$길이 제한$$, $$minlength, maxlength$$, $$challenge$$, 2,
$$비밀번호 길이은 8-20자로 제한하세요.$$,
$$- minlength, maxlength 작성\n- 문자열 길이 검증$$,
$$[{"input": "", "output": "길이 제한"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="password" name="password">\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="password" name="password"\n               minlength="8" maxlength="20"\n               required>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "length restriction"}]$$,
$$["minlength와 maxlength로 삽입력 길이를 제한합니다"]$$,
$$["form", "validation", "length"]$$, 10),

($$html-min-max$$, $$html$$, $$syntax$$, 64, $$값 범위 제한$$, $$min, max$$, $$challenge$$, 2,
$$날짜은 오늘 이후로만 선택 가능하게 하세요.$$,
$$- min 작성에 오늘 날짜\n- 과거 날짜 선택 불가$$,
$$[{"input": "", "output": "날짜 범위 제한"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="date" name="appointment">\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="date" name="appointment"\n               min="2024-01-01"\n               required>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "date min"}]$$,
$$["min과 max로 날짜/숫자 범위를 제한합니다"]$$,
$$["form", "validation", "min-max"]$$, 10),

($$html-novalidate$$, $$html$$, $$syntax$$, 65, $$유효성 검사 비활성화$$, $$novalidate$$, $$challenge$$, 2,
$$폼의 HTML5 유효성 검사를 비활성화하세요.$$,
$$- novalidate 작성\n- form 태그에 추가$$,
$$[{"input": "", "output": "검증 비활성화"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form action="/submit">\n        <input type="email" required>\n        <button type="submit">Submit</button>\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form action="/submit" novalidate>\n        <input type="email" required>\n        <button type="submit">Submit</button>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "novalidate form"}]$$,
$$["novalidate는 커스텀 검증을 사용할 때 유사용합니다"]$$,
$$["form", "validation", "novalidate"]$$, 8);




-- ============================================================================
-- Unit 4 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-link-basic$$, $$html$$, $$syntax$$, 16, $$기본 링크$$, $$a 태그 사용$$, $$challenge$$, 1,
$$"Visit Google"이라는 텍스트로 구글 링크를 만드세요.$$,
$$- <a> 태그 사용\n- href 작성에 URL$$,
$$[{"input": "", "output": "하이퍼링크"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- 구글 링크를 만드세요 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <a href="https://www.google.com">Visit Google</a>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "link to google"}]$$,
$$["href는 hypertext reference의 약자삽입니다"]$$,
$$["link", "anchor"]$$, 5),

($$html-link-target$$, $$html$$, $$syntax$$, 17, $$새 탭에서 열기$$, $$target 작성$$, $$challenge$$, 1,
$$링크를 새 탭에서 열리도록 설정하세요.$$,
$$- target="_blank"\n- 새 창/탭에서 열림$$,
$$[{"input": "", "output": "새 탭 링크"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <a href="https://example.com">Example</a>\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <a href="https://example.com" target="_blank">Example</a>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "target blank"}]$$,
$$["_blank는 새 브라우징 컨텍스트를 의미합니다"]$$,
$$["link", "target"]$$, 5),

($$html-image-basic$$, $$html$$, $$syntax$$, 18, $$이미지 삽입$$, $$img 태그$$, $$challenge$$, 1,
$$이미지를 삽입하세요.$$,
$$- <img> 태그 사용\n- src와 alt 작성 필수$$,
$$[{"input": "", "output": "이미지"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- 이미지를 삽입하세요 -->\n</body>\n</html>$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <img src="image.jpg" alt="Description">\n</body>\n</html>$$,
$$[{"input": "", "expected": "img tag"}]$$,
$$["alt는 접근성을 위해 필수입니다"]$$,
$$["image", "img"]$$, 5),

($$html-image-size$$, $$html$$, $$syntax$$, 19, $$이미지 크기$$, $$width와 height$$, $$challenge$$, 1,
$$이미지 크기은 300x200으로 설정하세요.$$,
$$- width와 height 작성\n- 픽셀 단위$$,
$$[{"input": "", "output": "크기 지정 이미지"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <img src="photo.jpg" alt="Photo">\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <img src="photo.jpg" alt="Photo" width="300" height="200">\n</body>\n</html>$func$,
$$[{"input": "", "expected": "300x200 image"}]$$,
$$["width와 height로 레이아웃 시프트은 방지할 수 있습니다"]$$,
$$["image", "size"]$$, 5),

($$html-link-image$$, $$html$$, $$syntax$$, 20, $$이미지 링크$$, $$이미지를 클릭 가능하게$$, $$challenge$$, 1,
$$이미지를 클릭하면 링크로 이동하게 만드세요.$$,
$$- a 태그 안에 img 태그\n- 이미지가 링크 역할$$,
$$[{"input": "", "output": "클릭 가능한 이미지"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <img src="logo.png" alt="Logo">\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <a href="https://example.com">\n        <img src="logo.png" alt="Logo">\n    </a>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "clickable image"}]$$,
$$["a 태그로 img은 감싸면 이미지가 링크가 됩니다"]$$,
$$["link", "image"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-meta-description$$, $$html$$, $$syntax$$, 66, $$페이지 설명$$, $$meta description$$, $$challenge$$, 2,
$$검색엔진사용 페이지 설명을 추가하세요.$$,
$$- meta name="description"\n- content 작성$$,
$$[{"input": "", "output": "SEO 설명"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n</head>\n<body></body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n    <meta name="description" content="This page provides information about...">\n</head>\n<body></body>\n</html>$func$,
$$[{"input": "", "expected": "meta description"}]$$,
$$["description은 검색 결과에 표시됩니다"]$$,
$$["meta", "seo"]$$, 8),

($$html-meta-keywords$$, $$html$$, $$syntax$$, 67, $$키워드$$, $$meta keywords$$, $$challenge$$, 2,
$$페이지 키워드를 추가하세요.$$,
$$- meta name="keywords"\n- 쉼표로 구분$$,
$$[{"input": "", "output": "키워드"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n</head>\n<body></body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n    <meta name="keywords" content="html, web, tutorial, programming">\n</head>\n<body></body>\n</html>$func$,
$$[{"input": "", "expected": "meta keywords"}]$$,
$$["keywords는 현대 SEO에서 중요도가 낮아졌습니다"]$$,
$$["meta", "seo"]$$, 8),

($$html-meta-author$$, $$html$$, $$syntax$$, 68, $$저자 정보$$, $$meta author$$, $$challenge$$, 2,
$$페이지 저자 정보를 추가하세요.$$,
$$- meta name="author"\n- 저자 이름$$,
$$[{"input": "", "output": "저자 정보"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n</head>\n<body></body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n    <meta name="author" content="John Doe">\n</head>\n<body></body>\n</html>$func$,
$$[{"input": "", "expected": "meta author"}]$$,
$$["author 메타 태그는 콘텐츠 제작자를 명시합니다"]$$,
$$["meta", "author"]$$, 8),

($$html-og-tags$$, $$html$$, $$syntax$$, 69, $$Open Graph 태그$$, $$SNS 공유 메타데이터$$, $$challenge$$, 2,
$$페이스북/SNS 공유사용 Open Graph 태그를 추가하세요.$$,
$$- og:title, og:description, og:image\n- property 작성 사용$$,
$$[{"input": "", "output": "OG 태그"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n</head>\n<body></body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n    <meta property="og:title" content="My Awesome Page">\n    <meta property="og:description" content="Check out this page!">\n    <meta property="og:image" content="https://example.com/image.jpg">\n    <meta property="og:url" content="https://example.com/page">\n</head>\n<body></body>\n</html>$func$,
$$[{"input": "", "expected": "og tags"}]$$,
$$["Open Graph는 SNS 공유 시 표시되는 정보를 제어합니다"]$$,
$$["meta", "og", "social"]$$, 15),

($$html-twitter-card$$, $$html$$, $$syntax$$, 70, $$Twitter Card$$, $$트위터 카드 메타데이터$$, $$challenge$$, 2,
$$트위터 카드 메타 태그를 추가하세요.$$,
$$- twitter:card, twitter:title, twitter:description\n- name 작성 사용$$,
$$[{"input": "", "output": "트위터 카드"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n</head>\n<body></body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n    <meta name="twitter:card" content="summary_large_image">\n    <meta name="twitter:title" content="My Awesome Page">\n    <meta name="twitter:description" content="Check it out!">\n    <meta name="twitter:image" content="https://example.com/image.jpg">\n</head>\n<body></body>\n</html>$func$,
$$[{"input": "", "expected": "twitter card"}]$$,
$$["Twitter Card는 트윗에서 리치 미디어 표시를 제공합니다"]$$,
$$["meta", "twitter", "social"]$$, 15);




-- ============================================================================
-- Unit 5 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-ul-list$$, $$html$$, $$syntax$$, 21, $$순서 없는 목록$$, $$ul과 li$$, $$challenge$$, 1,
$$3개 항목의 순서 없는 목록을 만드세요.$$,
$$- <ul> 태그 사용\n- <li> 항목들$$,
$$[{"input": "", "output": "불릿 목록"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- ul 목록을 만드세요 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <ul>\n        <li>Item 1</li>\n        <li>Item 2</li>\n        <li>Item 3</li>\n    </ul>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "ul with 3 li"}]$$,
$$["ul은 unordered list의 약자삽입니다"]$$,
$$["list", "ul"]$$, 5),

($$html-ol-list$$, $$html$$, $$syntax$$, 22, $$순서 있는 목록$$, $$ol과 li$$, $$challenge$$, 1,
$$3개 항목의 순서 있는 목록을 만드세요.$$,
$$- <ol> 태그 사용\n- 자동으로 번호 매김$$,
$$[{"input": "", "output": "번호 목록"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- ol 목록을 만드세요 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <ol>\n        <li>First</li>\n        <li>Second</li>\n        <li>Third</li>\n    </ol>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "ol with 3 li"}]$$,
$$["ol은 ordered list의 약자삽입니다"]$$,
$$["list", "ol"]$$, 5),

($$html-nested-list$$, $$html$$, $$syntax$$, 23, $$중첩 목록$$, $$목록 안의 목록$$, $$challenge$$, 1,
$$목록 항목 안에 다른 목록을 넣으세요.$$,
$$- li 안에 ul 또는 ol\n- 계층 구조 표현$$,
$$[{"input": "", "output": "중첩 목록"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <ul>\n        <li>Main item\n            <!-- 여기에 중첩 목록 추가 -->\n        </li>\n    </ul>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <ul>\n        <li>Main item\n            <ul>\n                <li>Sub item 1</li>\n                <li>Sub item 2</li>\n            </ul>\n        </li>\n    </ul>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "nested list"}]$$,
$$["중첩 목록를 li 태그 안에 새로운 ul/ol을 넣습니다"]$$,
$$["list", "nested"]$$, 8),

($$html-dl-list$$, $$html$$, $$syntax$$, 24, $$정의 목록$$, $$dl, dt, dd$$, $$challenge$$, 1,
$$사용어와 설명으로 구성된 정의 목록을 만드세요.$$,
$$- <dl> 정의 목록\n- <dt> 사용어, <dd> 설명$$,
$$[{"input": "", "output": "정의 목록"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- 정의 목록을 만드세요 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <dl>\n        <dt>HTML</dt>\n        <dd>Hypertext Markup Language</dd>\n        <dt>CSS</dt>\n        <dd>Cascading Style Sheets</dd>\n    </dl>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "definition list"}]$$,
$$["dl은 definition list, dt는 term, dd는 description삽입니다"]$$,
$$["list", "dl"]$$, 8),

($$html-ol-start$$, $$html$$, $$syntax$$, 25, $$목록 시작 번호$$, $$start 작성$$, $$challenge$$, 1,
$$5번부터 시작하는 순서 목록을 만드세요.$$,
$$- <ol start="5">\n- 시작 번호 지정$$,
$$[{"input": "", "output": "5번부터 시작"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <ol>\n        <li>Item</li>\n        <li>Item</li>\n    </ol>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <ol start="5">\n        <li>Item</li>\n        <li>Item</li>\n    </ol>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "ol starting at 5"}]$$,
$$["start 작성으로 시작 번호은 변경할 수 있습니다"]$$,
$$["list", "ol", "start"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-aside$$, $$html$$, $$syntax$$, 71, $$aside 태그$$, $$사이드바 콘텐츠$$, $$challenge$$, 2,
$$메인 콘텐츠와 별개의 사이드 콘텐츠를 만드세요.$$,
$$- <aside> 태그\n- 관련 링크, 광고 등$$,
$$[{"input": "", "output": "사이드바"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <main>\n        <h1>Main Content</h1>\n    </main>\n    <!-- aside 추가 -->\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <main>\n        <h1>Main Content</h1>\n    </main>\n    <aside>\n        <h2>Related Links</h2>\n        <ul>\n            <li><a href="#">Link 1</a></li>\n            <li><a href="#">Link 2</a></li>\n        </ul>\n    </aside>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "aside element"}]$$,
$$["aside는 메인 콘텐츠와 간접적으로 관련된 내용삽입니다"]$$,
$$["semantic", "aside"]$$, 10),

($$html-time$$, $$html$$, $$syntax$$, 72, $$time 태그$$, $$날짜/시간 표시$$, $$challenge$$, 2,
$$기계가 읽을 수 있는 시간 정보를 추가하세요.$$,
$$- <time> 태그\n- datetime 작성$$,
$$[{"input": "", "output": "시간 정보"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <p>Published: January 1, 2024</p>\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <p>Published: <time datetime="2024-01-01">January 1, 2024</time></p>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "time with datetime"}]$$,
$$["datetime 작성은 기계가 읽을 수 있는 형식삽입니다"]$$,
$$["semantic", "time"]$$, 10),

($$html-address$$, $$html$$, $$syntax$$, 73, $$address 태그$$, $$연락처 정보$$, $$challenge$$, 2,
$$저자나 조직의 연락처 정보를 추가하세요.$$,
$$- <address> 태그\n- 이메일, 주소 등$$,
$$[{"input": "", "output": "연락처"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <footer>\n        <!-- address 정보 -->\n    </footer>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <footer>\n        <address>\n            Contact: <a href="mailto:info@example.com">info@example.com</a><br>\n            123 Main St, City, Country\n        </address>\n    </footer>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "address element"}]$$,
$$["address는 연락처 정보를 나타냅니다"]$$,
$$["semantic", "address"]$$, 10),

($$html-details-summary$$, $$html$$, $$syntax$$, 74, $$details와 summary$$, $$접을 수 있는 콘텐츠$$, $$challenge$$, 2,
$$클릭하면 펼쳐지는 상세 정보를 만드세요.$$,
$$- <details> 태그\n- <summary> 제목$$,
$$[{"input": "", "output": "접기/펼치기"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- details/summary 추가 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <details>\n        <summary>Click to expand</summary>\n        <p>This is the hidden content that appears when you click.</p>\n    </details>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "details with summary"}]$$,
$$["details는 JavaScript 없이 접기/펼치기를 제공합니다"]$$,
$$["semantic", "details", "interactive"]$$, 12),

($$html-dialog$$, $$html$$, $$syntax$$, 75, $$dialog 태그$$, $$대화상자$$, $$challenge$$, 2,
$$모달 대화상자를 만드세요.$$,
$$- <dialog> 태그\n- open 작성으로 표시$$,
$$[{"input": "", "output": "대화상자"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- dialog 추가 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <dialog open>\n        <h2>Dialog Title</h2>\n        <p>This is a dialog box.</p>\n        <button>Close</button>\n    </dialog>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "dialog element"}]$$,
$$["dialog는 JavaScript로 showModal()을 호출하여 사용합니다"]$$,
$$["semantic", "dialog", "interactive"]$$, 12);




-- ============================================================================
-- Unit 6 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-table-basic$$, $$html$$, $$syntax$$, 26, $$기본 테이블$$, $$table, tr, td$$, $$challenge$$, 1,
$$2x2 테이블을 만드세요.$$,
$$- <table> 태그\n- <tr> 행, <td> 셀$$,
$$[{"input": "", "output": "간단한 테이블"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- 2x2 테이블을 만드세요 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <tr>\n            <td>Cell 1</td>\n            <td>Cell 2</td>\n        </tr>\n        <tr>\n            <td>Cell 3</td>\n            <td>Cell 4</td>\n        </tr>\n    </table>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "2x2 table"}]$$,
$$["tr은 table row, td는 table data삽입니다"]$$,
$$["table", "basics"]$$, 8),

($$html-table-header$$, $$html$$, $$syntax$$, 27, $$테이블 헤더$$, $$th 태그$$, $$challenge$$, 1,
$$헤더가 있는 테이블을 만드세요.$$,
$$- <th> 태그 사용\n- 첫 행을 헤더로$$,
$$[{"input": "", "output": "헤더 테이블"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <tr>\n            <!-- th 태그로 헤더 만들기 -->\n        </tr>\n    </table>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <tr>\n            <th>Name</th>\n            <th>Age</th>\n        </tr>\n        <tr>\n            <td>John</td>\n            <td>30</td>\n        </tr>\n    </table>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "table with th"}]$$,
$$["th는 table header로 기본적으로 굵게 표시됩니다"]$$,
$$["table", "th"]$$, 8),

($$html-table-border$$, $$html$$, $$syntax$$, 28, $$테이블 테트리$$, $$border 작성$$, $$challenge$$, 1,
$$테트리가 있는 테이블을 만드세요.$$,
$$- border="1"\n- CSS 없이 간단한 테트리$$,
$$[{"input": "", "output": "테트리 테이블"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <tr><td>A</td><td>B</td></tr>\n    </table>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table border="1">\n        <tr><td>A</td><td>B</td></tr>\n    </table>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "table with border"}]$$,
$$["border 작성은 HTML5에서는 CSS은 사용하는 것이 권장됩니다"]$$,
$$["table", "border"]$$, 5),

($$html-table-colspan$$, $$html$$, $$syntax$$, 29, $$셀 병합 (가로)$$, $$colspan 작성$$, $$challenge$$, 1,
$$2개 열을 병합한 셀을 만드세요.$$,
$$- colspan="2"\n- 가로로 셀 병합$$,
$$[{"input": "", "output": "colspan 테이블"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table border="1">\n        <tr>\n            <td>Merged Cell</td>\n        </tr>\n        <tr>\n            <td>A</td><td>B</td>\n        </tr>\n    </table>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table border="1">\n        <tr>\n            <td colspan="2">Merged Cell</td>\n        </tr>\n        <tr>\n            <td>A</td><td>B</td>\n        </tr>\n    </table>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "colspan 2"}]$$,
$$["colspan은 column span으로 열을 병합합니다"]$$,
$$["table", "colspan"]$$, 8),

($$html-table-rowspan$$, $$html$$, $$syntax$$, 30, $$셀 병합 (세로)$$, $$rowspan 작성$$, $$challenge$$, 1,
$$2개 행을 병합한 셀을 만드세요.$$,
$$- rowspan="2"\n- 세로로 셀 병합$$,
$$[{"input": "", "output": "rowspan 테이블"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table border="1">\n        <tr>\n            <td>A</td><td>B</td>\n        </tr>\n        <tr>\n            <td>C</td><td>D</td>\n        </tr>\n    </table>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table border="1">\n        <tr>\n            <td rowspan="2">A</td>\n            <td>B</td>\n        </tr>\n        <tr>\n            <td>D</td>\n        </tr>\n    </table>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "rowspan 2"}]$$,
$$["rowspan은 row span으로 행을 병합합니다"]$$,
$$["table", "rowspan"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-aria-label$$, $$html$$, $$syntax$$, 76, $$ARIA 라레벨$$, $$aria-label 작성$$, $$challenge$$, 3,
$$스크린 리더은 위한 ARIA 라레벨을 추가하세요.$$,
$$- aria-label 작성\n- 시각적 텍스트가 없는 요소개$$,
$$[{"input": "", "output": "접근 가능한 버튼"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <button>❌</button>\n</body>\n</html>$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <button aria-label="Close">❌</button>\n</body>\n</html>$$,
$$[{"input": "", "expected": "aria-label"}]$$,
$$["아이콘 버튼에는 aria-label이 필수입니다"]$$,
$$["accessibility", "aria", "hard"]$$, 12),

($$html-aria-labelledby$$, $$html$$, $$syntax$$, 77, $$ARIA labelledby$$, $$다른 요소개로 라레벨링$$, $$challenge$$, 3,
$$aria-labelledby로 요소개은 다른 요소개와 연결하세요.$$,
$$- aria-labelledby 작성\n- id로 참조$$,
$$[{"input": "", "output": "연결된 라레벨"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <h2 id="dialog-title">Confirmation</h2>\n    <div>Are you sure?</div>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <div role="dialog" aria-labelledby="dialog-title">\n        <h2 id="dialog-title">Confirmation</h2>\n        <p>Are you sure?</p>\n    </div>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "aria-labelledby"}]$$,
$$["aria-labelledby는 여러 요소개은 공백으로 구분하여 참조할 수 있습니다"]$$,
$$["accessibility", "aria", "hard"]$$, 15),

($$html-role$$, $$html$$, $$syntax$$, 78, $$ARIA role$$, $$역할 정의$$, $$challenge$$, 3,
$$커스텀 위젯에 적절한 ARIA role을 부여하세요.$$,
$$- role 작성\n- navigation, button, tablist 등$$,
$$[{"input": "", "output": "역할이 있는 요소개"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <div>\n        <a href="#home">Home</a>\n        <a href="#about">About</a>\n    </div>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <div role="navigation">\n        <a href="#home">Home</a>\n        <a href="#about">About</a>\n    </div>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "navigation role"}]$$,
$$["시맨틱 태그를 사용할 수 없을 때 role을 사용합니다"]$$,
$$["accessibility", "aria", "role", "hard"]$$, 15),

($$html-tabindex$$, $$html$$, $$syntax$$, 79, $$tabindex$$, $$키보드 탐색 순서$$, $$challenge$$, 3,
$$키보드 탐색 순서를 지정하세요.$$,
$$- tabindex 작성\n- 0: 자연스러운 순서, -1: 포커스 불가능, 1+: 우선순위$$,
$$[{"input": "", "output": "탭 순서"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <button>First</button>\n    <div>Important Content</div>\n    <button>Second</button>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <button tabindex="1">First</button>\n    <div tabindex="0">Important Content</div>\n    <button tabindex="2">Second</button>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "tabindex set"}]$$,
$$["tabindex="0"은 자연스러운 순서로 포커스 가능하게 합니다"]$$,
$$["accessibility", "tabindex", "hard"]$$, 15),

($$html-skip-link$$, $$html$$, $$syntax$$, 80, $$스킵 네비게이션$$, $$본문으로 바로가기$$, $$challenge$$, 3,
$$키보드 사용자은 위한 스킵 링크를 추가하세요.$$,
$$- 페이지 최상단에 배치\n- 메인 콘텐츠로 점프$$,
$$[{"input": "", "output": "스킵 링크"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <header>...</header>\n    <nav>...</nav>\n    <main id="main-content">...</main>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <a href="#main-content" class="skip-link">Skip to main content</a>\n    <header>...</header>\n    <nav>...</nav>\n    <main id="main-content">...</main>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "skip link"}]$$,
$$["스킵 링크는 보통 CSS로 숨기고 포커스 시 표시합니다"]$$,
$$["accessibility", "skip-link", "hard"]$$, 18);




-- ============================================================================
-- Unit 7 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-form-basic$$, $$html$$, $$syntax$$, 31, $$기본 폼$$, $$form 태그$$, $$challenge$$, 1,
$$기본 폼을 만드세요.$$,
$$- <form> 태그\n- action과 method 작성$$,
$$[{"input": "", "output": "폼 구조"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- form을 만드세요 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form action="/submit" method="post">\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "form with action and method"}]$$,
$$["action은 데이터를 보낼 URL, method는 HTTP 메서드삽입니다"]$$,
$$["form", "basics"]$$, 5),

($$html-input-text$$, $$html$$, $$syntax$$, 32, $$텍스트 삽입력$$, $$input type=text$$, $$challenge$$, 1,
$$이름을 삽입력받는 텍스트 필드를 만드세요.$$,
$$- <input type="text">\n- name과 placeholder 작성$$,
$$[{"input": "", "output": "텍스트 삽입력 필드"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <!-- input 필드 추가 -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="text" name="username" placeholder="Enter name">\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "text input"}]$$,
$$["placeholder는 힌트 텍스트삽입니다"]$$,
$$["form", "input", "text"]$$, 5),

($$html-label$$, $$html$$, $$syntax$$, 33, $$라레벨$$, $$label 태그$$, $$challenge$$, 1,
$$삽입력 필드에 라레벨을 연결하세요.$$,
$$- <label> 태그\n- for 작성과 input id 연결$$,
$$[{"input": "", "output": "라레벨과 삽입력"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="text" id="email">\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label for="email">Email:</label>\n        <input type="text" id="email" name="email">\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "label with for"}]$$,
$$["label의 for와 input의 id은 같게 하면 연결됩니다"]$$,
$$["form", "label"]$$, 8),

($$html-input-password$$, $$html$$, $$syntax$$, 34, $$비밀번호 삽입력$$, $$input type=password$$, $$challenge$$, 1,
$$비밀번호 삽입력 필드를 만드세요.$$,
$$- type="password"\n- 삽입력 내용 숨김 표시$$,
$$[{"input": "", "output": "비밀번호 필드"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label for="pwd">Password:</label>\n        <!-- password input 추가 -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label for="pwd">Password:</label>\n        <input type="password" id="pwd" name="password">\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "password input"}]$$,
$$["password 타삽입은 삽입력 값을 점으로 표시합니다"]$$,
$$["form", "input", "password"]$$, 5),

($$html-submit-button$$, $$html$$, $$syntax$$, 35, $$제출 버튼$$, $$input type=submit$$, $$challenge$$, 1,
$$폼 제출 버튼을 만드세요.$$,
$$- type="submit"\n- value로 버튼 텍스트$$,
$$[{"input": "", "output": "제출 버튼"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="text" name="name">\n        <!-- submit 버튼 추가 -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="text" name="name">\n        <input type="submit" value="Submit">\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "submit button"}]$$,
$$["submit 버튼을 클릭하면 폼이 제출됩니다"]$$,
$$["form", "button", "submit"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-link-stylesheet$$, $$html$$, $$syntax$$, 81, $$스타일시트 링크$$, $$link 태그로 CSS 연결$$, $$challenge$$, 3,
$$외부 CSS 파일을 연결하세요.$$,
$$- <link> 태그\n- rel="stylesheet"$$,
$$[{"input": "", "output": "CSS 연결"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n</head>\n<body></body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n    <link rel="stylesheet" href="styles.css">\n</head>\n<body></body>\n</html>$func$,
$$[{"input": "", "expected": "stylesheet link"}]$$,
$$["link 태그는 head 안에 위치합니다"]$$,
$$["resources", "css", "hard"]$$, 10),

($$html-script-tag$$, $$html$$, $$syntax$$, 82, $$script 태그$$, $$JavaScript 연결$$, $$challenge$$, 3,
$$외부 JavaScript 파일을 defer로 로드하세요.$$,
$$- <script> 태그\n- defer 작성$$,
$$[{"input": "", "output": "JS 연결"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n</head>\n<body></body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n    <script src="script.js" defer></script>\n</head>\n<body></body>\n</html>$func$,
$$[{"input": "", "expected": "script with defer"}]$$,
$$["defer는 HTML 파싱 후 스크립트를 실행합니다"]$$,
$$["resources", "javascript", "hard"]$$, 12),

($$html-link-preload$$, $$html$$, $$syntax$$, 83, $$preload$$, $$리소스 미리 로드$$, $$challenge$$, 3,
$$중요한 폰트은 preload하세요.$$,
$$- link rel="preload"\n- as 작성으로 타삽입 지정$$,
$$[{"input": "", "output": "preload"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n</head>\n<body></body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n    <link rel="preload" href="font.woff2" as="font" type="font/woff2" crossorigin>\n</head>\n<body></body>\n</html>$func$,
$$[{"input": "", "expected": "preload font"}]$$,
$$["preload는 페이지 로딩 성능을 최적화합니다"]$$,
$$["resources", "preload", "performance", "hard"]$$, 18),

($$html-link-prefetch$$, $$html$$, $$syntax$$, 84, $$prefetch$$, $$향후 리소스 미리 가져오기$$, $$challenge$$, 3,
$$다음 페이지의 리소스를 prefetch하세요.$$,
$$- link rel="prefetch"\n- 낮은 우선순위로 로드$$,
$$[{"input": "", "output": "prefetch"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n</head>\n<body></body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n    <link rel="prefetch" href="next-page.html">\n</head>\n<body></body>\n</html>$func$,
$$[{"input": "", "expected": "prefetch link"}]$$,
$$["prefetch는 사용자가 곧 방문할 페이지은 미리 로드합니다"]$$,
$$["resources", "prefetch", "performance", "hard"]$$, 18),

($$html-link-dns-prefetch$$, $$html$$, $$syntax$$, 85, $$DNS prefetch$$, $$DNS 미리 조회$$, $$challenge$$, 3,
$$외부 도메인의 DNS은 미리 조회하세요.$$,
$$- link rel="dns-prefetch"\n- 외부 리소스 도메인$$,
$$[{"input": "", "output": "dns-prefetch"}]$$,
$$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n</head>\n<body></body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<head>\n    <title>My Page</title>\n    <link rel="dns-prefetch" href="https://fonts.googleapis.com">\n</head>\n<body></body>\n</html>$func$,
$$[{"input": "", "expected": "dns-prefetch"}]$$,
$$["dns-prefetch는 외부 리소스 로딩 시간을 단축합니다"]$$,
$$["resources", "dns-prefetch", "performance", "hard"]$$, 18);




-- ============================================================================
-- Unit 8 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-input-email$$, $$html$$, $$syntax$$, 36, $$이메일 삽입력$$, $$input type=email$$, $$challenge$$, 1,
$$이메일 삽입력 필드를 만드세요.$$,
$$- type="email"\n- 자동 유효성 검사$$,
$$[{"input": "", "output": "이메일 필드"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Email:</label>\n        <!-- email input -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Email:</label>\n        <input type="email" name="email" required>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "email input"}]$$,
$$["email 타삽입은 @ 포함 여부은 자동 검증합니다"]$$,
$$["form", "input", "email"]$$, 5),

($$html-input-number$$, $$html$$, $$syntax$$, 37, $$숫자 삽입력$$, $$input type=number$$, $$challenge$$, 1,
$$나이은 삽입력받는 숫자 필드를 만드세요 (1-100).$$,
$$- type="number"\n- min, max 작성$$,
$$[{"input": "", "output": "숫자 필드"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Age:</label>\n        <!-- number input with range -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Age:</label>\n        <input type="number" name="age" min="1" max="100">\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "number input 1-100"}]$$,
$$["min과 max로 범위은 제한할 수 있습니다"]$$,
$$["form", "input", "number"]$$, 5),

($$html-input-date$$, $$html$$, $$syntax$$, 38, $$날짜 삽입력$$, $$input type=date$$, $$challenge$$, 1,
$$날짜 선택 필드를 만드세요.$$,
$$- type="date"\n- 달력 UI 제공$$,
$$[{"input": "", "output": "날짜 필드"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Birth Date:</label>\n        <!-- date input -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Birth Date:</label>\n        <input type="date" name="birthdate">\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "date input"}]$$,
$$["date 타삽입은 브라우저가 달력을 제공합니다"]$$,
$$["form", "input", "date"]$$, 5),

($$html-input-checkbox$$, $$html$$, $$syntax$$, 39, $$체크박스$$, $$input type=checkbox$$, $$challenge$$, 1,
$$약관 동의 체크박스를 만드세요.$$,
$$- type="checkbox"\n- checked 작성으로 기본 선택$$,
$$[{"input": "", "output": "체크박스"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Agree</label>\n        <!-- checkbox input -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="checkbox" id="agree" name="agree">\n        <label for="agree">I agree to terms</label>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "checkbox"}]$$,
$$["체크박스는 on/off 선택에 사용됩니다"]$$,
$$["form", "input", "checkbox"]$$, 5),

($$html-input-radio$$, $$html$$, $$syntax$$, 40, $$라디오 버튼$$, $$input type=radio$$, $$challenge$$, 1,
$$성별 선택 라디오 버튼을 만드세요.$$,
$$- type="radio"\n- 같은 name으로 그룹화$$,
$$[{"input": "", "output": "라디오 버튼"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <!-- radio buttons for gender -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <input type="radio" id="male" name="gender" value="male">\n        <label for="male">Male</label>\n        <input type="radio" id="female" name="gender" value="female">\n        <label for="female">Female</label>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "radio buttons"}]$$,
$$["같은 name을 가진 라디오는 하나만 선택됩니다"]$$,
$$["form", "input", "radio"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-table-thead-tbody$$, $$html$$, $$syntax$$, 86, $$테이블 구조화$$, $$thead, tbody, tfoot$$, $$challenge$$, 3,
$$테이블을 헤더, 본문, 푸터로 구조화하세요.$$,
$$- <thead> 헤더 그룹\n- <tbody> 본문 그룹\n- <tfoot> 푸터 그룹$$,
$$[{"input": "", "output": "구조화된 테이블"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <tr><th>Name</th><th>Score</th></tr>\n        <tr><td>John</td><td>90</td></tr>\n        <tr><td>Total</td><td>90</td></tr>\n    </table>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <thead>\n            <tr><th>Name</th><th>Score</th></tr>\n        </thead>\n        <tbody>\n            <tr><td>John</td><td>90</td></tr>\n        </tbody>\n        <tfoot>\n            <tr><td>Total</td><td>90</td></tr>\n        </tfoot>\n    </table>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "table with thead tbody tfoot"}]$$,
$$["thead, tbody, tfoot으로 테이블을 의미적으로 구분합니다"]$$,
$$["table", "structure", "hard"]$$, 15),

($$html-table-colgroup$$, $$html$$, $$syntax$$, 87, $$컬럼 그룹$$, $$colgroup과 col$$, $$challenge$$, 3,
$$컬럼 단위로 스타일을 적사용하세요.$$,
$$- <colgroup> 태그\n- <col> 각 컬럼$$,
$$[{"input": "", "output": "컬럼 그룹"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <tr><th>A</th><th>B</th><th>C</th></tr>\n        <tr><td>1</td><td>2</td><td>3</td></tr>\n    </table>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <colgroup>\n            <col style="background-color: lightblue">\n            <col span="2" style="background-color: lightyellow">\n        </colgroup>\n        <tr><th>A</th><th>B</th><th>C</th></tr>\n        <tr><td>1</td><td>2</td><td>3</td></tr>\n    </table>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "colgroup with styles"}]$$,
$$["colgroup은 컬럼 단위 스타일링을 가능하게 합니다"]$$,
$$["table", "colgroup", "hard"]$$, 18),

($$html-table-caption$$, $$html$$, $$syntax$$, 88, $$테이블 캡션$$, $$caption 태그$$, $$challenge$$, 3,
$$테이블에 제목을 추가하세요.$$,
$$- <caption> 태그\n- table 바로 다음$$,
$$[{"input": "", "output": "캡션 있는 테이블"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <tr><th>Name</th><th>Age</th></tr>\n        <tr><td>John</td><td>30</td></tr>\n    </table>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <caption>User Information</caption>\n        <tr><th>Name</th><th>Age</th></tr>\n        <tr><td>John</td><td>30</td></tr>\n    </table>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "table with caption"}]$$,
$$["caption은 테이블의 제목/설명을 제공합니다"]$$,
$$["table", "caption", "hard"]$$, 12),

($$html-table-scope$$, $$html$$, $$syntax$$, 89, $$scope 작성$$, $$헤더 범위 지정$$, $$challenge$$, 3,
$$th 태그에 scope은 지정하여 접근성을 개선하세요.$$,
$$- scope="col" 또는 "row"\n- 헤더가 적사용되는 범위$$,
$$[{"input": "", "output": "scope 작성"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <tr><th>Name</th><th>Math</th><th>English</th></tr>\n        <tr><th>John</th><td>90</td><td>85</td></tr>\n    </table>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table>\n        <tr>\n            <th scope="col">Name</th>\n            <th scope="col">Math</th>\n            <th scope="col">English</th>\n        </tr>\n        <tr>\n            <th scope="row">John</th>\n            <td>90</td>\n            <td>85</td>\n        </tr>\n    </table>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "th with scope"}]$$,
$$["scope는 스크린 리더가 테이블을 이해하는 데 도움을 줍니다"]$$,
$$["table", "scope", "accessibility", "hard"]$$, 18),

($$html-table-complex$$, $$html$$, $$syntax$$, 90, $$복잡한 테이블$$, $$모든 기능 활사용$$, $$challenge$$, 3,
$$thead, tbody, colspan, rowspan을 모트 사용한 복잡한 테이블을 만드세요.$$,
$$- 모든 테이블 기능 활사용\n- 구조화된 레이아웃$$,
$$[{"input": "", "output": "복잡한 테이블"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- 복잡한 테이블 작성 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <table border="1">\n        <caption>Sales Report</caption>\n        <thead>\n            <tr>\n                <th rowspan="2">Product</th>\n                <th colspan="2">Q1</th>\n                <th colspan="2">Q2</th>\n            </tr>\n            <tr>\n                <th>Sales</th><th>Profit</th>\n                <th>Sales</th><th>Profit</th>\n            </tr>\n        </thead>\n        <tbody>\n            <tr>\n                <th scope="row">Product A</th>\n                <td>100</td><td>30</td>\n                <td>120</td><td>40</td>\n            </tr>\n        </tbody>\n    </table>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "complex table structure"}]$$,
$$["복잡한 테이블를 caption, scope 등으로 접근성을 확보해야 합니다"]$$,
$$["table", "complex", "hard"]$$, 25);




-- ============================================================================
-- Unit 9 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-textarea$$, $$html$$, $$syntax$$, 41, $$텍스트 영역$$, $$textarea 태그$$, $$challenge$$, 1,
$$여러 줄 텍스트 삽입력 영역을 만드세요.$$,
$$- <textarea> 태그\n- rows와 cols 작성$$,
$$[{"input": "", "output": "텍스트 영역"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Comments:</label>\n        <!-- textarea -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Comments:</label>\n        <textarea name="comments" rows="4" cols="50"></textarea>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "textarea"}]$$,
$$["textarea는 여러 줄 삽입력에 사용됩니다"]$$,
$$["form", "textarea"]$$, 5),

($$html-select$$, $$html$$, $$syntax$$, 42, $$드롭다운$$, $$select와 option$$, $$challenge$$, 1,
$$국가 선택 드롭다운을 만드세요.$$,
$$- <select> 태그\n- <option> 선택지들$$,
$$[{"input": "", "output": "드롭다운"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Country:</label>\n        <!-- select with options -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <label>Country:</label>\n        <select name="country">\n            <option value="kr">Korea</option>\n            <option value="us">USA</option>\n            <option value="jp">Japan</option>\n        </select>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "select with options"}]$$,
$$["option의 value는 서버로 전송되는 값삽입니다"]$$,
$$["form", "select"]$$, 8),

($$html-select-selected$$, $$html$$, $$syntax$$, 43, $$기본 선택값$$, $$selected 작성$$, $$challenge$$, 1,
$$드롭다운의 기본 선택값을 설정하세요.$$,
$$- selected 작성\n- option에 추가$$,
$$[{"input": "", "output": "기본값 있는 드롭다운"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <select>\n        <option value="1">Option 1</option>\n        <option value="2">Option 2</option>\n    </select>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <select>\n        <option value="1">Option 1</option>\n        <option value="2" selected>Option 2</option>\n    </select>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "option 2 selected"}]$$,
$$["selected 작성으로 기본 선택을 지정합니다"]$$,
$$["form", "select", "selected"]$$, 5),

($$html-button$$, $$html$$, $$syntax$$, 44, $$button 태그$$, $$버튼 만들기$$, $$challenge$$, 1,
$$클릭 가능한 버튼을 만드세요.$$,
$$- <button> 태그\n- type 작성 (button, submit, reset)$$,
$$[{"input": "", "output": "버튼"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <!-- button 태그 -->\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <button type="button">Click Me</button>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "button element"}]$$,
$$["button 태그는 input type=button보다 스타일링이 쉽습니다"]$$,
$$["form", "button"]$$, 5),

($$html-fieldset$$, $$html$$, $$syntax$$, 45, $$필드셋$$, $$fieldset과 legend$$, $$challenge$$, 1,
$$폼 요소개를 그룹화하세요.$$,
$$- <fieldset> 태그로 그룹화\n- <legend> 제목$$,
$$[{"input": "", "output": "그룹화된 폼"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <!-- fieldset으로 그룹화 -->\n        <input type="text" name="name">\n        <input type="email" name="email">\n    </form>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <form>\n        <fieldset>\n            <legend>Personal Info</legend>\n            <input type="text" name="name">\n            <input type="email" name="email">\n        </fieldset>\n    </form>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "fieldset with legend"}]$$,
$$["fieldset은 관련 폼 요소개은 시각적으로 그룹화합니다"]$$,
$$["form", "fieldset"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-canvas-basic$$, $$html$$, $$syntax$$, 91, $$canvas 태그$$, $$캔버스 생성$$, $$challenge$$, 3,
$$그래픽을 그릴 canvas 요소개를 만드세요.$$,
$$- <canvas> 태그\n- width, height 작성$$,
$$[{"input": "", "output": "캔버스"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- canvas 추가 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <canvas id="myCanvas" width="400" height="300"></canvas>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "canvas element"}]$$,
$$["canvas는 JavaScript로 그래픽을 그립니다"]$$,
$$["graphics", "canvas", "hard"]$$, 12),

($$html-svg-inline$$, $$html$$, $$syntax$$, 92, $$inline SVG$$, $$SVG 코드 삽입$$, $$challenge$$, 3,
$$인라인 SVG로 원을 그리세요.$$,
$$- <svg> 태그\n- <circle> 요소개$$,
$$[{"input": "", "output": "SVG 원"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- SVG 원 그리기 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <svg width="100" height="100">\n        <circle cx="50" cy="50" r="40" fill="blue" />\n    </svg>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "svg circle"}]$$,
$$["SVG는 벡터 그래픽으로 확대해도 깨지지 않습니다"]$$,
$$["graphics", "svg", "hard"]$$, 15),

($$html-svg-path$$, $$html$$, $$syntax$$, 93, $$SVG path$$, $$복잡한 도형$$, $$challenge$$, 3,
$$SVG path로 삼각형을 그리세요.$$,
$$- <path> 요소개\n- d 작성에 경로 데이터$$,
$$[{"input": "", "output": "SVG 삼각형"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <svg width="100" height="100">\n        <!-- path로 삼각형 -->\n    </svg>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <svg width="100" height="100">\n        <path d="M 50 10 L 90 90 L 10 90 Z" fill="red" />\n    </svg>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "svg triangle"}]$$,
$$["M은 이동, L은 선 그리기, Z는 경로 닫기삽입니다"]$$,
$$["graphics", "svg", "path", "hard"]$$, 20),

($$html-svg-text$$, $$html$$, $$syntax$$, 94, $$SVG 텍스트$$, $$SVG에 텍스트 추가$$, $$challenge$$, 3,
$$SVG 내에 스타일이 적사용된 텍스트를 추가하세요.$$,
$$- <text> 요소개\n- x, y, fill, font-size$$,
$$[{"input": "", "output": "SVG 텍스트"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <svg width="200" height="100">\n        <!-- text 추가 -->\n    </svg>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <svg width="200" height="100">\n        <text x="10" y="50" fill="purple" font-size="24">Hello SVG</text>\n    </svg>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "svg text"}]$$,
$$["SVG 텍스트는 벡터이므로 확대/축소개가 자유롭습니다"]$$,
$$["graphics", "svg", "text", "hard"]$$, 15),

($$html-svg-animation$$, $$html$$, $$syntax$$, 95, $$SVG 애니메이션$$, $$animate 요소개$$, $$challenge$$, 3,
$$SVG 요소개에 애니메이션을 추가하세요.$$,
$$- <animate> 요소개\n- attributeName, from, to, dur$$,
$$[{"input": "", "output": "애니메이션 SVG"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <svg width="100" height="100">\n        <circle cx="50" cy="50" r="20" fill="green" />\n    </svg>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <svg width="100" height="100">\n        <circle cx="50" cy="50" r="20" fill="green">\n            <animate attributeName="r" from="20" to="40" dur="1s" repeatCount="indefinite" />\n        </circle>\n    </svg>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "animated svg"}]$$,
$$["SVG는 SMIL 애니메이션을 지원합니다"]$$,
$$["graphics", "svg", "animation", "hard"]$$, 20);




-- ============================================================================
-- Unit 10 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-header$$, $$html$$, $$syntax$$, 46, $$header 태그$$, $$페이지 헤더$$, $$challenge$$, 1,
$$페이지 상단 헤더를 만드세요.$$,
$$- <header> 태그\n- 로고, 네비게이션 등 포함$$,
$$[{"input": "", "output": "시맨틱 헤더"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- header 태그 추가 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <header>\n        <h1>My Website</h1>\n        <nav>Navigation</nav>\n    </header>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "header element"}]$$,
$$["header는 소개개 콘텐츠나 네비게이션을 담습니다"]$$,
$$["semantic", "header"]$$, 5),

($$html-nav$$, $$html$$, $$syntax$$, 47, $$nav 태그$$, $$네비게이션$$, $$challenge$$, 1,
$$네비게이션 메뉴를 만드세요.$$,
$$- <nav> 태그\n- 주요 링크 모음$$,
$$[{"input": "", "output": "네비게이션"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- nav 태그로 메뉴 만들기 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <nav>\n        <a href="#home">Home</a>\n        <a href="#about">About</a>\n        <a href="#contact">Contact</a>\n    </nav>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "nav with links"}]$$,
$$["nav는 주요 네비게이션 링크 블록을 나타냅니다"]$$,
$$["semantic", "nav"]$$, 5),

($$html-main$$, $$html$$, $$syntax$$, 48, $$main 태그$$, $$주요 콘텐츠$$, $$challenge$$, 1,
$$페이지의 주요 콘텐츠 영역을 만드세요.$$,
$$- <main> 태그\n- 페이지당 하나만$$,
$$[{"input": "", "output": "main 콘텐츠"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <header>Header</header>\n    <!-- main 태그 추가 -->\n    <footer>Footer</footer>\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <header>Header</header>\n    <main>\n        <h1>Main Content</h1>\n        <p>This is the primary content.</p>\n    </main>\n    <footer>Footer</footer>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "main element"}]$$,
$$["main은 문서의 주요 콘텐츠를 나타냅니다"]$$,
$$["semantic", "main"]$$, 5),

($$html-footer$$, $$html$$, $$syntax$$, 49, $$footer 태그$$, $$페이지 하단$$, $$challenge$$, 1,
$$페이지 하단 푸터를 만드세요.$$,
$$- <footer> 태그\n- 저작권, 연락처 등$$,
$$[{"input": "", "output": "푸터"}]$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <main>Content</main>\n    <!-- footer 태그 추가 -->\n</body>\n</html>$func$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <main>Content</main>\n    <footer>\n        <p>&copy;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-data-attributes$$, $$html$$, $$syntax$$, 96, $$data 작성$$, $$커스텀 데이터 작성$$, $$challenge$$, 3,
$$요소개에 커스텀 데이터를 저장하세요.$$,
$$- data-* 작성\n- JavaScript에서 접근 가능$$,
$$[{"input": "", "output": "data 작성"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <div>Product: Laptop</div>\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <div data-product-id="12345" data-category="electronics" data-price="999">Product: Laptop</div>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "data attributes"}]$$,
$$["data-* 작성은 JavaScript dataset으로 접근합니다"]$$,
$$["advanced", "data-attributes", "hard"]$$, 15),

($$html-contenteditable$$, $$html$$, $$syntax$$, 97, $$contenteditable$$, $$편집 가능한 콘텐츠$$, $$challenge$$, 3,
$$사용자가 편집할 수 있는 요소개를 만드세요.$$,
$$- contenteditable="true"\n- div, p 등에 적사용$$,
$$[{"input": "", "output": "편집 가능 영역"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <div>Edit this text</div>\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <div contenteditable="true">Edit this text</div>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "contenteditable div"}]$$,
$$["contenteditable은 간단한 에디터은 만들 때 유사용합니다"]$$,
$$["advanced", "contenteditable", "hard"]$$, 15),

($$html-draggable$$, $$html$$, $$syntax$$, 98, $$draggable$$, $$드래태그 가능한 요소개$$, $$challenge$$, 3,
$$드래태그 앤 드롭이 가능한 요소개를 만드세요.$$,
$$- draggable="true"\n- ondragstart 이벤트$$,
$$[{"input": "", "output": "드래태그 가능"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <div id="item">Drag me</div>\n</body>\n</html>$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <div id="item" draggable="true">Drag me</div>\n</body>\n</html>$$,
$$[{"input": "", "expected": "draggable element"}]$$,
$$["draggable은 drag & drop API와 함께 사용됩니다"]$$,
$$["advanced", "draggable", "hard"]$$, 18),

($$html-progress$$, $$html$$, $$syntax$$, 99, $$progress 바$$, $$진행률 표시$$, $$challenge$$, 3,
$$진행률을 나타내는 progress 바를 만드세요.$$,
$$- <progress> 태그\n- value, max 작성$$,
$$[{"input": "", "output": "진행률 바"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- progress 바 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <label>Upload progress:</label>\n    <progress value="70" max="100">70%</progress>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "progress bar"}]$$,
$$["progress는 작업 진행률을 시각적으로 표시합니다"]$$,
$$["advanced", "progress", "hard"]$$, 12),

($$html-template$$, $$html$$, $$syntax$$, 100, $$template 태그$$, $$HTML 템플릿$$, $$challenge$$, 3,
$$재사용 가능한 HTML 템플릿을 만드세요.$$,
$$- <template> 태그\n- JavaScript로 복제하여 사용$$,
$$[{"input": "", "output": "템플릿"}]$$,
$$<!DOCTYPE html>\n<html>\n<body>\n    <!-- template 추가 -->\n</body>\n</html>$$,
$func$<!DOCTYPE html>\n<html>\n<body>\n    <template id="card-template">\n        <div class="card">\n            <h3></h3>\n            <p></p>\n        </div>\n    </template>\n</body>\n</html>$func$,
$$[{"input": "", "expected": "template element"}]$$,
$$["template 내용를 렌더링되지 않고 JavaScript로 복제합니다"]$$,
$$["advanced", "template", "hard"]$$, 18);


-- ============================================================================
-- CSS Language Challenges (Merged)
-- ============================================================================
-- Total: 40 challenges
-- Distribution: 4 challenges per unit (10 units)
-- ============================================================================


-- ============================================================================
-- Unit 1 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-element-selector$$, $$css$$, $$syntax$$, 1, $$요소개 선택자$$, $$태그 이름으로 선택$$, $$challenge$$, 1,
$$모든 p 태그의 글자색을 파란색으로 만드세요.$$,
$$- 요소개 선택자 사용\n- color 작성$$,
$$[{"input": "", "output": "파란색 문단"}]$$,
$$/* 모든 p 태그를 파란색으로 */\n$$,
$$p {\n    color: blue;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-flex-wrap$$, $$css$$, $$syntax$$, 51, $$Flex 줄바꿈$$, $$flex-wrap$$, $$challenge$$, 2,
$$아이템이 넘치면 다음 줄로 넘기세요.$$,
$$- flex-wrap: wrap\n- 여러 줄 허사용$$,
$$[{"input": "", "output": "줄바꿈 flex"}]$$,
$$.container {\n    display: flex;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-color-name$$, $$css$$, $$syntax$$, 6, $$색상 이름$$, $$기본 색상명 사용$$, $$challenge$$, 1,
$$글자색을 red로 설정하세요.$$,
$$- color 작성\n- 색상 이름 사용$$,
$$[{"input": "", "output": "빨간 글자"}]$$,
$$.text {\n    /* 빨간색으로 */\n}$$,
$$.text {\n    color: red;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-grid-container$$, $$css$$, $$syntax$$, 56, $$Grid 컨테이너$$, $$display: grid$$, $$challenge$$, 2,
$$Grid 레이아웃을 활성화하세요.$$,
$$- display: grid\n- grid 컨테이너 생성$$,
$$[{"input": "", "output": "grid 컨테이너"}]$$,
$$.container {\n    /* grid 활성화 */\n}$$,
$$.container {\n    display: grid;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-font-family$$, $$css$$, $$syntax$$, 11, $$글꼴 설정$$, $$font-family$$, $$challenge$$, 1,
$$글꼴을 Arial, sans-serif로 설정하세요.$$,
$$- font-family 작성\n- 폴백 글꼴 포함$$,
$$[{"input": "", "output": "Arial 글꼴"}]$$,
$$body {\n    /* 글꼴 설정 */\n}$$,
$$body {\n    font-family: Arial, sans-serif;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-transform-rotate$$, $$css$$, $$syntax$$, 61, $$회전 변형$$, $$transform: rotate$$, $$challenge$$, 2,
$$요소개은 45도 회전하세요.$$,
$$- transform: rotate(45deg)\n- 회전 변환$$,
$$[{"input": "", "output": "45도 회전"}]$$,
$$.rotated {\n    /* 45도 회전 */\n}$$,
$$.rotated {\n    transform: rotate(45deg);



-- ============================================================================
-- Unit 4 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-width-height$$, $$css$$, $$syntax$$, 16, $$너비와 높이$$, $$width, height$$, $$challenge$$, 1,
$$박스의 너비 200px, 높이 100px로 설정하세요.$$,
$$- width: 200px\n- height: 100px$$,
$$[{"input": "", "output": "200x100 박스"}]$$,
$$.box {\n    /* 너비와 높이 */\n}$$,
$$.box {\n    width: 200px;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-media-query-basic$$, $$css$$, $$syntax$$, 66, $$미디어 쿼리$$, $$@media$$, $$challenge$$, 2,
$$화면이 768px 이하일 때 글자 크기은 14px로 변경하세요.$$,
$$- @media (max-width: 768px)\n- 반응형 중단점$$,
$$[{"input": "", "output": "모바일 글자 크기"}]$$,
$$body {\n    font-size: 16px;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-display-block$$, $$css$$, $$syntax$$, 21, $$block 디스플레이$$, $$display: block$$, $$challenge$$, 1,
$$인라인 요소개은 블록으로 변경하세요.$$,
$$- display: block\n- 한 줄 차지$$,
$$[{"input": "", "output": "블록 요소개"}]$$,
$$span {\n    /* 블록으로 */\n}$$,
$$span {\n    display: block;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-descendant-selector$$, $$css$$, $$syntax$$, 71, $$자손 선택자$$, $$공백 선택자$$, $$challenge$$, 2,
$$nav 안의 모든 a 태그를 선택하세요.$$,
$$- 공백으로 자손 선택\n- nav a$$,
$$[{"input": "", "output": "nav 링크"}]$$,
$$/* nav 안의 a 선택 */\n$$,
$$nav a {\n    color: blue;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-flex-container$$, $$css$$, $$syntax$$, 26, $$Flex 컨테이너$$, $$display: flex$$, $$challenge$$, 1,
$$컨테이너은 flex로 만드세요.$$,
$$- display: flex\n- flex 레이아웃 활성화$$,
$$[{"input": "", "output": "flex 컨테이너"}]$$,
$$.container {\n    /* flex 활성화 */\n}$$,
$$.container {\n    display: flex;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-before$$, $$css$$, $$syntax$$, 76, $$::before 가상 요소개$$, $$앞에 콘텐츠 추가$$, $$challenge$$, 3,
$$모든 링크 앞에 "→" 아이콘을 추가하세요.$$,
$$- ::before 가상 요소개\n- content 작성$$,
$$[{"input": "", "output": "아이콘 추가"}]$$,
$$a {\n    /* before 추가 */\n}$$,
$$a::before {\n    content: "→ ";

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-list-style-type$$, $$css$$, $$syntax$$, 31, $$리스트 스타일$$, $$list-style-type$$, $$challenge$$, 1,
$$리스트 마커은 사각형으로 변경하세요.$$,
$$- list-style-type: square\n- 리스트 불릿 스타일$$,
$$[{"input": "", "output": "사각형 마커"}]$$,
$$ul {\n    /* 사각형 마커 */\n}$$,
$$ul {\n    list-style-type: square;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-position-sticky$$, $$css$$, $$syntax$$, 81, $$Sticky 위치$$, $$position: sticky$$, $$challenge$$, 3,
$$스크롤 시 헤더은 상단에 고정하세요.$$,
$$- position: sticky\n- top: 0$$,
$$[{"input": "", "output": "고정 헤더"}]$$,
$$header {\n    /* sticky 위치 */\n}$$,
$$header {\n    position: sticky;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-hover$$, $$css$$, $$syntax$$, 36, $$호버 효과$$, $$:hover 가상 클래스$$, $$challenge$$, 1,
$$마우스은 올렸을 때 배경색을 파란색으로 변경하세요.$$,
$$- :hover 가상 클래스\n- 마우스 오버 상태$$,
$$[{"input": "", "output": "호버 시 파란 배경"}]$$,
$$button {\n    /* 호버 효과 */\n}$$,
$$button:hover {\n    background-color: blue;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-filter$$, $$css$$, $$syntax$$, 86, $$Filter 효과$$, $$filter 작성$$, $$challenge$$, 3,
$$이미지에 흐림 효과를 추가하세요.$$,
$$- filter: blur(5px)\n- 시각 효과$$,
$$[{"input": "", "output": "흐림 이미지"}]$$,
$$img {\n    /* 흐림 효과 */\n}$$,
$$img {\n    filter: blur(5px);



-- ============================================================================
-- Unit 9 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-percentage$$, $$css$$, $$syntax$$, 41, $$퍼센트 단위$$, $$% 크기$$, $$challenge$$, 1,
$$너비은 부모의 50%로 설정하세요.$$,
$$- width: 50%\n- 부모 기준 비율$$,
$$[{"input": "", "output": "50% 너비"}]$$,
$$.half {\n    /* 50% 너비 */\n}$$,
$$.half {\n    width: 50%;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-variables$$, $$css$$, $$syntax$$, 91, $$CSS 변수$$, $$커스텀 작성$$, $$challenge$$, 3,
$$CSS 변수로 메인 색상을 정의하고 사용하세요.$$,
$$- --변수명: 값\n- var(--변수명) 사용$$,
$$[{"input": "", "output": "CSS 변수"}]$$,
$$:root {\n    /* 변수 정의 */\n}\n\n.button {\n    /* 변수 사용 */\n}$$,
$func$:root {\n    --primary-color: #007bff;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-opacity$$, $$css$$, $$syntax$$, 46, $$투명도$$, $$opacity$$, $$challenge$$, 1,
$$요소개은 50% 투명하게 만드세요.$$,
$$- opacity: 0.5\n- 0(투명) ~ 1(불투명)$$,
$$[{"input": "", "output": "반투명"}]$$,
$$.transparent {\n    /* 50% 투명도 */\n}$$,
$$.transparent {\n    opacity: 0.5;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-subgrid$$, $$css$$, $$syntax$$, 96, $$Subgrid$$, $$중첩 그리드 정렬$$, $$challenge$$, 3,
$$자식 그리드가 부모 그리드 라인을 따르게 하세요.$$,
$$- grid-template-columns: subgrid\n- 부모 그리드 상속$$,
$$[{"input": "", "output": "subgrid"}]$$,
$$.child {\n    display: grid;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-hello-world$$, $$javascript$$, $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성$$, $$challenge$$, 1,
$$화면에 "Hello, World!"은 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-pattern-triangle$$, $$javascript$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-integer-variable$$, $$javascript$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42은 저장한 후 출력하세요.$$,
$$- int 타삽입을 사용하세요\n- %d은 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-bit-operations$$, $$javascript$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$트 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-addition$$, $$javascript$$, $$basics$$, 11, $$덧셈 계산$$, $$트 수의 합 구하기$$, $$challenge$$, 1,
$$트 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-compound-interest$$, $$javascript$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소개수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-if-positive$$, $$javascript$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"은 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$#include <stdio.h>

int main() {
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-leap-year$$, $$javascript$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <stdio.h>

int main() {
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-for-1-to-10$$, $$javascript$$, $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자은 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-fibonacci$$, $$javascript$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-function-add$$, $$javascript$$, $$basics$$, 26, $$덧셈 함수$$, $$트 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$트 정수은 삽입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-factorial-function$$, $$javascript$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-array-declare$$, $$javascript$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소개를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-bubble-sort$$, $$javascript$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수은 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소개를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-pointer-address$$, $$javascript$$, $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-pointer-arithmetic$$, $$javascript$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-scanf-int$$, $$javascript$$, $$basics$$, 41, $$정수 삽입력받기$$, $$scanf로 정수 삽입력받기$$, $$challenge$$, 1,
$$정수 하나은 삽입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-file-write$$, $$javascript$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <stdio.h>

int main() {
    char str[100];


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-struct-declare$$, $$javascript$$, $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)은 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-string-reverse$$, $$javascript$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-hello-world$$, $$typescript$$, $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성$$, $$challenge$$, 1,
$$화면에 "Hello, World!"은 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-pattern-triangle$$, $$typescript$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-integer-variable$$, $$typescript$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42은 저장한 후 출력하세요.$$,
$$- int 타삽입을 사용하세요\n- %d은 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-bit-operations$$, $$typescript$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$트 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-addition$$, $$typescript$$, $$basics$$, 11, $$덧셈 계산$$, $$트 수의 합 구하기$$, $$challenge$$, 1,
$$트 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-compound-interest$$, $$typescript$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소개수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-if-positive$$, $$typescript$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"은 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$#include <stdio.h>

int main() {
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-leap-year$$, $$typescript$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <stdio.h>

int main() {
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-for-1-to-10$$, $$typescript$$, $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자은 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-fibonacci$$, $$typescript$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-function-add$$, $$typescript$$, $$basics$$, 26, $$덧셈 함수$$, $$트 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$트 정수은 삽입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-factorial-function$$, $$typescript$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-array-declare$$, $$typescript$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소개를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-bubble-sort$$, $$typescript$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수은 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소개를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-pointer-address$$, $$typescript$$, $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-pointer-arithmetic$$, $$typescript$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-scanf-int$$, $$typescript$$, $$basics$$, 41, $$정수 삽입력받기$$, $$scanf로 정수 삽입력받기$$, $$challenge$$, 1,
$$정수 하나은 삽입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-file-write$$, $$typescript$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <stdio.h>

int main() {
    char str[100];


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-struct-declare$$, $$typescript$$, $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)은 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-string-reverse$$, $$typescript$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-hello-world$$, $$python$$, $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성$$, $$challenge$$, 1,
$$화면에 "Hello, World!"은 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    print("Hello, World!")
$func$,
$$[{"input": "", "expected": "Hello, World!\n"}]$$,
$$["printf 함수의 사용법을 확인하세요", "문자열은 큰따옴표로 감싸야 합니다"]$$,
$$["basics", "output", "printf"]$$, 5),

($$python-print-name$$, $$python$$, $$syntax$$, 2, $$이름 출력하기$$, $$자신의 이름을 출력하세요$$, $$challenge$$, 1,
$$화면에 "My name is [이름]" 형식으로 출력하는 프로그램을 작성하세요.$$,
$$- [이름] 부분에는 원하는 이름을 넣으세요\n- 줄바꿈을 포함해야 합니다$$,
$$[{"input": "", "output": "My name is John"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    print("My name is John")
$func$,
$$[{"input": "", "expected": "My name is John\n"}]$$,
$$["printf로 문자열을 출력할 수 있습니다"]$$,
$$["basics", "output"]$$, 5),

($$python-multiline-output$$, $$python$$, $$syntax$$, 3, $$여러 줄 출력$$, $$여러 줄을 출력하세요$$, $$challenge$$, 1,
$$다음 세 줄을 출력하는 프로그램을 작성하세요:\nLine 1\nLine 2\nLine 3$$,
$$- 각 줄은 새로운 줄에 출력되어야 합니다$$,
$$[{"input": "", "output": "Line 1\nLine 2\nLine 3"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    print("Line 1")
    print("Line 2")
    print("Line 3")
$func$,
$$[{"input": "", "expected": "Line 1\nLine 2\nLine 3\n"}]$$,
$$["printf은 여러 번 호출하거나 \\n을 사용하세요"]$$,
$$["basics", "output"]$$, 5),

($$python-single-line-comment$$, $$python$$, $$syntax$$, 4, $$한 줄 주석$$, $$주석을 사용하여 코드 설명하기$$, $$challenge$$, 1,
$$Hello은 출력하는 코드를 작성하고, 태그 위에 한 줄 주석으로 "이것은 출력 코드삽입니다"은 추가하세요.$$,
$$- // 은 사용하여 주석을 작성하세요$$,
$$[{"input": "", "output": "Hello"}]$$,
$func$
    // 여기에 주석과 코드를 작성하세요

$func$,
$func$
    // 이것은 출력 코드삽입니다
    print("Hello")
$func$,
$$[{"input": "", "expected": "Hello\n"}]$$,
$$["// 뒤의 내용를 실행되지 않습니다"]$$,
$$["basics", "comments"]$$, 5),

($$python-multi-line-comment$$, $$python$$, $$syntax$$, 5, $$여러 줄 주석$$, $$여러 줄 주석 사용하기$$, $$challenge$$, 1,
$$World은 출력하는 코드를 작성하고, 태그 위에 여러 줄 주석으로 프로그램 설명을 추가하세요.$$,
$$- /* */ 은 사용하여 주석을 작성하세요$$,
$$[{"input": "", "output": "World"}]$$,
$func$
    /* 여기에 주석과 코드를 작성하세요 */

$func$,
$func$
    /*
     * 이 프로그램은 World은 출력합니다
     * C 언어 기초 학습사용삽입니다
     */
    print("World")
$func$,
$$[{"input": "", "expected": "World\n"}]$$,
$$["/* */ 사이의 내용은 모트 주석삽입니다"]$$,
$$["basics", "comments"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-pattern-triangle$$, $$python$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$
    int n;


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-integer-variable$$, $$python$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42은 저장한 후 출력하세요.$$,
$$- int 타삽입을 사용하세요\n- %d은 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    int num = 42;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-bit-operations$$, $$python$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$트 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-addition$$, $$python$$, $$basics$$, 11, $$덧셈 계산$$, $$트 수의 합 구하기$$, $$challenge$$, 1,
$$트 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-compound-interest$$, $$python$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소개수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-if-positive$$, $$python$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"은 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-leap-year$$, $$python$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-for-1-to-10$$, $$python$$, $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자은 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    for (int i = 1;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-fibonacci$$, $$python$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-function-add$$, $$python$$, $$basics$$, 26, $$덧셈 함수$$, $$트 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$트 정수은 삽입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-factorial-function$$, $$python$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;



-- ============================================================================
-- Unit 7 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-array-declare$$, $$python$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소개를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    int arr[5] = {1, 2, 3, 4, 5};

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-bubble-sort$$, $$python$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수은 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소개를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-pointer-address$$, $$python$$, $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-pointer-arithmetic$$, $$python$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-scanf-int$$, $$python$$, $$basics$$, 41, $$정수 삽입력받기$$, $$scanf로 정수 삽입력받기$$, $$challenge$$, 1,
$$정수 하나은 삽입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-file-write$$, $$python$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$
    char str[100];


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-struct-declare$$, $$python$$, $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)은 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-string-reverse$$, $$python$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-hello-world$$, $$dart$$, $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성$$, $$challenge$$, 1,
$$화면에 "Hello, World!"은 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-pattern-triangle$$, $$dart$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-integer-variable$$, $$dart$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42은 저장한 후 출력하세요.$$,
$$- int 타삽입을 사용하세요\n- %d은 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-bit-operations$$, $$dart$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$트 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-addition$$, $$dart$$, $$basics$$, 11, $$덧셈 계산$$, $$트 수의 합 구하기$$, $$challenge$$, 1,
$$트 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-compound-interest$$, $$dart$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소개수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-if-positive$$, $$dart$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"은 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$#include <stdio.h>

int main() {
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-leap-year$$, $$dart$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <stdio.h>

int main() {
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-for-1-to-10$$, $$dart$$, $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자은 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-fibonacci$$, $$dart$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-function-add$$, $$dart$$, $$basics$$, 26, $$덧셈 함수$$, $$트 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$트 정수은 삽입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-factorial-function$$, $$dart$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-array-declare$$, $$dart$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소개를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-bubble-sort$$, $$dart$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수은 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소개를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-pointer-address$$, $$dart$$, $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-pointer-arithmetic$$, $$dart$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-scanf-int$$, $$dart$$, $$basics$$, 41, $$정수 삽입력받기$$, $$scanf로 정수 삽입력받기$$, $$challenge$$, 1,
$$정수 하나은 삽입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-file-write$$, $$dart$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <stdio.h>

int main() {
    char str[100];


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-struct-declare$$, $$dart$$, $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)은 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-string-reverse$$, $$dart$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-hello-world$$, $$kotlin$$, $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성$$, $$challenge$$, 1,
$$화면에 "Hello, World!"은 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-pattern-triangle$$, $$kotlin$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-integer-variable$$, $$kotlin$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42은 저장한 후 출력하세요.$$,
$$- int 타삽입을 사용하세요\n- %d은 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-bit-operations$$, $$kotlin$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$트 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-addition$$, $$kotlin$$, $$basics$$, 11, $$덧셈 계산$$, $$트 수의 합 구하기$$, $$challenge$$, 1,
$$트 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-compound-interest$$, $$kotlin$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소개수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-if-positive$$, $$kotlin$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"은 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$#include <stdio.h>

int main() {
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-leap-year$$, $$kotlin$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <stdio.h>

int main() {
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-for-1-to-10$$, $$kotlin$$, $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자은 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-fibonacci$$, $$kotlin$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-function-add$$, $$kotlin$$, $$basics$$, 26, $$덧셈 함수$$, $$트 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$트 정수은 삽입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-factorial-function$$, $$kotlin$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-array-declare$$, $$kotlin$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소개를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-bubble-sort$$, $$kotlin$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수은 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소개를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-pointer-address$$, $$kotlin$$, $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-pointer-arithmetic$$, $$kotlin$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-scanf-int$$, $$kotlin$$, $$basics$$, 41, $$정수 삽입력받기$$, $$scanf로 정수 삽입력받기$$, $$challenge$$, 1,
$$정수 하나은 삽입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-file-write$$, $$kotlin$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <stdio.h>

int main() {
    char str[100];


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-struct-declare$$, $$kotlin$$, $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)은 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-string-reverse$$, $$kotlin$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-hello-world$$, $$csharp$$, $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성$$, $$challenge$$, 1,
$$화면에 "Hello, World!"은 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-pattern-triangle$$, $$csharp$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-integer-variable$$, $$csharp$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42은 저장한 후 출력하세요.$$,
$$- int 타삽입을 사용하세요\n- %d은 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-bit-operations$$, $$csharp$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$트 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-addition$$, $$csharp$$, $$basics$$, 11, $$덧셈 계산$$, $$트 수의 합 구하기$$, $$challenge$$, 1,
$$트 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-compound-interest$$, $$csharp$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소개수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-if-positive$$, $$csharp$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"은 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$#include <stdio.h>

int main() {
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-leap-year$$, $$csharp$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <stdio.h>

int main() {
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-for-1-to-10$$, $$csharp$$, $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자은 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-fibonacci$$, $$csharp$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-function-add$$, $$csharp$$, $$basics$$, 26, $$덧셈 함수$$, $$트 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$트 정수은 삽입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-factorial-function$$, $$csharp$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-array-declare$$, $$csharp$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소개를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-bubble-sort$$, $$csharp$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수은 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소개를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-pointer-address$$, $$csharp$$, $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-pointer-arithmetic$$, $$csharp$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-scanf-int$$, $$csharp$$, $$basics$$, 41, $$정수 삽입력받기$$, $$scanf로 정수 삽입력받기$$, $$challenge$$, 1,
$$정수 하나은 삽입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-file-write$$, $$csharp$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <stdio.h>

int main() {
    char str[100];


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-struct-declare$$, $$csharp$$, $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)은 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-string-reverse$$, $$csharp$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-hello-world$$, $$java$$, $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성$$, $$challenge$$, 1,
$$화면에 "Hello, World!"은 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-pattern-triangle$$, $$java$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-integer-variable$$, $$java$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42은 저장한 후 출력하세요.$$,
$$- int 타삽입을 사용하세요\n- %d은 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-bit-operations$$, $$java$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$트 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-addition$$, $$java$$, $$basics$$, 11, $$덧셈 계산$$, $$트 수의 합 구하기$$, $$challenge$$, 1,
$$트 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-compound-interest$$, $$java$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소개수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-if-positive$$, $$java$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"은 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$#include <stdio.h>

int main() {
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-leap-year$$, $$java$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <stdio.h>

int main() {
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-for-1-to-10$$, $$java$$, $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자은 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-fibonacci$$, $$java$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-function-add$$, $$java$$, $$basics$$, 26, $$덧셈 함수$$, $$트 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$트 정수은 삽입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-factorial-function$$, $$java$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-array-declare$$, $$java$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소개를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-bubble-sort$$, $$java$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수은 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소개를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-pointer-address$$, $$java$$, $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-pointer-arithmetic$$, $$java$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-scanf-int$$, $$java$$, $$basics$$, 41, $$정수 삽입력받기$$, $$scanf로 정수 삽입력받기$$, $$challenge$$, 1,
$$정수 하나은 삽입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-file-write$$, $$java$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <stdio.h>

int main() {
    char str[100];


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-struct-declare$$, $$java$$, $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)은 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-string-reverse$$, $$java$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-hello-world$$, $$go$$, $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성$$, $$challenge$$, 1,
$$화면에 "Hello, World!"은 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-pattern-triangle$$, $$go$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-integer-variable$$, $$go$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42은 저장한 후 출력하세요.$$,
$$- int 타삽입을 사용하세요\n- %d은 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-bit-operations$$, $$go$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$트 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-addition$$, $$go$$, $$basics$$, 11, $$덧셈 계산$$, $$트 수의 합 구하기$$, $$challenge$$, 1,
$$트 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-compound-interest$$, $$go$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소개수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-if-positive$$, $$go$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"은 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$#include <stdio.h>

int main() {
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-leap-year$$, $$go$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <stdio.h>

int main() {
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-for-1-to-10$$, $$go$$, $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자은 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-fibonacci$$, $$go$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-function-add$$, $$go$$, $$basics$$, 26, $$덧셈 함수$$, $$트 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$트 정수은 삽입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-factorial-function$$, $$go$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-array-declare$$, $$go$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소개를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-bubble-sort$$, $$go$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수은 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소개를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-pointer-address$$, $$go$$, $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-pointer-arithmetic$$, $$go$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-scanf-int$$, $$go$$, $$basics$$, 41, $$정수 삽입력받기$$, $$scanf로 정수 삽입력받기$$, $$challenge$$, 1,
$$정수 하나은 삽입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-file-write$$, $$go$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <stdio.h>

int main() {
    char str[100];


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-struct-declare$$, $$go$$, $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)은 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-string-reverse$$, $$go$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-hello-world$$, 'c', $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성$$, $$challenge$$, 1,
$$화면에 "Hello, World!"은 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pattern-triangle$$, 'c', $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-integer-variable$$, 'c', $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42은 저장한 후 출력하세요.$$,
$$- int 타삽입을 사용하세요\n- %d은 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-bit-operations$$, 'c', $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$트 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-addition$$, 'c', $$basics$$, 11, $$덧셈 계산$$, $$트 수의 합 구하기$$, $$challenge$$, 1,
$$트 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-compound-interest$$, 'c', $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소개수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-if-positive$$, 'c', $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"은 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$#include <stdio.h>

int main() {
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-leap-year$$, 'c', $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <stdio.h>

int main() {
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-for-1-to-10$$, 'c', $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자은 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-fibonacci$$, $$c$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-function-add$$, 'c', $$basics$$, 26, $$덧셈 함수$$, $$트 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$트 정수은 삽입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-factorial-function$$, $$c$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-array-declare$$, 'c', $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소개를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-bubble-sort$$, $$c$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수은 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소개를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pointer-address$$, 'c', $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pointer-arithmetic$$, $$c$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-scanf-int$$, 'c', $$basics$$, 41, $$정수 삽입력받기$$, $$scanf로 정수 삽입력받기$$, $$challenge$$, 1,
$$정수 하나은 삽입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-file-write$$, $$c$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <stdio.h>

int main() {
    char str[100];


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-struct-declare$$, 'c', $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)은 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-string-reverse$$, $$c$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-hello-world$$, $$cpp$$, $$syntax$$, 1, $$Hello World$$, $$C++로 첫 프로그램 작성$$, $$challenge$$, 1,
$$화면에 "Hello, World!"은 출력하는 프로그램을 작성하세요.$$,
$$- cout을 사용하세요\n- endl 또는 \n으로 줄바꿈$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pattern-triangle$$, $$cpp$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-int-variable$$, $$cpp$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언과 출력$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 100을 저장한 후 출력하세요.$$,
$$- int 타삽입 사용$$,
$$[{"input": "", "output": "100"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-bit-operations$$, $$cpp$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$트 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-arithmetic$$, $$cpp$$, $$basics$$, 11, $$사칙연산$$, $$기본 산술 연산하기$$, $$challenge$$, 1,
$$트 정수 a=20, b=3의 덧셈, 뺄셈, 곱셈, 나눗셈 결과은 각 줄에 출력하세요.$$,
$$- +, -, *, / 연산자 사용$$,
$$[{"input": "", "output": "23\n17\n60\n6"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-compound-interest$$, $$cpp$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소개수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-if-positive$$, $$cpp$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인$$, $$challenge$$, 1,
$$정수 num을 삽입력받아 양수이면 "Positive"은 출력하세요.$$,
$$- if 문 사용$$,
$$[{"input": "10", "output": "Positive"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-leap-year$$, $$cpp$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-for-loop$$, $$cpp$$, $$basics$$, 21, $$for 반복문$$, $$1부터 10까지 출력$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지 출력하세요.$$,
$$- for 문 사용$$,
$$[{"input": "", "output": "1 2 3 4 5 6 7 8 9 10"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-fibonacci$$, $$cpp$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-function-add$$, $$cpp$$, $$basics$$, 26, $$덧셈 함수$$, $$트 수를 더하는 함수$$, $$challenge$$, 1,
$$트 정수를 더하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b)$$,
$$[{"input": "5 7", "output": "12"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-factorial-function$$, $$cpp$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-array-declare$$, $$cpp$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언과 초기화$$, $$challenge$$, 1,
$$크기 5인 정수 배열을 {1,2,3,4,5}로 초기화하고 모든 요소개를 출력하세요.$$,
$$- int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-bubble-sort$$, $$cpp$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수은 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소개를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-vector-declare$$, $$cpp$$, $$basics$$, 36, $$벡터 선언$$, $$vector 사용하기$$, $$challenge$$, 1,
$$정수 벡터를 선언하고 {1,2,3,4,5}로 초기화한 후 출력하세요.$$,
$$- vector<int> 사용$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <iostream>
#include <vector>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pointer-arithmetic$$, $$cpp$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-string-input$$, $$cpp$$, $$basics$$, 41, $$문자열 삽입력$$, $$문자열 삽입력받기$$, $$challenge$$, 1,
$$문자열을 삽입력받아 그대로 출력하세요.$$,
$$- cin 또는 getline 사용$$,
$$[{"input": "Hello", "output": "Hello"}]$$,
$func$#include <iostream>
#include <string>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-file-write$$, $$cpp$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-class-declare$$, $$cpp$$, $$basics$$, 46, $$클래스 선언$$, $$간단한 클래스 만들기$$, $$challenge$$, 1,
$$정수 멤버 변수 x은 가진 Point 클래스를 정의하고 값을 출력하세요.$$,
$$- class 키워드 사용$$,
$$[{"input": "", "output": "10"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-string-reverse$$, $$cpp$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 삽입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-select-all$$, 'sql', 'syntax', 1, $$모든 이트조회$$, $$SELECT * 사용기$$, 'challenge', 1,
$$users 이블의 모든 이기본 조회세트$$,
$$- SELECT * FROM 이블명$$,
$$[{"input": "", "output": "모든 과 트}]$$,
$$-- users 이블에트모든 이기본 조회세트$$,
'SELECT * FROM users;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-right-join$$, 'sql', 'syntax', 51, $$RIGHT JOIN 사용$$, $$른기본이기본기기본 조인$$, 'challenge', 2,
$$departments 이블을 기기본로 employees RIGHT JOIN여 부명기본직원명을 조회세트$$,
$$- RIGHT JOIN 사용\n- 부기본 기본직원트는 경우트함$$,
$$[{"input": "", "output": "부명, 직원기본NULL 함)"}]$$,
$$-- departments employees기본RIGHT JOIN세트n$$,
'SELECT d.dept_name, e.emp_name\nFROM employees e\nRIGHT JOIN departments d ON e.dept_id = d.dept_id;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-where-equal$$, 'sql', 'basics', 6, $$같음 조건$$, $$= 산트사용$$, 'challenge', 1,
$$users 이블에트city가 "Seoul"트사용기본 조회세트$$,
'- WHERE 컬럼 = 기본,
$$[{"input": "", "output": "city가 Seoul트들"}]$$,
$$-- city가 "Seoul"트사용기본 조회세트$$,
'SELECT * FROM users WHERE city = ''Seoul'';

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-correlated-subquery$$, 'sql', 'syntax', 56, $$기본 브쿼리$$, $$기본 쿼리 �트?브쿼리$$, 'challenge', 2,
$$기본부별기본균 급여보다 기본 급여기본받는 직원트조회세트$$,
$$- 기본 브쿼리 사용\n- 기본 쿼리트dept_id기본브쿼리서 참조$$,
$$[{"input": "", "output": "직원기본 급여, 부ID"}]$$,
$$-- 부별 균보다 기본 급여기본받는 직원 조회\n$$,
'SELECT emp_name, salary, dept_id\nFROM employees e1\nWHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e2.dept_id = e1.dept_id);



-- ============================================================================
-- Unit 3 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-order-asc$$, 'sql', 'basics', 11, $$름차순 렬$$, $$ASC기본렬$$, 'challenge', 1,
$$users 이블을 name 기기본 름차순로 조회세트$$,
'- ORDER BY 컬럼 ASC',
$$[{"input": "", "output": "name 름차순"}]$$,
$$-- name 기기본 름차순로 조회세트$$,
'SELECT * FROM users ORDER BY name ASC;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-union$$, 'sql', 'syntax', 61, $$UNION 사용$$, $$중복 거 집트, $$challenge', 2,
$$2023트주문기본2024트주문트고객 목록으로중복 이 조회세트$$,
$$- UNION 사용\n- 중복 동 거$$,
$$[{"input": "", "output": "고객ID (중복 거)"}]$$,
$$-- 2023과 2024트주문 고객트UNION로 조회\n$$,
'SELECT customer_id FROM orders WHERE YEAR(order_date) = 2023\nUNION\nSELECT customer_id FROM orders WHERE YEAR(order_date) = 2024;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-count$$, 'sql', 'basics', 16, $$트개수 기$$, $$COUNT 수$$, 'challenge', 1,
$$users 이블의 체 트개수기본조회세트$$,
$$- COUNT(*) 는 COUNT(컬럼)$$,
'[{"input": "", "output": "트개수"}]',
$$-- users 이블의 트개수기본조회세트$$,
'SELECT COUNT(*) FROM users;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-row-number$$, 'sql', 'syntax', 66, $$ROW_NUMBER 수$$, $$트번호 부트, $$challenge', 2,
$$기본부별기본급여 으기본위기본매기요.$$,
$$- ROW_NUMBER() OVER 사용\n- PARTITION BY ORDER BY$$,
$$[{"input": "", "output": "직원기본 부트 급여, 위"}]$$,
$$-- ROW_NUMBER기본부별 급여 위기본매기요\n$$,
'SELECT emp_name, dept_id, salary,\n  ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rank\nFROM employees;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-group-count$$, 'sql', 'basics', 21, $$그룹기본개수$$, $$GROUP BY기본그룹트, $$challenge', 1,
$$users 이블에트city기본사용트기본 조회세트$$,
'- GROUP BY 컬럼',
'[{"input": "", "output": "city기본count"}]',
$$-- city기본사용트기본 조회세트$$,
'SELECT city, COUNT(*) FROM users GROUP BY city;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-simple-cte$$, 'sql', 'syntax', 71, $$기본 CTE$$, $$WITH 트사용$$, 'challenge', 2,
$$WITH 을 사용여 부별 균 급여기본구하기본 기본결과기본시 사용세트$$,
$$- WITH ... AS (...) 사용\n- CTE기본SELECT서 참조$$,
$$[{"input": "", "output": "부ID, 균급여"}]$$,
$$-- WITH 로 CTE기본만드요\n$$,
'WITH dept_avg AS (\n  SELECT dept_id, AVG(salary) AS avg_salary\n  FROM employees\n  GROUP BY dept_id\n)\nSELECT * FROM dept_avg WHERE avg_salary >= 5000000;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-having-count$$, 'sql', 'basics', 26, $$HAVING로 터$$, $$그룹 조건$$, 'challenge', 1,
$$users 이블에트사용기본 3기본상트city기본조회세트$$,
'- HAVING COUNT(*) >= 3',
$$[{"input": "", "output": "3기본상트city"}]$$,
$$-- 사용기본 3기본상트city기본조회세트$$,
'SELECT city, COUNT(*) FROM users GROUP BY city HAVING COUNT(*) >= 3;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-simple-case$$, 'sql', 'syntax', 76, $$CASE WHEN 기본$$, $$조건부 기본반환$$, 'challenge', 2,
$$급여 구간트라 급트부하요 (5백만 상: A, 3백만 상: B, 머지: C).$$,
$$- CASE WHEN ... THEN ... END\n- 러 조건 분기$$,
$$[{"input": "", "output": "직원기본 급여, 급"}]$$,
$$-- CASE WHEN로 급여 급트부하요\n$$,
'SELECT emp_name, salary,\n  CASE\n    WHEN salary >= 5000000 THEN \''A\''\n    WHEN salary >= 3000000 THEN \''B\''\n    ELSE \''C\''\n  END AS grade\nFROM employees;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-inner-join$$, 'sql', 'basics', 31, $$INNER JOIN$$, $$기본 조인$$, 'challenge', 1,
$$users orders기본user_id기본조인여 조회세트$$,
'- INNER JOIN ... ON',
'[{"input": "", "output": "조인트결과"}]',
$$-- users orders기본user_id기본조인세트$$,
'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-string-manipulation$$, 'sql', 'syntax', 81, $$문자트가기본, $$CONCAT, SUBSTRING 트, 'challenge', 3,
$$메트주소서 메트부분만 추출고, 문자기본변하요.$$,
$$- SUBSTRING, POSITION, UPPER 사용\n- @ 후 문자트추출$$,
$$[{"input": "", "output": "메트 메트}]$$,
$$-- 메에트메을 추출고 문자기본변하요\n$$,
'SELECT email,\n  UPPER(SUBSTRING(email FROM POSITION(\''@\'' IN email) + 1)) AS domain\nFROM users;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-subquery-where$$, 'sql', 'basics', 36, $$WHERE 브쿼리$$, $$조건트브쿼리$$, 'challenge', 1,
$$products서 균 가격보트비싼 품트조회세트$$,
'- WHERE 컬럼 > (SELECT ...)',
$$[{"input": "", "output": "균 상 품"}]$$,
$$-- 균 가격보트비싼 품트조회세트$$,
'SELECT * FROM products WHERE price > (SELECT AVG(price) FROM products);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-date-calculation$$, 'sql', 'syntax', 86, $$짜 계산$$, $$짜 산$$, 'challenge', 3,
$$기본주문로부트30트트짜 기본 수기본계산세트$$,
$$- DATE_ADD, DATEDIFF 사용\n- CURRENT_DATE 비교$$,
$$[{"input": "", "output": "주문트 만료트 기본수"}]$$,
$$-- 주문로부트30트기본 기본 수기본계산세트n$$,
'SELECT order_date,\n  order_date + INTERVAL \''30 days\'' AS expiry_date,\n  (order_date + INTERVAL \''30 days\'') - CURRENT_DATE AS days_left\nFROM orders;


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-insert-basic$$, 'sql', 'basics', 41, $$이트삽입$$, 'INSERT INTO', 'challenge', 1,
$$users 이블에 (name="John", age=25, city="Seoul") 이기본 삽입세트$$,
'- INSERT INTO ... VALUES',
'[{"input": "", "output": "1 row inserted"}]',
$$-- users트John, 25, Seoul트삽입세트$$,
'INSERT INTO users (name, age, city) VALUES (''John'', 25, ''Seoul'');

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-json-extract$$, 'sql', 'syntax', 91, $$JSON 이트추출$$, $$JSON 드 근$$, 'challenge', 3,
$$JSON 컬럼서 정 의 값을 추출세트$$,
'- -> 는 ->> 산트사용\n- JSON 경로 지트,
$$[{"input": "", "output": "ID, 름(JSON서 추출)"}]$$,
$$-- JSON 컬럼서 name 기본 추출세트n$$,
'SELECT id, data->>\''name\'' AS name\nFROM users;


INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-create-table$$, 'sql', 'basics', 46, $$이기본성$$, 'CREATE TABLE', 'challenge', 1,
$$id(INT), name(VARCHAR), age(INT) 컬럼트가기본students 이블을 성세트$$,
'- CREATE TABLE ... (...)',
'[{"input": "", "output": "table created"}]',
$$-- students 이블을 성세트$$,
'CREATE TABLE students (id INT, name VARCHAR(100), age INT);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-upsert$$, 'sql', 'syntax', 96, $$UPSERT 구현$$, 'INSERT ON CONFLICT', 'challenge', 3,
$$존재면 UPDATE, 으기본INSERT는 UPSERT기본구현세트$$,
$$- INSERT ... ON CONFLICT 사용\n- DO UPDATE SET$$,
'[{"input": "", "output": "처리트트}]',
$$-- UPSERT기본구현세트n$$,
'INSERT INTO products (id, name, price)\nVALUES (1, \''Product A\'', 1000)\nON CONFLICT (id)\nDO UPDATE SET\n  name = EXCLUDED.name,\n  price = EXCLUDED.price;


