# Chapter 5: Service 계층과 비즈니스 로직

## 학습 목표
- Service 계층의 역할과 중요성 이해하기
- 비즈니스 로직 설계 및 구현하기
- 트랜잭션 관리와 예외 처리하기
- DTO와 Entity 변환 패턴 익히기

## Service 계층이란?

Service 계층은 비즈니스 로직을 담당하는 계층으로, Controller와 Repository 사이에 위치합니다.

### 계층 구조

```
Client (클라이언트)
    ↓
Controller (컨트롤러) - 요청/응답 처리
    ↓
Service (서비스) - 비즈니스 로직
    ↓
Repository (리포지토리) - 데이터 접근
    ↓
Database (데이터베이스)
```

### Service 계층의 역할

1. **비즈니스 로직 구현**: 도메인 규칙과 정책 적용
2. **트랜잭션 관리**: 여러 데이터베이스 작업을 하나의 단위로 묶음
3. **데이터 변환**: Entity와 DTO 간의 변환
4. **재사용성**: 여러 Controller에서 같은 로직 사용
5. **테스트 용이성**: 비즈니스 로직을 독립적으로 테스트

## DTO (Data Transfer Object) 패턴

DTO는 계층 간 데이터 전송을 위한 객체입니다.

### Entity vs DTO

```java
// Entity: 데이터베이스 테이블과 매핑
@Entity
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String description;
    private int duration;
    private String instructorName;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    // ... 많은 필드들
}

// DTO: 필요한 데이터만 전송
public class CourseListDto {
    private Long id;
    private String title;
    private int duration;
    private String instructorName;
    // 필요한 필드만 포함
}

public class CourseCreateDto {
    private String title;
    private String description;
    private int duration;
    private String instructorName;
    // ID나 자동 생성 필드는 제외
}
```

### DTO의 장점

1. **불필요한 데이터 노출 방지**: 필요한 필드만 전송
2. **순환 참조 방지**: Entity 간 관계에서 발생하는 문제 해결
3. **API 변경 유연성**: Entity 변경 시 API 영향 최소화
4. **검증 분리**: DTO별로 다른 검증 규칙 적용

## 실전 예제: 바데부 강의 관리 시스템

### 1. Entity 정의

```java
package com.badebu.learningapp.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private int duration; // 분 단위

    @Column(name = "instructor_name", nullable = false)
    private String instructorName;

    @Column(nullable = false)
    private int maxStudents;

    @Column(nullable = false)
    private int enrolledStudents = 0;

    @Column(nullable = false)
    private String level; // beginner, intermediate, advanced

    @Column(nullable = false)
    private boolean published = false;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    protected Course() {}

    public Course(String title, String description, int duration,
                  String instructorName, int maxStudents, String level) {
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.instructorName = instructorName;
        this.maxStudents = maxStudents;
        this.level = level;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // 비즈니스 메서드
    public void publish() {
        if (this.published) {
            throw new IllegalStateException("바데부: 이미 공개된 강의입니다!");
        }
        this.published = true;
        this.updatedAt = LocalDateTime.now();
    }

    public void unpublish() {
        if (!this.published) {
            throw new IllegalStateException("바데부: 이미 비공개 강의입니다!");
        }
        this.published = false;
        this.updatedAt = LocalDateTime.now();
    }

    public boolean canEnroll() {
        return published && enrolledStudents < maxStudents;
    }

    public void enroll() {
        if (!canEnroll()) {
            throw new IllegalStateException("바데부: 수강 신청할 수 없습니다!");
        }
        this.enrolledStudents++;
        this.updatedAt = LocalDateTime.now();
    }

    public void cancel() {
        if (enrolledStudents <= 0) {
            throw new IllegalStateException("바데부: 취소할 수강생이 없습니다!");
        }
        this.enrolledStudents--;
        this.updatedAt = LocalDateTime.now();
    }

    public int getAvailableSeats() {
        return maxStudents - enrolledStudents;
    }

    // Getters and Setters
    public Long getId() { return id; }

    public String getTitle() { return title; }
    public void setTitle(String title) {
        this.title = title;
        this.updatedAt = LocalDateTime.now();
    }

    public String getDescription() { return description; }
    public void setDescription(String description) {
        this.description = description;
        this.updatedAt = LocalDateTime.now();
    }

    public int getDuration() { return duration; }
    public void setDuration(int duration) {
        this.duration = duration;
        this.updatedAt = LocalDateTime.now();
    }

    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) {
        this.instructorName = instructorName;
        this.updatedAt = LocalDateTime.now();
    }

    public int getMaxStudents() { return maxStudents; }
    public int getEnrolledStudents() { return enrolledStudents; }
    public String getLevel() { return level; }
    public boolean isPublished() { return published; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
```

