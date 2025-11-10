# Chapter 8: 파일 업로드와 다운로드

## 학습 목표
- MultipartFile을 사용한 파일 업로드 구현하기
- 파일 다운로드 기능 만들기
- 파일 저장소 관리하기
- 파일 업로드 보안과 검증하기

## 파일 업로드 설정

### 1. application.properties

```properties
# 파일 업로드 설정
spring.servlet.multipart.enabled=true
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB

# 파일 저장 경로
file.upload-dir=./uploads
file.profile-dir=./uploads/profiles
file.course-material-dir=./uploads/materials
```

### 2. 파일 저장 설정 클래스

```java
package com.badebu.learningapp.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "file")
public class FileStorageProperties {

    private String uploadDir;
    private String profileDir;
    private String courseMaterialDir;

    // Getters and Setters
    public String getUploadDir() {
        return uploadDir;
    }

    public void setUploadDir(String uploadDir) {
        this.uploadDir = uploadDir;
    }

    public String getProfileDir() {
        return profileDir;
    }

    public void setProfileDir(String profileDir) {
        this.profileDir = profileDir;
    }

    public String getCourseMaterialDir() {
        return courseMaterialDir;
    }

    public void setCourseMaterialDir(String courseMaterialDir) {
        this.courseMaterialDir = courseMaterialDir;
    }
}
```

## 파일 저장 Entity

```java
package com.badebu.learningapp.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "uploaded_files")
public class UploadedFile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String originalFileName;

    @Column(nullable = false)
    private String storedFileName;

    @Column(nullable = false)
    private String filePath;

    @Column(nullable = false)
    private Long fileSize;

    @Column(nullable = false)
    private String contentType;

    @Column(name = "uploaded_by")
    private String uploadedBy;

    @Column(name = "uploaded_at")
    private LocalDateTime uploadedAt;

    @Column(length = 500)
    private String description;

    protected UploadedFile() {}

    public UploadedFile(String originalFileName, String storedFileName,
                       String filePath, Long fileSize, String contentType,
                       String uploadedBy) {
        this.originalFileName = originalFileName;
        this.storedFileName = storedFileName;
        this.filePath = filePath;
        this.fileSize = fileSize;
        this.contentType = contentType;
        this.uploadedBy = uploadedBy;
        this.uploadedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }

    public String getOriginalFileName() { return originalFileName; }
    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }

    public String getStoredFileName() { return storedFileName; }
    public void setStoredFileName(String storedFileName) {
        this.storedFileName = storedFileName;
    }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public Long getFileSize() { return fileSize; }
    public void setFileSize(Long fileSize) { this.fileSize = fileSize; }

    public String getContentType() { return contentType; }
    public void setContentType(String contentType) { this.contentType = contentType; }

    public String getUploadedBy() { return uploadedBy; }
    public void setUploadedBy(String uploadedBy) { this.uploadedBy = uploadedBy; }

    public LocalDateTime getUploadedAt() { return uploadedAt; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
```

## 파일 저장소 Service

