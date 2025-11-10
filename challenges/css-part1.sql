-- ====================================
-- CSS Language Challenges - Part 1
-- Levels 1-50 (EASY 50�?
-- ====================================

-- Unit 1: 기본 ?�택?��? ?��???(5 problems - EASY)
INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-element-selector', 'css', 'syntax', 1, '?�소 ?�택??, '?�그 ?�름?�로 ?�택', 'challenge', 1,
'모든 p ?�그??글?�색???��??�으�?만드?�요.',
'- ?�소 ?�택???�용\n- color ?�성',
'[{"input": "", "output": "?��???문단"}]',
'/* 모든 p ?�그�??��??�으�?*/\n',
'p {\n    color: blue;\n}',
'[{"input": "", "expected": "p color blue"}]',
'["?�소 ?�택?�는 ?�그 ?�름??직접 ?�용?�니??]',
ARRAY['selector', 'basics'], 5),

('css-class-selector', 'css', 'syntax', 2, '?�래???�택??, '.?�로 ?�래???�택', 'challenge', 1,
'.highlight ?�래?�의 배경?�을 ?��??�으�?만드?�요.',
'- ?�래???�택??(.?�래?�명)\n- background-color ?�성',
'[{"input": "", "output": "?��? 배경"}]',
'/* .highlight ?�래???��???*/\n',
'.highlight {\n    background-color: yellow;\n}',
'[{"input": "", "expected": "highlight yellow bg"}]',
'["?�래???�택?�는 .?�로 ?�작?�니??]',
ARRAY['selector', 'class'], 5),

('css-id-selector', 'css', 'syntax', 3, 'ID ?�택??, '#?�로 ID ?�택', 'challenge', 1,
'#header ID??글???�기�?24px�?만드?�요.',
'- ID ?�택??(#?�이?�명)\n- font-size ?�성',
'[{"input": "", "output": "??글??}]',
'/* #header ID??글???�기 */\n',
'#header {\n    font-size: 24px;\n}',
'[{"input": "", "expected": "header 24px"}]',
'["ID ?�택?�는 #?�로 ?�작?�니??]',
ARRAY['selector', 'id'], 5),

('css-multiple-selectors', 'css', 'syntax', 4, '?�러 ?�택??, '?�표�?그룹??, 'challenge', 1,
'h1, h2, h3 ?�그??글?�색??검?�?�으�?만드?�요.',
'- ?�표�??�러 ?�택??그룹??n- color: black',
'[{"input": "", "output": "검?�???�목??}]',
'/* ?�러 ?�택??*/\n',
'h1, h2, h3 {\n    color: black;\n}',
'[{"input": "", "expected": "headings black"}]',
'["?�표�??�러 ?�택?�에 같�? ?��??�을 ?�용?????�습?�다"]',
ARRAY['selector', 'grouping'], 5),

('css-universal-selector', 'css', 'syntax', 5, '?�체 ?�택??, '* ?�택??, 'challenge', 1,
'모든 ?�소??margin??0?�로 리셋?�세??',
'- * ?�체 ?�택??n- margin: 0',
'[{"input": "", "output": "margin 리셋"}]',
'/* 모든 ?�소??margin ?�거 */\n',
'* {\n    margin: 0;\n}',
'[{"input": "", "expected": "all margin 0"}]',
'["* ?�택?�는 모든 ?�소�??�택?�니??]',
ARRAY['selector', 'universal'], 5);

-- Unit 2: ?�상�?배경 (5 problems - EASY)
INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-color-name', 'css', 'syntax', 6, '?�상 ?�름', '기본 ?�상�??�용', 'challenge', 1,
'글?�색??red�??�정?�세??',
'- color ?�성\n- ?�상 ?�름 ?�용',
'[{"input": "", "output": "빨간 글??}]',
$/* CSS */
.text {\n    /* 빨간?�으�?*/\n}',
'.text {\n    color: red;\n}',
'[{"input": "", "expected": "red text"}]',
'["CSS??140�??�상???�상 ?�름??지?�합?�다"]',
ARRAY['color', 'basics'], 5),

