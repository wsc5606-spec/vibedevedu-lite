# Chapter 9: 테스트 작성하기

## 학습 목표
- JUnit을 사용한 단위 테스트 작성하기
- Mockito로 Mock 객체 활용하기
- Spring Boot Test로 통합 테스트하기
- 테스트 주도 개발(TDD) 이해하기

## 테스트가 중요한 이유

1. **버그 조기 발견**: 개발 단계에서 문제 발견
2. **리팩토링 안정성**: 코드 변경 시 기존 기능 보장
3. **문서화**: 테스트 코드가 사용법을 보여줌
4. **코드 품질 향상**: 테스트하기 쉬운 코드는 좋은 설계

## 테스트 종류

```
단위 테스트 (Unit Test)
    ↓ - 개별 클래스/메서드 테스트
    ↓ - 빠르고 많이 작성

통합 테스트 (Integration Test)
    ↓ - 여러 컴포넌트 함께 테스트
    ↓ - 실제 DB, 외부 API 연동

E2E 테스트 (End-to-End Test)
    - 전체 시스템 테스트
    - 사용자 시나리오 테스트
```

## 프로젝트 설정

### 1. 의존성 (pom.xml)

```xml
<dependencies>
    <!-- Spring Boot Test -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>

    <!-- JUnit 5 (포함됨) -->
    <!-- Mockito (포함됨) -->
    <!-- AssertJ (포함됨) -->

    <!-- H2 Database (테스트용) -->
    <dependency>
        <groupId>com.h2database</groupId>
        <artifactId>h2</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### 2. 테스트 설정 (src/test/resources/application.properties)

```properties
# H2 인메모리 데이터베이스
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driverClassName=org.h2.Driver
spring.jpa.hibernate.ddl-auto=create-drop

# 로깅
logging.level.com.badebu=DEBUG

# 바데부 테스트 환경
spring.profiles.active=test
```

## JUnit 5 기본 테스트

### 1. 간단한 단위 테스트

```java
package com.badebu.learningapp.util;

import org.junit.jupiter.api.*;
import static org.assertj.core.api.Assertions.*;

class BadebuCalculatorTest {

    private BadebuCalculator calculator;

    @BeforeEach
    void setUp() {
        calculator = new BadebuCalculator();
        System.out.println("바데부: 테스트 준비 완료!");
    }

    @AfterEach
    void tearDown() {
        System.out.println("바데부: 테스트 종료!");
    }

    @Test
    @DisplayName("바데부: 두 수를 더하는 테스트")
    void testAdd() {
        // Given (준비)
        int a = 10;
        int b = 20;

        // When (실행)
        int result = calculator.add(a, b);

        // Then (검증)
        assertThat(result).isEqualTo(30);
        System.out.println("바데부: 덧셈 테스트 성공!");
    }

    @Test
    @DisplayName("바데부: 0으로 나누기 예외 테스트")
    void testDivideByZero() {
        // Given
        int a = 10;
        int b = 0;

        // When & Then
        assertThatThrownBy(() -> calculator.divide(a, b))
            .isInstanceOf(ArithmeticException.class)
            .hasMessage("바데부: 0으로 나눌 수 없습니다!");
    }

    @Test
    @DisplayName("바데부: 음수 처리 테스트")
    void testNegativeNumbers() {
        // Given
        int a = -5;
        int b = 10;

        // When
        int result = calculator.add(a, b);

        // Then
        assertThat(result).isEqualTo(5);
    }

    @ParameterizedTest
    @DisplayName("바데부: 여러 입력값 테스트")
    @CsvSource({
        "1, 1, 2",
        "2, 3, 5",
        "10, 20, 30",
        "-5, 5, 0"
    })
    void testAddWithMultipleInputs(int a, int b, int expected) {
        int result = calculator.add(a, b);
        assertThat(result).isEqualTo(expected);
    }
}

// 테스트 대상 클래스
class BadebuCalculator {
    public int add(int a, int b) {
        return a + b;
    }

    public int subtract(int a, int b) {
        return a - b;
    }

    public int multiply(int a, int b) {
        return a * b;
    }

