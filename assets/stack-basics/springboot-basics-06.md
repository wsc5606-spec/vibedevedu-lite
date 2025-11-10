# Chapter 6: 예외 처리와 유효성 검증

## 학습 목표
- 예외 처리의 중요성과 전략 이해하기
- @ControllerAdvice로 전역 예외 처리하기
- Bean Validation으로 유효성 검증하기
- 커스텀 예외 클래스 만들기

## 예외 처리가 중요한 이유

### 예외 처리가 없는 코드

```java
@GetMapping("/student/{id}")
public Student getStudent(@PathVariable Long id) {
    return studentRepository.findById(id).get(); // NoSuchElementException 발생 가능
}
```

**문제점:**
- 500 Internal Server Error 반환
- 사용자에게 무엇이 잘못되었는지 알려주지 못함
- 로그에 불필요한 스택 트레이스 기록

### 예외 처리가 있는 코드

```java
@GetMapping("/student/{id}")
public ResponseEntity<Student> getStudent(@PathVariable Long id) {
    return studentRepository.findById(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
}
```

## 커스텀 예외 클래스

### 1. 비즈니스 예외 정의

```java
package com.badebu.learningapp.exception;

// 리소스를 찾을 수 없을 때
public class ResourceNotFoundException extends RuntimeException {
    private String resourceName;
    private String fieldName;
    private Object fieldValue;

    public ResourceNotFoundException(String resourceName, String fieldName, Object fieldValue) {
        super(String.format("바데부: %s를 찾을 수 없습니다. (%s: %s)",
                          resourceName, fieldName, fieldValue));
        this.resourceName = resourceName;
        this.fieldName = fieldName;
        this.fieldValue = fieldValue;
    }

    public ResourceNotFoundException(String message) {
        super(message);
    }

    // Getters
    public String getResourceName() { return resourceName; }
    public String getFieldName() { return fieldName; }
    public Object getFieldValue() { return fieldValue; }
}

// 비즈니스 규칙 위반
public class BusinessException extends RuntimeException {
    private String errorCode;

    public BusinessException(String message) {
        super(message);
    }

    public BusinessException(String message, String errorCode) {
        super(message);
        this.errorCode = errorCode;
    }

    public String getErrorCode() { return errorCode; }
}

// 중복 데이터
public class DuplicateResourceException extends RuntimeException {
    public DuplicateResourceException(String message) {
        super(message);
    }
}

// 잘못된 요청
public class InvalidRequestException extends RuntimeException {
    public InvalidRequestException(String message) {
        super(message);
    }
}
```

### 2. 에러 응답 DTO

```java
package com.badebu.learningapp.dto;

import java.time.LocalDateTime;
import java.util.List;

public class ErrorResponse {
    private int status;
    private String error;
    private String message;
    private String path;
    private LocalDateTime timestamp;
    private List<FieldError> fieldErrors;

    public ErrorResponse(int status, String error, String message, String path) {
        this.status = status;
        this.error = error;
        this.message = message;
        this.path = path;
        this.timestamp = LocalDateTime.now();
    }

    // 생성자, Getters and Setters
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getError() { return error; }
    public void setError(String error) { this.error = error; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getPath() { return path; }
    public void setPath(String path) { this.path = path; }

    public LocalDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }

    public List<FieldError> getFieldErrors() { return fieldErrors; }
    public void setFieldErrors(List<FieldError> fieldErrors) { this.fieldErrors = fieldErrors; }

    // 필드 에러 클래스
    public static class FieldError {
        private String field;
        private String message;
        private Object rejectedValue;

        public FieldError(String field, String message, Object rejectedValue) {
            this.field = field;
            this.message = message;
            this.rejectedValue = rejectedValue;
        }

        // Getters
        public String getField() { return field; }
        public String getMessage() { return message; }
        public Object getRejectedValue() { return rejectedValue; }
    }
}
```

## 전역 예외 처리 (@ControllerAdvice)