('css-color-hex', 'css', 'syntax', 7, 'HEX ?�상', '#RRGGBB ?�식', 'challenge', 1,
'배경?�을 HEX 코드 #FF5733?�로 ?�정?�세??',
'- background-color\n- #RRGGBB ?�식',
'[{"input": "", "output": "HEX 배경??}]',
$/* CSS */
.box {\n    /* HEX 배경??*/\n}',
'.box {\n    background-color: #FF5733;\n}',
'[{"input": "", "expected": "hex bg color"}]',
'["HEX 코드??#?�로 ?�작?�니??]',
ARRAY['color', 'hex'], 5),

('css-color-rgb', 'css', 'syntax', 8, 'RGB ?�상', 'rgb() ?�수', 'challenge', 1,
'글?�색??rgb(100, 150, 200)?�로 ?�정?�세??',
'- color ?�성\n- rgb(r, g, b) ?�식',
'[{"input": "", "output": "RGB 글?�색"}]',
$/* CSS */
.text {\n    /* RGB ?�상 */\n}',
'.text {\n    color: rgb(100, 150, 200);\n}',
'[{"input": "", "expected": "rgb color"}]',
'["RGB??0-255 범위??값을 ?�용?�니??]',
ARRAY['color', 'rgb'], 5),

('css-background-image', 'css', 'syntax', 9, '배경 ?��?지', 'background-image', 'challenge', 1,
'배경 ?��?지�??�정?�세??',
'- background-image: url()\n- ?��?지 경로',
'[{"input": "", "output": "배경 ?��?지"}]',
$/* CSS */
.banner {\n    /* 배경 ?��?지 */\n}',
'.banner {\n    background-image: url("background.jpg");\n}',
'[{"input": "", "expected": "bg image"}]',
'["url() ?�수�??��?지 경로�?지?�합?�다"]',
ARRAY['background', 'image'], 5),

('css-background-repeat', 'css', 'syntax', 10, '배경 반복', 'background-repeat', 'challenge', 1,
'배경 ?��?지가 반복?��? ?�게 ?�세??',
'- background-repeat: no-repeat\n- ??번만 ?�시',
'[{"input": "", "output": "반복 ?�음"}]',
$/* CSS */
.box {\n    background-image: url("pattern.png");\n    /* 반복 방�? */\n}',
'.box {\n    background-image: url("pattern.png");\n    background-repeat: no-repeat;\n}',
'[{"input": "", "expected": "no-repeat"}]',
'["repeat, repeat-x, repeat-y, no-repeat 값을 ?�용?????�습?�다"]',
ARRAY['background', 'repeat'], 5);

-- Unit 3: ?�스???��???(5 problems - EASY)
INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-font-family', 'css', 'syntax', 11, '글�??�정', 'font-family', 'challenge', 1,
'글꼴을 Arial, sans-serif�??�정?�세??',
'- font-family ?�성\n- ?�백 글�??�함',
'[{"input": "", "output": "Arial 글�?}]',
'body {\n    /* 글�??�정 */\n}',
'body {\n    font-family: Arial, sans-serif;\n}',
'[{"input": "", "expected": "arial font"}]',
'["?�러 글꼴을 ?�열?�면 ?�백?�로 ?�작?�니??]',
ARRAY['text', 'font'], 5),

('css-font-size', 'css', 'syntax', 12, '글???�기', 'font-size', 'challenge', 1,
'글???�기�?16px�??�정?�세??',
'- font-size: 16px\n- px ?�위 ?�용',
'[{"input": "", "output": "16px 글??}]',
'p {\n    /* 글???�기 */\n}',
'p {\n    font-size: 16px;\n}',
'[{"input": "", "expected": "16px font"}]',
'["px, em, rem, % ???�양???�위�??�용?????�습?�다"]',
ARRAY['text', 'font-size'], 5),

