# Chapter 5: Cloud Storage (파일 저장소)

안녕하세요! 바데부입니다! 이번에는 Firebase Cloud Storage로 이미지와 파일을 저장하는 방법을 배워볼 거예요!

## 5.1 Cloud Storage란?

Cloud Storage는 이미지, 동영상, 오디오 등 파일을 저장하고 관리하는 서비스예요. Google Cloud Storage를 기반으로 하여 안전하고 확장 가능합니다!

**Cloud Storage의 장점:**
- 대용량 파일 저장
- 안전한 파일 전송
- 자동 이미지 리사이징 (확장 기능)
- CDN을 통한 빠른 다운로드
- 세밀한 보안 규칙

## 5.2 Cloud Storage 시작하기

### 1단계: Storage 활성화

Firebase 콘솔 > Storage > 시작하기

**보안 규칙 선택:**
- 테스트 모드: 누구나 읽기/쓰기 (개발용)
- 프로덕션 모드: 인증된 사용자만 접근

### 2단계: SDK 설치

```bash
# 웹 프로젝트
npm install firebase

# Flutter 프로젝트
flutter pub add firebase_storage
```

### 3단계: Storage 초기화

```javascript
import { getStorage } from 'firebase/storage';

const storage = getStorage();
```

```dart
// Flutter
import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance;
```

## 5.3 파일 구조 이해하기

Cloud Storage는 버킷(bucket)에 파일을 저장합니다.

```
gs://your-project.appspot.com/
  ├─ images/
  │   ├─ profile/
  │   │   ├─ user1.jpg
  │   │   └─ user2.jpg
  │   └─ posts/
  │       └─ post1.jpg
  ├─ videos/
  │   └─ intro.mp4
  └─ documents/
      └─ resume.pdf
```

**경로 예시:**
- `images/profile/user1.jpg`
- `videos/intro.mp4`
- `documents/resume.pdf`

## 5.4 파일 업로드하기

### JavaScript/React - 파일 업로드

```javascript
import { ref, uploadBytes, getDownloadURL } from 'firebase/storage';

async function uploadFile(file, path) {
  try {
    // Storage 참조 생성
    const storageRef = ref(storage, path);

    // 파일 업로드
    const snapshot = await uploadBytes(storageRef, file);

    console.log('✅ 업로드 성공!');
    console.log('업로드된 바이트:', snapshot.totalBytes);

    // 다운로드 URL 가져오기
    const downloadURL = await getDownloadURL(snapshot.ref);
    console.log('다운로드 URL:', downloadURL);

    return downloadURL;
  } catch (error) {
    console.error('❌ 업로드 실패:', error);
  }
}

// 사용 예시
const fileInput = document.getElementById('fileInput');
fileInput.addEventListener('change', async (e) => {
  const file = e.target.files[0];
  const url = await uploadFile(file, 'images/profile/' + file.name);
});
```

### JavaScript/React - 진행률 표시

```javascript
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';

function uploadFileWithProgress(file, path, onProgress) {
  const storageRef = ref(storage, path);
  const uploadTask = uploadBytesResumable(storageRef, file);

  return new Promise((resolve, reject) => {
    uploadTask.on('state_changed',
      (snapshot) => {
        // 진행률 계산
        const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        console.log('업로드 진행률:', progress + '%');

        if (onProgress) {
          onProgress(progress);
        }
      },
      (error) => {
        console.error('❌ 업로드 실패:', error);
        reject(error);
      },
      async () => {
        // 업로드 완료
        const downloadURL = await getDownloadURL(uploadTask.snapshot.ref);
        console.log('✅ 업로드 완료!');
        resolve(downloadURL);
      }
    );
  });
}

// 사용 예시
await uploadFileWithProgress(file, 'images/' + file.name, (progress) => {
  console.log('진행률:', progress + '%');
});
```

### Flutter - 파일 업로드

```dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadFile(File file, String path) async {
  try {
    final storageRef = storage.ref().child(path);

    // 파일 업로드
    final uploadTask = await storageRef.putFile(file);

    // 다운로드 URL 가져오기
    final downloadURL = await uploadTask.ref.getDownloadURL();

    print('✅ 업로드 성공!');
    print('다운로드 URL: $downloadURL');

    return downloadURL;
  } catch (e) {
    print('❌ 업로드 실패: $e');
    return null;
  }
}

// 진행률 표시
Future<String?> uploadFileWithProgress(File file, String path) async {
  final storageRef = storage.ref().child(path);
  final uploadTask = storageRef.putFile(file);

  // 진행률 리스너
  uploadTask.snapshotEvents.listen((taskSnapshot) {
    final progress = taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
    print('업로드 진행률: ${(progress * 100).toStringAsFixed(2)}%');
  });

  // 완료 대기
  final snapshot = await uploadTask;
  return await snapshot.ref.getDownloadURL();
}
```

## 5.5 파일 다운로드하기

### JavaScript/React - 다운로드 URL 가져오기

```javascript
import { ref, getDownloadURL } from 'firebase/storage';

async function getFileURL(path) {
  try {
    const storageRef = ref(storage, path);
    const url = await getDownloadURL(storageRef);

    console.log('다운로드 URL:', url);
    return url;
  } catch (error) {
    if (error.code === 'storage/object-not-found') {
      console.error('파일이 존재하지 않습니다.');
    }
  }
}

// 이미지에 URL 설정
const url = await getFileURL('images/profile/badebu.jpg');
document.getElementById('myImage').src = url;
```

### JavaScript/React - 파일 다운로드

```javascript
import { ref, getDownloadURL } from 'firebase/storage';

async function downloadFile(path, filename) {
  const storageRef = ref(storage, path);
  const url = await getDownloadURL(storageRef);

  // 브라우저에서 다운로드
  const xhr = new XMLHttpRequest();
  xhr.responseType = 'blob';
  xhr.onload = () => {
    const blob = xhr.response;
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = filename;
    link.click();
  };
  xhr.open('GET', url);
  xhr.send();
}
```

### Flutter - 다운로드

```dart
Future<String?> getFileURL(String path) async {
  try {
    final storageRef = storage.ref().child(path);
    final url = await storageRef.getDownloadURL();

    print('다운로드 URL: $url');
    return url;
  } on FirebaseException catch (e) {
    if (e.code == 'object-not-found') {
      print('파일이 존재하지 않습니다.');
    }
    return null;
  }
}

// 이미지 위젯에서 사용
FutureBuilder<String?>(
  future: getFileURL('images/profile/badebu.jpg'),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Image.network(snapshot.data!);
    }
    return CircularProgressIndicator();
  },
)
```

## 5.6 파일 메타데이터

### JavaScript/React - 메타데이터 설정

```javascript
import { ref, uploadBytes, getMetadata, updateMetadata } from 'firebase/storage';

// 업로드 시 메타데이터 설정
async function uploadWithMetadata(file, path) {
  const storageRef = ref(storage, path);

  const metadata = {
    contentType: 'image/jpeg',
    customMetadata: {
      'uploadedBy': 'badebu',
      'description': '프로필 사진'
    }
  };

  await uploadBytes(storageRef, file, metadata);
}

// 메타데이터 가져오기
async function getFileMetadata(path) {
  const storageRef = ref(storage, path);
  const metadata = await getMetadata(storageRef);

  console.log('파일 크기:', metadata.size);
  console.log('콘텐츠 타입:', metadata.contentType);
  console.log('생성 시간:', metadata.timeCreated);
  console.log('커스텀 메타데이터:', metadata.customMetadata);
}

// 메타데이터 업데이트
async function updateFileMetadata(path) {
  const storageRef = ref(storage, path);

  const newMetadata = {
    customMetadata: {
      'description': '업데이트된 설명'
    }
  };

  await updateMetadata(storageRef, newMetadata);
}
```

### Flutter - 메타데이터

```dart
Future<void> uploadWithMetadata(File file, String path) async {
  final storageRef = storage.ref().child(path);

  final metadata = SettableMetadata(
    contentType: 'image/jpeg',
    customMetadata: {
      'uploadedBy': 'badebu',
      'description': '프로필 사진',
    },
  );

  await storageRef.putFile(file, metadata);
}

// 메타데이터 가져오기
Future<void> getFileMetadata(String path) async {
  final storageRef = storage.ref().child(path);
  final metadata = await storageRef.getMetadata();

  print('파일 크기: ${metadata.size}');
  print('콘텐츠 타입: ${metadata.contentType}');
  print('생성 시간: ${metadata.timeCreated}');
}
```