```java
package com.badebu.learningapp.exception;

import com.badebu.learningapp.dto.ErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import java.util.List;
import java.util.stream.Collectors;

@RestControllerAdvice
public class GlobalExceptionHandler {

    // 리소스를 찾을 수 없을 때
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleResourceNotFoundException(
            ResourceNotFoundException ex, WebRequest request) {

        ErrorResponse errorResponse = new ErrorResponse(
            HttpStatus.NOT_FOUND.value(),
            "Not Found",
            ex.getMessage(),
            request.getDescription(false).replace("uri=", "")
        );

        System.out.println("바데부: 리소스를 찾을 수 없습니다 - " + ex.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
    }

    // 비즈니스 규칙 위반
    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<ErrorResponse> handleBusinessException(
            BusinessException ex, WebRequest request) {

        ErrorResponse errorResponse = new ErrorResponse(
            HttpStatus.BAD_REQUEST.value(),
            "Business Rule Violation",
            ex.getMessage(),
            request.getDescription(false).replace("uri=", "")
        );

        System.out.println("바데부: 비즈니스 규칙 위반 - " + ex.getMessage());
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
    }

    // 중복 데이터
    @ExceptionHandler(DuplicateResourceException.class)
    public ResponseEntity<ErrorResponse> handleDuplicateResourceException(
            DuplicateResourceException ex, WebRequest request) {

        ErrorResponse errorResponse = new ErrorResponse(
            HttpStatus.CONFLICT.value(),
            "Duplicate Resource",
            ex.getMessage(),
            request.getDescription(false).replace("uri=", "")
        );

        System.out.println("바데부: 중복 데이터 - " + ex.getMessage());
        return ResponseEntity.status(HttpStatus.CONFLICT).body(errorResponse);
    }

    // 잘못된 요청
    @ExceptionHandler(InvalidRequestException.class)
    public ResponseEntity<ErrorResponse> handleInvalidRequestException(
            InvalidRequestException ex, WebRequest request) {

        ErrorResponse errorResponse = new ErrorResponse(
            HttpStatus.BAD_REQUEST.value(),
            "Invalid Request",
            ex.getMessage(),
            request.getDescription(false).replace("uri=", "")
        );

        System.out.println("바데부: 잘못된 요청 - " + ex.getMessage());
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
    }

    // Validation 에러 (Bean Validation)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidationException(
            MethodArgumentNotValidException ex, WebRequest request) {

        BindingResult bindingResult = ex.getBindingResult();

        List<ErrorResponse.FieldError> fieldErrors = bindingResult.getFieldErrors().stream()
                .map(error -> new ErrorResponse.FieldError(
                    error.getField(),
                    error.getDefaultMessage(),
                    error.getRejectedValue()
                ))
                .collect(Collectors.toList());

        ErrorResponse errorResponse = new ErrorResponse(
            HttpStatus.BAD_REQUEST.value(),
            "Validation Failed",
            "바데부: 입력 데이터 검증에 실패했습니다.",
            request.getDescription(false).replace("uri=", "")
        );
        errorResponse.setFieldErrors(fieldErrors);

        System.out.println("바데부: 검증 실패 - " + fieldErrors.size() + "개의 오류");
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
    }

    // IllegalArgumentException
    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> handleIllegalArgumentException(
            IllegalArgumentException ex, WebRequest request) {

        ErrorResponse errorResponse = new ErrorResponse(
            HttpStatus.BAD_REQUEST.value(),
            "Bad Request",
            ex.getMessage(),
            request.getDescription(false).replace("uri=", "")
        );

        System.out.println("바데부: 잘못된 인자 - " + ex.getMessage());
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
    }

    // IllegalStateException
    @ExceptionHandler(IllegalStateException.class)
    public ResponseEntity<ErrorResponse> handleIllegalStateException(
            IllegalStateException ex, WebRequest request) {

        ErrorResponse errorResponse = new ErrorResponse(
            HttpStatus.CONFLICT.value(),
            "Conflict",
            ex.getMessage(),
            request.getDescription(false).replace("uri=", "")
        );

        System.out.println("바데부: 상태 오류 - " + ex.getMessage());
        return ResponseEntity.status(HttpStatus.CONFLICT).body(errorResponse);
    }

    // 그 외 모든 예외
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGlobalException(
            Exception ex, WebRequest request) {

        ErrorResponse errorResponse = new ErrorResponse(
            HttpStatus.INTERNAL_SERVER_ERROR.value(),
            "Internal Server Error",
            "바데부: 서버에서 오류가 발생했습니다. 관리자에게 문의하세요.",
            request.getDescription(false).replace("uri=", "")
        );

        System.err.println("바데부: 예상치 못한 오류 발생!");
        ex.printStackTrace();
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
    }
}
```

