# Chapter 3: 데이터 분석 시작하기

안녕하세요! 바데부입니다! 이제 본격적으로 데이터 분석을 시작해봅시다! pandas와 numpy는 데이터 과학의 필수 도구예요! 📊

## 3.1 NumPy 기초

NumPy는 수치 계산을 위한 Python 라이브러리예요. 빠른 배열 연산이 특징이죠!

### NumPy 시작하기

```python
# NumPy 설치 (Colab에는 이미 설치되어 있어요!)
!pip install numpy

# NumPy 임포트
import numpy as np

# 버전 확인
print(f"NumPy 버전: {np.__version__}")
```

### 배열 생성

```python
# 리스트로부터 배열 생성
arr1 = np.array([1, 2, 3, 4, 5])
print(f"1차원 배열: {arr1}")
print(f"타입: {type(arr1)}")
print(f"형태: {arr1.shape}")

# 2차원 배열
arr2 = np.array([[1, 2, 3], [4, 5, 6]])
print(f"\n2차원 배열:\n{arr2}")
print(f"형태: {arr2.shape}")  # (2, 3)
print(f"차원: {arr2.ndim}")   # 2

# 특별한 배열 생성
zeros = np.zeros((3, 4))      # 0으로 채워진 배열
ones = np.ones((2, 3))        # 1로 채워진 배열
empty = np.empty((2, 2))      # 초기화하지 않은 배열
eye = np.eye(3)               # 단위 행렬

print(f"\nzeros:\n{zeros}")
print(f"\neye:\n{eye}")
```

### 범위 배열

```python
# arange: 파이썬의 range와 비슷
arr = np.arange(10)           # 0부터 9까지
print(f"arange(10): {arr}")

arr = np.arange(5, 15)        # 5부터 14까지
print(f"arange(5, 15): {arr}")

arr = np.arange(0, 1, 0.1)    # 0부터 1까지 0.1씩
print(f"arange(0, 1, 0.1): {arr}")

# linspace: 균등하게 나눈 값
arr = np.linspace(0, 10, 5)   # 0부터 10까지 5개
print(f"\nlinspace(0, 10, 5): {arr}")
```

### 배열 연산

```python
# 기본 연산
a = np.array([1, 2, 3, 4])
b = np.array([10, 20, 30, 40])

print(f"a + b = {a + b}")      # 요소별 덧셈
print(f"a - b = {a - b}")      # 요소별 뺄셈
print(f"a * b = {a * b}")      # 요소별 곱셈
print(f"a / b = {a / b}")      # 요소별 나눗셈

# 스칼라 연산
print(f"\na * 2 = {a * 2}")
print(f"a + 10 = {a + 10}")
print(f"a ** 2 = {a ** 2}")    # 제곱
```

### 배열 인덱싱과 슬라이싱

```python
# 1차원 배열
arr = np.array([10, 20, 30, 40, 50])

print(f"첫 번째 요소: {arr[0]}")
print(f"마지막 요소: {arr[-1]}")
print(f"슬라이싱 [1:4]: {arr[1:4]}")
print(f"처음 3개: {arr[:3]}")

# 2차원 배열
arr2d = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

print(f"\n2차원 배열:\n{arr2d}")
print(f"[0, 0]: {arr2d[0, 0]}")  # 1행 1열
print(f"[1, 2]: {arr2d[1, 2]}")  # 2행 3열
print(f"첫 번째 행: {arr2d[0]}")
print(f"첫 번째 열: {arr2d[:, 0]}")
```

### 유용한 배열 함수

```python
arr = np.array([1, 2, 3, 4, 5])

print(f"합계: {np.sum(arr)}")
print(f"평균: {np.mean(arr)}")
print(f"중앙값: {np.median(arr)}")
print(f"표준편차: {np.std(arr)}")
print(f"최댓값: {np.max(arr)}")
print(f"최솟값: {np.min(arr)}")
print(f"최댓값 인덱스: {np.argmax(arr)}")
print(f"최솟값 인덱스: {np.argmin(arr)}")

# 2차원 배열의 축별 연산
arr2d = np.array([[1, 2, 3], [4, 5, 6]])
print(f"\n2차원 배열:\n{arr2d}")
print(f"전체 합: {np.sum(arr2d)}")
print(f"열별 합 (axis=0): {np.sum(arr2d, axis=0)}")
print(f"행별 합 (axis=1): {np.sum(arr2d, axis=1)}")
```

