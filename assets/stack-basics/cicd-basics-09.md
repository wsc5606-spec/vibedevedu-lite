# 배포 자동화

## 배포 자동화란?

배포 자동화는 코드를 프로덕션 환경에 자동으로 전달하는 프로세스입니다. 바데부와 함께 안전하고 효율적인 배포를 배워봅시다!

### 배포 전략 개요

```yaml
# 주요 배포 전략
배포_방식:
  1. 직접_배포: 메인 브랜치 → 바로 프로덕션
  2. 스테이징_배포: 개발 → 스테이징 → 프로덕션
  3. Blue_Green: 두 환경을 전환
  4. Canary: 일부 사용자에게 먼저 배포
  5. Rolling: 서버를 순차적으로 업데이트

# 바데부: "프로젝트에 맞는 전략을 선택하세요!"
```

## 기본 배포 자동화

### Vercel 배포

```yaml
# .github/workflows/deploy-vercel.yml

name: Vercel 배포

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: 빌드
        run: npm run build

      - name: Vercel 배포
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'

# 바데부: "코드 푸시하면 자동으로 배포 완료!"
```

### Netlify 배포

```yaml
# .github/workflows/deploy-netlify.yml

name: Netlify 배포

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - name: 빌드
        run: |
          npm ci
          npm run build

      - name: Netlify 배포
        uses: netlify/actions/cli@master
        env:
          NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
          NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
        with:
          args: deploy --prod --dir=dist
```

### AWS S3 + CloudFront 배포

```yaml
# .github/workflows/deploy-aws.yml

name: AWS 배포

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - name: 빌드
        run: |
          npm ci
          npm run build

      - name: AWS 자격증명 설정
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ap-northeast-2

      - name: S3 업로드
        run: |
          aws s3 sync dist/ s3://${{ secrets.S3_BUCKET }}/ --delete

      - name: CloudFront 캐시 무효화
        run: |
          aws cloudfront create-invalidation \
            --distribution-id ${{ secrets.CLOUDFRONT_ID }} \
            --paths "/*"

# 바데부: "AWS에 배포하고 CDN 캐시도 자동 갱신!"
```

## Docker 배포

### Docker Hub 배포

```yaml
# .github/workflows/deploy-docker.yml

name: Docker 이미지 배포

on:
  push:
    branches: [main]
    tags:
      - 'v*'

jobs:
  build-and-push:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      # Docker Buildx 설정
      - name: Docker Buildx 설정
        uses: docker/setup-buildx-action@v2

      # Docker Hub 로그인
      - name: Docker Hub 로그인
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}

      # 메타데이터 추출
      - name: Docker 메타데이터
        id: meta
        uses: docker/metadata-action@v4
        with:
          images: badebu/app
          tags: |
            type=ref,event=branch
            type=semver,pattern={{version}}
            type=semver,pattern={{major}}.{{minor}}
            type=sha

      # 빌드 및 푸시
      - name: Docker 빌드 및 푸시
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

# 바데부: "Docker 이미지 자동 빌드 및 배포!"
```

### Docker Compose 배포

```yaml
name: Docker Compose 배포

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: SSH로 서버 접속 및 배포
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.SERVER_HOST }}
          username: ${{ secrets.SERVER_USER }}
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          script: |
            cd /app
            git pull origin main
            docker-compose pull
            docker-compose up -d
            docker-compose exec -T app npm run migrate
            echo "🚀 배포 완료!"
```

## 환경별 배포 전략

### 개발/스테이징/프로덕션 분리

