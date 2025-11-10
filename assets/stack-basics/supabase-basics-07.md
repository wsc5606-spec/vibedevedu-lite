# Chapter 7: 스토리지 (Storage)

## Supabase Storage 이해하기

Supabase Storage는 파일을 저장하고 관리하는 객체 스토리지 서비스입니다. 이미지, 비디오, 문서 등 모든 종류의 파일을 안전하게 저장하고, CDN을 통해 빠르게 제공할 수 있습니다.

### Storage의 핵심 개념

- **버킷 (Bucket)**: 파일을 저장하는 최상위 컨테이너
- **경로 (Path)**: 버킷 내 파일의 위치
- **공개/비공개**: 파일의 접근 권한 설정
- **정책 (Policy)**: RLS와 유사한 파일 접근 제어

## 버킷 생성하기

### Dashboard에서 버킷 생성

```
1. Supabase Dashboard > Storage > New bucket
2. 버킷 이름: avatars (프로필 사진용)
3. Public bucket: ON (공개 접근 허용)
```

### SQL로 버킷 관리

```sql
-- 버킷 생성 (코드로는 불가, Dashboard 사용)
-- 하지만 버킷 정보는 조회 가능
SELECT * FROM storage.buckets;

-- 버킷의 파일 목록
SELECT * FROM storage.objects WHERE bucket_id = 'avatars';
```

## 파일 업로드

### 기본 파일 업로드

```javascript
import { supabase } from './supabase.js'

// 파일 업로드
async function uploadFile(file, bucketName, filePath) {
  const { data, error } = await supabase.storage
    .from(bucketName)
    .upload(filePath, file)

  if (error) {
    console.error('업로드 실패:', error.message)
    return null
  }

  console.log('업로드 성공:', data.path)
  return data
}

// 사용 예시
const fileInput = document.getElementById('file-input')
const file = fileInput.files[0]
await uploadFile(file, 'avatars', `public/${file.name}`)
```

### 바데부의 프로필 사진 업로드

```javascript
async function uploadBadebuAvatar(file) {
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    console.error('로그인이 필요합니다')
    return null
  }

  // 파일 확장자 추출
  const fileExt = file.name.split('.').pop()
  // 고유한 파일 이름 생성
  const fileName = `${user.id}-${Date.now()}.${fileExt}`
  const filePath = `avatars/${fileName}`

  // 파일 크기 확인 (5MB 제한)
  if (file.size > 5 * 1024 * 1024) {
    console.error('파일 크기는 5MB 이하여야 합니다')
    return null
  }

  // 파일 타입 확인
  if (!file.type.startsWith('image/')) {
    console.error('이미지 파일만 업로드 가능합니다')
    return null
  }

  const { data, error } = await supabase.storage
    .from('avatars')
    .upload(filePath, file, {
      cacheControl: '3600',
      upsert: false  // 같은 이름의 파일이 있으면 에러
    })

  if (error) {
    console.error('업로드 실패:', error.message)
    return null
  }

  // 공개 URL 생성
  const { data: { publicUrl } } = supabase.storage
    .from('avatars')
    .getPublicUrl(filePath)

  console.log('바데부의 프로필 사진이 업로드되었습니다!')
  console.log('URL:', publicUrl)

  // 프로필에 URL 저장
  await supabase
    .from('user_profiles')
    .update({ avatar_url: publicUrl })
    .eq('id', user.id)

  return publicUrl
}
```

### 여러 파일 동시 업로드

```javascript
async function uploadMultipleFiles(files, bucketName, folderPath) {
  const { data: { user } } = await supabase.auth.getUser()

  const uploadPromises = Array.from(files).map(async (file) => {
    const fileName = `${Date.now()}-${file.name}`
    const filePath = `${folderPath}/${fileName}`

    const { data, error } = await supabase.storage
      .from(bucketName)
      .upload(filePath, file)

    if (error) {
      console.error(`${file.name} 업로드 실패:`, error.message)
      return null
    }

    return data
  })

  const results = await Promise.all(uploadPromises)
  const successCount = results.filter(r => r !== null).length

  console.log(`${successCount}개 파일 업로드 완료`)
  return results.filter(r => r !== null)
}

// 사용 예시
const fileInput = document.getElementById('multiple-files')
const files = fileInput.files
await uploadMultipleFiles(files, 'documents', `users/${user.id}/docs`)
```

## 파일 다운로드

### 공개 URL로 파일 접근

