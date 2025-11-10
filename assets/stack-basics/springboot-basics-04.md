# Chapter 4: JPA와 데이터베이스 연동

## 학습 목표
- JPA(Java Persistence API)의 개념 이해하기
- Spring Data JPA로 데이터베이스 연동하기
- Entity와 Repository 사용법 익히기
- 기본 CRUD 및 쿼리 메서드 작성하기

## JPA란?

JPA는 Java 객체와 관계형 데이터베이스를 매핑해주는 ORM(Object-Relational Mapping) 표준 기술입니다.

### JPA의 장점

1. **SQL을 직접 작성할 필요 없음**: 객체 중심으로 개발
2. **생산성 향상**: CRUD 코드를 자동으로 생성
3. **유지보수성**: 필드 추가 시 SQL 수정 불필요
4. **데이터베이스 독립성**: 다른 DB로 쉽게 변경 가능

### JPA vs JDBC

```java
// JDBC 방식 (복잡함)
String sql = "INSERT INTO student (name, email) VALUES (?, ?)";
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setString(1, "바데부");
pstmt.setString(2, "badebu@example.com");
pstmt.executeUpdate();

// JPA 방식 (간단함)
Student student = new Student("바데부", "badebu@example.com");
studentRepository.save(student);
```

## 프로젝트 설정

### 1. 의존성 추가 (pom.xml)

```xml
<dependencies>
    <!-- Spring Data JPA -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>

    <!-- H2 Database (개발용 인메모리 DB) -->
    <dependency>
        <groupId>com.h2database</groupId>
        <artifactId>h2</artifactId>
        <scope>runtime</scope>
    </dependency>

    <!-- MySQL Driver (실제 운영 시) -->
    <dependency>
        <groupId>com.mysql</groupId>
        <artifactId>mysql-connector-j</artifactId>
        <scope>runtime</scope>
    </dependency>
</dependencies>
```

### 2. application.properties 설정

```properties
# H2 Database 설정 (개발용)
spring.datasource.url=jdbc:h2:mem:badebu-learning
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=

# H2 Console 활성화
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

# JPA 설정
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# MySQL 설정 (실제 운영 시)
# spring.datasource.url=jdbc:mysql://localhost:3306/badebu_db
# spring.datasource.username=root
# spring.datasource.password=password
# spring.jpa.hibernate.ddl-auto=update
# spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect
```

### ddl-auto 옵션 설명

- **create**: 애플리케이션 시작 시 테이블 생성
- **create-drop**: 시작 시 생성, 종료 시 삭제
- **update**: 변경사항만 반영 (운영 환경에서 주의)
- **validate**: 엔티티와 테이블이 정상 매핑되었는지만 확인
- **none**: 아무것도 하지 않음

## Entity 클래스 만들기

### 기본 Entity

```java
package com.badebu.learningapp.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "students")
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(nullable = false, unique = true, length = 100)
    private String email;

    @Column(length = 20)
    private String level;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // 기본 생성자 (JPA 필수)
    protected Student() {}

    // 비즈니스 생성자
    public Student(String name, String email, String level) {
        this.name = name;
        this.email = email;
        this.level = level;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // Lifecycle callbacks
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        System.out.println("바데부: 새 학생이 생성됩니다!");
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
        System.out.println("바데부: 학생 정보가 수정됩니다!");
    }

    // Getters and Setters
    public Long getId() { return id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }

    @Override
    public String toString() {
        return String.format("Student[id=%d, name='%s', email='%s', level='%s']",
                           id, name, email, level);
    }
}
```

### Entity 어노테이션 설명

- **@Entity**: JPA 엔티티임을 선언
- **@Table**: 테이블 이름 지정 (생략 시 클래스명)
- **@Id**: 기본 키(Primary Key) 지정
- **@GeneratedValue**: 기본 키 생성 전략
  - `IDENTITY`: DB의 AUTO_INCREMENT 사용
  - `SEQUENCE`: DB 시퀀스 사용
  - `TABLE`: 키 생성 테이블 사용
  - `AUTO`: DB에 맞게 자동 선택
- **@Column**: 컬럼 속성 지정
  - `nullable`: NULL 허용 여부
  - `unique`: 유니크 제약조건
  - `length`: 문자열 길이
  - `name`: 컬럼 이름

## Repository 인터페이스 만들기