('css-font-weight', 'css', 'syntax', 13, '글???�께', 'font-weight', 'challenge', 1,
'글?��? 굵게(bold) 만드?�요.',
'- font-weight: bold\n- ?�는 ?�자 700',
'[{"input": "", "output": "굵�? 글??}]',
'h1 {\n    /* 굵게 */\n}',
'h1 {\n    font-weight: bold;\n}',
'[{"input": "", "expected": "bold text"}]',
'["normal(400), bold(700) ?�는 100-900 ?�자�??�용?�니??]',
ARRAY['text', 'font-weight'], 5),

('css-text-align', 'css', 'syntax', 14, '?�스???�렬', 'text-align', 'challenge', 1,
'?�스?��? 가?�데 ?�렬?�세??',
'- text-align: center\n- 좌우 ?�렬',
'[{"input": "", "output": "중앙 ?�렬"}]',
$/* CSS */
.title {\n    /* 가?�데 ?�렬 */\n}',
'.title {\n    text-align: center;\n}',
'[{"input": "", "expected": "center aligned"}]',
'["left, center, right, justify 값을 ?�용?????�습?�다"]',
ARRAY['text', 'alignment'], 5),

('css-text-decoration', 'css', 'syntax', 15, '?�스???�식', 'text-decoration', 'challenge', 1,
'링크??밑줄???�거?�세??',
'- text-decoration: none\n- 밑줄 ?�거',
'[{"input": "", "output": "밑줄 ?�는 링크"}]',
'a {\n    /* 밑줄 ?�거 */\n}',
'a {\n    text-decoration: none;\n}',
'[{"input": "", "expected": "no underline"}]',
'["none, underline, overline, line-through 값을 ?�용?�니??]',
ARRAY['text', 'decoration'], 5);

-- Unit 4: 박스 모델 (5 problems - EASY)
INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-width-height', 'css', 'syntax', 16, '?�비?� ?�이', 'width, height', 'challenge', 1,
'박스???�비 200px, ?�이 100px�??�정?�세??',
'- width: 200px\n- height: 100px',
'[{"input": "", "output": "200x100 박스"}]',
$/* CSS */
.box {\n    /* ?�비?� ?�이 */\n}',
'.box {\n    width: 200px;\n    height: 100px;\n}',
'[{"input": "", "expected": "200x100 size"}]',
'["px, %, em, rem, vw, vh ?�의 ?�위�??�용?????�습?�다"]',
ARRAY['box-model', 'size'], 5),

('css-padding', 'css', 'syntax', 17, '?�쪽 ?�백', 'padding', 'challenge', 1,
'모든 방향??20px ?�딩??추�??�세??',
'- padding: 20px\n- ?�쪽 ?�백',
'[{"input": "", "output": "20px ?�딩"}]',
$/* CSS */
.box {\n    /* ?�딩 추�? */\n}',
'.box {\n    padding: 20px;\n}',
'[{"input": "", "expected": "20px padding"}]',
'["padding?� 콘텐츠�? ?�두�??�이 공간?�니??]',
ARRAY['box-model', 'padding'], 5),

('css-margin', 'css', 'syntax', 18, '바깥 ?�백', 'margin', 'challenge', 1,
'?�소�?가?�데 ?�렬?�기 ?�해 margin??auto�??�정?�세??',
'- margin: 0 auto\n- 좌우 ?�동 ?�백',
'[{"input": "", "output": "중앙 ?�렬"}]',
$/* CSS */
.container {\n    width: 800px;\n    /* 가?�데 ?�렬 */\n}',
'.container {\n    width: 800px;\n    margin: 0 auto;\n}',
'[{"input": "", "expected": "centered with margin"}]',
'["margin auto??block ?�소�?가?�데 ?�렬?�니??]',
ARRAY['box-model', 'margin'], 8),

