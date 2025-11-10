# Chapter 2: 셀 타입과 실행

안녕하세요! 바데부입니다! Jupyter와 Colab의 핵심인 '셀(Cell)'에 대해 깊이 알아봅시다! 셀을 잘 다루면 생산성이 확 올라가요! ⚡

## 2.1 셀(Cell)이란?

셀은 Jupyter Notebook의 기본 단위예요. 코드나 텍스트를 담는 블록이라고 생각하면 돼요!

**셀의 특징:**
- 독립적으로 실행 가능
- 위에서 아래로 순차 실행 권장
- 결과가 바로바로 표시
- 여러 번 수정하고 재실행 가능
- 순서를 바꿔서 실행할 수도 있음 (주의 필요!)

**셀 실행 순서 표시:**
```python
In [1]:  # 첫 번째로 실행된 셀
In [2]:  # 두 번째로 실행된 셀
In [*]:  # 현재 실행 중인 셀
```

## 2.2 코드 셀 (Code Cell)

코드 셀은 Python 코드를 작성하고 실행하는 셀이에요!

### 기본 코드 실행

```python
# 간단한 계산
result = 10 + 20
print(f"결과: {result}")

# 마지막 값은 자동으로 출력
result  # 30이 출력됨
```

**자동 출력 규칙:**
- 셀의 마지막 줄 값은 자동으로 출력
- `print()` 없이도 결과 확인 가능

```python
# 여러 값 확인
x = 10
y = 20
x + y  # 30만 출력됨 (마지막 줄)
```

```python
# 여러 값 모두 출력하려면
x = 10
y = 20
print(f"x = {x}")
print(f"y = {y}")
print(f"x + y = {x + y}")
```

### 변수는 전역적으로 공유

```python
# 셀 1에서 정의
name = "바데부"
age = 3

# 셀 2에서 사용 가능
print(f"{name}의 나이는 {age}살입니다!")
```

**주의사항:**
- 셀을 실행한 순서가 중요해요!
- 위 셀을 실행하지 않고 아래 셀을 실행하면 오류 발생

### 여러 줄 출력

```python
# 여러 결과 출력하기
from IPython.display import display

x = 10
y = 20

display(x)
display(y)
display(x + y)
```

## 2.3 마크다운 셀 (Markdown Cell)

마크다운 셀은 문서화를 위한 셀이에요. 코드 설명, 메모, 제목 등을 작성해요!

### 제목 만들기

```markdown
# 제목 1 (가장 큼)
## 제목 2
### 제목 3
#### 제목 4
##### 제목 5
###### 제목 6 (가장 작음)
```

### 텍스트 스타일

```markdown
**굵게**: **바데부**
*기울임*: *바데부*
***굵고 기울임***: ***바데부***
~~취소선~~: ~~바데부~~
`코드`: `print("Hello")`
```

### 목록 만들기

```markdown
# 순서 없는 목록
- 항목 1
- 항목 2
  - 하위 항목 2.1
  - 하위 항목 2.2
- 항목 3

# 순서 있는 목록
1. 첫 번째
2. 두 번째
3. 세 번째
```

### 링크와 이미지

```markdown
# 링크
[구글](https://www.google.com)
[VibeDevEdu](https://vibedev.com)

# 이미지
![대체 텍스트](이미지URL)
![바데부](https://example.com/badb.png)
```

### 코드 블록

````markdown
# 인라인 코드
`print("Hello")`를 실행하면 Hello가 출력됩니다.

# 코드 블록
```python
def greet(name):
    print(f"안녕하세요, {name}!")

greet("바데부")
```
````

### 수학 수식 (LaTeX)

```markdown
# 인라인 수식
질량-에너지 등가 원리: $E = mc^2$

# 블록 수식
$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}
$$

# 복잡한 수식
$$
f(x) = \int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
$$
```

### 표 만들기

```markdown
| 이름 | 나이 | 직업 |
|------|------|------|
| 바데부 | 3 | 튜터 |
| 철수 | 25 | 개발자 |
| 영희 | 28 | 데이터 과학자 |

# 정렬
| 왼쪽 정렬 | 중앙 정렬 | 오른쪽 정렬 |
|:---------|:--------:|----------:|
| 왼쪽 | 중앙 | 오른쪽 |
```

### 인용구

```markdown
> 바데부가 말했다:
> "Jupyter는 정말 멋진 도구예요!"
>
> > 중첩 인용도 가능해요!
```

### 수평선

```markdown
---
또는
***
또는
___
```

## 2.4 매직 명령어 (Magic Commands)

매직 명령어는 Jupyter의 특별한 기능들이에요! `%`나 `%%`로 시작해요.

