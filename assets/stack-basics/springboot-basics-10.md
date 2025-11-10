# Chapter 10: 프로덕션 배포와 모범 사례

## 학습 목표
- 프로덕션 환경 설정하기
- 애플리케이션 패키징과 배포하기
- 모니터링과 로깅 구성하기
- Spring Boot 모범 사례 이해하기

## 프로파일별 설정 관리

### 1. 환경별 설정 파일

```
src/main/resources/
├── application.properties          # 공통 설정
├── application-dev.properties      # 개발 환경
├── application-test.properties     # 테스트 환경
└── application-prod.properties     # 운영 환경
```

### 2. application.properties (공통)

```properties
# 애플리케이션 기본 설정
spring.application.name=badebu-learning-app
server.port=8080

# 기본 프로파일
spring.profiles.active=dev

# 로깅 기본 설정
logging.pattern.console=%d{yyyy-MM-dd HH:mm:ss} - %msg%n
logging.file.name=logs/badebu-app.log
```

### 3. application-dev.properties

```properties
# 개발 환경 설정
spring.datasource.url=jdbc:h2:mem:devdb
spring.datasource.username=sa
spring.datasource.password=

# H2 Console
spring.h2.console.enabled=true

# JPA 설정
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# 로깅
logging.level.com.badebu=DEBUG
logging.level.org.springframework.web=DEBUG

# 바데부 개발 환경
badebu.environment=development
badebu.debug-mode=true
```

### 4. application-prod.properties

```properties
# 운영 환경 설정
spring.datasource.url=${DB_URL}
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# 커넥션 풀 설정
spring.datasource.hikari.maximum-pool-size=20
spring.datasource.hikari.minimum-idle=5
spring.datasource.hikari.connection-timeout=30000

# JPA 설정
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.format_sql=false
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect

# 로깅
logging.level.com.badebu=INFO
logging.level.org.springframework.web=WARN

# 보안
server.ssl.enabled=false
server.compression.enabled=true

# 바데부 운영 환경
badebu.environment=production
badebu.debug-mode=false
```

## 환경 변수 사용

### 1. 환경 변수 설정 클래스

```java
package com.badebu.learningapp.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "badebu")
public class BadebuProperties {

    private String environment;
    private boolean debugMode;
    private String apiBaseUrl;
    private int maxUploadSize;

    // Getters and Setters
    public String getEnvironment() {
        return environment;
    }

    public void setEnvironment(String environment) {
        this.environment = environment;
    }

    public boolean isDebugMode() {
        return debugMode;
    }

    public void setDebugMode(boolean debugMode) {
        this.debugMode = debugMode;
    }

    public String getApiBaseUrl() {
        return apiBaseUrl;
    }

    public void setApiBaseUrl(String apiBaseUrl) {
        this.apiBaseUrl = apiBaseUrl;
    }

    public int getMaxUploadSize() {
        return maxUploadSize;
    }

    public void setMaxUploadSize(int maxUploadSize) {
        this.maxUploadSize = maxUploadSize;
    }
}
```

### 2. 사용 예시

```java
@Service
public class BadebuConfigService {

    private final BadebuProperties properties;

    public BadebuConfigService(BadebuProperties properties) {
        this.properties = properties;
    }

    public void printConfig() {
        System.out.println("바데부: 현재 환경 - " + properties.getEnvironment());
        System.out.println("바데부: 디버그 모드 - " + properties.isDebugMode());
    }
}
```

## 애플리케이션 패키징

### 1. JAR 파일로 빌드

```bash
# Maven 빌드
mvn clean package -DskipTests

# 빌드된 JAR 파일 위치
# target/badebu-learning-app-0.0.1-SNAPSHOT.jar

# Gradle 빌드
gradle clean build -x test

# 빌드된 JAR 파일 위치
# build/libs/badebu-learning-app-0.0.1-SNAPSHOT.jar
```

### 2. JAR 실행

```bash
# 기본 실행
java -jar target/badebu-learning-app-0.0.1-SNAPSHOT.jar

# 프로파일 지정
java -jar target/badebu-learning-app-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod

# 환경 변수와 함께 실행
java -jar \
  -Dspring.profiles.active=prod \
  -DDB_URL=jdbc:mysql://localhost:3306/badebu \
  -DDB_USERNAME=root \
  -DDB_PASSWORD=password \
  target/badebu-learning-app-0.0.1-SNAPSHOT.jar
```

### 3. pom.xml 빌드 설정

```xml
<build>
    <finalName>badebu-learning-app</finalName>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
            <configuration>
                <excludes>
                    <exclude>
                        <groupId>org.projectlombok</groupId>
                        <artifactId>lombok</artifactId>
                    </exclude>
                </excludes>
            </configuration>
        </plugin>
    </plugins>
</build>
```

## Docker 배포

### 1. Dockerfile