## 3.2 Pandas 기초

pandas는 데이터 분석을 위한 최고의 라이브러리예요! 엑셀처럼 테이블 형태로 데이터를 다룰 수 있어요!

### Pandas 시작하기

```python
# pandas 설치 (Colab에는 이미 설치되어 있어요!)
!pip install pandas

# pandas 임포트
import pandas as pd

# 버전 확인
print(f"pandas 버전: {pd.__version__}")
```

### Series (1차원 데이터)

```python
# 리스트로부터 Series 생성
data = pd.Series([10, 20, 30, 40, 50])
print("Series:")
print(data)
print(f"\n타입: {type(data)}")

# 인덱스 지정
data = pd.Series([10, 20, 30], index=['a', 'b', 'c'])
print("\n인덱스가 있는 Series:")
print(data)
print(f"\ndata['b'] = {data['b']}")

# 딕셔너리로부터 Series 생성
score_dict = {'국어': 90, '수학': 85, '영어': 95}
scores = pd.Series(score_dict)
print("\n딕셔너리로부터 생성:")
print(scores)
```

### DataFrame (2차원 데이터)

```python
# 딕셔너리로부터 DataFrame 생성
data = {
    '이름': ['바데부', '철수', '영희', '민수'],
    '나이': [3, 25, 28, 22],
    '점수': [95, 85, 92, 88]
}

df = pd.DataFrame(data)
print("DataFrame:")
print(df)

# 기본 정보
print(f"\n형태: {df.shape}")           # (행, 열)
print(f"열 이름: {df.columns.tolist()}")
print(f"인덱스: {df.index.tolist()}")
print(f"데이터 타입:\n{df.dtypes}")
```

### 데이터 확인하기

```python
# 샘플 데이터 생성
df = pd.DataFrame({
    '이름': ['바데부', '철수', '영희', '민수', '지수', '현우'],
    '나이': [3, 25, 28, 22, 26, 24],
    '점수': [95, 85, 92, 88, 90, 87],
    '학과': ['컴공', '경영', '컴공', '경영', '컴공', '수학']
})

# 처음 5행
print("처음 5행:")
print(df.head())

# 처음 3행
print("\n처음 3행:")
print(df.head(3))

# 마지막 3행
print("\n마지막 3행:")
print(df.tail(3))

# 요약 통계
print("\n요약 통계:")
print(df.describe())

# 기본 정보
print("\n기본 정보:")
print(df.info())
```

### 열(Column) 선택

```python
# 단일 열 선택 (Series 반환)
names = df['이름']
print("이름 열:")
print(names)
print(f"타입: {type(names)}")

# 여러 열 선택 (DataFrame 반환)
subset = df[['이름', '점수']]
print("\n이름과 점수:")
print(subset)

# 새로운 열 추가
df['합격여부'] = df['점수'] >= 90
print("\n합격여부 열 추가:")
print(df)

# 열 삭제
df_dropped = df.drop('합격여부', axis=1)
print("\n열 삭제 후:")
print(df_dropped)
```

### 행(Row) 선택

```python
# 인덱스로 선택 (iloc)
print("첫 번째 행 (iloc[0]):")
print(df.iloc[0])

print("\n첫 3행:")
print(df.iloc[:3])

print("\n특정 위치 (2행 2열):")
print(df.iloc[1, 1])

# 라벨로 선택 (loc)
df_with_index = df.set_index('이름')
print("\n이름을 인덱스로 설정:")
print(df_with_index)

print("\n'바데부' 행:")
print(df_with_index.loc['바데부'])
```

### 조건으로 필터링