### 라인 매직 (%): 한 줄에 적용

```python
# 실행 시간 측정
%time sum(range(1000000))

# 여러 번 실행 후 평균 시간
%timeit sum(range(1000000))

# 변수 목록 보기
%who

# 변수 상세 정보
%whos

# 작업 디렉토리 확인
%pwd

# 디렉토리 변경
%cd /content

# 디렉토리 목록
%ls

# 환경 변수 보기
%env

# 실행 기록 보기
%history
```

### 셀 매직 (%%): 전체 셀에 적용

```python
# 전체 셀 실행 시간 측정
%%time
total = 0
for i in range(1000000):
    total += i
print(total)
```

```python
# HTML 렌더링
%%html
<h1 style="color: blue;">안녕하세요, 바데부입니다!</h1>
<p>HTML을 직접 작성할 수 있어요!</p>
```

```python
# JavaScript 실행
%%javascript
alert('바데부가 Jupyter를 배우고 있어요!');
```

```python
# 다른 언어 실행 (bash)
%%bash
echo "Bash 명령어를 실행해요!"
date
pwd
```

```python
# 파일에 내용 저장
%%writefile hello.py
def greet(name):
    print(f"안녕하세요, {name}!")

greet("바데부")
```

```python
# 저장된 파일 실행
%run hello.py
```

### 자주 사용하는 매직 명령어

```python
# matplotlib을 노트북에 표시
%matplotlib inline

# 자동 리로드 (모듈 변경 시 자동 갱신)
%load_ext autoreload
%autoreload 2

# 디버깅 모드
%debug

# 프로파일링 (성능 분석)
%prun sum(range(1000000))

# 메모리 사용량 확인
%memit [1, 2, 3, 4, 5]

# 라인별 실행 시간
%lprun -f 함수이름 함수이름(인자)
```

## 2.5 시스템 명령어 실행

`!`를 사용하면 시스템 명령어를 실행할 수 있어요!

### 기본 시스템 명령어

```python
# 현재 디렉토리
!pwd

# 파일 목록
!ls

# 상세 파일 목록
!ls -la

# 파일 내용 보기
!cat hello.py

# 디렉토리 생성
!mkdir data

# 파일 복사
!cp source.txt destination.txt

# 파일 이동/이름 변경
!mv old.txt new.txt

# 파일 삭제
!rm file.txt
```

### 패키지 관리

```python
# 패키지 설치
!pip install pandas

# 특정 버전 설치
!pip install numpy==1.24.0

# 설치된 패키지 목록
!pip list

# 패키지 정보 확인
!pip show pandas

# 패키지 제거
!pip uninstall -y matplotlib

# requirements.txt로 설치
!pip install -r requirements.txt

# 업그레이드
!pip install --upgrade pandas
```

### Python 정보

```python
# Python 버전
!python --version

# Python 경로
!which python

# 설치된 Python 패키지 경로
!python -c "import sys; print(sys.path)"
```

### 시스템 정보 (Colab/Linux)

```python
# CPU 정보
!cat /proc/cpuinfo

# 메모리 정보
!cat /proc/meminfo

# 디스크 용량
!df -h

# GPU 정보
!nvidia-smi

# 현재 사용자
!whoami

# 환경 변수
!env
```

### 네트워크 명령어

```python
# 파일 다운로드
!wget https://example.com/data.csv

# curl로 다운로드
!curl -O https://example.com/data.csv

# git clone
!git clone https://github.com/user/repo.git

# 압축 해제
!unzip file.zip
!tar -xvf file.tar.gz
```

## 2.6 셀 실행 단축키

### Colab/Jupyter 공통 단축키

**셀 실행:**
- Shift + Enter: 실행 후 다음 셀로
- Ctrl + Enter: 실행 후 현재 셀에 머물기
- Alt + Enter: 실행 후 아래에 새 셀 추가

**셀 편집 (명령 모드에서):**
- A: 위에 셀 추가
- B: 아래에 셀 추가
- DD: 셀 삭제
- Z: 실행 취소
- M: 마크다운 셀로 변환
- Y: 코드 셀로 변환
- C: 셀 복사
- X: 셀 잘라내기
- V: 아래에 붙여넣기

**기타:**
- Esc: 명령 모드로 전환
- Enter: 편집 모드로 전환
- Ctrl + S: 저장
- Ctrl + /: 주석 토글

### Colab 전용 단축키

```
Ctrl + M + B: 아래에 코드 셀 추가
Ctrl + M + A: 위에 코드 셀 추가
Ctrl + M + D: 셀 삭제
Ctrl + M + Y: 코드 셀로 변환
Ctrl + M + M: 마크다운 셀로 변환
Ctrl + M + I: 셀 실행 중단
Ctrl + M + H: 단축키 도움말
```