### 2. DTO 클래스들

```java
package com.badebu.learningapp.dto;

import java.time.LocalDateTime;

// 강의 목록 조회용 DTO
public class CourseListDto {
    private Long id;
    private String title;
    private int duration;
    private String instructorName;
    private String level;
    private int enrolledStudents;
    private int maxStudents;
    private boolean published;

    public CourseListDto(Long id, String title, int duration, String instructorName,
                         String level, int enrolledStudents, int maxStudents, boolean published) {
        this.id = id;
        this.title = title;
        this.duration = duration;
        this.instructorName = instructorName;
        this.level = level;
        this.enrolledStudents = enrolledStudents;
        this.maxStudents = maxStudents;
        this.published = published;
    }

    // Getters
    public Long getId() { return id; }
    public String getTitle() { return title; }
    public int getDuration() { return duration; }
    public String getInstructorName() { return instructorName; }
    public String getLevel() { return level; }
    public int getEnrolledStudents() { return enrolledStudents; }
    public int getMaxStudents() { return maxStudents; }
    public boolean isPublished() { return published; }
    public int getAvailableSeats() { return maxStudents - enrolledStudents; }
}

// 강의 상세 조회용 DTO
public class CourseDetailDto {
    private Long id;
    private String title;
    private String description;
    private int duration;
    private String instructorName;
    private String level;
    private int enrolledStudents;
    private int maxStudents;
    private boolean published;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public CourseDetailDto(Long id, String title, String description, int duration,
                           String instructorName, String level, int enrolledStudents,
                           int maxStudents, boolean published,
                           LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.instructorName = instructorName;
        this.level = level;
        this.enrolledStudents = enrolledStudents;
        this.maxStudents = maxStudents;
        this.published = published;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters
    public Long getId() { return id; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public int getDuration() { return duration; }
    public String getInstructorName() { return instructorName; }
    public String getLevel() { return level; }
    public int getEnrolledStudents() { return enrolledStudents; }
    public int getMaxStudents() { return maxStudents; }
    public boolean isPublished() { return published; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public int getAvailableSeats() { return maxStudents - enrolledStudents; }
}

// 강의 생성용 DTO
public class CourseCreateDto {
    private String title;
    private String description;
    private int duration;
    private String instructorName;
    private int maxStudents;
    private String level;

    public CourseCreateDto() {}

    // Getters and Setters
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }

    public int getMaxStudents() { return maxStudents; }
    public void setMaxStudents(int maxStudents) { this.maxStudents = maxStudents; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
}

// 강의 수정용 DTO
public class CourseUpdateDto {
    private String title;
    private String description;
    private int duration;
    private int maxStudents;

    public CourseUpdateDto() {}

    // Getters and Setters
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public int getMaxStudents() { return maxStudents; }
    public void setMaxStudents(int maxStudents) { this.maxStudents = maxStudents; }
}
```

### 3. Repository 인터페이스

```java
package com.badebu.learningapp.repository;

import com.badebu.learningapp.entity.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CourseRepository extends JpaRepository<Course, Long> {

    // 공개된 강의 조회
    List<Course> findByPublishedTrue();

    // 레벨별 강의 조회
    List<Course> findByLevel(String level);

    // 레벨별 공개 강의 조회
    List<Course> findByLevelAndPublishedTrue(String level);

    // 강사별 강의 조회
    List<Course> findByInstructorName(String instructorName);

    // 제목으로 검색
    List<Course> findByTitleContaining(String keyword);

    // 수강 가능한 강의 조회 (공개 + 자리 있음)
    List<Course> findByPublishedTrueAndEnrolledStudentsLessThan(int maxStudents);
}
```

### 4. Service 계층 구현

