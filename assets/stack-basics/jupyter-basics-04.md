# Chapter 4: 데이터 시각화

안녕하세요! 바데부입니다! 데이터를 그래프로 표현하면 한눈에 이해할 수 있어요! matplotlib, seaborn, plotly로 멋진 시각화를 만들어봅시다! 📈

## 4.1 Matplotlib 기초

matplotlib는 Python의 대표적인 시각화 라이브러리예요!

### Matplotlib 시작하기

```python
# 라이브러리 임포트
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# Jupyter/Colab에서 그래프 표시
%matplotlib inline

# 한글 폰트 설정 (Colab)
!apt-get install -y fonts-nanum
!fc-cache -fv
!rm ~/.cache/matplotlib -rf

import matplotlib.pyplot as plt
plt.rcParams['font.family'] = 'NanumGothic'
plt.rcParams['axes.unicode_minus'] = False  # 마이너스 기호 깨짐 방지
```

### 기본 선 그래프

```python
# 데이터 준비
x = [1, 2, 3, 4, 5]
y = [2, 4, 6, 8, 10]

# 그래프 그리기
plt.plot(x, y)
plt.title('바데부의 첫 그래프')
plt.xlabel('X축')
plt.ylabel('Y축')
plt.grid(True)
plt.show()
```

### 선 스타일 꾸미기

```python
# 여러 선 그리기
x = np.linspace(0, 10, 100)
y1 = np.sin(x)
y2 = np.cos(x)

plt.figure(figsize=(10, 6))  # 크기 설정

plt.plot(x, y1, 'r-', label='sin(x)', linewidth=2)    # 빨간 실선
plt.plot(x, y2, 'b--', label='cos(x)', linewidth=2)   # 파란 점선

plt.title('삼각함수 그래프', fontsize=16)
plt.xlabel('x', fontsize=12)
plt.ylabel('y', fontsize=12)
plt.legend(fontsize=10)
plt.grid(True, alpha=0.3)
plt.show()
```

**선 스타일:**
- `-`: 실선
- `--`: 점선
- `-.`: 일점쇄선
- `:`: 점선
- `o`: 원 마커
- `^`: 삼각형 마커

**색상:**
- `r`: 빨강
- `g`: 초록
- `b`: 파랑
- `k`: 검정
- `y`: 노랑
- `c`: 청록
- `m`: 자홍

### 산점도 (Scatter Plot)

```python
# 랜덤 데이터 생성
np.random.seed(42)
x = np.random.randn(100)
y = np.random.randn(100)
colors = np.random.rand(100)
sizes = 1000 * np.random.rand(100)

# 산점도
plt.figure(figsize=(10, 6))
plt.scatter(x, y, c=colors, s=sizes, alpha=0.5, cmap='viridis')
plt.colorbar(label='색상 값')
plt.title('산점도 예제')
plt.xlabel('X')
plt.ylabel('Y')
plt.grid(True, alpha=0.3)
plt.show()
```

### 막대 그래프 (Bar Chart)

```python
# 데이터
categories = ['Python', 'JavaScript', 'Java', 'C++', 'Go']
values = [85, 70, 60, 55, 50]

# 세로 막대 그래프
plt.figure(figsize=(10, 6))
bars = plt.bar(categories, values, color=['#3776ab', '#f7df1e', '#007396', '#00599c', '#00add8'])

# 값 표시
for bar in bars:
    height = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2., height,
             f'{height}점',
             ha='center', va='bottom')

plt.title('프로그래밍 언어별 인기도')
plt.xlabel('언어')
plt.ylabel('점수')
plt.ylim(0, 100)
plt.grid(True, alpha=0.3, axis='y')
plt.show()

# 가로 막대 그래프
plt.figure(figsize=(10, 6))
plt.barh(categories, values, color='skyblue')
plt.title('프로그래밍 언어별 인기도 (가로)')
plt.xlabel('점수')
plt.ylabel('언어')
plt.grid(True, alpha=0.3, axis='x')
plt.show()
```

### 히스토그램 (Histogram)

```python
# 정규분포 데이터 생성
data = np.random.randn(1000)

plt.figure(figsize=(10, 6))
plt.hist(data, bins=30, color='skyblue', edgecolor='black', alpha=0.7)
plt.title('정규분포 히스토그램')
plt.xlabel('값')
plt.ylabel('빈도')
plt.grid(True, alpha=0.3, axis='y')
plt.axvline(data.mean(), color='red', linestyle='--', linewidth=2, label='평균')
plt.legend()
plt.show()
```

