# Chapter 3: REST API 만들기

## 학습 목표
- REST API의 개념과 설계 원칙 이해하기
- @RestController와 HTTP 메서드 사용하기
- 요청과 응답 데이터 처리하기
- Path Variable과 Query Parameter 활용하기

## REST API란?

REST(Representational State Transfer)는 웹 서비스를 설계하는 아키텍처 스타일입니다.

### REST의 핵심 원칙

1. **자원(Resource)**: URL로 표현 (예: `/api/users`, `/api/contents`)
2. **행위(Verb)**: HTTP 메서드로 표현 (GET, POST, PUT, DELETE)
3. **표현(Representation)**: JSON, XML 등의 형식으로 데이터 전송
4. **무상태(Stateless)**: 각 요청은 독립적

### HTTP 메서드

| 메서드 | 용도 | 예시 |
|--------|------|------|
| GET | 조회 | 사용자 목록 조회 |
| POST | 생성 | 새 사용자 생성 |
| PUT | 전체 수정 | 사용자 정보 전체 수정 |
| PATCH | 부분 수정 | 사용자 이름만 수정 |
| DELETE | 삭제 | 사용자 삭제 |

## @RestController 기본

```java
package com.badebu.learningapp.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/badebu")
public class BadebuBasicController {

    // GET: 단순 텍스트 반환
    @GetMapping("/hello")
    public String hello() {
        return "안녕하세요! 바데부입니다!";
    }

    // GET: JSON 객체 반환
    @GetMapping("/info")
    public BadebuInfo getInfo() {
        return new BadebuInfo("바데부", "Spring Boot 강사", "초보자 환영!");
    }

    // 내부 클래스로 DTO 정의
    static class BadebuInfo {
        private String name;
        private String role;
        private String message;

        public BadebuInfo(String name, String role, String message) {
            this.name = name;
            this.role = role;
            this.message = message;
        }

        // Getters
        public String getName() { return name; }
        public String getRole() { return role; }
        public String getMessage() { return message; }
    }
}
```

## Path Variable 사용하기

URL 경로의 일부를 변수로 받아오는 방법입니다.

```java
package com.badebu.learningapp.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/students")
public class StudentController {

    // Path Variable 하나
    @GetMapping("/{id}")
    public String getStudent(@PathVariable Long id) {
        return "바데부: " + id + "번 학생의 정보를 조회합니다!";
    }

    // Path Variable 여러 개
    @GetMapping("/{studentId}/courses/{courseId}")
    public String getStudentCourse(
            @PathVariable Long studentId,
            @PathVariable Long courseId) {
        return String.format("바데부: %d번 학생의 %d번 강의를 조회합니다!",
                           studentId, courseId);
    }

    // Path Variable 이름 지정
    @GetMapping("/user/{username}")
    public String getByUsername(@PathVariable("username") String name) {
        return "바데부: " + name + " 학생을 찾았습니다!";
    }
}
```

## Query Parameter 사용하기

URL의 쿼리 스트링(?key=value)으로 데이터를 받습니다.

```java
package com.badebu.learningapp.controller;

import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/api/search")
public class SearchController {

    // 단일 Query Parameter
    @GetMapping("/student")
    public String searchStudent(@RequestParam String name) {
        return "바데부: " + name + "을(를) 검색합니다!";
    }

    // 여러 Query Parameters
    @GetMapping("/courses")
    public String searchCourses(
            @RequestParam String subject,
            @RequestParam String level) {
        return String.format("바데부: %s 과목의 %s 레벨 강의를 검색합니다!",
                           subject, level);
    }

    // 선택적 Parameter (기본값 설정)
    @GetMapping("/filter")
    public String filterContents(
            @RequestParam(required = false, defaultValue = "all") String category,
            @RequestParam(required = false, defaultValue = "10") int limit) {
        return String.format("바데부: %s 카테고리의 강의 %d개를 조회합니다!",
                           category, limit);
    }

    // 여러 값을 List로 받기
    @GetMapping("/tags")
    public String searchByTags(@RequestParam List<String> tags) {
        return "바데부: " + String.join(", ", tags) + " 태그로 검색합니다!";
    }
}
```