```java
package com.badebu.learningapp.repository;

import com.badebu.learningapp.entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {

    // 기본 제공 메서드 (JpaRepository에서 상속)
    // - save(S entity)
    // - findById(ID id)
    // - findAll()
    // - deleteById(ID id)
    // - count()

    // 쿼리 메서드: 메서드 이름으로 쿼리 자동 생성

    // 이름으로 찾기
    Optional<Student> findByName(String name);

    // 이메일로 찾기
    Optional<Student> findByEmail(String email);

    // 레벨로 찾기
    List<Student> findByLevel(String level);

    // 이름에 특정 문자열 포함
    List<Student> findByNameContaining(String keyword);

    // 레벨과 이름으로 찾기 (AND 조건)
    List<Student> findByLevelAndName(String level, String name);

    // 레벨 또는 이름으로 찾기 (OR 조건)
    List<Student> findByLevelOrName(String level, String name);

    // 이름으로 정렬하여 찾기
    List<Student> findByLevelOrderByNameAsc(String level);

    // 이메일 존재 여부 확인
    boolean existsByEmail(String email);

    // 레벨별 학생 수 세기
    long countByLevel(String level);
}
```

### 쿼리 메서드 키워드

| 키워드 | 설명 | 예시 |
|--------|------|------|
| findBy | 조회 | findByName |
| countBy | 개수 | countByLevel |
| existsBy | 존재 확인 | existsByEmail |
| deleteBy | 삭제 | deleteByName |
| And | AND 조건 | findByNameAndEmail |
| Or | OR 조건 | findByNameOrEmail |
| Between | BETWEEN | findByAgeBetween |
| LessThan | < | findByAgeLessThan |
| GreaterThan | > | findByAgeGreaterThan |
| Like | LIKE | findByNameLike |
| Containing | LIKE %keyword% | findByNameContaining |
| StartingWith | LIKE keyword% | findByNameStartingWith |
| EndingWith | LIKE %keyword | findByNameEndingWith |
| OrderBy | 정렬 | findByLevelOrderByNameAsc |

## Service 계층 구현

```java
package com.badebu.learningapp.service;

import com.badebu.learningapp.entity.Student;
import com.badebu.learningapp.repository.StudentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional(readOnly = true)
public class StudentService {

    private final StudentRepository studentRepository;

    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    // 학생 생성
    @Transactional
    public Student createStudent(String name, String email, String level) {
        // 이메일 중복 체크
        if (studentRepository.existsByEmail(email)) {
            throw new RuntimeException("바데부: 이미 존재하는 이메일입니다!");
        }

        Student student = new Student(name, email, level);
        Student savedStudent = studentRepository.save(student);
        System.out.println("바데부: " + name + " 학생이 등록되었습니다!");
        return savedStudent;
    }

    // 전체 학생 조회
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    // ID로 학생 조회
    public Student getStudentById(Long id) {
        return studentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("바데부: 학생을 찾을 수 없습니다!"));
    }

    // 이름으로 학생 조회
    public Student getStudentByName(String name) {
        return studentRepository.findByName(name)
                .orElseThrow(() -> new RuntimeException("바데부: " + name + " 학생을 찾을 수 없습니다!"));
    }

    // 레벨별 학생 조회
    public List<Student> getStudentsByLevel(String level) {
        return studentRepository.findByLevel(level);
    }

    // 이름으로 검색
    public List<Student> searchStudentsByName(String keyword) {
        return studentRepository.findByNameContaining(keyword);
    }

    // 학생 정보 수정
    @Transactional
    public Student updateStudent(Long id, String name, String email, String level) {
        Student student = getStudentById(id);

        // 이메일 변경 시 중복 체크
        if (!student.getEmail().equals(email) && studentRepository.existsByEmail(email)) {
            throw new RuntimeException("바데부: 이미 사용 중인 이메일입니다!");
        }

        student.setName(name);
        student.setEmail(email);
        student.setLevel(level);

        return studentRepository.save(student);
    }

    // 학생 삭제
    @Transactional
    public void deleteStudent(Long id) {
        if (!studentRepository.existsById(id)) {
            throw new RuntimeException("바데부: 삭제할 학생을 찾을 수 없습니다!");
        }
        studentRepository.deleteById(id);
        System.out.println("바데부: 학생이 삭제되었습니다!");
    }

    // 통계: 전체 학생 수
    public long getTotalStudentCount() {
        return studentRepository.count();
    }

    // 통계: 레벨별 학생 수
    public long getStudentCountByLevel(String level) {
        return studentRepository.countByLevel(level);
    }
}
```