### 파이 차트 (Pie Chart)

```python
# 데이터
languages = ['Python', 'JavaScript', 'Java', 'C++', 'Others']
shares = [35, 25, 20, 10, 10]
colors = ['#3776ab', '#f7df1e', '#007396', '#00599c', '#cccccc']
explode = (0.1, 0, 0, 0, 0)  # Python 강조

plt.figure(figsize=(10, 8))
plt.pie(shares, labels=languages, colors=colors, explode=explode,
        autopct='%1.1f%%', shadow=True, startangle=90)
plt.title('프로그래밍 언어 시장 점유율')
plt.axis('equal')
plt.show()
```

### 서브플롯 (Subplots)

```python
# 여러 그래프를 한 화면에
fig, axes = plt.subplots(2, 2, figsize=(12, 10))

# 1번 그래프: 선 그래프
x = np.linspace(0, 10, 100)
axes[0, 0].plot(x, np.sin(x))
axes[0, 0].set_title('Sin 그래프')
axes[0, 0].grid(True)

# 2번 그래프: 산점도
axes[0, 1].scatter(np.random.randn(50), np.random.randn(50))
axes[0, 1].set_title('산점도')
axes[0, 1].grid(True)

# 3번 그래프: 막대 그래프
axes[1, 0].bar(['A', 'B', 'C', 'D'], [10, 20, 15, 25])
axes[1, 0].set_title('막대 그래프')
axes[1, 0].grid(True)

# 4번 그래프: 히스토그램
axes[1, 1].hist(np.random.randn(1000), bins=30)
axes[1, 1].set_title('히스토그램')
axes[1, 1].grid(True)

plt.tight_layout()
plt.show()
```

## 4.2 Seaborn으로 고급 시각화

seaborn은 matplotlib를 기반으로 더 예쁜 그래프를 쉽게 만들 수 있어요!

### Seaborn 시작하기

```python
import seaborn as sns

# 스타일 설정
sns.set_style('whitegrid')
sns.set_palette('husl')

# 샘플 데이터 로드
tips = sns.load_dataset('tips')
print(tips.head())
```

### 분포 시각화

```python
# 히스토그램 + KDE (커널 밀도 추정)
plt.figure(figsize=(10, 6))
sns.histplot(data=tips, x='total_bill', kde=True, bins=30)
plt.title('계산서 금액 분포')
plt.xlabel('금액 ($)')
plt.ylabel('빈도')
plt.show()

# 박스플롯
plt.figure(figsize=(10, 6))
sns.boxplot(data=tips, x='day', y='total_bill')
plt.title('요일별 계산서 금액')
plt.xlabel('요일')
plt.ylabel('금액 ($)')
plt.show()

# 바이올린 플롯
plt.figure(figsize=(10, 6))
sns.violinplot(data=tips, x='day', y='total_bill', hue='sex')
plt.title('요일별/성별 계산서 금액 분포')
plt.xlabel('요일')
plt.ylabel('금액 ($)')
plt.show()
```

### 관계 시각화

```python
# 산점도
plt.figure(figsize=(10, 6))
sns.scatterplot(data=tips, x='total_bill', y='tip', hue='time', size='size')
plt.title('계산서 금액과 팁의 관계')
plt.xlabel('계산서 금액 ($)')
plt.ylabel('팁 ($)')
plt.show()

# 회귀선 포함 산점도
plt.figure(figsize=(10, 6))
sns.regplot(data=tips, x='total_bill', y='tip', scatter_kws={'alpha':0.5})
plt.title('계산서 금액과 팁의 상관관계')
plt.xlabel('계산서 금액 ($)')
plt.ylabel('팁 ($)')
plt.show()

# 페어플롯 (모든 변수 쌍의 관계)
sns.pairplot(tips, hue='time')
plt.show()
```

### 카테고리 시각화

```python
# 카운트 플롯
plt.figure(figsize=(10, 6))
sns.countplot(data=tips, x='day', hue='sex')
plt.title('요일별 방문자 수')
plt.xlabel('요일')
plt.ylabel('방문자 수')
plt.show()

# 막대 그래프
plt.figure(figsize=(10, 6))
sns.barplot(data=tips, x='day', y='total_bill', hue='sex', ci=None)
plt.title('요일별/성별 평균 계산서 금액')
plt.xlabel('요일')
plt.ylabel('평균 금액 ($)')
plt.show()
```

### 히트맵 (Heatmap)