    public int divide(int a, int b) {
        if (b == 0) {
            throw new ArithmeticException("바데부: 0으로 나눌 수 없습니다!");
        }
        return a / b;
    }
}
```

### JUnit 주요 어노테이션

| 어노테이션 | 설명 |
|-----------|------|
| @Test | 테스트 메서드 |
| @BeforeEach | 각 테스트 전 실행 |
| @AfterEach | 각 테스트 후 실행 |
| @BeforeAll | 전체 테스트 시작 전 1회 실행 (static) |
| @AfterAll | 전체 테스트 종료 후 1회 실행 (static) |
| @DisplayName | 테스트 이름 지정 |
| @Disabled | 테스트 비활성화 |
| @ParameterizedTest | 파라미터화된 테스트 |

## Repository 테스트

```java
package com.badebu.learningapp.repository;

import com.badebu.learningapp.entity.Student;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;

@DataJpaTest
@DisplayName("바데부: StudentRepository 테스트")
class StudentRepositoryTest {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private TestEntityManager entityManager;

    @Test
    @DisplayName("바데부: 학생 저장 테스트")
    void testSaveStudent() {
        // Given
        Student student = new Student("바데부", "badebu@example.com", "beginner");

        // When
        Student saved = studentRepository.save(student);

        // Then
        assertThat(saved.getId()).isNotNull();
        assertThat(saved.getName()).isEqualTo("바데부");
        assertThat(saved.getEmail()).isEqualTo("badebu@example.com");
        System.out.println("바데부: 저장 테스트 성공!");
    }

    @Test
    @DisplayName("바데부: ID로 학생 조회 테스트")
    void testFindById() {
        // Given
        Student student = new Student("바데부", "badebu@example.com", "beginner");
        Student saved = entityManager.persist(student);
        entityManager.flush();

        // When
        Optional<Student> found = studentRepository.findById(saved.getId());

        // Then
        assertThat(found).isPresent();
        assertThat(found.get().getName()).isEqualTo("바데부");
    }

    @Test
    @DisplayName("바데부: 이메일로 학생 조회 테스트")
    void testFindByEmail() {
        // Given
        Student student = new Student("바데부", "badebu@example.com", "beginner");
        entityManager.persist(student);
        entityManager.flush();

        // When
        Optional<Student> found = studentRepository.findByEmail("badebu@example.com");

        // Then
        assertThat(found).isPresent();
        assertThat(found.get().getName()).isEqualTo("바데부");
    }

    @Test
    @DisplayName("바데부: 레벨별 학생 조회 테스트")
    void testFindByLevel() {
        // Given
        Student student1 = new Student("바데부1", "badebu1@example.com", "beginner");
        Student student2 = new Student("바데부2", "badebu2@example.com", "beginner");
        Student student3 = new Student("바데부3", "badebu3@example.com", "advanced");

        entityManager.persist(student1);
        entityManager.persist(student2);
        entityManager.persist(student3);
        entityManager.flush();

        // When
        List<Student> beginners = studentRepository.findByLevel("beginner");

        // Then
        assertThat(beginners).hasSize(2);
        assertThat(beginners).extracting("level").containsOnly("beginner");
    }

    @Test
    @DisplayName("바데부: 학생 삭제 테스트")
    void testDeleteStudent() {
        // Given
        Student student = new Student("바데부", "badebu@example.com", "beginner");
        Student saved = entityManager.persist(student);
        entityManager.flush();

        // When
        studentRepository.deleteById(saved.getId());

        // Then
        Optional<Student> deleted = studentRepository.findById(saved.getId());
        assertThat(deleted).isEmpty();
    }

    @Test
    @DisplayName("바데부: 이메일 존재 여부 테스트")
    void testExistsByEmail() {
        // Given
        Student student = new Student("바데부", "badebu@example.com", "beginner");
        entityManager.persist(student);
        entityManager.flush();

        // When
        boolean exists = studentRepository.existsByEmail("badebu@example.com");
        boolean notExists = studentRepository.existsByEmail("notfound@example.com");

        // Then
        assertThat(exists).isTrue();
        assertThat(notExists).isFalse();
    }
}
```

## Service 테스트 (Mockito 사용)

```java
package com.badebu.learningapp.service;

import com.badebu.learningapp.entity.Student;
import com.badebu.learningapp.exception.DuplicateResourceException;
import com.badebu.learningapp.exception.ResourceNotFoundException;
import com.badebu.learningapp.repository.StudentRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("바데부: StudentService 테스트")
class StudentServiceTest {

    @Mock
    private StudentRepository studentRepository;

    @InjectMocks
    private StudentService studentService;

    private Student testStudent;

    @BeforeEach
    void setUp() {
        testStudent = new Student("바데부", "badebu@example.com", "beginner");
        System.out.println("바데부: 테스트 데이터 준비 완료!");
    }