('css-border', 'css', 'syntax', 19, '?�두�?, 'border', 'challenge', 1,
'2px ?�선 검?�???�두리�? 추�??�세??',
'- border: 2px solid black\n- ?�께 ?��????�상',
'[{"input": "", "output": "검?� ?�두�?}]',
$/* CSS */
.box {\n    /* ?�두�?*/\n}',
'.box {\n    border: 2px solid black;\n}',
'[{"input": "", "expected": "2px solid border"}]',
'["border??width, style, color ?�서�??�성?�니??]',
ARRAY['box-model', 'border'], 5),

('css-box-sizing', 'css', 'syntax', 20, 'box-sizing', 'border-box 모델', 'challenge', 1,
'box-sizing??border-box�??�정?�세??',
'- box-sizing: border-box\n- padding/border ?�함 ?�기',
'[{"input": "", "output": "border-box"}]',
'* {\n    /* box-sizing ?�정 */\n}',
'* {\n    box-sizing: border-box;\n}',
'[{"input": "", "expected": "border-box sizing"}]',
'["border-box??width??padding�?border�??�함?�니??]',
ARRAY['box-model', 'box-sizing'], 8);

-- Unit 5: Display?� Position (5 problems - EASY)
INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-display-block', 'css', 'syntax', 21, 'block ?�스?�레??, 'display: block', 'challenge', 1,
'?�라???�소�?블록?�로 변경하?�요.',
'- display: block\n- ??�?차�?',
'[{"input": "", "output": "블록 ?�소"}]',
'span {\n    /* 블록?�로 */\n}',
'span {\n    display: block;\n}',
'[{"input": "", "expected": "block display"}]',
'["block ?�소???�체 ?�비�?차�??�니??]',
ARRAY['layout', 'display'], 5),

('css-display-inline', 'css', 'syntax', 22, 'inline ?�스?�레??, 'display: inline', 'challenge', 1,
'블록 ?�소�??�라?�으�?변경하?�요.',
'- display: inline\n- ??줄에 ?��???,
'[{"input": "", "output": "?�라???�소"}]',
'div {\n    /* ?�라?�으�?*/\n}',
'div {\n    display: inline;\n}',
'[{"input": "", "expected": "inline display"}]',
'["inline ?�소??width/height�?가�????�습?�다"]',
ARRAY['layout', 'display'], 5),

('css-display-none', 'css', 'syntax', 23, '?�소 ?�기�?, 'display: none', 'challenge', 1,
'?�소�??�전???�기?�요.',
'- display: none\n- 공간??차�??��? ?�음',
'[{"input": "", "output": "?�겨�??�소"}]',
$/* CSS */
.hidden {\n    /* ?�기�?*/\n}',
'.hidden {\n    display: none;\n}',
'[{"input": "", "expected": "display none"}]',
'["visibility: hidden�??�리 공간??차�??��? ?�습?�다"]',
ARRAY['layout', 'display', 'visibility'], 5),

('css-position-relative', 'css', 'syntax', 24, '?��? ?�치', 'position: relative', 'challenge', 1,
'?�소�??�래 ?�치?�서 ?�로 10px ?�동?�세??',
'- position: relative\n- top: -10px',
'[{"input": "", "output": "?��? ?�동"}]',
$/* CSS */
.box {\n    /* ?�로 10px ?�동 */\n}',
'.box {\n    position: relative;\n    top: -10px;\n}',
'[{"input": "", "expected": "relative position"}]',
'["relative???�래 ?�치 기�??�로 ?�동?�니??]',
ARRAY['layout', 'position'], 8),

('css-position-absolute', 'css', 'syntax', 25, '?��? ?�치', 'position: absolute', 'challenge', 1,
'?�소�?부모의 ?�른�??�단??배치?�세??',
'- position: absolute\n- top: 0, right: 0',
'[{"input": "", "output": "?��? ?�치"}]',
$/* CSS */
.badge {\n    /* ?�른�??�단 */\n}',
'.badge {\n    position: absolute;\n    top: 0;\n    right: 0;\n}',
'[{"input": "", "expected": "absolute position"}]',
'["absolute??position???�는 가??가까운 조상 기�??�니??]',
ARRAY['layout', 'position'], 8);

