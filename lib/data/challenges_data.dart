/// 로컬 챌린지 데이터
/// 13개 언어 × 10개 단원 × 5개 문제 = 650개

class ChallengesData {
  static List<Map<String, dynamic>> getAllChallenges() {
    final challenges = <Map<String, dynamic>>[];

    // 13개 언어
    final languages = [
      'python', 'dart', 'go', 'java', 'typescript',
      'javascript', 'sql', 'c', 'cpp', 'csharp',
      'kotlin', 'html', 'css'
    ];

    for (final lang in languages) {
      challenges.addAll(_generateChallengesForLanguage(lang));
    }

    return challenges;
  }

  static List<Map<String, dynamic>> _generateChallengesForLanguage(String language) {
    final challenges = <Map<String, dynamic>>[];
    final units = _getUnitsForLanguage(language);

    for (int unitNum = 1; unitNum <= 10; unitNum++) {
      final unitName = units[unitNum - 1];

      for (int problemNum = 1; problemNum <= 5; problemNum++) {
        challenges.add({
          'slug': '${language}-unit${unitNum}-problem${problemNum}',
          'language': language,
          'unit': unitNum,
          'title': '$unitName - 문제 $problemNum',
          'description': '$language의 $unitName 학습을 위한 문제입니다.',
          'difficulty': _getDifficulty(unitNum),
          'points': unitNum * 10,
          'starter_code': _getStarterCode(language, unitNum, problemNum),
          'solution': _getSolution(language, unitNum, problemNum),
          'test_cases': _getTestCases(language, unitNum, problemNum),
          'hints': _getHints(language, unitNum, problemNum),
        });
      }
    }

    return challenges;
  }

  static List<String> _getUnitsForLanguage(String language) {
    switch (language) {
      case 'python':
        return [
          '기본 문법과 변수',
          '조건문과 반복문',
          '리스트와 튜플',
          '딕셔너리와 집합',
          '함수 정의',
          '클래스와 객체',
          '파일 입출력',
          '예외 처리',
          '모듈과 패키지',
          '고급 기능',
        ];
      case 'dart':
        return [
          '변수와 데이터 타입',
          '제어 구조',
          '함수',
          '리스트와 맵',
          '클래스 기초',
          '상속과 인터페이스',
          'Null Safety',
          '비동기 프로그래밍',
          '제네릭',
          '고급 패턴',
        ];
      case 'go':
        return [
          '변수와 상수',
          '제어문',
          '함수',
          '배열과 슬라이스',
          '맵과 구조체',
          '포인터',
          '메서드와 인터페이스',
          '고루틴',
          '채널',
          '패키지 관리',
        ];
      case 'java':
        return [
          '변수와 자료형',
          '연산자와 제어문',
          '배열',
          '클래스와 객체',
          '상속',
          '인터페이스',
          '예외 처리',
          '컬렉션',
          '제네릭',
          '스트림 API',
        ];
      case 'typescript':
        return [
          '기본 타입',
          '인터페이스',
          '클래스',
          '함수',
          '제네릭',
          '유니온과 인터섹션',
          '타입 가드',
          '데코레이터',
          '모듈',
          '고급 타입',
        ];
      case 'javascript':
        return [
          '변수와 데이터 타입',
          '연산자와 제어문',
          '함수',
          '배열과 객체',
          'DOM 조작',
          '이벤트 처리',
          '비동기 처리',
          'Promise와 Async/Await',
          'ES6+ 문법',
          '모듈 시스템',
        ];
      case 'sql':
        return [
          'SELECT 기초',
          'WHERE 조건',
          'JOIN',
          'GROUP BY와 집계',
          'SUBQUERY',
          'INSERT/UPDATE/DELETE',
          '인덱스',
          '뷰',
          '트랜잭션',
          '고급 쿼리',
        ];
      case 'c':
        return [
          '변수와 자료형',
          '연산자',
          '제어문',
          '배열',
          '포인터 기초',
          '함수',
          '구조체',
          '파일 입출력',
          '동적 메모리',
          '전처리기',
        ];
      case 'cpp':
        return [
          'C++ 기초',
          '참조와 포인터',
          '클래스',
          '상속',
          '다형성',
          '연산자 오버로딩',
          'STL 컨테이너',
          '템플릿',
          '예외 처리',
          '스마트 포인터',
        ];
      case 'csharp':
        return [
          '변수와 타입',
          '제어문',
          '메서드',
          '클래스와 객체',
          '상속과 다형성',
          '인터페이스',
          '컬렉션',
          'LINQ',
          '비동기',
          '델리게이트와 이벤트',
        ];
      case 'kotlin':
        return [
          '변수와 타입',
          '제어 흐름',
          '함수',
          '클래스',
          '상속',
          '인터페이스',
          'Null Safety',
          '확장 함수',
          '코루틴',
          '고급 기능',
        ];
      case 'html':
        return [
          '기본 태그',
          '텍스트와 링크',
          '리스트',
          '테이블',
          '폼',
          '시맨틱 태그',
          '미디어',
          '메타 태그',
          '접근성',
          'HTML5 API',
        ];
      case 'css':
        return [
          '선택자',
          '박스 모델',
          '색상과 배경',
          '텍스트 스타일',
          '레이아웃 기초',
          'Flexbox',
          'Grid',
          '반응형 디자인',
          '애니메이션',
          '고급 기법',
        ];
      default:
        return List.generate(10, (i) => '단원 ${i + 1}');
    }
  }