```javascript
// 공개 버킷의 파일 URL 가져오기
function getPublicUrl(bucketName, filePath) {
  const { data } = supabase.storage
    .from(bucketName)
    .getPublicUrl(filePath)

  return data.publicUrl
}

// 사용 예시
const avatarUrl = getPublicUrl('avatars', 'avatars/badebu-123.png')
console.log('이미지 URL:', avatarUrl)

// HTML에서 사용
// <img src="${avatarUrl}" alt="바데부 프로필" />
```

### 비공개 파일 다운로드

```javascript
// 비공개 버킷의 파일 다운로드
async function downloadPrivateFile(bucketName, filePath) {
  const { data, error } = await supabase.storage
    .from(bucketName)
    .download(filePath)

  if (error) {
    console.error('다운로드 실패:', error.message)
    return null
  }

  // Blob 데이터를 URL로 변환
  const url = URL.createObjectURL(data)

  // 다운로드 링크 생성
  const a = document.createElement('a')
  a.href = url
  a.download = filePath.split('/').pop()
  a.click()

  console.log('바데부가 파일을 다운로드했습니다')
  return data
}
```

### 임시 서명된 URL 생성

```javascript
// 비공개 파일에 대한 임시 접근 URL 생성 (60초 유효)
async function createSignedUrl(bucketName, filePath, expiresIn = 60) {
  const { data, error } = await supabase.storage
    .from(bucketName)
    .createSignedUrl(filePath, expiresIn)

  if (error) {
    console.error('URL 생성 실패:', error.message)
    return null
  }

  console.log('임시 URL:', data.signedUrl)
  console.log('만료 시간:', new Date(Date.now() + expiresIn * 1000))
  return data.signedUrl
}

// 바데부의 학습 자료 공유
async function shareLearningMaterial(filePath) {
  // 24시간 동안 유효한 링크 생성
  const signedUrl = await createSignedUrl('private-docs', filePath, 60 * 60 * 24)

  console.log('바데부가 학습 자료를 공유했습니다:', signedUrl)
  return signedUrl
}
```

## 파일 관리

### 파일 목록 조회

```javascript
// 폴더의 모든 파일 조회
async function listFiles(bucketName, folderPath = '') {
  const { data, error } = await supabase.storage
    .from(bucketName)
    .list(folderPath, {
      limit: 100,
      offset: 0,
      sortBy: { column: 'created_at', order: 'desc' }
    })

  if (error) {
    console.error('파일 목록 조회 실패:', error.message)
    return []
  }

  console.log('파일 목록:', data.length, '개')
  data.forEach(file => {
    console.log('-', file.name, `(${(file.metadata.size / 1024).toFixed(2)} KB)`)
  })

  return data
}

// 바데부의 모든 아바타 조회
async function getBadebuAvatars() {
  const { data: { user } } = await supabase.auth.getUser()
  const files = await listFiles('avatars', `avatars`)

  // 사용자의 파일만 필터링
  const userFiles = files.filter(file => file.name.startsWith(user.id))

  return userFiles
}
```

### 파일 삭제

```javascript
// 단일 파일 삭제
async function deleteFile(bucketName, filePath) {
  const { data, error } = await supabase.storage
    .from(bucketName)
    .remove([filePath])

  if (error) {
    console.error('삭제 실패:', error.message)
    return false
  }

  console.log('파일 삭제 완료')
  return true
}

// 여러 파일 동시 삭제
async function deleteMultipleFiles(bucketName, filePaths) {
  const { data, error } = await supabase.storage
    .from(bucketName)
    .remove(filePaths)

  if (error) {
    console.error('삭제 실패:', error.message)
    return false
  }

  console.log(`${filePaths.length}개 파일 삭제 완료`)
  return true
}

// 바데부의 오래된 아바타 삭제
async function cleanupOldAvatars() {
  const { data: { user } } = await supabase.auth.getUser()
  const files = await listFiles('avatars', 'avatars')

  // 사용자의 파일 중 최신 1개만 제외하고 삭제
  const userFiles = files
    .filter(file => file.name.startsWith(user.id))
    .sort((a, b) => new Date(b.created_at) - new Date(a.created_at))

  if (userFiles.length > 1) {
    const filesToDelete = userFiles.slice(1).map(f => `avatars/${f.name}`)
    await deleteMultipleFiles('avatars', filesToDelete)
    console.log('바데부의 오래된 아바타가 삭제되었습니다')
  }
}
```

### 파일 이동 및 복사