```dockerfile
# 멀티 스테이지 빌드
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /app

# Maven Wrapper와 pom.xml 복사
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# 의존성 다운로드
RUN ./mvnw dependency:go-offline

# 소스 코드 복사 및 빌드
COPY src src
RUN ./mvnw package -DskipTests

# 실행 스테이지
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# 빌드된 JAR 복사
COPY --from=builder /app/target/badebu-learning-app.jar app.jar

# 포트 노출
EXPOSE 8080

# 헬스체크
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/actuator/health || exit 1

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]

# 바데부 메시지
LABEL maintainer="badebu@example.com"
LABEL description="바데부 학습 애플리케이션"
```

### 2. docker-compose.yml

```yaml
version: '3.8'

services:
  badebu-app:
    build: .
    container_name: badebu-learning-app
    ports:
      - "8080:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=prod
      - DB_URL=jdbc:mysql://mysql:3306/badebu_db
      - DB_USERNAME=root
      - DB_PASSWORD=password
    depends_on:
      - mysql
    networks:
      - badebu-network

  mysql:
    image: mysql:8.0
    container_name: badebu-mysql
    environment:
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_DATABASE=badebu_db
    ports:
      - "3306:3306"
    volumes:
      - mysql-data:/var/lib/mysql
    networks:
      - badebu-network

networks:
  badebu-network:
    driver: bridge

volumes:
  mysql-data:
```

### 3. Docker 명령어

```bash
# 이미지 빌드
docker build -t badebu-learning-app .

# 컨테이너 실행
docker run -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=prod \
  badebu-learning-app

# Docker Compose로 실행
docker-compose up -d

# 로그 확인
docker-compose logs -f badebu-app

# 종료
docker-compose down
```

## Spring Boot Actuator (모니터링)

### 1. 의존성 추가

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

### 2. application.properties 설정

```properties
# Actuator 엔드포인트 설정
management.endpoints.web.exposure.include=health,info,metrics,env,loggers
management.endpoint.health.show-details=always

# 애플리케이션 정보
info.app.name=바데부 학습 애플리케이션
info.app.description=Spring Boot 학습 플랫폼
info.app.version=@project.version@
info.app.author=바데부

# 헬스 체크
management.health.db.enabled=true
management.health.diskspace.enabled=true
```

### 3. 커스텀 헬스 체크

```java
package com.badebu.learningapp.health;

import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;

@Component
public class BadebuHealthIndicator implements HealthIndicator {

    @Override
    public Health health() {
        try {
            // 커스텀 헬스 체크 로직
            boolean isHealthy = checkBadebuService();

            if (isHealthy) {
                return Health.up()
                        .withDetail("message", "바데부: 모든 시스템이 정상입니다!")
                        .withDetail("status", "HEALTHY")
                        .build();
            } else {
                return Health.down()
                        .withDetail("message", "바데부: 시스템에 문제가 있습니다!")
                        .withDetail("status", "UNHEALTHY")
                        .build();
            }
        } catch (Exception e) {
            return Health.down()
                    .withDetail("error", e.getMessage())
                    .build();
        }
    }

    private boolean checkBadebuService() {
        // 실제 헬스 체크 로직
        return true;
    }
}
```

### 4. Actuator 엔드포인트

```bash
# 헬스 체크
curl http://localhost:8080/actuator/health

# 애플리케이션 정보
curl http://localhost:8080/actuator/info

# 메트릭 정보
curl http://localhost:8080/actuator/metrics

# 특정 메트릭 조회
curl http://localhost:8080/actuator/metrics/jvm.memory.used

# 환경 변수
curl http://localhost:8080/actuator/env

# 로거 레벨 조회
curl http://localhost:8080/actuator/loggers/com.badebu

# 로거 레벨 변경 (POST)
curl -X POST http://localhost:8080/actuator/loggers/com.badebu \
  -H "Content-Type: application/json" \
  -d '{"configuredLevel": "DEBUG"}'
```

## 로깅 설정

### 1. Logback 설정 (logback-spring.xml)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <!-- 콘솔 출력 -->
    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!-- 파일 출력 -->
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>logs/badebu-app.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>logs/badebu-app.%d{yyyy-MM-dd}.%i.log</fileNamePattern>
            <timeBasedFileNamingAndTriggeringPolicy
                class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">
                <maxFileSize>10MB</maxFileSize>
            </timeBasedFileNamingAndTriggeringPolicy>
            <maxHistory>30</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!-- 프로파일별 로깅 레벨 -->
    <springProfile name="dev">
        <logger name="com.badebu" level="DEBUG"/>
        <root level="INFO">
            <appender-ref ref="CONSOLE"/>
        </root>
    </springProfile>

    <springProfile name="prod">
        <logger name="com.badebu" level="INFO"/>
        <root level="WARN">
            <appender-ref ref="FILE"/>
        </root>
    </springProfile>