## 2.7 셀 출력 제어

### 출력 숨기기

```python
# 세미콜론으로 출력 숨기기
result = 10 + 20;  # 30이 출력되지 않음

# 변수에 저장만 하기
x = [1, 2, 3, 4, 5]  # 리스트가 출력되지 않음
```

### 출력 초기화

```python
# IPython display 사용
from IPython.display import clear_output
import time

for i in range(10):
    clear_output(wait=True)
    print(f"진행률: {i+1}/10")
    time.sleep(0.5)
```

### Rich 출력

```python
# HTML 출력
from IPython.display import HTML
HTML('<h1 style="color: red;">안녕하세요!</h1>')

# 이미지 출력
from IPython.display import Image
Image(url='https://example.com/image.png', width=300)

# 비디오 출력
from IPython.display import Video
Video('video.mp4', width=600)

# JSON 출력
from IPython.display import JSON
data = {'name': '바데부', 'age': 3}
JSON(data)
```

### 프로그레스 바

```python
# tqdm 사용
from tqdm import tqdm
import time

for i in tqdm(range(100)):
    time.sleep(0.01)
    # 작업 수행

# 중첩 프로그레스 바
from tqdm import tqdm, trange

for i in trange(5, desc='외부 루프'):
    for j in tqdm(range(100), desc='내부 루프', leave=False):
        time.sleep(0.01)
```

## 2.8 일반적인 실수와 해결방법

### 실수 1: 셀 실행 순서

```python
# ❌ 잘못된 순서
# 셀 2
print(result)  # NameError!

# 셀 1
result = 100

# ✅ 올바른 순서
# 셀 1
result = 100

# 셀 2
print(result)  # 100
```

**해결방법:**
- 런타임 → 모두 실행으로 위에서부터 순서대로 실행
- 또는 Ctrl + F9 (Colab)

### 실수 2: 무한 루프

```python
# ❌ 무한 루프
while True:
    print("멈추지 않아요!")

# ✅ 중단 방법
# 런타임 → 실행 중단
# 또는 Ctrl + M + I (Colab)
# 또는 커널 재시작
```

### 실수 3: 메모리 부족

```python
# ❌ 너무 큰 데이터
huge_list = [i for i in range(10000000000)]  # 메모리 부족!

# ✅ 제너레이터 사용
def generate_numbers(n):
    for i in range(n):
        yield i

# 또는 런타임 재시작
# 런타임 → 런타임 다시 시작
```

## 2.9 바데부의 실전 팁

### 팁 1: 셀 번호 초기화

```python
# 런타임 → 런타임 다시 시작
# 셀 실행 번호가 In [1]부터 다시 시작돼요
```

### 팁 2: 코드 스니펫 라이브러리

```python
# Colab 왼쪽의 코드 스니펫 (<>) 활용
# - 카메라로 사진 찍기
# - 파일 업로드
# - 구글 시트 연동
# 등 유용한 예제가 가득!
```

### 팁 3: 셀 접기

```python
# Colab에서 긴 코드는 자동으로 접을 수 있어요
# 셀 왼쪽의 화살표 클릭!
```

### 팁 4: 여러 셀 동시 선택

```python
# Shift + 위/아래 화살표로 여러 셀 선택
# 선택 후 한 번에 실행, 삭제, 이동 가능
```

## 연습 문제

1. 코드 셀을 만들고 1부터 100까지의 합을 계산하세요
2. 마크다운 셀을 만들고 자기소개를 작성하세요 (제목, 리스트 사용)
3. `%timeit`을 사용하여 리스트 컴프리헨션과 for 루프의 속도를 비교하세요
4. `!ls` 명령어로 현재 디렉토리의 파일 목록을 확인하세요
5. 셀 실행 단축키를 사용하여 효율적으로 여러 셀을 실행해보세요

## 다음 단계

다음 챕터에서는 **데이터 분석 시작하기**를 배워봅시다! pandas와 numpy를 사용하여 실제 데이터를 다뤄볼 거예요!

## 핵심 요약

- 코드 셀: Python 코드 실행
- 마크다운 셀: 문서화 및 설명 작성
- 매직 명령어: `%` (라인), `%%` (셀)
- 시스템 명령어: `!` 사용
- Shift + Enter: 셀 실행 후 다음 셀로
- %timeit: 실행 시간 측정
- %who/%whos: 변수 확인
- 셀은 전역 네임스페이스 공유
- 실행 순서가 중요함 (위에서 아래로)
- 마크다운으로 LaTeX 수식 작성 가능

바데부와 함께 Jupyter 셀 마스터! 💪