```yaml
# .github/workflows/deploy-multi-env.yml

name: 바데부의 다중 환경 배포

on:
  push:
    branches:
      - develop    # 개발 환경
      - staging    # 스테이징 환경
      - main       # 프로덕션 환경

jobs:
  # 공통 빌드
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: 테스트
        run: npm test

      - name: 빌드
        run: npm run build

      - name: 빌드 결과 업로드
        uses: actions/upload-artifact@v3
        with:
          name: build-output
          path: dist/

  # 개발 환경 배포
  deploy-dev:
    needs: build
    if: github.ref == 'refs/heads/develop'
    runs-on: ubuntu-latest
    environment:
      name: development
      url: https://dev.badebu.com

    steps:
      - uses: actions/download-artifact@v3
        with:
          name: build-output
          path: dist/

      - name: 개발 서버 배포
        env:
          DEPLOY_URL: https://dev.badebu.com
          API_KEY: ${{ secrets.DEV_API_KEY }}
        run: |
          echo "🔧 개발 환경 배포 중..."
          # 배포 스크립트 실행
          curl -X POST $DEPLOY_URL/deploy \
            -H "Authorization: Bearer $API_KEY" \
            -F "files=@dist.zip"

  # 스테이징 환경 배포
  deploy-staging:
    needs: build
    if: github.ref == 'refs/heads/staging'
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.badebu.com

    steps:
      - uses: actions/download-artifact@v3
        with:
          name: build-output
          path: dist/

      - name: 스테이징 서버 배포
        env:
          DEPLOY_URL: https://staging.badebu.com
          API_KEY: ${{ secrets.STAGING_API_KEY }}
        run: |
          echo "🧪 스테이징 환경 배포 중..."
          # 배포 스크립트 실행

      - name: Smoke 테스트
        run: |
          echo "스모크 테스트 실행..."
          curl -f https://staging.badebu.com/health

  # 프로덕션 환경 배포
  deploy-prod:
    needs: build
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://badebu.com

    steps:
      - uses: actions/download-artifact@v3
        with:
          name: build-output
          path: dist/

      # 배포 전 확인
      - name: 배포 전 검증
        run: |
          echo "✅ 빌드 크기 확인"
          du -sh dist/
          echo "✅ 필수 파일 확인"
          test -f dist/index.html

      - name: 프로덕션 배포
        env:
          DEPLOY_URL: https://badebu.com
          API_KEY: ${{ secrets.PROD_API_KEY }}
        run: |
          echo "🚀 프로덕션 배포 중..."
          # 배포 스크립트 실행

      - name: 헬스 체크
        run: |
          echo "헬스 체크 실행..."
          for i in {1..5}; do
            if curl -f https://badebu.com/health; then
              echo "✅ 헬스 체크 성공"
              exit 0
            fi
            echo "재시도 $i/5..."
            sleep 10
          done
          exit 1

      - name: Slack 알림
        if: success()
        env:
          SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
        run: |
          curl -X POST $SLACK_WEBHOOK \
            -H 'Content-Type: application/json' \
            -d '{
              "text": "🎉 바데부 앱 프로덕션 배포 완료!",
              "attachments": [{
                "color": "good",
                "fields": [
                  {"title": "환경", "value": "Production", "short": true},
                  {"title": "버전", "value": "${{ github.sha }}", "short": true}
                ]
              }]
            }'
```

## Blue-Green 배포

```yaml
# .github/workflows/deploy-blue-green.yml

name: Blue-Green 배포

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      # 현재 활성 환경 확인
      - name: 현재 환경 확인
        id: current
        run: |
          ACTIVE=$(curl -s https://api.badebu.com/active-env)
          if [ "$ACTIVE" == "blue" ]; then
            echo "target=green" >> $GITHUB_OUTPUT
          else
            echo "target=blue" >> $GITHUB_OUTPUT
          fi

      - name: 빌드
        run: npm ci && npm run build

      # 비활성 환경에 배포
      - name: ${{ steps.current.outputs.target }} 환경 배포
        run: |
          echo "배포 대상: ${{ steps.current.outputs.target }}"
          ./deploy.sh ${{ steps.current.outputs.target }}

      # 헬스 체크
      - name: 헬스 체크
        run: |
          TARGET=${{ steps.current.outputs.target }}
          curl -f https://$TARGET.badebu.com/health

      # Smoke 테스트
      - name: Smoke 테스트
        run: |
          npm run test:smoke -- --url=https://${{ steps.current.outputs.target }}.badebu.com

      # 트래픽 전환
      - name: 트래픽 전환
        run: |
          echo "트래픽을 ${{ steps.current.outputs.target }}로 전환"
          curl -X POST https://api.badebu.com/switch \
            -d "target=${{ steps.current.outputs.target }}"

      - name: 전환 확인
        run: |
          sleep 5
          ACTIVE=$(curl -s https://api.badebu.com/active-env)
          echo "현재 활성 환경: $ACTIVE"

# 바데부: "무중단 배포 완료!"
```