## Bean Validation (유효성 검증)

### 1. 의존성 추가

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-validation</artifactId>
</dependency>
```

### 2. DTO에 검증 어노테이션 추가

```java
package com.badebu.learningapp.dto;

import jakarta.validation.constraints.*;

public class StudentCreateDto {

    @NotBlank(message = "바데부: 이름은 필수입니다!")
    @Size(min = 2, max = 50, message = "바데부: 이름은 2~50자 사이여야 합니다!")
    private String name;

    @NotBlank(message = "바데부: 이메일은 필수입니다!")
    @Email(message = "바데부: 올바른 이메일 형식이 아닙니다!")
    private String email;

    @NotBlank(message = "바데부: 레벨은 필수입니다!")
    @Pattern(regexp = "^(beginner|intermediate|advanced)$",
             message = "바데부: 레벨은 beginner, intermediate, advanced 중 하나여야 합니다!")
    private String level;

    @Min(value = 0, message = "바데부: 나이는 0 이상이어야 합니다!")
    @Max(value = 150, message = "바데부: 나이는 150 이하여야 합니다!")
    private Integer age;

    @NotNull(message = "바데부: 활성 여부는 필수입니다!")
    private Boolean active;

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public Boolean getActive() { return active; }
    public void setActive(Boolean active) { this.active = active; }
}
```

### 주요 검증 어노테이션

| 어노테이션 | 설명 | 예시 |
|-----------|------|------|
| @NotNull | null 불가 | @NotNull private String name; |
| @NotBlank | null, 빈 문자열, 공백 불가 | @NotBlank private String title; |
| @NotEmpty | null, 빈 컬렉션 불가 | @NotEmpty private List items; |
| @Size | 길이 제한 | @Size(min=2, max=50) |
| @Min / @Max | 최소/최대 값 | @Min(0) @Max(100) |
| @Email | 이메일 형식 | @Email private String email; |
| @Pattern | 정규식 매칭 | @Pattern(regexp="...") |
| @Positive | 양수 | @Positive private int count; |
| @PositiveOrZero | 0 또는 양수 | @PositiveOrZero |
| @Past / @Future | 과거/미래 날짜 | @Past private LocalDate birth; |

### 3. Controller에서 검증 활성화

```java
package com.badebu.learningapp.controller;

import com.badebu.learningapp.dto.StudentCreateDto;
import com.badebu.learningapp.service.StudentService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/students")
public class StudentValidationController {

    private final StudentService studentService;

    public StudentValidationController(StudentService studentService) {
        this.studentService = studentService;
    }

    // @Valid 어노테이션으로 검증 활성화
    @PostMapping
    public ResponseEntity<String> createStudent(@Valid @RequestBody StudentCreateDto dto) {
        // 검증 통과 시에만 이 코드가 실행됨
        studentService.createStudent(dto.getName(), dto.getEmail(), dto.getLevel());
        return ResponseEntity.status(HttpStatus.CREATED)
                .body("바데부: 학생이 생성되었습니다!");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateStudent(
            @PathVariable Long id,
            @Valid @RequestBody StudentCreateDto dto) {
        // 검증 통과 후 실행
        studentService.updateStudent(id, dto.getName(), dto.getEmail(), dto.getLevel());
        return ResponseEntity.ok("바데부: 학생 정보가 수정되었습니다!");
    }
}
```

## 커스텀 Validator 만들기

### 1. 커스텀 어노테이션

```java
package com.badebu.learningapp.validation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.*;

@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = BadebuLevelValidator.class)
@Documented
public @interface ValidBadebuLevel {
    String message() default "바데부: 올바른 학습 레벨이 아닙니다!";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
```

### 2. Validator 구현

```java
package com.badebu.learningapp.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import java.util.Arrays;
import java.util.List;

public class BadebuLevelValidator implements ConstraintValidator<ValidBadebuLevel, String> {

    private static final List<String> VALID_LEVELS = Arrays.asList(
        "beginner", "intermediate", "advanced", "expert"
    );

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null) {
            return true; // @NotNull로 따로 검증
        }

        boolean valid = VALID_LEVELS.contains(value.toLowerCase());