```python
# 조건 필터링
high_score = df[df['점수'] >= 90]
print("점수 90점 이상:")
print(high_score)

# 여러 조건 (AND)
result = df[(df['점수'] >= 90) & (df['나이'] < 10)]
print("\n점수 90점 이상이고 나이 10살 미만:")
print(result)

# 여러 조건 (OR)
result = df[(df['학과'] == '컴공') | (df['점수'] >= 90)]
print("\n컴공이거나 점수 90점 이상:")
print(result)

# isin 사용
result = df[df['학과'].isin(['컴공', '수학'])]
print("\n컴공 또는 수학:")
print(result)
```

### 정렬

```python
# 점수로 오름차순 정렬
sorted_df = df.sort_values('점수')
print("점수 오름차순:")
print(sorted_df)

# 점수로 내림차순 정렬
sorted_df = df.sort_values('점수', ascending=False)
print("\n점수 내림차순:")
print(sorted_df)

# 여러 열로 정렬
sorted_df = df.sort_values(['학과', '점수'], ascending=[True, False])
print("\n학과 오름차순, 점수 내림차순:")
print(sorted_df)
```

### 집계 함수

```python
# 기본 집계
print(f"평균 점수: {df['점수'].mean():.2f}")
print(f"최고 점수: {df['점수'].max()}")
print(f"최저 점수: {df['점수'].min()}")
print(f"점수 합계: {df['점수'].sum()}")
print(f"표준편차: {df['점수'].std():.2f}")

# 그룹별 집계
grouped = df.groupby('학과')['점수'].mean()
print("\n학과별 평균 점수:")
print(grouped)

# 여러 집계 함수
grouped = df.groupby('학과')['점수'].agg(['mean', 'max', 'min', 'count'])
print("\n학과별 상세 통계:")
print(grouped)
```

## 3.3 데이터 불러오기와 저장하기

### CSV 파일

```python
# CSV 파일 생성
df = pd.DataFrame({
    '이름': ['바데부', '철수', '영희'],
    '나이': [3, 25, 28],
    '점수': [95, 85, 92]
})

# CSV로 저장
df.to_csv('students.csv', index=False, encoding='utf-8-sig')
print("CSV 파일 저장 완료!")

# CSV 파일 읽기
df_loaded = pd.read_csv('students.csv')
print("\n불러온 데이터:")
print(df_loaded)

# URL에서 직접 읽기
url = 'https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv'
titanic = pd.read_csv(url)
print("\nTitanic 데이터 (처음 5행):")
print(titanic.head())
```

### Excel 파일

```python
# Excel 설치 필요
!pip install openpyxl

# Excel로 저장
df.to_excel('students.xlsx', index=False, sheet_name='학생정보')
print("Excel 파일 저장 완료!")

# Excel 파일 읽기
df_excel = pd.read_excel('students.xlsx', sheet_name='학생정보')
print("\n불러온 데이터:")
print(df_excel)
```

### JSON 파일

```python
# JSON으로 저장
df.to_json('students.json', orient='records', force_ascii=False)
print("JSON 파일 저장 완료!")

# JSON 파일 읽기
df_json = pd.read_json('students.json')
print("\n불러온 데이터:")
print(df_json)
```

## 3.4 데이터 전처리

### 결측치 처리

```python
# 결측치가 있는 데이터 생성
df = pd.DataFrame({
    '이름': ['바데부', '철수', '영희', '민수'],
    '나이': [3, 25, None, 22],
    '점수': [95, None, 92, 88]
})

print("원본 데이터:")
print(df)

# 결측치 확인
print("\n결측치 개수:")
print(df.isnull().sum())

# 결측치 제거
df_dropped = df.dropna()
print("\n결측치 제거:")
print(df_dropped)

# 결측치 채우기
df_filled = df.fillna(0)
print("\n0으로 채우기:")
print(df_filled)

# 평균으로 채우기
df_filled = df.fillna(df.mean())
print("\n평균으로 채우기:")
print(df_filled)
```

### 중복 데이터 처리

```python
# 중복 데이터
df = pd.DataFrame({
    '이름': ['바데부', '철수', '바데부', '영희'],
    '나이': [3, 25, 3, 28]
})

print("원본 데이터:")
print(df)

# 중복 확인
print(f"\n중복 개수: {df.duplicated().sum()}")

# 중복 제거
df_unique = df.drop_duplicates()
print("\n중복 제거:")
print(df_unique)
```