## 5.7 파일 삭제하기

### JavaScript/React

```javascript
import { ref, deleteObject } from 'firebase/storage';

async function deleteFile(path) {
  try {
    const storageRef = ref(storage, path);
    await deleteObject(storageRef);

    console.log('✅ 파일 삭제 성공!');
  } catch (error) {
    if (error.code === 'storage/object-not-found') {
      console.log('파일이 존재하지 않습니다.');
    } else {
      console.error('❌ 삭제 실패:', error);
    }
  }
}

// 사용 예시
await deleteFile('images/profile/old-photo.jpg');
```

### Flutter

```dart
Future<void> deleteFile(String path) async {
  try {
    final storageRef = storage.ref().child(path);
    await storageRef.delete();

    print('✅ 파일 삭제 성공!');
  } on FirebaseException catch (e) {
    if (e.code == 'object-not-found') {
      print('파일이 존재하지 않습니다.');
    }
  }
}
```

## 5.8 파일 목록 가져오기

### JavaScript/React

```javascript
import { ref, listAll, getDownloadURL } from 'firebase/storage';

async function listFiles(path) {
  try {
    const storageRef = ref(storage, path);
    const result = await listAll(storageRef);

    // 폴더 목록
    result.prefixes.forEach((folderRef) => {
      console.log('폴더:', folderRef.name);
    });

    // 파일 목록
    const fileURLs = [];
    for (const itemRef of result.items) {
      const url = await getDownloadURL(itemRef);
      fileURLs.push({
        name: itemRef.name,
        path: itemRef.fullPath,
        url: url
      });
    }

    console.log('파일 목록:', fileURLs);
    return fileURLs;
  } catch (error) {
    console.error('❌ 목록 가져오기 실패:', error);
  }
}

// 사용 예시
const files = await listFiles('images/profile/');
```

### Flutter

```dart
Future<List<String>> listFiles(String path) async {
  final storageRef = storage.ref().child(path);
  final result = await storageRef.listAll();

  // 파일 URL 목록
  final urls = <String>[];
  for (var item in result.items) {
    final url = await item.getDownloadURL();
    urls.add(url);
  }

  return urls;
}
```

## 5.9 이미지 압축 및 최적화

### JavaScript/React - 업로드 전 압축

```javascript
// 이미지 리사이징 (canvas 사용)
function resizeImage(file, maxWidth, maxHeight) {
  return new Promise((resolve) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const img = new Image();
      img.onload = () => {
        const canvas = document.createElement('canvas');
        let width = img.width;
        let height = img.height;

        // 비율 유지하며 리사이징
        if (width > maxWidth) {
          height *= maxWidth / width;
          width = maxWidth;
        }
        if (height > maxHeight) {
          width *= maxHeight / height;
          height = maxHeight;
        }

        canvas.width = width;
        canvas.height = height;

        const ctx = canvas.getContext('2d');
        ctx.drawImage(img, 0, 0, width, height);

        canvas.toBlob((blob) => {
          resolve(blob);
        }, 'image/jpeg', 0.9); // 품질 90%
      };
      img.src = e.target.result;
    };
    reader.readAsDataURL(file);
  });
}

// 사용 예시
async function uploadResizedImage(file, path) {
  const resizedBlob = await resizeImage(file, 800, 600);
  const storageRef = ref(storage, path);
  await uploadBytes(storageRef, resizedBlob);
}
```

### Flutter - 이미지 압축

```dart
import 'package:image/image.dart' as img;

Future<File> compressImage(File file) async {
  // 이미지 읽기
  final bytes = await file.readAsBytes();
  final image = img.decodeImage(bytes);

  // 리사이징
  final resized = img.copyResize(image!, width: 800);

  // 압축하여 저장
  final compressed = img.encodeJpg(resized, quality: 85);
  final compressedFile = File(file.path)..writeAsBytesSync(compressed);

  return compressedFile;
}

// 사용 예시
Future<String?> uploadCompressedImage(File file, String path) async {
  final compressed = await compressImage(file);
  return await uploadFile(compressed, path);
}
```