```java
package com.badebu.learningapp.service;

import com.badebu.learningapp.config.FileStorageProperties;
import com.badebu.learningapp.exception.FileStorageException;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class FileStorageService {

    private final Path fileStorageLocation;
    private final Path profileStorageLocation;
    private final Path courseMaterialLocation;

    public FileStorageService(FileStorageProperties fileStorageProperties) {
        this.fileStorageLocation = Paths.get(fileStorageProperties.getUploadDir())
                .toAbsolutePath().normalize();
        this.profileStorageLocation = Paths.get(fileStorageProperties.getProfileDir())
                .toAbsolutePath().normalize();
        this.courseMaterialLocation = Paths.get(fileStorageProperties.getCourseMaterialDir())
                .toAbsolutePath().normalize();

        try {
            Files.createDirectories(this.fileStorageLocation);
            Files.createDirectories(this.profileStorageLocation);
            Files.createDirectories(this.courseMaterialLocation);
            System.out.println("바데부: 파일 저장 디렉토리가 생성되었습니다!");
        } catch (Exception ex) {
            throw new FileStorageException("바데부: 파일 저장 디렉토리를 생성할 수 없습니다!", ex);
        }
    }

    // 일반 파일 저장
    public String storeFile(MultipartFile file) {
        return storeFile(file, fileStorageLocation);
    }

    // 프로필 이미지 저장
    public String storeProfileImage(MultipartFile file) {
        validateImageFile(file);
        return storeFile(file, profileStorageLocation);
    }

    // 강의 자료 저장
    public String storeCourseMaterial(MultipartFile file) {
        return storeFile(file, courseMaterialLocation);
    }

    // 실제 파일 저장 로직
    private String storeFile(MultipartFile file, Path location) {
        // 파일명 정규화
        String originalFileName = StringUtils.cleanPath(file.getOriginalFilename());

        try {
            // 파일명 검증
            if (originalFileName.contains("..")) {
                throw new FileStorageException(
                    "바데부: 파일명에 부적절한 경로가 포함되어 있습니다: " + originalFileName);
            }

            // 고유한 파일명 생성
            String fileExtension = getFileExtension(originalFileName);
            String storedFileName = UUID.randomUUID().toString() + fileExtension;

            // 파일 저장
            Path targetLocation = location.resolve(storedFileName);
            Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);

            System.out.println("바데부: 파일이 저장되었습니다 - " + storedFileName);
            return storedFileName;

        } catch (IOException ex) {
            throw new FileStorageException(
                "바데부: 파일 저장 중 오류가 발생했습니다: " + originalFileName, ex);
        }
    }

    // 파일 로드
    public Resource loadFileAsResource(String fileName) {
        return loadFileAsResource(fileName, fileStorageLocation);
    }

    public Resource loadProfileImage(String fileName) {
        return loadFileAsResource(fileName, profileStorageLocation);
    }

    public Resource loadCourseMaterial(String fileName) {
        return loadFileAsResource(fileName, courseMaterialLocation);
    }

    private Resource loadFileAsResource(String fileName, Path location) {
        try {
            Path filePath = location.resolve(fileName).normalize();
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists()) {
                System.out.println("바데부: 파일을 찾았습니다 - " + fileName);
                return resource;
            } else {
                throw new FileStorageException("바데부: 파일을 찾을 수 없습니다: " + fileName);
            }
        } catch (MalformedURLException ex) {
            throw new FileStorageException("바데부: 파일을 찾을 수 없습니다: " + fileName, ex);
        }
    }

    // 파일 삭제
    public void deleteFile(String fileName) {
        deleteFile(fileName, fileStorageLocation);
    }

    public void deleteProfileImage(String fileName) {
        deleteFile(fileName, profileStorageLocation);
    }

    public void deleteCourseMaterial(String fileName) {
        deleteFile(fileName, courseMaterialLocation);
    }

    private void deleteFile(String fileName, Path location) {
        try {
            Path filePath = location.resolve(fileName).normalize();
            Files.deleteIfExists(filePath);
            System.out.println("바데부: 파일이 삭제되었습니다 - " + fileName);
        } catch (IOException ex) {
            throw new FileStorageException("바데부: 파일 삭제 중 오류가 발생했습니다: " + fileName, ex);
        }
    }

    // 유틸리티 메서드
    private String getFileExtension(String fileName) {
        if (fileName.lastIndexOf(".") != -1) {
            return fileName.substring(fileName.lastIndexOf("."));
        }
        return "";
    }

    private void validateImageFile(MultipartFile file) {
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new FileStorageException("바데부: 이미지 파일만 업로드할 수 있습니다!");
        }

        // 파일 크기 검증 (5MB)
        long maxSize = 5 * 1024 * 1024; // 5MB
        if (file.getSize() > maxSize) {
            throw new FileStorageException("바데부: 파일 크기는 5MB를 초과할 수 없습니다!");
        }
    }
}
```

## 파일 업로드 Service