### @Transactional 설명

- **트랜잭션**: 데이터베이스 작업의 논리적 단위
- **@Transactional**: 메서드 실행 중 예외 발생 시 자동 롤백
- **readOnly = true**: 읽기 전용 최적화 (조회 메서드에 사용)

## Controller 구현

```java
package com.badebu.learningapp.controller;

import com.badebu.learningapp.entity.Student;
import com.badebu.learningapp.service.StudentService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/students")
public class StudentJpaController {

    private final StudentService studentService;

    public StudentJpaController(StudentService studentService) {
        this.studentService = studentService;
    }

    // 전체 학생 조회
    @GetMapping
    public ResponseEntity<List<Student>> getAllStudents() {
        return ResponseEntity.ok(studentService.getAllStudents());
    }

    // ID로 학생 조회
    @GetMapping("/{id}")
    public ResponseEntity<Student> getStudent(@PathVariable Long id) {
        return ResponseEntity.ok(studentService.getStudentById(id));
    }

    // 레벨별 학생 조회
    @GetMapping("/level/{level}")
    public ResponseEntity<List<Student>> getStudentsByLevel(@PathVariable String level) {
        return ResponseEntity.ok(studentService.getStudentsByLevel(level));
    }

    // 이름으로 검색
    @GetMapping("/search")
    public ResponseEntity<List<Student>> searchStudents(@RequestParam String keyword) {
        return ResponseEntity.ok(studentService.searchStudentsByName(keyword));
    }

    // 학생 생성
    @PostMapping
    public ResponseEntity<Student> createStudent(@RequestBody StudentCreateDto dto) {
        Student student = studentService.createStudent(
            dto.getName(), dto.getEmail(), dto.getLevel()
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(student);
    }

    // 학생 수정
    @PutMapping("/{id}")
    public ResponseEntity<Student> updateStudent(
            @PathVariable Long id,
            @RequestBody StudentCreateDto dto) {
        Student student = studentService.updateStudent(
            id, dto.getName(), dto.getEmail(), dto.getLevel()
        );
        return ResponseEntity.ok(student);
    }

    // 학생 삭제
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteStudent(@PathVariable Long id) {
        studentService.deleteStudent(id);
        return ResponseEntity.ok("바데부: 학생이 삭제되었습니다!");
    }

    // 통계: 전체 학생 수
    @GetMapping("/stats/total")
    public ResponseEntity<String> getTotalCount() {
        long count = studentService.getTotalStudentCount();
        return ResponseEntity.ok("바데부: 전체 학생 수는 " + count + "명입니다!");
    }

    // 통계: 레벨별 학생 수
    @GetMapping("/stats/level/{level}")
    public ResponseEntity<String> getCountByLevel(@PathVariable String level) {
        long count = studentService.getStudentCountByLevel(level);
        return ResponseEntity.ok("바데부: " + level + " 레벨 학생은 " + count + "명입니다!");
    }
}

// DTO 클래스
class StudentCreateDto {
    private String name;
    private String email;
    private String level;

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
}
```

## 관계 매핑 예제

### 일대다 관계 (One-to-Many)

```java
// 강사 엔티티
@Entity
@Table(name = "instructors")
public class Instructor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @OneToMany(mappedBy = "instructor", cascade = CascadeType.ALL)
    private List<Course> courses = new ArrayList<>();

    // 생성자, Getters, Setters
}

// 강의 엔티티
@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "instructor_id")
    private Instructor instructor;

    // 생성자, Getters, Setters
}
```

## 핵심 정리

1. **JPA**는 객체와 관계형 DB를 매핑하는 ORM 기술
2. **@Entity**로 엔티티 클래스 정의
3. **JpaRepository**를 상속하여 CRUD 자동 생성
4. **쿼리 메서드**로 메서드 이름만으로 쿼리 생성
5. **@Transactional**로 트랜잭션 관리
6. **H2 Database**로 빠른 개발 및 테스트

## 실습 과제

1. Course 엔티티 만들기 (id, title, description, duration)
2. CourseRepository 만들기 (제목 검색, 기간별 조회 기능)
3. CourseService와 Controller 완성하기
4. H2 Console에서 데이터 확인하기

## 다음 챕터 미리보기

다음 챕터에서는 **Service 계층**의 비즈니스 로직 설계와 트랜잭션 관리에 대해 더 깊이 배워보겠습니다!
