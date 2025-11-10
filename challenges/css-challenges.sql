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
($$css-element-selector$$, $$css$$, $$syntax$$, 1, $$요소 선택자$$, $$태그 이름으로 선택$$, $$challenge$$, 1,
$$모든 p 태그의 글자색을 파란색으로 만드세요.$$,
$$- 요소 선택자 사용\n- color 속성$$,
$$[{"input": "", "output": "파란색 문단"}]$$,
$$/* 모든 p 태그를 파란색으로 */\n$$,
$$p {\n    color: blue;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-flex-wrap$$, $$css$$, $$syntax$$, 51, $$Flex 줄바꿈$$, $$flex-wrap$$, $$challenge$$, 2,
$$아이템이 넘치면 다음 줄로 넘기세요.$$,
$$- flex-wrap: wrap\n- 여러 줄 허용$$,
$$[{"input": "", "output": "줄바꿈 flex"}]$$,
$$.container {\n    display: flex;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-element-selector', 'css', 'syntax', 1, '?�소 ?�택??, '?�그 ?�름?�로 ?�택', 'challenge', 1,
'모든 p ?�그??글?�색???��??�으�?만드?�요.',
'- ?�소 ?�택???�용\n- color ?�성',
'[{"input": "", "output": "?��???문단"}]',
'/* 모든 p ?�그�??��??�으�?*/\n',
'p {\n    color: blue;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-flex-wrap', 'css', 'syntax', 51, 'Flex 줄바�?, 'flex-wrap', 'challenge', 2,
'?�이?�이 ?�치�??�음 줄로 ?�기?�요.',
'- flex-wrap: wrap\n- ?�러 �??�용',
'[{"input": "", "output": "줄바�?flex"}]',
'.container {\n    display: flex;


-- ============================================================================
-- Unit 2 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-color-name$$, $$css$$, $$syntax$$, 6, $$색상 이름$$, $$기본 색상명 사용$$, $$challenge$$, 1,
$$글자색을 red로 설정하세요.$$,
$$- color 속성\n- 색상 이름 사용$$,
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
('css-color-name', 'css', 'syntax', 6, '?�상 ?�름', '기본 ?�상�??�용', 'challenge', 1,
'글?�색??red�??�정?�세??',
'- color ?�성\n- ?�상 ?�름 ?�용',
'[{"input": "", "output": "빨간 글??}]',
$/* CSS */
.text {\n    /* 빨간?�으�?*/\n}',
'.text {\n    color: red;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-grid-container', 'css', 'syntax', 56, 'Grid 컨테?�너', 'display: grid', 'challenge', 2,
'Grid ?�이?�웃???�성?�하?�요.',
'- display: grid\n- grid 컨테?�너 ?�성',
'[{"input": "", "output": "grid 컨테?�너"}]',
'.container {\n    /* grid ?�성??*/\n}',
'.container {\n    display: grid;


-- ============================================================================
-- Unit 3 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-font-family$$, $$css$$, $$syntax$$, 11, $$글꼴 설정$$, $$font-family$$, $$challenge$$, 1,
$$글꼴을 Arial, sans-serif로 설정하세요.$$,
$$- font-family 속성\n- 폴백 글꼴 포함$$,
$$[{"input": "", "output": "Arial 글꼴"}]$$,
$$body {\n    /* 글꼴 설정 */\n}$$,
$$body {\n    font-family: Arial, sans-serif;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-transform-rotate$$, $$css$$, $$syntax$$, 61, $$회전 변형$$, $$transform: rotate$$, $$challenge$$, 2,
$$요소를 45도 회전하세요.$$,
$$- transform: rotate(45deg)\n- 회전 변환$$,
$$[{"input": "", "output": "45도 회전"}]$$,
$$.rotated {\n    /* 45도 회전 */\n}$$,
$$.rotated {\n    transform: rotate(45deg);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-font-family', 'css', 'syntax', 11, '글�??�정', 'font-family', 'challenge', 1,
'글꼴을 Arial, sans-serif�??�정?�세??',
'- font-family ?�성\n- ?�백 글�??�함',
'[{"input": "", "output": "Arial 글�?}]',
'body {\n    /* 글�??�정 */\n}',
'body {\n    font-family: Arial, sans-serif;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-transform-rotate', 'css', 'syntax', 61, '?�전 변??, 'transform: rotate', 'challenge', 2,
'?�소�?45???�전?�세??',
'- transform: rotate(45deg)\n- ?�전 변??,
'[{"input": "", "output": "45???�전"}]',
'.rotated {\n    /* 45???�전 */\n}',
'.rotated {\n    transform: rotate(45deg);


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
$$화면이 768px 이하일 때 글자 크기를 14px로 변경하세요.$$,
$$- @media (max-width: 768px)\n- 반응형 중단점$$,
$$[{"input": "", "output": "모바일 글자 크기"}]$$,
$$body {\n    font-size: 16px;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-width-height', 'css', 'syntax', 16, '?�비?� ?�이', 'width, height', 'challenge', 1,
'박스???�비 200px, ?�이 100px�??�정?�세??',
'- width: 200px\n- height: 100px',
'[{"input": "", "output": "200x100 박스"}]',
$/* CSS */
.box {\n    /* ?�비?� ?�이 */\n}',
'.box {\n    width: 200px;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-media-query-basic', 'css', 'syntax', 66, '미디??쿼리', '@media', 'challenge', 2,
'?�면??768px ?�하????글???�기�?14px�?변경하?�요.',
'- @media (max-width: 768px)\n- 반응??중단??,
'[{"input": "", "output": "모바??글???�기"}]',
'body {\n    font-size: 16px;


-- ============================================================================
-- Unit 5 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-display-block$$, $$css$$, $$syntax$$, 21, $$block 디스플레이$$, $$display: block$$, $$challenge$$, 1,
$$인라인 요소를 블록으로 변경하세요.$$,
$$- display: block\n- 한 줄 차지$$,
$$[{"input": "", "output": "블록 요소"}]$$,
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
('css-display-block', 'css', 'syntax', 21, 'block ?�스?�레??, 'display: block', 'challenge', 1,
'?�라???�소�?블록?�로 변경하?�요.',
'- display: block\n- ??�?차�?',
'[{"input": "", "output": "블록 ?�소"}]',
'span {\n    /* 블록?�로 */\n}',
'span {\n    display: block;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-descendant-selector', 'css', 'syntax', 71, '?�손 ?�택??, '공백 ?�택??, 'challenge', 2,
'nav ?�의 모든 a ?�그�??�택?�세??',
'- 공백?�로 ?�손 ?�택\n- nav a',
'[{"input": "", "output": "nav 링크"}]',
'',
'nav a {\n    color: blue;


-- ============================================================================
-- Unit 6 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-flex-container$$, $$css$$, $$syntax$$, 26, $$Flex 컨테이너$$, $$display: flex$$, $$challenge$$, 1,
$$컨테이너를 flex로 만드세요.$$,
$$- display: flex\n- flex 레이아웃 활성화$$,
$$[{"input": "", "output": "flex 컨테이너"}]$$,
$$.container {\n    /* flex 활성화 */\n}$$,
$$.container {\n    display: flex;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-before$$, $$css$$, $$syntax$$, 76, $$::before 가상 요소$$, $$앞에 콘텐츠 추가$$, $$challenge$$, 3,
$$모든 링크 앞에 "→" 아이콘을 추가하세요.$$,
$$- ::before 가상 요소\n- content 속성$$,
$$[{"input": "", "output": "아이콘 추가"}]$$,
$$a {\n    /* before 추가 */\n}$$,
$$a::before {\n    content: "→ ";

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-flex-container', 'css', 'syntax', 26, 'Flex 컨테?�너', 'display: flex', 'challenge', 1,
'컨테?�너�?flex�?만드?�요.',
'- display: flex\n- flex ?�이?�웃 ?�성??,
'[{"input": "", "output": "flex 컨테?�너"}]',
$/* CSS */
.container {\n    /* flex ?�성??*/\n}',
'.container {\n    display: flex;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-before', 'css', 'syntax', 76, '::before 가???�소', '?�에 콘텐�?추�?', 'challenge', 3,
'모든 링크 ?�에 "?? ?�이콘을 추�??�세??',
'- ::before 가???�소\n- content ?�성',
'[{"input": "", "output": "?�이�?추�?"}]',
'a {\n    /* before 추�? */\n}',
'a::before {\n    content: "??";


-- ============================================================================
-- Unit 7 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-list-style-type$$, $$css$$, $$syntax$$, 31, $$리스트 스타일$$, $$list-style-type$$, $$challenge$$, 1,
$$리스트 마커를 사각형으로 변경하세요.$$,
$$- list-style-type: square\n- 리스트 불릿 스타일$$,
$$[{"input": "", "output": "사각형 마커"}]$$,
$$ul {\n    /* 사각형 마커 */\n}$$,
$$ul {\n    list-style-type: square;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-position-sticky$$, $$css$$, $$syntax$$, 81, $$Sticky 위치$$, $$position: sticky$$, $$challenge$$, 3,
$$스크롤 시 헤더를 상단에 고정하세요.$$,
$$- position: sticky\n- top: 0$$,
$$[{"input": "", "output": "고정 헤더"}]$$,
$$header {\n    /* sticky 위치 */\n}$$,
$$header {\n    position: sticky;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-list-style-type', 'css', 'syntax', 31, '리스???��???, 'list-style-type', 'challenge', 1,
'리스??마커�??�각?�으�?변경하?�요.',
'- list-style-type: square\n- 리스??불릿 ?��???,
'[{"input": "", "output": "?�각??마커"}]',
'ul {\n    /* ?�각??마커 */\n}',
'ul {\n    list-style-type: square;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-position-sticky', 'css', 'syntax', 81, 'Sticky ?�치', 'position: sticky', 'challenge', 3,
'?�크�????�더�??�단??고정?�세??',
'- position: sticky\n- top: 0',
'[{"input": "", "output": "고정 ?�더"}]',
'/* Code */
header {\n    /* sticky ?�치 */\n}',
'header {\n    position: sticky;


-- ============================================================================
-- Unit 8 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-hover$$, $$css$$, $$syntax$$, 36, $$호버 효과$$, $$:hover 가상 클래스$$, $$challenge$$, 1,
$$마우스를 올렸을 때 배경색을 파란색으로 변경하세요.$$,
$$- :hover 가상 클래스\n- 마우스 오버 상태$$,
$$[{"input": "", "output": "호버 시 파란 배경"}]$$,
$$button {\n    /* 호버 효과 */\n}$$,
$$button:hover {\n    background-color: blue;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-filter$$, $$css$$, $$syntax$$, 86, $$Filter 효과$$, $$filter 속성$$, $$challenge$$, 3,
$$이미지에 흐림 효과를 추가하세요.$$,
$$- filter: blur(5px)\n- 시각 효과$$,
$$[{"input": "", "output": "흐림 이미지"}]$$,
$$img {\n    /* 흐림 효과 */\n}$$,
$$img {\n    filter: blur(5px);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-hover', 'css', 'syntax', 36, '?�버 ?�과', ':hover 가???�래??, 'challenge', 1,
'마우?��? ?�렸????배경?�을 ?��??�으�?변경하?�요.',
'- :hover 가???�래??n- 마우???�버 ?�태',
'[{"input": "", "output": "?�버 ???��? 배경"}]',
'button {\n    /* ?�버 ?�과 */\n}',
'button:hover {\n    background-color: blue;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-filter', 'css', 'syntax', 86, 'Filter ?�과', 'filter ?�성', 'challenge', 3,
'?��?지???�림 ?�과�?추�??�세??',
'- filter: blur(5px)\n- ?�각 ?�과',
'[{"input": "", "output": "?�림 ?��?지"}]',
'/* Code */
img {\n    /* ?�림 ?�과 */\n}',
'img {\n    filter: blur(5px);


-- ============================================================================
-- Unit 9 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-percentage$$, $$css$$, $$syntax$$, 41, $$퍼센트 단위$$, $$% 크기$$, $$challenge$$, 1,
$$너비를 부모의 50%로 설정하세요.$$,
$$- width: 50%\n- 부모 기준 비율$$,
$$[{"input": "", "output": "50% 너비"}]$$,
$$.half {\n    /* 50% 너비 */\n}$$,
$$.half {\n    width: 50%;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-variables$$, $$css$$, $$syntax$$, 91, $$CSS 변수$$, $$커스텀 속성$$, $$challenge$$, 3,
$$CSS 변수로 메인 색상을 정의하고 사용하세요.$$,
$$- --변수명: 값\n- var(--변수명) 사용$$,
$$[{"input": "", "output": "CSS 변수"}]$$,
$$:root {\n    /* 변수 정의 */\n}\n\n.button {\n    /* 변수 사용 */\n}$$,
$func$:root {\n    --primary-color: #007bff;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-percentage', 'css', 'syntax', 41, '?�센???�위', '% ?�기', 'challenge', 1,
'?�비�?부모의 50%�??�정?�세??',
'- width: 50%\n- 부�?기�? 비율',
'[{"input": "", "output": "50% ?�비"}]',
$/* CSS */
.half {\n    /* 50% ?�비 */\n}',
'.half {\n    width: 50%;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-variables', 'css', 'syntax', 91, 'CSS 변??, '커스?� ?�성', 'challenge', 3,
'CSS 변?�로 메인 ?�상???�의?�고 ?�용?�세??',
'- --변?�명: �?n- var(--변?�명) ?�용',
'[{"input": "", "output": "CSS 변??}]',
':root {\n    /* 변???�의 */\n}\n\n.button {\n    /* 변???�용 */\n}',
':root {\n    --primary-color: #007bff;


-- ============================================================================
-- Unit 10 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-opacity$$, $$css$$, $$syntax$$, 46, $$투명도$$, $$opacity$$, $$challenge$$, 1,
$$요소를 50% 투명하게 만드세요.$$,
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
('css-opacity', 'css', 'syntax', 46, '?�명??, 'opacity', 'challenge', 1,
'?�소�?50% ?�명?�게 만드?�요.',
'- opacity: 0.5\n- 0(?�명) ~ 1(불투�?',
'[{"input": "", "output": "반투�?}]',
$/* CSS */
.transparent {\n    /* 50% ?�명??*/\n}',
'.transparent {\n    opacity: 0.5;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-subgrid', 'css', 'syntax', 96, 'Subgrid', '중첩 그리???�렬', 'challenge', 3,
'?�식 그리?��? 부�?그리???�인???�르�??�세??',
'- grid-template-columns: subgrid\n- 부�?그리???�속',
'[{"input": "", "output": "subgrid"}]',
'.child {\n    display: grid;