```java
package com.badebu.learningapp.service;

import com.badebu.learningapp.entity.UploadedFile;
import com.badebu.learningapp.repository.UploadedFileRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

@Service
@Transactional
public class FileUploadService {

    private final FileStorageService fileStorageService;
    private final UploadedFileRepository uploadedFileRepository;

    public FileUploadService(FileStorageService fileStorageService,
                            UploadedFileRepository uploadedFileRepository) {
        this.fileStorageService = fileStorageService;
        this.uploadedFileRepository = uploadedFileRepository;
    }

    public UploadedFile uploadFile(MultipartFile file, String uploadedBy, String description) {
        // 파일 저장
        String storedFileName = fileStorageService.storeFile(file);

        // 메타데이터 저장
        UploadedFile uploadedFile = new UploadedFile(
            file.getOriginalFilename(),
            storedFileName,
            fileStorageService.fileStorageLocation.toString(),
            file.getSize(),
            file.getContentType(),
            uploadedBy
        );
        uploadedFile.setDescription(description);

        UploadedFile saved = uploadedFileRepository.save(uploadedFile);
        System.out.println("바데부: 파일 업로드 완료 - " + file.getOriginalFilename());
        return saved;
    }

    public UploadedFile uploadProfileImage(MultipartFile file, String username) {
        String storedFileName = fileStorageService.storeProfileImage(file);

        UploadedFile uploadedFile = new UploadedFile(
            file.getOriginalFilename(),
            storedFileName,
            fileStorageService.profileStorageLocation.toString(),
            file.getSize(),
            file.getContentType(),
            username
        );
        uploadedFile.setDescription("프로필 이미지");

        return uploadedFileRepository.save(uploadedFile);
    }

    public UploadedFile uploadCourseMaterial(MultipartFile file, String uploadedBy,
                                            String description) {
        String storedFileName = fileStorageService.storeCourseMaterial(file);

        UploadedFile uploadedFile = new UploadedFile(
            file.getOriginalFilename(),
            storedFileName,
            fileStorageService.courseMaterialLocation.toString(),
            file.getSize(),
            file.getContentType(),
            uploadedBy
        );
        uploadedFile.setDescription(description);

        return uploadedFileRepository.save(uploadedFile);
    }

    @Transactional(readOnly = true)
    public UploadedFile getFileInfo(Long id) {
        return uploadedFileRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("바데부: 파일을 찾을 수 없습니다!"));
    }

    @Transactional(readOnly = true)
    public List<UploadedFile> getAllFiles() {
        return uploadedFileRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<UploadedFile> getFilesByUser(String username) {
        return uploadedFileRepository.findByUploadedBy(username);
    }

    public void deleteFile(Long id) {
        UploadedFile file = getFileInfo(id);
        fileStorageService.deleteFile(file.getStoredFileName());
        uploadedFileRepository.delete(file);
        System.out.println("바데부: 파일이 삭제되었습니다 - " + file.getOriginalFileName());
    }
}
```

## 파일 업로드/다운로드 Controller

```java
package com.badebu.learningapp.controller;

import com.badebu.learningapp.entity.UploadedFile;
import com.badebu.learningapp.service.FileStorageService;
import com.badebu.learningapp.service.FileUploadService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/files")
public class FileController {

    private final FileUploadService fileUploadService;
    private final FileStorageService fileStorageService;

    public FileController(FileUploadService fileUploadService,
                         FileStorageService fileStorageService) {
        this.fileUploadService = fileUploadService;
        this.fileStorageService = fileStorageService;
    }

    // 단일 파일 업로드
    @PostMapping("/upload")
    public ResponseEntity<UploadedFile> uploadFile(
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "description", required = false) String description,
            @AuthenticationPrincipal UserDetails userDetails) {

        String username = userDetails != null ? userDetails.getUsername() : "anonymous";
        UploadedFile uploadedFile = fileUploadService.uploadFile(file, username, description);

        return ResponseEntity.status(HttpStatus.CREATED).body(uploadedFile);
    }

    // 여러 파일 업로드
    @PostMapping("/upload/multiple")
    public ResponseEntity<List<UploadedFile>> uploadMultipleFiles(
            @RequestParam("files") MultipartFile[] files,
            @AuthenticationPrincipal UserDetails userDetails) {

        String username = userDetails != null ? userDetails.getUsername() : "anonymous";

        List<UploadedFile> uploadedFiles = java.util.Arrays.stream(files)
                .map(file -> fileUploadService.uploadFile(file, username, null))
                .toList();

        return ResponseEntity.status(HttpStatus.CREATED).body(uploadedFiles);
    }

    // 프로필 이미지 업로드
    @PostMapping("/upload/profile")
    public ResponseEntity<UploadedFile> uploadProfileImage(
            @RequestParam("file") MultipartFile file,
            @AuthenticationPrincipal UserDetails userDetails) {

        String username = userDetails.getUsername();
        UploadedFile uploadedFile = fileUploadService.uploadProfileImage(file, username);

        return ResponseEntity.status(HttpStatus.CREATED).body(uploadedFile);
    }

    // 강의 자료 업로드
    @PostMapping("/upload/course-material")
    public ResponseEntity<UploadedFile> uploadCourseMaterial(
            @RequestParam("file") MultipartFile file,
            @RequestParam("description") String description,
            @AuthenticationPrincipal UserDetails userDetails) {

        String username = userDetails.getUsername();
        UploadedFile uploadedFile = fileUploadService.uploadCourseMaterial(
            file, username, description);

        return ResponseEntity.status(HttpStatus.CREATED).body(uploadedFile);
    }

    // 파일 다운로드
    @GetMapping("/download/{fileId}")
    public ResponseEntity<Resource> downloadFile(
            @PathVariable Long fileId,
            HttpServletRequest request) {

        UploadedFile fileInfo = fileUploadService.getFileInfo(fileId);
        Resource resource = fileStorageService.loadFileAsResource(fileInfo.getStoredFileName());

        // Content-Type 결정
        String contentType = null;
        try {
            contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
        } catch (IOException ex) {
            System.out.println("바데부: Content-Type을 결정할 수 없습니다.");
        }

        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION,
                       "attachment; filename=\"" + fileInfo.getOriginalFileName() + "\"")
                .body(resource);
    }

    // 파일 목록 조회
    @GetMapping
    public ResponseEntity<List<UploadedFile>> getAllFiles() {
        return ResponseEntity.ok(fileUploadService.getAllFiles());
    }

    // 내 파일 목록 조회
    @GetMapping("/my-files")
    public ResponseEntity<List<UploadedFile>> getMyFiles(
            @AuthenticationPrincipal UserDetails userDetails) {
        String username = userDetails.getUsername();
        return ResponseEntity.ok(fileUploadService.getFilesByUser(username));
    }

    // 파일 정보 조회
    @GetMapping("/{fileId}")
    public ResponseEntity<UploadedFile> getFileInfo(@PathVariable Long fileId) {
        return ResponseEntity.ok(fileUploadService.getFileInfo(fileId));
    }

    // 파일 삭제
    @DeleteMapping("/{fileId}")
    public ResponseEntity<String> deleteFile(@PathVariable Long fileId) {
        fileUploadService.deleteFile(fileId);
        return ResponseEntity.ok("바데부: 파일이 삭제되었습니다!");
    }
}
```