-- Unit 6: Flexbox 기본 (5 problems - EASY)
INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-flex-container', 'css', 'syntax', 26, 'Flex 컨테?�너', 'display: flex', 'challenge', 1,
'컨테?�너�?flex�?만드?�요.',
'- display: flex\n- flex ?�이?�웃 ?�성??,
'[{"input": "", "output": "flex 컨테?�너"}]',
$/* CSS */
.container {\n    /* flex ?�성??*/\n}',
'.container {\n    display: flex;\n}',
'[{"input": "", "expected": "flex container"}]',
'["display: flex???�식?�을 flex ?�이?�으�?만듭?�다"]',
ARRAY['flexbox', 'basics'], 5),

('css-justify-content', 'css', 'syntax', 27, '주축 ?�렬', 'justify-content', 'challenge', 1,
'?�이?�을 가?�데 ?�렬?�세??',
'- justify-content: center\n- 주축(가�? ?�렬',
'[{"input": "", "output": "가?�데 ?�렬"}]',
$/* CSS */
.container {\n    display: flex;\n    /* 가?�데 ?�렬 */\n}',
'.container {\n    display: flex;\n    justify-content: center;\n}',
'[{"input": "", "expected": "centered items"}]',
'["flex-start, center, flex-end, space-between, space-around ??]',
ARRAY['flexbox', 'alignment'], 8),

('css-align-items', 'css', 'syntax', 28, '교차�??�렬', 'align-items', 'challenge', 1,
'?�이?�을 ?�로 가?�데 ?�렬?�세??',
'- align-items: center\n- 교차�??�로) ?�렬',
'[{"input": "", "output": "?�로 중앙"}]',
$/* CSS */
.container {\n    display: flex;\n    height: 200px;\n    /* ?�로 가?�데 */\n}',
'.container {\n    display: flex;\n    height: 200px;\n    align-items: center;\n}',
'[{"input": "", "expected": "vertically centered"}]',
'["stretch, flex-start, center, flex-end, baseline"]',
ARRAY['flexbox', 'alignment'], 8),

('css-flex-direction', 'css', 'syntax', 29, 'Flex 방향', 'flex-direction', 'challenge', 1,
'?�이?�을 ?�로�?배치?�세??',
'- flex-direction: column\n- ?�로 방향',
'[{"input": "", "output": "?�로 배치"}]',
$/* CSS */
.container {\n    display: flex;\n    /* ?�로 배치 */\n}',
'.container {\n    display: flex;\n    flex-direction: column;\n}',
'[{"input": "", "expected": "column direction"}]',
'["row(기본), column, row-reverse, column-reverse"]',
ARRAY['flexbox', 'direction'], 8),

('css-flex-gap', 'css', 'syntax', 30, 'Flex 간격', 'gap ?�성', 'challenge', 1,
'?�이???�이??20px 간격??추�??�세??',
'- gap: 20px\n- ?�이??�?간격',
'[{"input": "", "output": "20px 간격"}]',
$/* CSS */
.container {\n    display: flex;\n    /* 간격 추�? */\n}',
'.container {\n    display: flex;\n    gap: 20px;\n}',
'[{"input": "", "expected": "20px gap"}]',
'["gap?� margin보다 간격 조절???�리?�니??]',
ARRAY['flexbox', 'gap'], 8);

-- Unit 7: 리스?��? ?�이�?(5 problems - EASY)
INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-list-style-type', 'css', 'syntax', 31, '리스???��???, 'list-style-type', 'challenge', 1,
'리스??마커�??�각?�으�?변경하?�요.',
'- list-style-type: square\n- 리스??불릿 ?��???,
'[{"input": "", "output": "?�각??마커"}]',
'ul {\n    /* ?�각??마커 */\n}',
'ul {\n    list-style-type: square;\n}',
'[{"input": "", "expected": "square markers"}]',
'["disc, circle, square, none, decimal ??]',
ARRAY['list', 'style'], 5),