## Request Body 처리하기

JSON 데이터를 받아서 처리합니다.

### DTO(Data Transfer Object) 클래스

```java
package com.badebu.learningapp.dto;

public class CourseCreateRequest {
    private String title;
    private String description;
    private String instructor;
    private int duration; // 분 단위

    // 기본 생성자
    public CourseCreateRequest() {}

    // 전체 생성자
    public CourseCreateRequest(String title, String description,
                               String instructor, int duration) {
        this.title = title;
        this.description = description;
        this.instructor = instructor;
        this.duration = duration;
    }

    // Getters and Setters
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getInstructor() { return instructor; }
    public void setInstructor(String instructor) { this.instructor = instructor; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }
}
```

### Controller에서 사용하기

```java
package com.badebu.learningapp.controller;

import com.badebu.learningapp.dto.CourseCreateRequest;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/courses")
public class CourseController {

    @PostMapping
    public String createCourse(@RequestBody CourseCreateRequest request) {
        return String.format(
            "바데부: '%s' 강의가 생성되었습니다!\n" +
            "강사: %s\n" +
            "설명: %s\n" +
            "소요 시간: %d분",
            request.getTitle(),
            request.getInstructor(),
            request.getDescription(),
            request.getDuration()
        );
    }
}
```

## 실전 예제: 바데부 학습 관리 API

### 1. DTO 클래스들

```java
package com.badebu.learningapp.dto;

public class StudentDto {
    private Long id;
    private String name;
    private String email;
    private String level;

    public StudentDto() {}

    public StudentDto(Long id, String name, String email, String level) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.level = level;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
}
```

### 2. Service 계층

```java
package com.badebu.learningapp.service;

import com.badebu.learningapp.dto.StudentDto;
import org.springframework.stereotype.Service;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class StudentService {

    private final Map<Long, StudentDto> students = new ConcurrentHashMap<>();
    private Long currentId = 1L;

    public StudentDto createStudent(String name, String email, String level) {
        StudentDto student = new StudentDto(currentId++, name, email, level);
        students.put(student.getId(), student);
        System.out.println("바데부: " + name + " 학생이 등록되었습니다!");
        return student;
    }

    public List<StudentDto> getAllStudents() {
        return new ArrayList<>(students.values());
    }

    public Optional<StudentDto> getStudentById(Long id) {
        return Optional.ofNullable(students.get(id));
    }

    public List<StudentDto> getStudentsByLevel(String level) {
        return students.values().stream()
                .filter(s -> s.getLevel().equalsIgnoreCase(level))
                .toList();
    }

    public StudentDto updateStudent(Long id, String name, String email, String level) {
        StudentDto student = students.get(id);
        if (student == null) {
            throw new RuntimeException("바데부: 학생을 찾을 수 없습니다!");
        }
        student.setName(name);
        student.setEmail(email);
        student.setLevel(level);
        return student;
    }

    public void deleteStudent(Long id) {
        students.remove(id);
        System.out.println("바데부: " + id + "번 학생이 삭제되었습니다!");
    }
}
```

### 3. 완전한 REST Controller

