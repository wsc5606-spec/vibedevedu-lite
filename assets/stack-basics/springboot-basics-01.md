# Chapter 1: Spring Boot 소개 및 프로젝트 설정

## 학습 목표
- Spring Boot의 개념과 장점 이해하기
- Spring Initializr를 사용한 프로젝트 생성
- 프로젝트 구조와 주요 파일 파악하기

## Spring Boot란?

Spring Boot는 Spring 프레임워크를 기반으로 한 강력한 Java 애플리케이션 개발 도구입니다. 복잡한 설정 없이 빠르게 프로덕션 수준의 애플리케이션을 만들 수 있습니다.

### 주요 특징

1. **자동 설정(Auto Configuration)**: 필요한 설정을 자동으로 구성
2. **내장 서버**: Tomcat, Jetty 등의 서버가 내장되어 있어 별도 설치 불필요
3. **의존성 관리**: Starter 패키지로 간편한 의존성 관리
4. **프로덕션 준비**: 모니터링, 헬스 체크 등 운영 기능 기본 제공

## Spring Initializr로 프로젝트 생성하기

### 방법 1: 웹 사이트 이용

1. [https://start.spring.io](https://start.spring.io) 접속
2. 프로젝트 설정:
   - Project: **Maven** 또는 **Gradle**
   - Language: **Java**
   - Spring Boot: **3.2.0** (최신 안정 버전)
   - Project Metadata:
     - Group: `com.badebu`
     - Artifact: `learning-app`
     - Name: `learning-app`
     - Package name: `com.badebu.learningapp`
     - Packaging: **Jar**
     - Java: **17** 또는 **21**

3. Dependencies 추가:
   - Spring Web
   - Spring Boot DevTools
   - Lombok

4. **GENERATE** 버튼 클릭하여 다운로드

### 방법 2: IDE 사용 (IntelliJ IDEA)

```
File → New → Project → Spring Initializr
```

위와 동일한 설정을 IDE에서 직접 입력할 수 있습니다.

## 프로젝트 구조 이해하기

```
learning-app/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── badebu/
│   │   │           └── learningapp/
│   │   │               └── LearningAppApplication.java
│   │   └── resources/
│   │       ├── static/
│   │       ├── templates/
│   │       └── application.properties
│   └── test/
│       └── java/
│           └── com/
│               └── badebu/
│                   └── learningapp/
│                       └── LearningAppApplicationTests.java
├── pom.xml (또는 build.gradle)
└── README.md
```

### 주요 파일 설명

#### 1. LearningAppApplication.java (메인 클래스)

```java
package com.badebu.learningapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class LearningAppApplication {

    public static void main(String[] args) {
        SpringApplication.run(LearningAppApplication.class, args);
        System.out.println("바데부의 Spring Boot 학습 앱이 시작되었습니다!");
    }
}
```

**@SpringBootApplication**은 다음 3가지 어노테이션의 조합입니다:
- `@Configuration`: 설정 클래스임을 나타냄
- `@EnableAutoConfiguration`: 자동 설정 활성화
- `@ComponentScan`: 컴포넌트 스캔 활성화

#### 2. application.properties

```properties
# 서버 포트 설정
server.port=8080

# 애플리케이션 이름
spring.application.name=badebu-learning-app

# 로그 레벨 설정
logging.level.com.badebu=INFO
```

#### 3. pom.xml (Maven 사용 시)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project>
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.0</version>
    </parent>

    <groupId>com.badebu</groupId>
    <artifactId>learning-app</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>learning-app</name>
    <description>바데부의 Spring Boot 학습 프로젝트</description>

    <properties>
        <java.version>17</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>
</project>
```

## 첫 번째 컨트롤러 만들기

```java
package com.badebu.learningapp.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String hello() {
        return "안녕하세요! 바데부의 Spring Boot 학습에 오신 것을 환영합니다!";
    }

    @GetMapping("/badebu")
    public String badebu() {
        return "바데부와 함께하는 즐거운 코딩!";
    }
}
```

## 애플리케이션 실행하기

### 방법 1: IDE에서 실행
메인 클래스(`LearningAppApplication.java`)에서 Run 버튼 클릭

### 방법 2: Maven 명령어
```bash
mvn spring-boot:run
```

### 방법 3: Gradle 명령어
```bash
gradle bootRun
```

### 방법 4: JAR 파일로 실행
```bash
# 빌드
mvn clean package

# 실행
java -jar target/learning-app-0.0.1-SNAPSHOT.jar
```

## 실행 확인하기

브라우저나 터미널에서 다음 URL을 확인하세요:

```bash
# 브라우저에서
http://localhost:8080/
http://localhost:8080/badebu

# curl 사용
curl http://localhost:8080/
curl http://localhost:8080/badebu
```

## 개발 편의 기능: Spring Boot DevTools

DevTools는 개발 중 생산성을 높여주는 도구입니다:

1. **자동 재시작**: 코드 변경 시 자동으로 애플리케이션 재시작
2. **라이브 리로드**: 브라우저 자동 새로고침
3. **개발 환경 최적화**: 캐시 비활성화 등

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <scope>runtime</scope>
    <optional>true</optional>
</dependency>
```

## 핵심 정리

1. **Spring Boot**는 설정을 최소화하고 빠른 개발을 가능하게 하는 프레임워크
2. **Spring Initializr**로 프로젝트를 쉽게 생성할 수 있음
3. **@SpringBootApplication**은 Spring Boot 애플리케이션의 시작점
4. **내장 서버**로 별도의 서버 설치 없이 바로 실행 가능
5. **DevTools**로 개발 편의성 향상

## 실습 과제

1. Spring Initializr로 새 프로젝트 생성하기
2. 자신의 이름을 반환하는 `/myname` 엔드포인트 만들기
3. 서버 포트를 8090으로 변경해보기
4. 애플리케이션 시작 시 "바데부의 앱이 시작되었습니다!" 로그 출력하기

## 다음 챕터 미리보기

다음 챕터에서는 Spring의 핵심 개념인 **의존성 주입(Dependency Injection)**과 **IoC 컨테이너**에 대해 배워보겠습니다!