('css-list-style-none', 'css', 'syntax', 32, '리스??마커 ?�거', 'list-style: none', 'challenge', 1,
'리스??마커�??�전???�거?�세??',
'- list-style: none\n- 마커 ?��?',
'[{"input": "", "output": "마커 ?�음"}]',
'ul {\n    /* 마커 ?�거 */\n}',
'ul {\n    list-style: none;\n}',
'[{"input": "", "expected": "no markers"}]',
'["?�비게이??메뉴�?만들 ???�주 ?�용?�니??]',
ARRAY['list', 'style'], 5),

('css-table-border-collapse', 'css', 'syntax', 33, '?�이�??�두�?병합', 'border-collapse', 'challenge', 1,
'?�이�??�두리�? ?�나�??�치?�요.',
'- border-collapse: collapse\n- ?�중 ?�두�??�거',
'[{"input": "", "output": "병합???�두�?}]',
'table {\n    /* ?�두�?병합 */\n}',
'table {\n    border-collapse: collapse;\n}',
'[{"input": "", "expected": "collapsed borders"}]',
'["collapse???�접???�두리�? ?�나�?만듭?�다"]',
ARRAY['table', 'border'], 5),

('css-table-width', 'css', 'syntax', 34, '?�이�??�비', '100% ?�비', 'challenge', 1,
'?�이블이 ?�체 ?�비�?차�??�게 ?�세??',
'- width: 100%\n- 부�??�비만큼',
'[{"input": "", "output": "?�체 ?�비"}]',
'table {\n    /* ?�체 ?�비 */\n}',
'table {\n    width: 100%;\n}',
'[{"input": "", "expected": "full width table"}]',
'["?�이블�? 기본?�으�?콘텐�??�기만큼�?차�??�니??]',
ARRAY['table', 'width'], 5),

('css-td-padding', 'css', 'syntax', 35, '?�이�??� ?�딩', 'td ?��???, 'challenge', 1,
'?�이�??�??10px ?�딩??추�??�세??',
'- td, th ?�택??n- padding: 10px',
'[{"input": "", "output": "?� ?�딩"}]',
'/* Code */
td, th {\n    /* ?�딩 추�? */\n}',
'td, th {\n    padding: 10px;\n}',
'[{"input": "", "expected": "cell padding"}]',
'["?� ?�딩?� ?�이�?가?�성???�상?�킵?�다"]',
ARRAY['table', 'padding'], 5);

-- Unit 8: 가???�래??(5 problems - EASY)
INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-hover', 'css', 'syntax', 36, '?�버 ?�과', ':hover 가???�래??, 'challenge', 1,
'마우?��? ?�렸????배경?�을 ?��??�으�?변경하?�요.',
'- :hover 가???�래??n- 마우???�버 ?�태',
'[{"input": "", "output": "?�버 ???��? 배경"}]',
'button {\n    /* ?�버 ?�과 */\n}',
'button:hover {\n    background-color: blue;\n}',
'[{"input": "", "expected": "hover blue bg"}]',
'[":hover??마우???�인?��? ?�소 ?�에 ?�을 ???�용?�니??]',
ARRAY['pseudo-class', 'hover'], 5),

('css-active', 'css', 'syntax', 37, '?�성 ?�태', ':active 가???�래??, 'challenge', 1,
'?�릭?�는 ?�간 글?�색???�색?�로 변경하?�요.',
'- :active 가???�래??n- ?�릭 �??�태',
'[{"input": "", "output": "?�릭 ????글??}]',
'button {\n    /* ?�성 ?�태 */\n}',
'button:active {\n    color: white;\n}',
'[{"input": "", "expected": "active white text"}]',
'[":active???�소�??�릭?�는 ?�안 ?�용?�니??]',
ARRAY['pseudo-class', 'active'], 5),

('css-focus', 'css', 'syntax', 38, '?�커???�태', ':focus 가???�래??, 'challenge', 1,
'?�력 ?�드???�커?????�두리�? ?��??�으�?변경하?�요.',
'- :focus 가???�래??n- ?�커???�태',
'[{"input": "", "output": "?�커?????��? ?�두�?}]',
'input {\n    /* ?�커???��???*/\n}',
'input:focus {\n    border-color: blue;\n}',
'[{"input": "", "expected": "focus blue border"}]',
'[":focus???�보?�나 ?�릭?�로 ?�커?�된 ?�소???�용?�니??]',
ARRAY['pseudo-class', 'focus'], 5),