### 데이터 타입 변환

```python
# 데이터 생성
df = pd.DataFrame({
    '이름': ['바데부', '철수', '영희'],
    '나이': ['3', '25', '28'],  # 문자열
    '점수': [95.5, 85.0, 92.3]
})

print("원본 타입:")
print(df.dtypes)

# 타입 변환
df['나이'] = df['나이'].astype(int)
df['점수'] = df['점수'].astype(int)

print("\n변환 후 타입:")
print(df.dtypes)
print("\n변환 후 데이터:")
print(df)
```

## 3.5 실전 데이터 분석 예제

### 타이타닉 데이터 분석

```python
# 타이타닉 데이터 로드
url = 'https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv'
titanic = pd.read_csv(url)

# 기본 정보
print("데이터 형태:", titanic.shape)
print("\n처음 5행:")
print(titanic.head())

# 생존율 계산
survival_rate = titanic['Survived'].mean() * 100
print(f"\n전체 생존율: {survival_rate:.2f}%")

# 성별 생존율
gender_survival = titanic.groupby('Sex')['Survived'].mean() * 100
print("\n성별 생존율:")
print(gender_survival)

# 등급별 생존율
class_survival = titanic.groupby('Pclass')['Survived'].mean() * 100
print("\n등급별 생존율:")
print(class_survival)

# 나이대별 생존율
titanic['Age_Group'] = pd.cut(titanic['Age'],
                               bins=[0, 18, 35, 60, 100],
                               labels=['어린이', '청년', '중년', '노년'])
age_survival = titanic.groupby('Age_Group')['Survived'].mean() * 100
print("\n나이대별 생존율:")
print(age_survival)
```

## 3.6 바데부의 실전 팁

### 팁 1: 체이닝 활용

```python
# 여러 작업을 한 번에!
result = (df
    .query('점수 >= 90')
    .sort_values('점수', ascending=False)
    .head(3)
)
```

### 팁 2: 유용한 pandas 옵션

```python
# 표시 옵션 설정
pd.set_option('display.max_rows', 100)      # 최대 표시 행
pd.set_option('display.max_columns', 20)    # 최대 표시 열
pd.set_option('display.width', 1000)        # 출력 너비
pd.set_option('display.precision', 2)       # 소수점 자릿수
```

### 팁 3: 빠른 데이터 확인

```python
# 한 줄로 데이터 요약
df.describe(include='all')  # 모든 열 통계
df.info()                   # 메모리 사용량 포함
df.nunique()               # 고유값 개수
```

### 팁 4: apply 함수 활용

```python
# 커스텀 함수 적용
def grade(score):
    if score >= 90:
        return 'A'
    elif score >= 80:
        return 'B'
    elif score >= 70:
        return 'C'
    else:
        return 'F'

df['학점'] = df['점수'].apply(grade)
```

## 연습 문제

1. NumPy로 1부터 100까지의 배열을 만들고 평균과 표준편차를 계산하세요
2. pandas DataFrame을 생성하고 학생 5명의 정보를 입력하세요
3. 타이타닉 데이터에서 30세 이상 생존자의 평균 요금을 계산하세요
4. 결측치가 있는 데이터를 만들고 적절히 처리해보세요
5. CSV 파일을 읽고 그룹별 집계를 수행해보세요

## 다음 단계

다음 챕터에서는 **데이터 시각화**를 배워봅시다! matplotlib, seaborn, plotly로 멋진 그래프를 만들어볼 거예요!

## 핵심 요약

- NumPy: 빠른 수치 계산, 배열 연산
- pandas Series: 1차원 데이터 (인덱스 + 값)
- pandas DataFrame: 2차원 테이블 데이터
- iloc: 위치 기반 인덱싱, loc: 라벨 기반 인덱싱
- read_csv/to_csv: CSV 파일 입출력
- dropna/fillna: 결측치 처리
- groupby: 그룹별 집계
- sort_values: 정렬
- describe: 요약 통계

바데부와 함께 데이터 분석 마스터! 📊
