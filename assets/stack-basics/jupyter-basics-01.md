# Chapter 1: Jupyter Notebook & Colab 소개

안녕하세요! 바데부입니다! 오늘은 Jupyter Notebook과 Google Colab에 대해 알아볼 거예요. 데이터 분석과 머신러닝의 필수 도구예요! 📊

## 1.1 Jupyter Notebook이란?

Jupyter Notebook은 코드, 텍스트, 시각화를 하나의 문서에 담을 수 있는 대화형 개발 환경이예요. 데이터 과학자들이 가장 사랑하는 도구랍니다!

**Jupyter Notebook의 특징:**
- 코드와 결과를 바로바로 확인
- 마크다운으로 문서화 가능
- 데이터 시각화 지원
- 다양한 프로그래밍 언어 지원 (Python, R, Julia 등)
- 셀 단위로 코드 실행
- 교육 및 연구에 최적화

**Jupyter의 의미:**
- Ju(lia) + Pyt(hon) + R
- 세 가지 주요 데이터 과학 언어를 지원한다는 의미!

## 1.2 Google Colab이란?

Google Colab(Colaboratory)은 구글이 제공하는 클라우드 기반 Jupyter Notebook 환경이에요. 무료로 GPU까지 사용할 수 있어요! 🎁

**Google Colab의 장점:**
- 설치 불필요 - 브라우저만 있으면 OK!
- 무료 GPU/TPU 제공
- Google Drive와 연동
- 협업 기능 (Google Docs처럼!)
- 대부분의 라이브러리 사전 설치
- 언제 어디서나 접속 가능

**Colab vs Jupyter Notebook:**
| 특징 | Google Colab | Jupyter Notebook |
|------|--------------|------------------|
| 설치 | 불필요 | 필요 |
| GPU | 무료 제공 | 로컬 GPU 필요 |
| 협업 | 쉬움 | 어려움 |
| 비용 | 무료 (제한) | 무료 |
| 커스터마이징 | 제한적 | 자유로움 |
| 인터넷 | 필수 | 선택적 |

## 1.3 Google Colab 시작하기

### Colab 접속하기

