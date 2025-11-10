# Chapter 2: 의존성 주입과 IoC 컨테이너

## 학습 목표
- 의존성 주입(Dependency Injection)의 개념 이해하기
- IoC(Inversion of Control) 컨테이너의 역할 파악하기
- Spring의 주요 어노테이션 사용법 익히기

## 의존성 주입(Dependency Injection)이란?

의존성 주입은 객체 간의 의존 관계를 외부에서 주입하는 디자인 패턴입니다.

### 의존성 주입이 없는 코드

```java
public class BadebuService {
    private BadebuRepository repository = new BadebuRepository(); // 직접 생성

    public void doSomething() {
        repository.save();
    }
}
```

**문제점:**
- 강한 결합: `BadebuService`가 `BadebuRepository`에 직접 의존
- 테스트 어려움: Mock 객체로 교체하기 어려움
- 유연성 부족: 다른 구현체로 변경하기 어려움

### 의존성 주입을 사용한 코드

```java
@Service
public class BadebuService {
    private final BadebuRepository repository;

    // 생성자를 통한 의존성 주입
    public BadebuService(BadebuRepository repository) {
        this.repository = repository;
    }

    public void doSomething() {
        repository.save();
    }
}
```

**장점:**
- 느슨한 결합: 인터페이스에 의존
- 테스트 용이: Mock 객체 주입 가능
- 유연성: 다른 구현체로 쉽게 교체

## IoC(Inversion of Control) 컨테이너

IoC 컨테이너는 객체의 생성과 생명주기를 관리하는 Spring의 핵심 기능입니다.

### 전통적인 방식 vs IoC

```java
// 전통적인 방식: 개발자가 직접 제어
public class Main {
    public static void main(String[] args) {
        BadebuRepository repo = new BadebuRepository();
        BadebuService service = new BadebuService(repo);
        service.doSomething();
    }
}

// IoC 방식: Spring이 제어권을 가짐
@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
        // Spring이 자동으로 Bean 생성 및 주입
    }
}
```

## Spring Bean과 Component

Spring이 관리하는 객체를 **Bean**이라고 합니다.

### 주요 어노테이션

#### 1. @Component
가장 기본적인 Bean 등록 어노테이션

```java
package com.badebu.learningapp.component;

import org.springframework.stereotype.Component;

@Component
public class BadebuGreeter {

    public String greet(String name) {
        return "안녕하세요, " + name + "님! 바데부가 환영합니다!";
    }

    public String farewell(String name) {
        return name + "님, 다음에 또 만나요! - 바데부";
    }
}
```

#### 2. @Service
비즈니스 로직을 담당하는 서비스 계층

```java
package com.badebu.learningapp.service;

import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

@Service
public class BadebuLearningService {

    private final List<String> learningTopics = new ArrayList<>();

    public void addTopic(String topic) {
        learningTopics.add(topic);
        System.out.println("바데부: " + topic + "을(를) 학습 목록에 추가했습니다!");
    }

    public List<String> getAllTopics() {
        return new ArrayList<>(learningTopics);
    }

    public int getTopicCount() {
        return learningTopics.size();
    }

    public String getProgress() {
        return String.format("바데부의 학습 진행 상황: 총 %d개의 주제를 학습 중입니다!",
                           learningTopics.size());
    }
}
```

#### 3. @Repository
데이터베이스 접근을 담당하는 DAO(Data Access Object) 계층

```java
package com.badebu.learningapp.repository;

import org.springframework.stereotype.Repository;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Repository
public class BadebuUserRepository {

    private final Map<Long, String> users = new HashMap<>();
    private Long currentId = 1L;

    public Long save(String username) {
        Long id = currentId++;
        users.put(id, username);
        System.out.println("바데부: " + username + " 사용자가 저장되었습니다!");
        return id;
    }

    public Optional<String> findById(Long id) {
        return Optional.ofNullable(users.get(id));
    }

    public Map<Long, String> findAll() {
        return new HashMap<>(users);
    }
}
```

#### 4. @Controller
웹 요청을 처리하는 컨트롤러

```java
package com.badebu.learningapp.controller;

import com.badebu.learningapp.service.BadebuLearningService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/learning")
public class BadebuLearningController {

    private final BadebuLearningService learningService;

    // 생성자 주입
    public BadebuLearningController(BadebuLearningService learningService) {
        this.learningService = learningService;
    }

    @GetMapping("/topics")
    public List<String> getTopics() {
        return learningService.getAllTopics();
    }

    @PostMapping("/topics")
    public String addTopic(@RequestParam String topic) {
        learningService.addTopic(topic);
        return "바데부: 주제가 추가되었습니다!";
    }

    @GetMapping("/progress")
    public String getProgress() {
        return learningService.getProgress();
    }
}
```

## 의존성 주입 방법

### 1. 생성자 주입 (권장)

```java
@Service
public class BadebuService {
    private final BadebuRepository repository;
    private final BadebuGreeter greeter;

    // Spring이 자동으로 의존성을 주입
    public BadebuService(BadebuRepository repository, BadebuGreeter greeter) {
        this.repository = repository;
        this.greeter = greeter;
    }
}
```