</configuration>
```

### 2. 구조화된 로깅

```java
package com.badebu.learningapp.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class BadebuLoggingService {

    private static final Logger log = LoggerFactory.getLogger(BadebuLoggingService.class);

    public void demonstrateLogging() {
        log.trace("바데부: TRACE 레벨 로그");
        log.debug("바데부: DEBUG 레벨 로그");
        log.info("바데부: INFO 레벨 로그");
        log.warn("바데부: WARN 레벨 로그");
        log.error("바데부: ERROR 레벨 로그");

        // 파라미터를 사용한 로깅
        String username = "바데부";
        int score = 100;
        log.info("바데부: {}님의 점수는 {}점입니다.", username, score);

        // 예외 로깅
        try {
            throw new RuntimeException("테스트 예외");
        } catch (Exception e) {
            log.error("바데부: 오류 발생!", e);
        }
    }
}
```

## 성능 최적화

### 1. 데이터베이스 연결 풀 설정

```properties
# HikariCP 설정
spring.datasource.hikari.maximum-pool-size=20
spring.datasource.hikari.minimum-idle=5
spring.datasource.hikari.connection-timeout=30000
spring.datasource.hikari.idle-timeout=600000
spring.datasource.hikari.max-lifetime=1800000
```

### 2. JPA 최적화

```properties
# JPA 배치 처리
spring.jpa.properties.hibernate.jdbc.batch_size=20
spring.jpa.properties.hibernate.order_inserts=true
spring.jpa.properties.hibernate.order_updates=true

# 쿼리 캐싱
spring.jpa.properties.hibernate.cache.use_second_level_cache=true
spring.jpa.properties.hibernate.cache.region.factory_class=org.hibernate.cache.jcache.JCacheRegionFactory
```

### 3. 캐싱 설정

```java
package com.badebu.learningapp.config;

import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableCaching
public class CacheConfig {
    // Spring Cache 설정
}

// 서비스에서 캐싱 사용
@Service
public class BadebuCacheService {

    @Cacheable(value = "students", key = "#id")
    public Student getStudent(Long id) {
        System.out.println("바데부: 데이터베이스에서 조회합니다.");
        return studentRepository.findById(id).orElse(null);
    }

    @CacheEvict(value = "students", key = "#id")
    public void updateStudent(Long id, Student student) {
        System.out.println("바데부: 캐시를 제거합니다.");
        studentRepository.save(student);
    }
}
```

## 보안 모범 사례

### 1. 민감 정보 암호화

```properties
# Jasypt를 사용한 암호화
spring.datasource.password=ENC(encrypted-password)

# application.properties
jasypt.encryptor.password=${JASYPT_PASSWORD}
jasypt.encryptor.algorithm=PBEWithMD5AndDES
```

### 2. CORS 설정

```java
package com.badebu.learningapp.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
                .allowedOrigins("https://badebu.com")
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }
}
```

### 3. Rate Limiting

```java
// Bucket4j를 사용한 API 호출 제한
@Component
public class RateLimitingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {
        // Rate limiting 로직
        System.out.println("바데부: API 호출 횟수 체크");
        chain.doFilter(request, response);
    }
}
```

## 시스템 운영 체크리스트

### 배포 전 체크리스트

- [ ] 모든 테스트 통과 확인
- [ ] 운영 환경 설정 파일 검토
- [ ] 민감한 정보 환경 변수 처리
- [ ] 로깅 레벨 적절히 설정
- [ ] 데이터베이스 마이그레이션 스크립트 준비
- [ ] 백업 및 롤백 계획 수립
- [ ] 모니터링 및 알림 설정
- [ ] 보안 취약점 점검

### 운영 중 모니터링

```bash
# 애플리케이션 상태 확인
curl http://localhost:8080/actuator/health

# 메모리 사용량 확인
curl http://localhost:8080/actuator/metrics/jvm.memory.used

# 로그 모니터링
tail -f logs/badebu-app.log

# Docker 컨테이너 상태
docker stats badebu-learning-app
```

## 핵심 정리

1. **프로파일별 설정** 분리로 환경 관리
2. **Docker**로 일관된 배포 환경 구축
3. **Actuator**로 애플리케이션 모니터링
4. **구조화된 로깅**으로 문제 추적
5. **보안 설정** 철저히 관리
6. **성능 최적화** 지속적 수행

## 최종 실습 과제

1. 전체 애플리케이션을 Docker로 컨테이너화하기
2. CI/CD 파이프라인 구축 (GitHub Actions)
3. 프로메테우스와 그라파나로 모니터링 설정
4. 무중단 배포 전략 구현

## 바데부의 마무리 메시지

축하합니다! Spring Boot 기초 과정 10개 챕터를 모두 완료하셨습니다!

**배운 내용:**
1. Spring Boot 프로젝트 설정
2. 의존성 주입과 IoC
3. REST API 개발
4. JPA 데이터베이스 연동
5. Service 계층 설계
6. 예외 처리와 검증
7. Spring Security 인증
8. 파일 업로드/다운로드
9. 테스트 작성
10. 프로덕션 배포

**다음 단계:**
- Spring Cloud로 마이크로서비스 아키텍처 학습
- Kafka, Redis 등 메시징 시스템 연동
- Kubernetes로 컨테이너 오케스트레이션
- 실전 프로젝트 개발

바데부와 함께한 Spring Boot 여정이 즐거우셨기를 바랍니다!
계속해서 성장하는 개발자가 되세요! 화이팅!