**1단계: 구글 계정으로 로그인**
1. [colab.research.google.com](https://colab.research.google.com) 접속
2. 구글 계정으로 로그인

**2단계: 새 노트북 만들기**
```
파일 → 새 노트북
또는
File → New notebook
```

**3단계: 노트북 이름 변경**
- 왼쪽 상단의 "Untitled.ipynb" 클릭
- "바데부의 첫 노트북.ipynb"로 변경

### 첫 번째 코드 실행하기

```python
# 첫 번째 셀에 입력
print("안녕하세요, 바데부입니다!")
print("Jupyter와 Colab을 배워봅시다! 🚀")
```

**실행 방법:**
- Shift + Enter: 실행 후 다음 셀로 이동
- Ctrl + Enter: 실행 후 현재 셀에 머물기
- 재생 버튼 ▶ 클릭

## 1.4 로컬 Jupyter Notebook 설치하기

로컬에서도 사용하고 싶다면 설치해봅시다!

### Anaconda로 설치 (권장)

**1단계: Anaconda 다운로드**
[anaconda.com](https://www.anaconda.com/download)에서 설치 파일 다운로드

**2단계: 설치**
```bash
# Windows: 설치 파일 실행
# Mac/Linux: 터미널에서
bash Anaconda3-latest-Linux-x86_64.sh
```

**3단계: Jupyter Notebook 실행**
```bash
# 터미널 또는 Anaconda Prompt에서
jupyter notebook

# 특정 포트로 실행
jupyter notebook --port 8888
```

브라우저가 자동으로 열리면서 Jupyter가 실행돼요!

### pip로 설치

```bash
# Python이 이미 설치되어 있다면
pip install jupyter

# 또는 Python3
pip3 install jupyter

# 실행
jupyter notebook
```

## 1.5 Colab 인터페이스 둘러보기

### 주요 메뉴

**파일 메뉴:**
- 새 노트북: 새로운 노트북 생성
- 노트북 열기: 기존 노트북 열기
- Drive에 사본 저장: Google Drive에 저장
- GitHub에서 열기: GitHub 저장소에서 노트북 불러오기

**수정 메뉴:**
- 실행 취소/다시 실행
- 셀 잘라내기/복사/붙여넣기
- 모두 선택

**런타임 메뉴:**
- 모두 실행: 모든 셀 실행
- 런타임 다시 시작: 커널 재시작
- 런타임 유형 변경: GPU/TPU 선택

**도구 메뉴:**
- 설정: 편집기 설정
- 단축키: 키보드 단축키 확인
- 차이 비교: 버전 비교

## 1.6 첫 번째 데이터 분석

### 간단한 계산

```python
# 기본 연산
a = 10
b = 20
print(f"a + b = {a + b}")
print(f"a * b = {a * b}")

# 리스트 연산
numbers = [1, 2, 3, 4, 5]
print(f"합계: {sum(numbers)}")
print(f"평균: {sum(numbers) / len(numbers)}")
```

### 데이터 시각화 맛보기

```python
# matplotlib 사용
import matplotlib.pyplot as plt

# 데이터 준비
x = [1, 2, 3, 4, 5]
y = [2, 4, 6, 8, 10]

# 그래프 그리기
plt.plot(x, y, marker='o')
plt.title('바데부의 첫 그래프')
plt.xlabel('X축')
plt.ylabel('Y축')
plt.grid(True)
plt.show()
```

Colab에서는 그래프가 바로 표시돼요! 신기하죠? 📈

## 1.7 Colab의 특별한 기능

### 무료 GPU 사용하기

```
런타임 → 런타임 유형 변경 → GPU 선택
```

**GPU 확인:**
```python
# GPU 정보 확인
!nvidia-smi

# TensorFlow로 GPU 확인
import tensorflow as tf
print("GPU 사용 가능:", tf.config.list_physical_devices('GPU'))
```

### 시스템 명령어 실행

Colab에서는 `!`를 붙여서 리눅스 명령어를 실행할 수 있어요!

```python
# 현재 디렉토리 확인
!pwd

# 파일 목록 보기
!ls -la

# Python 버전 확인
!python --version

# 라이브러리 설치
!pip install pandas
```

### 매직 명령어

`%`로 시작하는 특별한 명령어예요!

```python
# 실행 시간 측정
%time sum(range(1000000))

# 여러 번 실행 후 평균 시간
%timeit sum(range(1000000))

# 현재 변수 목록
%who

# 상세 변수 정보
%whos
```

## 1.8 Google Drive 연동

### Drive 마운트하기

```python
# Google Drive 연결
from google.colab import drive
drive.mount('/content/drive')

# 연결 확인
!ls /content/drive/MyDrive

# Drive에서 파일 읽기
import pandas as pd
df = pd.read_csv('/content/drive/MyDrive/data.csv')
```

### Drive에 파일 저장하기

```python
# 데이터프레임을 CSV로 저장
df.to_csv('/content/drive/MyDrive/output.csv', index=False)

# 그래프를 이미지로 저장
plt.savefig('/content/drive/MyDrive/graph.png')
print("파일이 Google Drive에 저장되었습니다!")
```

## 1.9 Colab vs Jupyter Notebook 선택 가이드

### Colab을 선택하세요:
- 설치 없이 바로 시작하고 싶을 때
- GPU가 필요할 때
- 다른 사람과 협업할 때
- 여러 컴퓨터에서 작업할 때
- 학습 목적일 때

### Jupyter Notebook을 선택하세요:
- 인터넷이 불안정할 때
- 대용량 로컬 데이터를 다룰 때
- 완전한 커스터마이징이 필요할 때
- 보안이 중요한 데이터를 다룰 때
- 오프라인 작업이 필요할 때

## 1.10 일반적인 실수와 해결방법

### 실수 1: 런타임 연결 끊김

```python
# ❌ Colab은 90분 후 자동 연결 해제
# 장시간 실행 시 중간중간 셀 실행 필요

# ✅ 주기적으로 상태 확인
import time
for i in range(10):
    print(f"작업 진행 중... {i+1}/10")
    time.sleep(60)  # 1분마다 상태 업데이트
```

### 실수 2: 셀 실행 순서

```python
# ❌ 순서대로 실행하지 않으면 오류 발생
# 셀 3: print(result)
# 셀 1: result = 10 + 20

# ✅ 위에서 아래로 순서대로 실행
# 셀 1: result = 10 + 20
# 셀 2: print(result)
```

### 실수 3: 패키지 버전 충돌

```python
# ❌ 버전 지정 없이 설치
!pip install tensorflow

# ✅ 특정 버전 설치
!pip install tensorflow==2.13.0

# 설치된 버전 확인
!pip show tensorflow
```

## 1.11 바데부의 실전 팁

### 팁 1: 단축키 마스터하기

**필수 단축키:**
- Ctrl + M + B: 아래에 코드 셀 추가
- Ctrl + M + A: 위에 코드 셀 추가
- Ctrl + M + D: 셀 삭제
- Ctrl + M + Y: 코드 셀로 변환
- Ctrl + M + M: 마크다운 셀로 변환

### 팁 2: 코드 스니펫 활용

Colab 왼쪽의 `< >` 아이콘을 클릭하면 유용한 코드 예제가 가득해요!

### 팁 3: 폼 기능 사용

```python
#@title 사용자 입력 받기
name = "바데부" #@param {type:"string"}
age = 3 #@param {type:"integer"}
is_student = True #@param {type:"boolean"}

print(f"이름: {name}, 나이: {age}, 학생: {is_student}")
```

### 팁 4: 세션 시간 확인

```python
# 런타임 연결 시간 확인
import time
import psutil

print(f"부팅 시간: {time.time() - psutil.boot_time():.0f}초 전")
```

## 연습 문제

1. Google Colab에 접속하여 새 노트북을 만들어보세요
2. "Hello, Jupyter!"를 출력하는 코드를 작성하고 실행해보세요
3. 1부터 10까지의 합을 계산하고 출력해보세요
4. matplotlib를 사용하여 간단한 선 그래프를 그려보세요
5. `!pwd` 명령어로 현재 디렉토리를 확인해보세요

## 다음 단계

다음 챕터에서는 **셀 타입과 실행**에 대해 배워봅시다! 코드 셀, 마크다운 셀, 그리고 강력한 매직 명령어들을 마스터할 거예요!

## 핵심 요약

- Jupyter Notebook은 코드, 텍스트, 시각화를 통합한 대화형 환경
- Google Colab은 클라우드 기반 Jupyter로 무료 GPU 제공
- Colab은 설치 불필요, Jupyter는 로컬 설치 필요
- Shift + Enter로 셀 실행
- `!`로 시스템 명령어, `%`로 매직 명령어 실행
- Google Drive 연동으로 파일 저장 가능
- 런타임은 90분 후 자동 연결 해제 (Colab)
- 셀은 위에서 아래로 순서대로 실행

바데부와 함께 Jupyter를 마스터해봅시다! 🚀