**장점:**
- 불변성: `final` 키워드 사용 가능
- 필수 의존성 명확: 생성자에서 모든 의존성 확인
- 순환 참조 감지: 컴파일 시점에 발견

### 2. Setter 주입

```java
@Service
public class BadebuService {
    private BadebuRepository repository;

    @Autowired
    public void setRepository(BadebuRepository repository) {
        this.repository = repository;
    }
}
```

### 3. 필드 주입 (권장하지 않음)

```java
@Service
public class BadebuService {
    @Autowired
    private BadebuRepository repository;
}
```

**단점:** 테스트가 어렵고, 순환 참조 문제를 런타임에서만 발견

## 실전 예제: 바데부 학습 시스템

### 1. 학습 내용 모델

```java
package com.badebu.learningapp.model;

public class LearningContent {
    private Long id;
    private String title;
    private String description;
    private String author;

    public LearningContent(Long id, String title, String description) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.author = "바데부";
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getAuthor() { return author; }
}
```

### 2. Repository 계층

```java
package com.badebu.learningapp.repository;

import com.badebu.learningapp.model.LearningContent;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class LearningContentRepository {

    private final Map<Long, LearningContent> storage = new HashMap<>();
    private Long currentId = 1L;

    public LearningContent save(LearningContent content) {
        content.setId(currentId++);
        storage.put(content.getId(), content);
        return content;
    }

    public Optional<LearningContent> findById(Long id) {
        return Optional.ofNullable(storage.get(id));
    }

    public List<LearningContent> findAll() {
        return new ArrayList<>(storage.values());
    }

    public void deleteById(Long id) {
        storage.remove(id);
    }
}
```

### 3. Service 계층

```java
package com.badebu.learningapp.service;

import com.badebu.learningapp.model.LearningContent;
import com.badebu.learningapp.repository.LearningContentRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class LearningContentService {

    private final LearningContentRepository repository;

    public LearningContentService(LearningContentRepository repository) {
        this.repository = repository;
    }

    public LearningContent createContent(String title, String description) {
        LearningContent content = new LearningContent(null, title, description);
        return repository.save(content);
    }

    public List<LearningContent> getAllContents() {
        return repository.findAll();
    }

    public LearningContent getContentById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("바데부: 해당 학습 내용을 찾을 수 없습니다!"));
    }

    public void deleteContent(Long id) {
        repository.deleteById(id);
    }
}
```

### 4. Controller 계층

```java
package com.badebu.learningapp.controller;

import com.badebu.learningapp.model.LearningContent;
import com.badebu.learningapp.service.LearningContentService;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/contents")
public class LearningContentController {

    private final LearningContentService service;

    public LearningContentController(LearningContentService service) {
        this.service = service;
    }

    @PostMapping
    public LearningContent create(@RequestParam String title,
                                   @RequestParam String description) {
        return service.createContent(title, description);
    }

    @GetMapping
    public List<LearningContent> getAll() {
        return service.getAllContents();
    }

    @GetMapping("/{id}")
    public LearningContent getById(@PathVariable Long id) {
        return service.getContentById(id);
    }

    @DeleteMapping("/{id}")
    public String delete(@PathVariable Long id) {
        service.deleteContent(id);
        return "바데부: 학습 내용이 삭제되었습니다!";
    }
}
```

## Bean의 생명주기

```java
package com.badebu.learningapp.component;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import org.springframework.stereotype.Component;

@Component
public class BadebuLifecycleBean {

    @PostConstruct
    public void init() {
        System.out.println("바데부: Bean이 초기화되었습니다!");
    }

    @PreDestroy
    public void cleanup() {
        System.out.println("바데부: Bean이 소멸됩니다. 안녕히 가세요!");
    }
}
```

## Bean Scope

```java
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

// Singleton (기본값): 애플리케이션 전체에서 하나의 인스턴스만 생성
@Component
@Scope("singleton")
public class SingletonBean { }

// Prototype: 요청할 때마다 새로운 인스턴스 생성
@Component
@Scope("prototype")
public class PrototypeBean { }
```

## 핵심 정리

1. **의존성 주입**은 객체 간의 결합도를 낮추고 테스트를 용이하게 함
2. **IoC 컨테이너**가 Bean의 생명주기를 관리
3. **@Component, @Service, @Repository, @Controller**로 Bean 등록
4. **생성자 주입**이 가장 권장되는 방식
5. **계층 구조**: Controller → Service → Repository

## 실습 과제

1. `BadebuMessageService` 만들기: 환영 메시지를 반환하는 서비스
2. `BadebuScoreRepository` 만들기: 학습 점수를 저장하는 저장소
3. 생성자 주입을 사용하여 Service에 Repository 주입하기
4. Controller에서 전체 시스템 테스트하기

## 다음 챕터 미리보기

다음 챕터에서는 **REST API**를 만들고 다양한 HTTP 메서드를 활용하는 방법을 배워보겠습니다!