('css-first-child', 'css', 'syntax', 39, '�?번째 ?�식', ':first-child', 'challenge', 1,
'�?번째 li ?�소??글?��? 굵게 만드?�요.',
'- :first-child 가???�래??n- �??�식 ?�택',
'[{"input": "", "output": "�???�� 굵게"}]',
'li {\n    /* �?번째�?굵게 */\n}',
'li:first-child {\n    font-weight: bold;\n}',
'[{"input": "", "expected": "first child bold"}]',
'[":first-child??부모의 �?번째 ?�식???�택?�니??]',
ARRAY['pseudo-class', 'first-child'], 8),

('css-last-child', 'css', 'syntax', 40, '마�?�??�식', ':last-child', 'challenge', 1,
'마�?�?p ?�소??margin-bottom??0?�로 만드?�요.',
'- :last-child 가???�래??n- 마�?�??�식 ?�택',
'[{"input": "", "output": "마�?�??�백 ?�거"}]',
'p {\n    /* 마�?막만 margin 0 */\n}',
'p:last-child {\n    margin-bottom: 0;\n}',
'[{"input": "", "expected": "last child no margin"}]',
'["마�?�??�소???�백???�거?�면 ?�이?�웃??깔끔?�집?�다"]',
ARRAY['pseudo-class', 'last-child'], 8);

-- Unit 9: ?�위?� �?(5 problems - EASY)
INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-percentage', 'css', 'syntax', 41, '?�센???�위', '% ?�기', 'challenge', 1,
'?�비�?부모의 50%�??�정?�세??',
'- width: 50%\n- 부�?기�? 비율',
'[{"input": "", "output": "50% ?�비"}]',
$/* CSS */
.half {\n    /* 50% ?�비 */\n}',
'.half {\n    width: 50%;\n}',
'[{"input": "", "expected": "50% width"}]',
'["%??부�??�소�?기�??�로 계산?�니??]',
ARRAY['units', 'percentage'], 5),

('css-em-unit', 'css', 'syntax', 42, 'em ?�위', '?��????�기', 'challenge', 1,
'글???�기�?부모의 1.5배로 ?�정?�세??',
'- font-size: 1.5em\n- 부�?글???�기 기�?',
'[{"input": "", "output": "1.5�??�기"}]',
$/* CSS */
.large {\n    /* 1.5�??�기 */\n}',
'.large {\n    font-size: 1.5em;\n}',
'[{"input": "", "expected": "1.5em font"}]',
'["em?� 부�??�소??font-size�?기�??�로 ?�니??]',
ARRAY['units', 'em'], 8),

('css-rem-unit', 'css', 'syntax', 43, 'rem ?�위', '루트 기�? ?�기', 'challenge', 1,
'글???�기�?루트??2배로 ?�정?�세??',
'- font-size: 2rem\n- html ?�소 기�?',
'[{"input": "", "output": "2�??�기"}]',
$/* CSS */
.heading {\n    /* 2rem ?�기 */\n}',
'.heading {\n    font-size: 2rem;\n}',
'[{"input": "", "expected": "2rem font"}]',
'["rem?� html ?�소??font-size�?기�??�로 ?�니??]',
ARRAY['units', 'rem'], 8),

('css-vw-vh', 'css', 'syntax', 44, 'Viewport ?�위', 'vw, vh', 'challenge', 1,
'?�비�?뷰포?�의 100vw�??�정?�세??',
'- width: 100vw\n- 뷰포???�비 100%',
'[{"input": "", "output": "?�체 뷰포???�비"}]',
$/* CSS */
.full-width {\n    /* 100vw */\n}',
'.full-width {\n    width: 100vw;\n}',
'[{"input": "", "expected": "100vw width"}]',
'["vw??뷰포???�비??1%, vh??뷰포???�이??1%"]',
ARRAY['units', 'viewport'], 8),