```java
package com.badebu.learningapp.service;

import com.badebu.learningapp.dto.*;
import com.badebu.learningapp.entity.Course;
import com.badebu.learningapp.repository.CourseRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
public class CourseService {

    private final CourseRepository courseRepository;

    public CourseService(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    // 강의 생성
    @Transactional
    public CourseDetailDto createCourse(CourseCreateDto dto) {
        // 비즈니스 검증
        validateCourseData(dto);

        // Entity 생성
        Course course = new Course(
            dto.getTitle(),
            dto.getDescription(),
            dto.getDuration(),
            dto.getInstructorName(),
            dto.getMaxStudents(),
            dto.getLevel()
        );

        // 저장
        Course savedCourse = courseRepository.save(course);
        System.out.println("바데부: '" + course.getTitle() + "' 강의가 생성되었습니다!");

        // DTO 변환 후 반환
        return toDetailDto(savedCourse);
    }

    // 전체 강의 목록 조회
    public List<CourseListDto> getAllCourses() {
        return courseRepository.findAll().stream()
                .map(this::toListDto)
                .collect(Collectors.toList());
    }

    // 공개 강의 목록 조회
    public List<CourseListDto> getPublishedCourses() {
        return courseRepository.findByPublishedTrue().stream()
                .map(this::toListDto)
                .collect(Collectors.toList());
    }

    // 레벨별 공개 강의 조회
    public List<CourseListDto> getPublishedCoursesByLevel(String level) {
        validateLevel(level);
        return courseRepository.findByLevelAndPublishedTrue(level).stream()
                .map(this::toListDto)
                .collect(Collectors.toList());
    }

    // 강의 상세 조회
    public CourseDetailDto getCourseDetail(Long id) {
        Course course = findCourseById(id);
        return toDetailDto(course);
    }

    // 강의 수정
    @Transactional
    public CourseDetailDto updateCourse(Long id, CourseUpdateDto dto) {
        Course course = findCourseById(id);

        // 비즈니스 검증
        if (dto.getMaxStudents() < course.getEnrolledStudents()) {
            throw new IllegalArgumentException(
                "바데부: 최대 수강생은 현재 수강생 수보다 작을 수 없습니다!");
        }

        // 수정
        course.setTitle(dto.getTitle());
        course.setDescription(dto.getDescription());
        course.setDuration(dto.getDuration());
        // maxStudents는 별도 메서드로 관리하는 것이 좋음

        System.out.println("바데부: 강의가 수정되었습니다!");
        return toDetailDto(course);
    }

    // 강의 공개
    @Transactional
    public void publishCourse(Long id) {
        Course course = findCourseById(id);
        course.publish();
        System.out.println("바데부: '" + course.getTitle() + "' 강의가 공개되었습니다!");
    }

    // 강의 비공개
    @Transactional
    public void unpublishCourse(Long id) {
        Course course = findCourseById(id);
        course.unpublish();
        System.out.println("바데부: '" + course.getTitle() + "' 강의가 비공개되었습니다!");
    }

    // 수강 신청
    @Transactional
    public void enrollCourse(Long courseId) {
        Course course = findCourseById(courseId);
        course.enroll();
        System.out.println("바데부: 수강 신청이 완료되었습니다!");
    }

    // 수강 취소
    @Transactional
    public void cancelEnrollment(Long courseId) {
        Course course = findCourseById(courseId);
        course.cancel();
        System.out.println("바데부: 수강이 취소되었습니다!");
    }

    // 강의 삭제
    @Transactional
    public void deleteCourse(Long id) {
        Course course = findCourseById(id);

        // 비즈니스 검증
        if (course.getEnrolledStudents() > 0) {
            throw new IllegalStateException(
                "바데부: 수강생이 있는 강의는 삭제할 수 없습니다!");
        }

        courseRepository.delete(course);
        System.out.println("바데부: 강의가 삭제되었습니다!");
    }

    // 강의 검색
    public List<CourseListDto> searchCourses(String keyword) {
        return courseRepository.findByTitleContaining(keyword).stream()
                .map(this::toListDto)
                .collect(Collectors.toList());
    }

    // === Private Helper Methods ===

    private Course findCourseById(Long id) {
        return courseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("바데부: 강의를 찾을 수 없습니다!"));
    }

    private void validateCourseData(CourseCreateDto dto) {
        if (dto.getTitle() == null || dto.getTitle().trim().isEmpty()) {
            throw new IllegalArgumentException("바데부: 강의 제목은 필수입니다!");
        }
        if (dto.getDuration() <= 0) {
            throw new IllegalArgumentException("바데부: 강의 시간은 0보다 커야 합니다!");
        }
        if (dto.getMaxStudents() <= 0) {
            throw new IllegalArgumentException("바데부: 최대 수강생은 0보다 커야 합니다!");
        }
        validateLevel(dto.getLevel());
    }

    private void validateLevel(String level) {
        if (!List.of("beginner", "intermediate", "advanced").contains(level)) {
            throw new IllegalArgumentException(
                "바데부: 레벨은 beginner, intermediate, advanced 중 하나여야 합니다!");
        }
    }

    // Entity to DTO 변환
    private CourseListDto toListDto(Course course) {
        return new CourseListDto(
            course.getId(),
            course.getTitle(),
            course.getDuration(),
            course.getInstructorName(),
            course.getLevel(),
            course.getEnrolledStudents(),
            course.getMaxStudents(),
            course.isPublished()
        );
    }

    private CourseDetailDto toDetailDto(Course course) {
        return new CourseDetailDto(
            course.getId(),
            course.getTitle(),
            course.getDescription(),
            course.getDuration(),
            course.getInstructorName(),
            course.getLevel(),
            course.getEnrolledStudents(),
            course.getMaxStudents(),
            course.isPublished(),
            course.getCreatedAt(),
            course.getUpdatedAt()
        );
    }
}
```