## Repository

```java
package com.badebu.learningapp.repository;

import com.badebu.learningapp.entity.UploadedFile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UploadedFileRepository extends JpaRepository<UploadedFile, Long> {

    List<UploadedFile> findByUploadedBy(String username);

    List<UploadedFile> findByContentType(String contentType);

    List<UploadedFile> findByOriginalFileNameContaining(String keyword);
}
```

## 파일 업로드 예외 처리

```java
package com.badebu.learningapp.exception;

public class FileStorageException extends RuntimeException {

    public FileStorageException(String message) {
        super(message);
    }

    public FileStorageException(String message, Throwable cause) {
        super(message, cause);
    }
}
```

## 테스트 (cURL)

```bash
# 1. 파일 업로드
curl -X POST http://localhost:8080/api/files/upload \
  -H "Authorization: Bearer {your-token}" \
  -F "file=@/path/to/file.pdf" \
  -F "description=바데부 학습 자료"

# 2. 여러 파일 업로드
curl -X POST http://localhost:8080/api/files/upload/multiple \
  -H "Authorization: Bearer {your-token}" \
  -F "files=@/path/to/file1.pdf" \
  -F "files=@/path/to/file2.jpg"

# 3. 프로필 이미지 업로드
curl -X POST http://localhost:8080/api/files/upload/profile \
  -H "Authorization: Bearer {your-token}" \
  -F "file=@/path/to/profile.jpg"

# 4. 파일 다운로드
curl -X GET http://localhost:8080/api/files/download/1 \
  -H "Authorization: Bearer {your-token}" \
  -o downloaded-file.pdf

# 5. 파일 목록 조회
curl -X GET http://localhost:8080/api/files \
  -H "Authorization: Bearer {your-token}"

# 6. 파일 삭제
curl -X DELETE http://localhost:8080/api/files/1 \
  -H "Authorization: Bearer {your-token}"
```

## 핵심 정리

1. **MultipartFile**로 파일 업로드 처리
2. **UUID**로 고유한 파일명 생성
3. **Resource**로 파일 다운로드 응답
4. **파일 검증**: 크기, 형식, 경로 검증
5. **메타데이터 관리**: DB에 파일 정보 저장

## 실습 과제

1. 이미지 리사이징 기능 구현
2. 파일 업로드 진행률 표시
3. 대용량 파일 청크 업로드
4. 파일 미리보기 기능
5. 압축 파일 처리 기능

## 다음 챕터 미리보기

다음 챕터에서는 **JUnit과 Mockito를 사용한 테스트 작성**에 대해 배워보겠습니다!