```java
package com.badebu.learningapp.controller;

import com.badebu.learningapp.dto.StudentDto;
import com.badebu.learningapp.service.StudentService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/students")
public class StudentRestController {

    private final StudentService studentService;

    public StudentRestController(StudentService studentService) {
        this.studentService = studentService;
    }

    // 1. 모든 학생 조회 (GET)
    @GetMapping
    public ResponseEntity<List<StudentDto>> getAllStudents() {
        List<StudentDto> students = studentService.getAllStudents();
        return ResponseEntity.ok(students);
    }

    // 2. 특정 학생 조회 (GET with Path Variable)
    @GetMapping("/{id}")
    public ResponseEntity<StudentDto> getStudent(@PathVariable Long id) {
        return studentService.getStudentById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // 3. 레벨별 학생 조회 (GET with Query Parameter)
    @GetMapping("/search")
    public ResponseEntity<List<StudentDto>> getStudentsByLevel(
            @RequestParam String level) {
        List<StudentDto> students = studentService.getStudentsByLevel(level);
        return ResponseEntity.ok(students);
    }

    // 4. 학생 생성 (POST with Request Body)
    @PostMapping
    public ResponseEntity<StudentDto> createStudent(
            @RequestBody StudentCreateRequest request) {
        StudentDto student = studentService.createStudent(
            request.getName(),
            request.getEmail(),
            request.getLevel()
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(student);
    }

    // 5. 학생 정보 수정 (PUT)
    @PutMapping("/{id}")
    public ResponseEntity<StudentDto> updateStudent(
            @PathVariable Long id,
            @RequestBody StudentCreateRequest request) {
        try {
            StudentDto student = studentService.updateStudent(
                id,
                request.getName(),
                request.getEmail(),
                request.getLevel()
            );
            return ResponseEntity.ok(student);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // 6. 학생 삭제 (DELETE)
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteStudent(@PathVariable Long id) {
        studentService.deleteStudent(id);
        return ResponseEntity.ok("바데부: 학생이 삭제되었습니다!");
    }
}

// Request DTO
class StudentCreateRequest {
    private String name;
    private String email;
    private String level;

    public StudentCreateRequest() {}

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
}
```

## HTTP 상태 코드 활용하기

```java
@RestController
@RequestMapping("/api/status-demo")
public class StatusCodeController {

    // 200 OK
    @GetMapping("/ok")
    public ResponseEntity<String> ok() {
        return ResponseEntity.ok("바데부: 성공!");
    }

    // 201 Created
    @PostMapping("/created")
    public ResponseEntity<String> created() {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body("바데부: 생성 완료!");
    }

    // 204 No Content
    @DeleteMapping("/no-content")
    public ResponseEntity<Void> noContent() {
        return ResponseEntity.noContent().build();
    }

    // 404 Not Found
    @GetMapping("/not-found")
    public ResponseEntity<String> notFound() {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body("바데부: 찾을 수 없습니다!");
    }

    // 400 Bad Request
    @PostMapping("/bad-request")
    public ResponseEntity<String> badRequest() {
        return ResponseEntity.badRequest()
                .body("바데부: 잘못된 요청입니다!");
    }
}
```

## API 테스트하기

### cURL 명령어 예시

```bash
# 1. 전체 학생 조회
curl http://localhost:8080/api/students

# 2. 특정 학생 조회
curl http://localhost:8080/api/students/1

# 3. 레벨별 조회
curl "http://localhost:8080/api/students/search?level=beginner"

# 4. 학생 생성
curl -X POST http://localhost:8080/api/students \
  -H "Content-Type: application/json" \
  -d '{
    "name": "바데부",
    "email": "badebu@example.com",
    "level": "advanced"
  }'

# 5. 학생 수정
curl -X PUT http://localhost:8080/api/students/1 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "바데부Pro",
    "email": "badebu.pro@example.com",
    "level": "expert"
  }'

# 6. 학생 삭제
curl -X DELETE http://localhost:8080/api/students/1
```

## 핵심 정리

1. **@RestController**는 @Controller + @ResponseBody의 조합
2. **Path Variable**은 URL 경로에서 데이터 추출 (@PathVariable)
3. **Query Parameter**는 URL 쿼리 스트링에서 데이터 추출 (@RequestParam)
4. **Request Body**는 JSON 데이터를 Java 객체로 변환 (@RequestBody)
5. **ResponseEntity**로 HTTP 상태 코드와 헤더를 제어
6. **REST 규칙**: 자원은 명사, 행위는 HTTP 메서드로 표현

## 실습 과제

1. 바데부 강의 관리 API 만들기 (CRUD 전체)
2. 강의 검색 기능: 제목, 강사, 레벨로 검색
3. 강의 평점 시스템 추가
4. cURL로 모든 API 테스트하기

## 다음 챕터 미리보기

다음 챕터에서는 **JPA와 데이터베이스 연동**을 통해 실제 데이터베이스에 데이터를 저장하는 방법을 배워보겠습니다!