```python
# 상관관계 행렬
plt.figure(figsize=(10, 8))
correlation = tips.corr(numeric_only=True)
sns.heatmap(correlation, annot=True, cmap='coolwarm', center=0,
            square=True, linewidths=1)
plt.title('변수 간 상관관계')
plt.show()

# 피벗 테이블 히트맵
pivot = tips.pivot_table(values='tip', index='day', columns='time', aggfunc='mean')
plt.figure(figsize=(8, 6))
sns.heatmap(pivot, annot=True, fmt='.2f', cmap='YlOrRd')
plt.title('요일/시간대별 평균 팁')
plt.show()
```

## 4.3 Plotly로 인터랙티브 시각화

plotly는 상호작용이 가능한 동적 그래프를 만들어요!

### Plotly 시작하기

```python
!pip install plotly

import plotly.express as px
import plotly.graph_objects as go
```

### 인터랙티브 선 그래프

```python
# 데이터 준비
df = pd.DataFrame({
    '날짜': pd.date_range('2024-01-01', periods=100),
    '방문자': np.random.randint(100, 500, 100)
})

# 그래프 생성
fig = px.line(df, x='날짜', y='방문자', title='일일 방문자 수')
fig.update_traces(line_color='#3776ab', line_width=3)
fig.show()
```

### 인터랙티브 산점도

```python
# Iris 데이터
iris = px.data.iris()

fig = px.scatter(iris, x='sepal_width', y='sepal_length',
                 color='species', size='petal_length',
                 hover_data=['petal_width'],
                 title='Iris 데이터셋')
fig.show()
```

### 3D 산점도

```python
fig = px.scatter_3d(iris, x='sepal_length', y='sepal_width', z='petal_length',
                    color='species', size='petal_width',
                    title='Iris 3D 산점도')
fig.show()
```

### 인터랙티브 막대 그래프

```python
# 데이터
df = pd.DataFrame({
    '언어': ['Python', 'JavaScript', 'Java', 'C++', 'Go'],
    '2023': [80, 65, 55, 50, 45],
    '2024': [85, 70, 60, 55, 50]
})

fig = go.Figure(data=[
    go.Bar(name='2023', x=df['언어'], y=df['2023']),
    go.Bar(name='2024', x=df['언어'], y=df['2024'])
])

fig.update_layout(
    title='프로그래밍 언어 인기도 변화',
    xaxis_title='언어',
    yaxis_title='점수',
    barmode='group'
)
fig.show()
```

### 애니메이션

```python
# 가상의 시계열 데이터
df = pd.DataFrame({
    '연도': list(range(2020, 2025)) * 5,
    '언어': ['Python'] * 5 + ['JavaScript'] * 5 + ['Java'] * 5 + ['C++'] * 5 + ['Go'] * 5,
    '점수': [70, 75, 78, 82, 85] + [60, 63, 65, 68, 70] + [65, 62, 60, 58, 55] +
            [55, 53, 52, 51, 50] + [30, 35, 40, 45, 50]
})

fig = px.bar(df, x='언어', y='점수', color='언어',
             animation_frame='연도',
             range_y=[0, 100],
             title='프로그래밍 언어 인기도 변화 (2020-2024)')
fig.show()
```

## 4.4 실전 데이터 시각화

### 타이타닉 데이터 시각화

```python
# 데이터 로드
url = 'https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv'
titanic = pd.read_csv(url)

# 1. 생존율 파이 차트
plt.figure(figsize=(8, 8))
survival_counts = titanic['Survived'].value_counts()
plt.pie(survival_counts, labels=['사망', '생존'], autopct='%1.1f%%',
        colors=['#ff6b6b', '#51cf66'], startangle=90)
plt.title('타이타닉 생존율')
plt.show()

# 2. 등급별 생존자 수
plt.figure(figsize=(10, 6))
sns.countplot(data=titanic, x='Pclass', hue='Survived')
plt.title('등급별 생존자/사망자 수')
plt.xlabel('등급')
plt.ylabel('인원 수')
plt.legend(title='생존', labels=['사망', '생존'])
plt.show()

# 3. 성별/등급별 생존율
plt.figure(figsize=(12, 6))
survival_rate = titanic.groupby(['Sex', 'Pclass'])['Survived'].mean().reset_index()
sns.barplot(data=survival_rate, x='Pclass', y='Survived', hue='Sex')
plt.title('성별/등급별 생존율')
plt.xlabel('등급')
plt.ylabel('생존율')
plt.ylim(0, 1)
plt.show()

# 4. 나이 분포
plt.figure(figsize=(12, 6))
plt.subplot(1, 2, 1)
titanic[titanic['Survived']==0]['Age'].hist(bins=30, alpha=0.7, label='사망')
titanic[titanic['Survived']==1]['Age'].hist(bins=30, alpha=0.7, label='생존')
plt.title('생존 여부에 따른 나이 분포')
plt.xlabel('나이')
plt.ylabel('빈도')
plt.legend()

plt.subplot(1, 2, 2)
sns.boxplot(data=titanic, x='Survived', y='Age')
plt.title('생존 여부에 따른 나이 박스플롯')
plt.xlabel('생존 (0: 사망, 1: 생존)')
plt.ylabel('나이')

plt.tight_layout()
plt.show()
```