```javascript
// 파일 이동
async function moveFile(bucketName, fromPath, toPath) {
  const { data, error } = await supabase.storage
    .from(bucketName)
    .move(fromPath, toPath)

  if (error) {
    console.error('이동 실패:', error.message)
    return false
  }

  console.log('파일 이동 완료:', toPath)
  return true
}

// 파일 복사
async function copyFile(bucketName, fromPath, toPath) {
  const { data, error } = await supabase.storage
    .from(bucketName)
    .copy(fromPath, toPath)

  if (error) {
    console.error('복사 실패:', error.message)
    return false
  }

  console.log('파일 복사 완료:', toPath)
  return true
}
```

## 이미지 변환

### 이미지 리사이징

```javascript
// 이미지를 특정 크기로 변환
function getTransformedImageUrl(bucketName, filePath, options) {
  const { data } = supabase.storage
    .from(bucketName)
    .getPublicUrl(filePath, {
      transform: {
        width: options.width,
        height: options.height,
        resize: options.resize || 'cover',  // cover, contain, fill
        quality: options.quality || 80
      }
    })

  return data.publicUrl
}

// 바데부의 아바타를 다양한 크기로 표시
function getBadebuAvatarSizes(filePath) {
  return {
    thumbnail: getTransformedImageUrl('avatars', filePath, {
      width: 64,
      height: 64,
      resize: 'cover'
    }),
    medium: getTransformedImageUrl('avatars', filePath, {
      width: 256,
      height: 256,
      resize: 'cover'
    }),
    large: getTransformedImageUrl('avatars', filePath, {
      width: 512,
      height: 512,
      resize: 'contain'
    })
  }
}

// 사용 예시
const avatarSizes = getBadebuAvatarSizes('avatars/badebu-123.png')
console.log('썸네일:', avatarSizes.thumbnail)
console.log('중간:', avatarSizes.medium)
console.log('큰 이미지:', avatarSizes.large)
```

## Storage 정책 (RLS)

### 공개 접근 정책

```sql
-- avatars 버킷: 모든 사용자가 읽기 가능
CREATE POLICY "공개 읽기"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'avatars');

-- 인증된 사용자는 자신의 파일만 업로드
CREATE POLICY "자신의 아바타만 업로드"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'avatars' AND
  (storage.foldername(name))[1] = 'avatars'
);

-- 자신의 파일만 삭제
CREATE POLICY "자신의 아바타만 삭제"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'avatars' AND
  owner = auth.uid()
);
```

### 비공개 버킷 정책

```sql
-- 비공개 문서 버킷
CREATE POLICY "자신의 문서만 접근"
ON storage.objects FOR SELECT
TO authenticated
USING (
  bucket_id = 'private-docs' AND
  owner = auth.uid()
);

CREATE POLICY "자신의 문서만 업로드"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'private-docs' AND
  owner = auth.uid()
);
```

## 바데부의 실전 예제: 학습 자료 관리 시스템