  static String _getDifficulty(int unit) {
    if (unit <= 3) return 'easy';
    if (unit <= 7) return 'medium';
    return 'hard';
  }

  static String _getStarterCode(String language, int unit, int problem) {
    switch (language) {
      case 'python':
        return '''def solution():
    # 여기에 코드를 작성하세요
    pass

# 테스트
print(solution())''';
      case 'dart':
        return '''void solution() {
  // 여기에 코드를 작성하세요
}

void main() {
  print(solution());
}''';
      case 'javascript':
        return '''function solution() {
  // 여기에 코드를 작성하세요
}

console.log(solution());''';
      case 'java':
        return '''public class Solution {
    public static void solution() {
        // 여기에 코드를 작성하세요
    }

    public static void main(String[] args) {
        System.out.println(solution());
    }
}''';
      case 'go':
        return '''package main

import "fmt"

func solution() {
    // 여기에 코드를 작성하세요
}

func main() {
    fmt.Println(solution())
}''';
      case 'typescript':
        return '''function solution(): void {
  // 여기에 코드를 작성하세요
}

console.log(solution());''';
      case 'sql':
        return '''-- 여기에 SQL 쿼리를 작성하세요
SELECT * FROM table_name;''';
      case 'c':
        return '''#include <stdio.h>

void solution() {
    // 여기에 코드를 작성하세요
}

int main() {
    solution();
    return 0;
}''';
      case 'cpp':
        return '''#include <iostream>
using namespace std;

void solution() {
    // 여기에 코드를 작성하세요
}

int main() {
    solution();
    return 0;
}''';
      case 'csharp':
        return '''using System;

class Solution {
    static void Main() {
        // 여기에 코드를 작성하세요
    }
}''';
      case 'kotlin':
        return '''fun solution() {
    // 여기에 코드를 작성하세요
}

fun main() {
    println(solution())
}''';
      case 'html':
        return '''<!DOCTYPE html>
<html>
<head>
    <title>문제 $problem</title>
</head>
<body>
    <!-- 여기에 HTML을 작성하세요 -->
</body>
</html>''';
      case 'css':
        return '''/* 여기에 CSS를 작성하세요 */
.container {

}''';
      default:
        return '// 코드를 작성하세요';
    }
  }

  static String _getSolution(String language, int unit, int problem) {
    return '// 정답 코드 (관리자용)';
  }

  static List<Map<String, dynamic>> _getTestCases(String language, int unit, int problem) {
    return [
      {'input': 'test1', 'expected': 'result1'},
      {'input': 'test2', 'expected': 'result2'},
      {'input': 'test3', 'expected': 'result3'},
    ];
  }

  static List<String> _getHints(String language, int unit, int problem) {
    return [
      '힌트 1: 문제를 작은 단위로 나누어 생각해보세요.',
      '힌트 2: 예제 입출력을 먼저 분석해보세요.',
      '힌트 3: 비슷한 문제를 풀어본 경험을 떠올려보세요.',
    ];
  }
}