## Canary 배포

```yaml
# .github/workflows/deploy-canary.yml

name: Canary 배포

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: 빌드
        run: npm ci && npm run build

      # Phase 1: 10% 배포
      - name: Canary 10% 배포
        run: |
          echo "🐤 10% 사용자에게 배포"
          ./deploy-canary.sh 10

      - name: 5분 대기 및 모니터링
        run: |
          sleep 300
          ERROR_RATE=$(curl -s https://api.badebu.com/metrics/error-rate)
          if [ "$ERROR_RATE" -gt "1" ]; then
            echo "에러율 높음! 롤백"
            ./rollback.sh
            exit 1
          fi

      # Phase 2: 50% 배포
      - name: Canary 50% 배포
        run: |
          echo "🐤 50% 사용자에게 배포"
          ./deploy-canary.sh 50

      - name: 10분 대기 및 모니터링
        run: |
          sleep 600
          ERROR_RATE=$(curl -s https://api.badebu.com/metrics/error-rate)
          if [ "$ERROR_RATE" -gt "1" ]; then
            echo "에러율 높음! 롤백"
            ./rollback.sh
            exit 1
          fi

      # Phase 3: 100% 배포
      - name: 전체 배포
        run: |
          echo "🚀 100% 배포 완료"
          ./deploy-canary.sh 100

# 바데부: "단계적으로 안전하게 배포!"
```

## 롤백 전략

```yaml
# .github/workflows/rollback.yml

name: 긴급 롤백

on:
  workflow_dispatch:
    inputs:
      version:
        description: '롤백할 버전'
        required: true
        type: string

jobs:
  rollback:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
        with:
          ref: ${{ inputs.version }}

      - name: 이전 버전 확인
        run: |
          echo "롤백 버전: ${{ inputs.version }}"
          git log -1 --oneline

      - name: 빌드
        run: npm ci && npm run build

      - name: 긴급 배포
        env:
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
        run: |
          echo "🔄 롤백 중..."
          ./deploy.sh --version=${{ inputs.version }}

      - name: 헬스 체크
        run: |
          curl -f https://badebu.com/health

      - name: Slack 긴급 알림
        env:
          SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
        run: |
          curl -X POST $SLACK_WEBHOOK \
            -H 'Content-Type: application/json' \
            -d '{
              "text": "⚠️ 긴급 롤백 완료",
              "attachments": [{
                "color": "warning",
                "fields": [
                  {"title": "버전", "value": "${{ inputs.version }}", "short": true},
                  {"title": "작업자", "value": "${{ github.actor }}", "short": true}
                ]
              }]
            }'

# 바데부: "문제 발생 시 빠르게 이전 버전으로!"
```

## 실전 예제: 바데부의 완전한 배포 파이프라인