        if (!valid) {
            // 커스텀 에러 메시지
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate(
                "바데부: 레벨은 " + String.join(", ", VALID_LEVELS) + " 중 하나여야 합니다!"
            ).addConstraintViolation();
        }

        return valid;
    }
}
```

### 3. 사용 예시

```java
public class CourseCreateDto {

    @NotBlank(message = "바데부: 제목은 필수입니다!")
    private String title;

    @ValidBadebuLevel
    private String level;

    // Getters and Setters
}
```

## Service 계층에서 예외 사용하기

```java
package com.badebu.learningapp.service;

import com.badebu.learningapp.entity.Course;
import com.badebu.learningapp.exception.*;
import com.badebu.learningapp.repository.CourseRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class CourseExceptionService {

    private final CourseRepository courseRepository;

    public CourseExceptionService(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    public Course getCourseById(Long id) {
        return courseRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("강의", "ID", id));
    }

    @Transactional
    public Course createCourse(String title, String description, int duration,
                               String instructor, int maxStudents, String level) {
        // 제목 중복 체크
        if (courseRepository.findByTitleContaining(title).size() > 0) {
            throw new DuplicateResourceException("바데부: 이미 존재하는 강의 제목입니다!");
        }

        // 비즈니스 검증
        if (maxStudents <= 0) {
            throw new InvalidRequestException("바데부: 최대 수강생은 1명 이상이어야 합니다!");
        }

        Course course = new Course(title, description, duration, instructor, maxStudents, level);
        return courseRepository.save(course);
    }

    @Transactional
    public void enrollCourse(Long courseId) {
        Course course = getCourseById(courseId);

        if (!course.isPublished()) {
            throw new BusinessException("바데부: 공개되지 않은 강의는 수강 신청할 수 없습니다!", "COURSE_NOT_PUBLISHED");
        }

        if (!course.canEnroll()) {
            throw new BusinessException("바데부: 정원이 가득 찼습니다!", "COURSE_FULL");
        }

        course.enroll();
    }

    @Transactional
    public void deleteCourse(Long id) {
        Course course = getCourseById(id);

        if (course.getEnrolledStudents() > 0) {
            throw new BusinessException(
                "바데부: 수강생이 있는 강의는 삭제할 수 없습니다!",
                "COURSE_HAS_STUDENTS"
            );
        }

        courseRepository.delete(course);
    }
}
```

## 실습 예제: 완전한 예외 처리

```java
// 테스트용 Controller
@RestController
@RequestMapping("/api/demo/exception")
public class ExceptionDemoController {

    @GetMapping("/not-found")
    public String testNotFound() {
        throw new ResourceNotFoundException("바데부: 데모 리소스를 찾을 수 없습니다!");
    }

    @GetMapping("/business")
    public String testBusiness() {
        throw new BusinessException("바데부: 비즈니스 규칙 위반!", "DEMO_ERROR");
    }

    @GetMapping("/duplicate")
    public String testDuplicate() {
        throw new DuplicateResourceException("바데부: 중복된 데이터입니다!");
    }

    @PostMapping("/validation")
    public String testValidation(@Valid @RequestBody TestDto dto) {
        return "바데부: 검증 성공!";
    }
}

class TestDto {
    @NotBlank(message = "바데부: 이름은 필수입니다!")
    @Size(min = 2, max = 10, message = "바데부: 이름은 2~10자여야 합니다!")
    private String name;

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}
```

## 핵심 정리

1. **@RestControllerAdvice**로 전역 예외 처리
2. **커스텀 예외 클래스**로 명확한 예외 구분
3. **Bean Validation**으로 입력 데이터 검증
4. **ErrorResponse DTO**로 일관된 에러 응답
5. **적절한 HTTP 상태 코드** 반환 (404, 400, 409 등)

## 실습 과제

1. 비밀번호 검증 커스텀 Validator 만들기 (최소 8자, 대소문자/숫자 포함)
2. 전화번호 형식 검증 어노테이션 만들기
3. 파일 업로드 크기 제한 예외 처리
4. API 호출 횟수 제한 예외 구현

## 다음 챕터 미리보기

다음 챕터에서는 **Spring Security**를 활용한 인증과 권한 관리를 배워보겠습니다!