## 5.10 일반적인 실수와 해결방법

### 실수 1: 파일 이름에 특수문자 사용

```javascript
// ❌ 잘못된 방법
const path = 'images/프로필 사진@#$.jpg'; // 특수문자 포함

// ✅ 올바른 방법
const filename = file.name.replace(/[^a-zA-Z0-9.-]/g, '_');
const path = 'images/' + Date.now() + '_' + filename;
```

### 실수 2: 대용량 파일 검증 누락

```javascript
// ✅ 올바른 방법
function validateFile(file) {
  const maxSize = 5 * 1024 * 1024; // 5MB

  if (file.size > maxSize) {
    alert('파일 크기는 5MB 이하여야 합니다.');
    return false;
  }

  const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
  if (!allowedTypes.includes(file.type)) {
    alert('JPEG, PNG, GIF 파일만 업로드 가능합니다.');
    return false;
  }

  return true;
}
```

### 실수 3: 다운로드 URL 캐싱 누락

```javascript
// ✅ 올바른 방법
const urlCache = {};

async function getCachedURL(path) {
  if (urlCache[path]) {
    return urlCache[path];
  }

  const url = await getDownloadURL(ref(storage, path));
  urlCache[path] = url;
  return url;
}
```

## 5.11 바데부의 실전 팁

### 팁 1: 고유한 파일 이름 생성
```javascript
function generateUniqueFilename(originalName) {
  const timestamp = Date.now();
  const randomString = Math.random().toString(36).substring(7);
  const extension = originalName.split('.').pop();

  return `${timestamp}_${randomString}.${extension}`;
}
```

### 팁 2: 썸네일 생성 (Cloud Functions 사용)
```javascript
// Firebase Extensions 사용
// "Resize Images" 확장 기능 설치
// 자동으로 여러 크기의 썸네일 생성
```

### 팁 3: 보안 규칙 설정
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /images/{userId}/{fileName} {
      // 인증된 사용자만 자신의 폴더에 업로드
      allow write: if request.auth != null && request.auth.uid == userId;
      // 모두 읽기 가능
      allow read: if true;
    }
  }
}
```

## 5.12 실전 예제: 프로필 사진 업로드

### JavaScript/React

```javascript
async function uploadProfilePicture(userId, file) {
  // 1. 파일 검증
  if (!validateFile(file)) {
    return null;
  }

  // 2. 이미지 리사이징
  const resizedBlob = await resizeImage(file, 400, 400);

  // 3. 고유한 파일 이름 생성
  const filename = generateUniqueFilename(file.name);
  const path = `images/profile/${userId}/${filename}`;

  // 4. 업로드
  const url = await uploadFileWithProgress(resizedBlob, path, (progress) => {
    console.log('진행률:', progress + '%');
  });

  // 5. Firestore에 URL 저장
  await updateDoc(doc(db, 'users', userId), {
    photoURL: url
  });

  return url;
}
```

## 연습 문제

1. 파일 업로드 폼을 만들고 진행률을 표시하세요
2. 업로드된 이미지 목록을 그리드로 표시하세요
3. 이미지 클릭 시 다운로드 기능을 구현하세요
4. 파일 크기와 타입을 검증하는 함수를 작성하세요

## 다음 단계

다음 챕터에서는 **Cloud Functions**를 배워봅시다! 서버리스 함수로 백엔드 로직을 실행하는 방법을 알아볼 거예요!

## 핵심 요약

- Cloud Storage는 파일을 안전하게 저장하는 서비스
- uploadBytes()로 파일 업로드
- getDownloadURL()로 다운로드 URL 가져오기
- uploadBytesResumable()로 진행률 표시
- deleteObject()로 파일 삭제
- listAll()로 파일 목록 가져오기
- 메타데이터로 추가 정보 저장
- 업로드 전 파일 검증 및 압축 권장

바데부와 함께 Cloud Storage 마스터하기! 🔥