```yaml
# .github/workflows/badebu-complete-deploy.yml

name: 바데부의 완전한 배포 파이프라인

on:
  push:
    branches: [main]
  workflow_dispatch:
    inputs:
      skip_tests:
        description: '테스트 건너뛰기'
        type: boolean
        default: false

jobs:
  # Stage 1: 빌드 및 테스트
  build:
    name: 빌드 및 테스트
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: 린트
        run: npm run lint

      - name: 단위 테스트
        if: inputs.skip_tests == false
        run: npm run test:unit

      - name: 통합 테스트
        if: inputs.skip_tests == false
        run: npm run test:integration

      - name: 빌드
        run: npm run build

      - name: 빌드 결과 업로드
        uses: actions/upload-artifact@v3
        with:
          name: production-build
          path: dist/

  # Stage 2: 보안 스캔
  security:
    name: 보안 검사
    needs: build
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: 의존성 취약점 검사
        run: npm audit --audit-level=moderate

      - name: 코드 보안 스캔
        uses: github/codeql-action/analyze@v2

  # Stage 3: 스테이징 배포
  deploy-staging:
    name: 스테이징 배포
    needs: [build, security]
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.badebu.com

    steps:
      - uses: actions/download-artifact@v3
        with:
          name: production-build
          path: dist/

      - name: 스테이징 배포
        env:
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
          VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
          VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}
        run: |
          npx vercel --token $VERCEL_TOKEN deploy dist/ --prod=false

      - name: E2E 테스트
        run: |
          npx playwright test --config=staging.config.js

  # Stage 4: 프로덕션 배포
  deploy-production:
    name: 프로덕션 배포
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://badebu.com

    steps:
      - uses: actions/download-artifact@v3
        with:
          name: production-build
          path: dist/

      - name: 배포 전 체크리스트
        run: |
          echo "✅ 빌드 파일 확인"
          test -f dist/index.html || exit 1
          echo "✅ 환경 변수 확인"
          test -n "${{ secrets.PROD_API_KEY }}" || exit 1

      - name: 프로덕션 배포
        env:
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
          VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
          VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}
        run: |
          echo "🚀 프로덕션 배포 시작"
          DEPLOYMENT_URL=$(npx vercel --token $VERCEL_TOKEN deploy dist/ --prod)
          echo "배포 URL: $DEPLOYMENT_URL"

      - name: 헬스 체크
        run: |
          for i in {1..10}; do
            if curl -f https://badebu.com/health; then
              echo "✅ 헬스 체크 성공"
              break
            fi
            echo "재시도 $i/10..."
            sleep 5
          done

      - name: 성공 알림
        if: success()
        env:
          SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
        run: |
          curl -X POST $SLACK_WEBHOOK \
            -H 'Content-Type: application/json' \
            -d '{
              "text": "🎉 바데부 프로덕션 배포 성공!",
              "attachments": [{
                "color": "good",
                "fields": [
                  {"title": "버전", "value": "${{ github.sha }}", "short": true},
                  {"title": "배포자", "value": "${{ github.actor }}", "short": true},
                  {"title": "URL", "value": "https://badebu.com", "short": false}
                ]
              }]
            }'

      - name: 실패 알림 및 롤백
        if: failure()
        env:
          SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
        run: |
          curl -X POST $SLACK_WEBHOOK \
            -H 'Content-Type: application/json' \
            -d '{"text": "❌ 배포 실패! 롤백 필요"}'
          # 자동 롤백 로직 추가
```

## 다음 단계

다음 장에서는 CI/CD 모범 사례를 배웁니다:

- 워크플로우 최적화
- 보안 강화
- 모니터링 및 알림
- 트러블슈팅

## 핵심 요약

- **배포 자동화**로 수동 작업을 제거하고 배포 시간을 단축합니다
- **환경 분리**(dev, staging, prod)로 안전한 배포를 보장합니다
- **Blue-Green 배포**로 무중단 배포를 구현합니다
- **Canary 배포**로 단계적으로 안전하게 배포합니다
- **롤백 전략**으로 문제 발생 시 빠르게 복구합니다
- **헬스 체크**와 **알림**으로 배포 상태를 모니터링합니다

바데부와 함께 배포 자동화를 마스터했습니다! 🚀