## 4.5 그래프 저장하기

### Matplotlib 그래프 저장

```python
# 그래프 생성
plt.figure(figsize=(10, 6))
plt.plot([1, 2, 3, 4], [1, 4, 9, 16])
plt.title('바데부의 그래프')

# 저장 (다양한 형식)
plt.savefig('graph.png', dpi=300, bbox_inches='tight')
plt.savefig('graph.pdf', bbox_inches='tight')
plt.savefig('graph.svg', bbox_inches='tight')
plt.show()

print("그래프가 저장되었습니다!")
```

### Plotly 그래프 저장

```python
# HTML로 저장 (인터랙티브 유지)
fig = px.scatter(iris, x='sepal_width', y='sepal_length', color='species')
fig.write_html('interactive_graph.html')

# 정적 이미지로 저장
!pip install -U kaleido
fig.write_image('graph.png')
fig.write_image('graph.pdf')

print("Plotly 그래프가 저장되었습니다!")
```

## 4.6 바데부의 실전 팁

### 팁 1: 색상 팔레트 선택

```python
# Seaborn 색상 팔레트
sns.set_palette('husl')        # 밝고 다양한 색
sns.set_palette('Set2')        # 파스텔톤
sns.set_palette('muted')       # 차분한 색
sns.set_palette('deep')        # 진한 색

# 커스텀 색상
custom_colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A', '#98D8C8']
sns.set_palette(custom_colors)
```

### 팁 2: 그래프 스타일

```python
# Matplotlib 스타일
plt.style.use('ggplot')        # R의 ggplot2 스타일
plt.style.use('seaborn-v0_8')  # seaborn 스타일
plt.style.use('bmh')           # Bayesian Methods for Hackers

# 사용 가능한 스타일 확인
print(plt.style.available)
```

### 팁 3: 한글 폰트 빠른 설정

```python
# Colab 한글 설정 (간단 버전)
!apt-get install -qq fonts-nanum
!fc-cache -fv
!rm ~/.cache/matplotlib -rf

import matplotlib.pyplot as plt
plt.rcParams['font.family'] = 'NanumGothic'
plt.rcParams['axes.unicode_minus'] = False
```

### 팁 4: 그래프 품질 향상

```python
# 고해상도 그래프
plt.figure(figsize=(12, 8), dpi=100)

# 저장 시 고품질
plt.savefig('high_quality.png', dpi=300, bbox_inches='tight',
            facecolor='white', edgecolor='none')
```

## 연습 문제

1. matplotlib로 sin, cos, tan 그래프를 한 화면에 그려보세요
2. seaborn으로 타이타닉 데이터의 히트맵을 만들어보세요
3. plotly로 인터랙티브 3D 산점도를 만들어보세요
4. 서브플롯을 사용하여 4가지 다른 그래프를 한 화면에 배치하세요
5. 자신만의 색상 팔레트로 그래프를 꾸며보세요

## 다음 단계

다음 챕터에서는 **파일 업로드와 다운로드**를 배워봅시다! Colab과 Jupyter에서 파일을 다루는 다양한 방법을 알아볼 거예요!

## 핵심 요약

- matplotlib: 기본 시각화 라이브러리
- seaborn: 고급 통계 시각화
- plotly: 인터랙티브 시각화
- plt.plot(): 선 그래프
- plt.scatter(): 산점도
- plt.bar()/barh(): 막대 그래프
- plt.hist(): 히스토그램
- plt.pie(): 파이 차트
- sns.heatmap(): 히트맵
- px.scatter_3d(): 3D 산점도
- plt.savefig(): 그래프 저장

바데부와 함께 시각화 마스터! 📊