    @Test
    @DisplayName("바데부: 학생 생성 성공 테스트")
    void testCreateStudentSuccess() {
        // Given
        when(studentRepository.existsByEmail(anyString())).thenReturn(false);
        when(studentRepository.save(any(Student.class))).thenReturn(testStudent);

        // When
        Student created = studentService.createStudent("바데부", "badebu@example.com", "beginner");

        // Then
        assertThat(created).isNotNull();
        assertThat(created.getName()).isEqualTo("바데부");

        verify(studentRepository, times(1)).existsByEmail("badebu@example.com");
        verify(studentRepository, times(1)).save(any(Student.class));
    }

    @Test
    @DisplayName("바데부: 중복 이메일 예외 테스트")
    void testCreateStudentDuplicateEmail() {
        // Given
        when(studentRepository.existsByEmail(anyString())).thenReturn(true);

        // When & Then
        assertThatThrownBy(() ->
            studentService.createStudent("바데부", "badebu@example.com", "beginner"))
            .isInstanceOf(DuplicateResourceException.class)
            .hasMessageContaining("이미 존재하는 이메일");

        verify(studentRepository, times(1)).existsByEmail("badebu@example.com");
        verify(studentRepository, never()).save(any(Student.class));
    }

    @Test
    @DisplayName("바데부: ID로 학생 조회 성공 테스트")
    void testGetStudentByIdSuccess() {
        // Given
        when(studentRepository.findById(1L)).thenReturn(Optional.of(testStudent));

        // When
        Student found = studentService.getStudentById(1L);

        // Then
        assertThat(found).isNotNull();
        assertThat(found.getName()).isEqualTo("바데부");

        verify(studentRepository, times(1)).findById(1L);
    }

    @Test
    @DisplayName("바데부: 존재하지 않는 학생 조회 예외 테스트")
    void testGetStudentByIdNotFound() {
        // Given
        when(studentRepository.findById(999L)).thenReturn(Optional.empty());

        // When & Then
        assertThatThrownBy(() -> studentService.getStudentById(999L))
            .isInstanceOf(ResourceNotFoundException.class)
            .hasMessageContaining("학생을 찾을 수 없습니다");

        verify(studentRepository, times(1)).findById(999L);
    }