### 5. Controller 구현

```java
package com.badebu.learningapp.controller;

import com.badebu.learningapp.dto.*;
import com.badebu.learningapp.service.CourseService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/courses")
public class CourseController {

    private final CourseService courseService;

    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @PostMapping
    public ResponseEntity<CourseDetailDto> createCourse(@RequestBody CourseCreateDto dto) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(courseService.createCourse(dto));
    }

    @GetMapping
    public ResponseEntity<List<CourseListDto>> getAllCourses() {
        return ResponseEntity.ok(courseService.getAllCourses());
    }

    @GetMapping("/published")
    public ResponseEntity<List<CourseListDto>> getPublishedCourses() {
        return ResponseEntity.ok(courseService.getPublishedCourses());
    }

    @GetMapping("/level/{level}")
    public ResponseEntity<List<CourseListDto>> getCoursesByLevel(@PathVariable String level) {
        return ResponseEntity.ok(courseService.getPublishedCoursesByLevel(level));
    }

    @GetMapping("/{id}")
    public ResponseEntity<CourseDetailDto> getCourseDetail(@PathVariable Long id) {
        return ResponseEntity.ok(courseService.getCourseDetail(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<CourseDetailDto> updateCourse(
            @PathVariable Long id,
            @RequestBody CourseUpdateDto dto) {
        return ResponseEntity.ok(courseService.updateCourse(id, dto));
    }

    @PostMapping("/{id}/publish")
    public ResponseEntity<String> publishCourse(@PathVariable Long id) {
        courseService.publishCourse(id);
        return ResponseEntity.ok("바데부: 강의가 공개되었습니다!");
    }

    @PostMapping("/{id}/unpublish")
    public ResponseEntity<String> unpublishCourse(@PathVariable Long id) {
        courseService.unpublishCourse(id);
        return ResponseEntity.ok("바데부: 강의가 비공개되었습니다!");
    }

    @PostMapping("/{id}/enroll")
    public ResponseEntity<String> enrollCourse(@PathVariable Long id) {
        courseService.enrollCourse(id);
        return ResponseEntity.ok("바데부: 수강 신청이 완료되었습니다!");
    }

    @PostMapping("/{id}/cancel")
    public ResponseEntity<String> cancelEnrollment(@PathVariable Long id) {
        courseService.cancelEnrollment(id);
        return ResponseEntity.ok("바데부: 수강이 취소되었습니다!");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteCourse(@PathVariable Long id) {
        courseService.deleteCourse(id);
        return ResponseEntity.ok("바데부: 강의가 삭제되었습니다!");
    }

    @GetMapping("/search")
    public ResponseEntity<List<CourseListDto>> searchCourses(@RequestParam String keyword) {
        return ResponseEntity.ok(courseService.searchCourses(keyword));
    }
}
```

## 핵심 정리

1. **Service 계층**은 비즈니스 로직을 담당하는 핵심 계층
2. **DTO**로 계층 간 데이터 전송 및 API 설계
3. **@Transactional**로 데이터 일관성 보장
4. **Entity에 비즈니스 메서드** 구현으로 도메인 모델 강화
5. **검증 로직**은 Service 계층에서 처리

## 실습 과제

1. 수강 평가 기능 추가 (Review Entity, DTO, Service, Controller)
2. 강의 평균 평점 계산 기능 구현
3. 인기 강의 조회 기능 (수강생 수 기준)
4. 강사별 통계 기능 (총 강의 수, 총 수강생 수)

## 다음 챕터 미리보기

다음 챕터에서는 **예외 처리와 유효성 검증**을 통해 안정적인 API를 만드는 방법을 배워보겠습니다!