('css-calc', 'css', 'syntax', 45, 'calc() ?�수', '계산???�용', 'challenge', 1,
'?�비�?"100% - 50px"�?계산?�세??',
'- calc() ?�수\n- ?�위 ?�합 계산',
'[{"input": "", "output": "계산???�비"}]',
$/* CSS */
.box {\n    /* calc ?�용 */\n}',
'.box {\n    width: calc(100% - 50px);\n}',
'[{"input": "", "expected": "calc width"}]',
'["calc()�??�로 ?�른 ?�위�?계산?????�습?�다"]',
ARRAY['units', 'calc'], 10);

-- Unit 10: 기�? ?��???(5 problems - EASY)
INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('css-opacity', 'css', 'syntax', 46, '?�명??, 'opacity', 'challenge', 1,
'?�소�?50% ?�명?�게 만드?�요.',
'- opacity: 0.5\n- 0(?�명) ~ 1(불투�?',
'[{"input": "", "output": "반투�?}]',
$/* CSS */
.transparent {\n    /* 50% ?�명??*/\n}',
'.transparent {\n    opacity: 0.5;\n}',
'[{"input": "", "expected": "0.5 opacity"}]',
'["opacity???�소 ?�체???�명?��? 조절?�니??]',
ARRAY['effects', 'opacity'], 5),

('css-cursor', 'css', 'syntax', 47, '커서 ?��???, 'cursor', 'challenge', 1,
'마우??커서�??�인?�로 변경하?�요.',
'- cursor: pointer\n- ?��???모양',
'[{"input": "", "output": "?�인??커서"}]',
'button {\n    /* ?�인??커서 */\n}',
'button {\n    cursor: pointer;\n}',
'[{"input": "", "expected": "pointer cursor"}]',
'["pointer, default, move, text, wait ???�양??커서가 ?�습?�다"]',
ARRAY['interaction', 'cursor'], 5),

('css-overflow-hidden', 'css', 'syntax', 48, '?�침 ?��?', 'overflow: hidden', 'challenge', 1,
'?�치??콘텐츠�? ?�기?�요.',
'- overflow: hidden\n- ?�침 ?�라?�기',
'[{"input": "", "output": "?�침 ?��?"}]',
$/* CSS */
.box {\n    /* ?�침 ?��? */\n}',
'.box {\n    overflow: hidden;\n}',
'[{"input": "", "expected": "overflow hidden"}]',
'["visible, hidden, scroll, auto 값을 ?�용?????�습?�다"]',
ARRAY['overflow', 'hidden'], 5),

('css-border-radius', 'css', 'syntax', 49, '?�근 모서�?, 'border-radius', 'challenge', 1,
'모서리�? 10px ?��?�?만드?�요.',
'- border-radius: 10px\n- ?�근 ?�두�?,
'[{"input": "", "output": "?�근 모서�?}]',
$/* CSS */
.card {\n    /* ?�근 모서�?*/\n}',
'.card {\n    border-radius: 10px;\n}',
'[{"input": "", "expected": "10px radius"}]',
'["50%�??�정?�면 ?�이 ?�니??]',
ARRAY['border', 'radius'], 5),

('css-box-shadow', 'css', 'syntax', 50, '그림??, 'box-shadow', 'challenge', 1,
'박스??그림?��? 추�??�세??',
'- box-shadow: 0 2px 4px rgba(0,0,0,0.1)\n- x, y, blur, color',
'[{"input": "", "output": "그림???�과"}]',
$/* CSS */
.card {\n    /* 그림??*/\n}'',
'.card {\n    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);\n}',
'[{"input": "", "expected": "box shadow"}]',
'["box-shadow??x-offset, y-offset, blur, spread, color ?�입?�다"]',
ARRAY['effects', 'shadow'], 8);

-- ====================================
-- ?�료 메시지
-- ====================================