    @Test
    @DisplayName("바데부: 전체 학생 조회 테스트")
    void testGetAllStudents() {
        // Given
        Student student1 = new Student("바데부1", "badebu1@example.com", "beginner");
        Student student2 = new Student("바데부2", "badebu2@example.com", "advanced");
        when(studentRepository.findAll()).thenReturn(Arrays.asList(student1, student2));

        // When
        List<Student> students = studentService.getAllStudents();

        // Then
        assertThat(students).hasSize(2);
        assertThat(students).extracting("name").contains("바데부1", "바데부2");

        verify(studentRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("바데부: 학생 수정 테스트")
    void testUpdateStudent() {
        // Given
        when(studentRepository.findById(1L)).thenReturn(Optional.of(testStudent));
        when(studentRepository.existsByEmail("new@example.com")).thenReturn(false);
        when(studentRepository.save(any(Student.class))).thenReturn(testStudent);

        // When
        Student updated = studentService.updateStudent(1L, "새이름", "new@example.com", "advanced");

        // Then
        assertThat(updated).isNotNull();
        verify(studentRepository, times(1)).findById(1L);
        verify(studentRepository, times(1)).save(any(Student.class));
    }

    @Test
    @DisplayName("바데부: 학생 삭제 테스트")
    void testDeleteStudent() {
        // Given
        when(studentRepository.existsById(1L)).thenReturn(true);
        doNothing().when(studentRepository).deleteById(1L);

        // When
        studentService.deleteStudent(1L);

        // Then
        verify(studentRepository, times(1)).existsById(1L);
        verify(studentRepository, times(1)).deleteById(1L);
    }
}
```

### Mockito 주요 메서드

| 메서드 | 설명 |
|--------|------|
| @Mock | Mock 객체 생성 |
| @InjectMocks | Mock 객체 주입 |
| when().thenReturn() | 메서드 호출 시 반환값 지정 |
| when().thenThrow() | 메서드 호출 시 예외 발생 |
| verify() | 메서드 호출 검증 |
| times(n) | n번 호출 검증 |
| never() | 호출되지 않음 검증 |
| any() | 모든 인자 매칭 |
| anyString() | 모든 문자열 인자 매칭 |

## Controller 테스트

```java
package com.badebu.learningapp.controller;

import com.badebu.learningapp.entity.Student;
import com.badebu.learningapp.service.StudentService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.List;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.hamcrest.Matchers.*;

@WebMvcTest(StudentController.class)
@DisplayName("바데부: StudentController 테스트")
class StudentControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private StudentService studentService;

    @Test
    @DisplayName("바데부: 전체 학생 조회 API 테스트")
    void testGetAllStudents() throws Exception {
        // Given
        Student student1 = new Student("바데부1", "badebu1@example.com", "beginner");
        Student student2 = new Student("바데부2", "badebu2@example.com", "advanced");
        List<Student> students = Arrays.asList(student1, student2);

        when(studentService.getAllStudents()).thenReturn(students);

        // When & Then
        mockMvc.perform(get("/api/students"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(2)))
                .andExpect(jsonPath("$[0].name", is("바데부1")))
                .andExpect(jsonPath("$[1].name", is("바데부2")));

        verify(studentService, times(1)).getAllStudents();
    }

    @Test
    @DisplayName("바데부: 학생 생성 API 테스트")
    void testCreateStudent() throws Exception {
        // Given
        Student student = new Student("바데부", "badebu@example.com", "beginner");
        when(studentService.createStudent(anyString(), anyString(), anyString()))
            .thenReturn(student);

        String requestBody = """
            {
                "name": "바데부",
                "email": "badebu@example.com",
                "level": "beginner"
            }
            """;

        // When & Then
        mockMvc.perform(post("/api/students")
                .contentType(MediaType.APPLICATION_JSON)
                .content(requestBody))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name", is("바데부")))
                .andExpect(jsonPath("$.email", is("badebu@example.com")));

        verify(studentService, times(1)).createStudent(anyString(), anyString(), anyString());
    }

    @Test
    @DisplayName("바데부: ID로 학생 조회 API 테스트")
    void testGetStudentById() throws Exception {
        // Given
        Student student = new Student("바데부", "badebu@example.com", "beginner");
        when(studentService.getStudentById(1L)).thenReturn(student);

        // When & Then
        mockMvc.perform(get("/api/students/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name", is("바데부")))
                .andExpect(jsonPath("$.email", is("badebu@example.com")));

        verify(studentService, times(1)).getStudentById(1L);
    }

    @Test
    @DisplayName("바데부: 학생 삭제 API 테스트")
    void testDeleteStudent() throws Exception {
        // Given
        doNothing().when(studentService).deleteStudent(1L);

        // When & Then
        mockMvc.perform(delete("/api/students/1"))
                .andExpect(status().isOk());

        verify(studentService, times(1)).deleteStudent(1L);
    }
}
```

## 통합 테스트

```java
package com.badebu.learningapp.integration;

import com.badebu.learningapp.entity.Student;
import com.badebu.learningapp.repository.StudentRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.hamcrest.Matchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@Transactional
@DisplayName("바데부: 학생 관리 통합 테스트")
class StudentIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() {
        studentRepository.deleteAll();
        System.out.println("바데부: 테스트 데이터베이스 초기화 완료!");
    }

    @Test
    @DisplayName("바데부: 학생 생성 및 조회 통합 테스트")
    void testCreateAndGetStudent() throws Exception {
        // 1. 학생 생성
        String createRequest = """
            {
                "name": "바데부",
                "email": "badebu@example.com",
                "level": "beginner"
            }
            """;

        String response = mockMvc.perform(post("/api/students")
                .contentType(MediaType.APPLICATION_JSON)
                .content(createRequest))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString();

        Student created = objectMapper.readValue(response, Student.class);

        // 2. 생성된 학생 조회
        mockMvc.perform(get("/api/students/" + created.getId()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name", is("바데부")))
                .andExpect(jsonPath("$.email", is("badebu@example.com")));

        System.out.println("바데부: 통합 테스트 성공!");
    }
}
```

## 핵심 정리

1. **@DataJpaTest**: Repository 계층 테스트
2. **@WebMvcTest**: Controller 계층 테스트
3. **@SpringBootTest**: 전체 통합 테스트
4. **Mockito**: 의존성 Mock 처리
5. **AssertJ**: 읽기 쉬운 Assertion

## 실습 과제

1. Course 엔티티 전체 테스트 작성
2. 파일 업로드 Service 테스트
3. JWT 인증 통합 테스트
4. 성능 테스트 (대량 데이터)

## 다음 챕터 미리보기

마지막 챕터에서는 **프로덕션 배포와 모범 사례**를 배워보겠습니다!