```javascript
// learning-materials.js
class LearningMaterialsManager {
  constructor() {
    this.bucketName = 'learning-materials'
  }

  // 학습 자료 업로드
  async uploadMaterial(file, category) {
    const { data: { user } } = await supabase.auth.getUser()

    // 파일 검증
    if (file.size > 50 * 1024 * 1024) {  // 50MB 제한
      throw new Error('파일 크기는 50MB 이하여야 합니다')
    }

    const fileExt = file.name.split('.').pop()
    const fileName = `${Date.now()}-${file.name}`
    const filePath = `${user.id}/${category}/${fileName}`

    // 업로드
    const { data, error } = await supabase.storage
      .from(this.bucketName)
      .upload(filePath, file, {
        cacheControl: '3600',
        upsert: false
      })

    if (error) throw error

    // 메타데이터 저장
    await this.saveMaterialMetadata({
      user_id: user.id,
      file_path: filePath,
      file_name: file.name,
      file_size: file.size,
      file_type: file.type,
      category: category
    })

    console.log('바데부가 학습 자료를 업로드했습니다:', file.name)
    return data
  }

  // 메타데이터 저장
  async saveMaterialMetadata(metadata) {
    const { data, error } = await supabase
      .from('learning_materials')
      .insert(metadata)
      .select()
      .single()

    if (error) throw error
    return data
  }

  // 카테고리별 자료 조회
  async getMaterialsByCategory(category) {
    const { data: { user } } = await supabase.auth.getUser()

    const { data, error } = await supabase
      .from('learning_materials')
      .select('*')
      .eq('user_id', user.id)
      .eq('category', category)
      .order('created_at', { ascending: false })

    if (error) throw error

    // 각 자료의 다운로드 URL 생성
    const materialsWithUrls = await Promise.all(
      data.map(async (material) => {
        const signedUrl = await supabase.storage
          .from(this.bucketName)
          .createSignedUrl(material.file_path, 60 * 60)  // 1시간

        return {
          ...material,
          downloadUrl: signedUrl.data.signedUrl
        }
      })
    )

    return materialsWithUrls
  }

  // 자료 검색
  async searchMaterials(keyword) {
    const { data: { user } } = await supabase.auth.getUser()

    const { data, error } = await supabase
      .from('learning_materials')
      .select('*')
      .eq('user_id', user.id)
      .ilike('file_name', `%${keyword}%`)

    if (error) throw error
    return data
  }

  // 자료 삭제
  async deleteMaterial(materialId) {
    // 메타데이터 조회
    const { data: material, error: fetchError } = await supabase
      .from('learning_materials')
      .select('file_path')
      .eq('id', materialId)
      .single()

    if (fetchError) throw fetchError

    // 스토리지에서 파일 삭제
    const { error: storageError } = await supabase.storage
      .from(this.bucketName)
      .remove([material.file_path])

    if (storageError) throw storageError

    // 메타데이터 삭제
    const { error: dbError } = await supabase
      .from('learning_materials')
      .delete()
      .eq('id', materialId)

    if (dbError) throw dbError

    console.log('바데부가 학습 자료를 삭제했습니다')
  }

  // 통계 조회
  async getStatistics() {
    const { data: { user } } = await supabase.auth.getUser()

    const { data, error } = await supabase
      .from('learning_materials')
      .select('file_size, category')
      .eq('user_id', user.id)

    if (error) throw error

    const totalSize = data.reduce((sum, m) => sum + m.file_size, 0)
    const categoryCount = data.reduce((acc, m) => {
      acc[m.category] = (acc[m.category] || 0) + 1
      return acc
    }, {})

    return {
      totalFiles: data.length,
      totalSize: totalSize,
      totalSizeMB: (totalSize / 1024 / 1024).toFixed(2),
      byCategory: categoryCount
    }
  }
}

// 사용 예시
const materialManager = new LearningMaterialsManager()

// 자료 업로드
const fileInput = document.getElementById('file-input')
const file = fileInput.files[0]
await materialManager.uploadMaterial(file, 'Supabase')

// 카테고리별 조회
const supabaseMaterials = await materialManager.getMaterialsByCategory('Supabase')
console.log('Supabase 학습 자료:', supabaseMaterials)

// 통계
const stats = await materialManager.getStatistics()
console.log('바데부의 학습 자료 통계:', stats)
```

## 일반적인 실수와 해결방법

### 실수 1: 파일 크기 제한 확인 안 함

```javascript
// ❌ 큰 파일을 무조건 업로드 시도
await supabase.storage.from('avatars').upload(path, file)

// ✅ 파일 크기 확인
if (file.size > 5 * 1024 * 1024) {
  alert('파일은 5MB 이하여야 합니다')
  return
}
```

### 실수 2: 공개/비공개 버킷 혼동

```javascript
// ❌ 비공개 버킷에서 getPublicUrl 사용
const url = supabase.storage.from('private').getPublicUrl(path)
// 접근 불가!

// ✅ 임시 서명된 URL 사용
const { data } = await supabase.storage.from('private').createSignedUrl(path, 60)
```

### 실수 3: Storage 정책 누락

```sql
-- ❌ 정책 없이 업로드 시도
-- 결과: 403 Forbidden

-- ✅ 적절한 정책 생성
CREATE POLICY "upload_policy" ON storage.objects
FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'avatars' AND owner = auth.uid());
```

## 실습 과제

1. **프로필 사진 업로드**: 이미지 업로드 및 미리보기 기능 구현
2. **파일 갤러리**: 업로드한 모든 이미지를 그리드로 표시
3. **파일 관리자**: 파일 목록, 검색, 삭제 기능이 있는 관리자 구현
4. **이미지 최적화**: 다양한 크기의 썸네일 생성

## 다음 장 미리보기

다음 장에서는 Edge Functions를 배웁니다. 서버리스 함수를 작성하여 백엔드 로직을 실행하고, 외부 API와 연동하는 방법을 알아봅니다.

## 핵심 요약

- Storage는 파일을 저장하는 객체 스토리지 서비스
- 버킷으로 파일을 조직화
- 공개 버킷은 누구나 접근, 비공개는 인증 필요
- 이미지 변환으로 다양한 크기 제공
- Storage 정책으로 접근 제어
- 임시 서명된 URL로 안전하게 공유
- 파일 크기와 타입을 항상 검증
