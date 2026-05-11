# Blog Profile Pages Design

- **Date:** 2026-05-11
- **Status:** Approved — pending implementation
- **Branch:** `feature/profile-pages`
- **Reviews incorporated:** `2026-05-11-blog-profile-pages-design-review.md` (Codex)

## 목표

`jiyeon914.github.io` (Minimal Mistakes 기반 Jekyll 블로그)에 사이트 주인의 프로필/이력 정보를 노출하는 페이지를 추가한다. 현재 사이트는 콘텐츠가 거의 비어있고 네비게이션은 theme 템플릿의 placeholder("Quick-Start Guide")만 남아있어, 첫 방문자가 사이트 주인이 누구인지 알 수 없다. 이번 작업은 *콘텐츠 1차 채움*에 해당하며, 추가 포스트 작성은 별도 작업.

## 출처 자료

- 학술 CV: `D:\Personal\01_커리어\경력 이직\2026 상반기 삼성전자 DX부문\지원서\CV_Jiyeon Kim.pdf` (2025-08 기준, 3 페이지). 본 spec에 공개 가능한 항목을 전사함 — 원본 PDF가 구현 환경에서 접근 불가해도 spec 자체로 self-contained.
- LinkedIn 프로필 URL: `https://www.linkedin.com/in/jiyeon-kim-b4ba19314/`
- LinkedIn 현 직장 정보 (수동 제공): "Professional AI Scientist, LG CNS, Full-time, Jul 2025 – Present, Seoul · On-site, Project: Data Center Cooling Control AI Agent (Ongoing)"

## 구현 경로 기준

모든 구현 경로는 **repo root** (`/home/jykim/project/gitblog`) 기준이다.

이 repo는 Minimal Mistakes 테마 소스 클론에 기반해서 `docs/` 디렉터리에 테마 자체 문서 사이트(`docs/_config.yml`, `docs/_pages/`, `docs/_data/navigation.yml` 등)가 그대로 남아있다. **`docs/` 하위는 이번 구현 대상이 아니다.**

현재 root `_config.yml`의 `exclude:` 리스트에 `docs`가 빠져있어, 빌드 시 `docs/_pages/about.md`(permalink `/about/`)가 root와 충돌할 위험이 있다. 이번 작업에서 **`docs`를 exclude에 추가**한다 (수정할 파일 표 참조).

## 합의된 결정 사항

| 항목 | 결정 |
|---|---|
| 언어 | 영어 메인. About 페이지 상단에 한국어 짧은 인사말 추가 |
| 페이지 구성 | 5탭 — About \| Experience \| Research \| Publications \| Posts |
| 노출 PII | 이름, 학력, 연구이력, 이메일(`jykim3994@gmail.com`), ORCID(`0000-0001-6668-1951`), GitHub(`jiyeon914`), LinkedIn 프로필 URL |
| 제외 | 주소, 전화번호, 추천인 연락처, 학교 이메일(접속 불가) |
| 현 소속 반영 | PhD 완료 + LG CNS Professional AI Scientist 명시. Data Center Cooling Control AI Agent 프로젝트 언급 |
| 아바타 | 'JK' 이니셜 SVG 플레이스홀더, `/assets/images/avatar.svg` |
| 테마 스킨 | 기존 `dark` 유지 |
| 서브타이틀 | `"A Belated Journal of Dr. Kim"` (기존 `"A Belated Journal of Prospective Dr. Kim"`에서 "Prospective" 제거) |
| 브랜치 전략 | `feature/profile-pages` 단일 브랜치. 첫 커밋 = 스펙, 이후 커밋 = 구현. PR 하나로 통합 |

## 페이지별 콘텐츠

### About (`_pages/about.md`)

페이지의 최소·기본 정보. 깊이는 다른 페이지에 위임.

- 한국어 짧은 인사말 (2–3줄, 캐주얼 톤): 환영 + 사이트 목적 한 줄
- English bio (3–5줄):
  - 현재 LG CNS Professional AI Scientist, Data Center Cooling Control AI Agent 프로젝트
  - PhD in Fluid Mechanics, Yonsei University (Aug 2025)
  - "Bridging CFD and deep learning" 류의 한 줄 포지셔닝
- 본문에 contact/links 인라인 (Email, ORCID, GitHub, LinkedIn). 사이드바와 중복되지만 본문 컨텍스트에서 한 번 더 명시.

### Experience (`_pages/experience.md`)

학력 + 직무를 시간순(역순) 정리하는 *개요* 페이지.

- **Education**
  - Ph.D. in Fluid Mechanics, Yonsei University (Mar 2020 – Aug 2025), advised by Changhoon Lee
  - B.S. in Mechanical Engineering, Yonsei University (Mar 2012 – Feb 2020)
- **Industry**
  - Professional AI Scientist, LG CNS (Jul 2025 – Present), Seoul, Korea
    - Project: Data Center Cooling Control AI Agent (Ongoing)
- **Academic Research**
  - Graduate Student Researcher, TURBULENCE Lab, Yonsei University (Mar 2020 – Aug 2025)
    - CV의 4 bullets을 narrative 1–2 문장으로 압축
  - Undergraduate Research Intern, TURBULENCE Lab, Yonsei University (Jan 2019 – Feb 2020)
    - CV의 3 bullets 압축
- **Teaching**
  - CSE Undergraduate Research Program, CFD team instructor (Summer/Winter 2022, 2023)
  - Teaching Assistant, Yonsei: MEU3009 (Winter 2022), MEU4400 (Spring 2024, Fall 2024)

### Research (`_pages/research.md`)

연구 주제·방법론 narrative. *무엇/어떻게/왜*에 초점.

- **Research Interests** (CV 두 카테고리 확장)
  - Fluid mechanics — turbulence, CFD, 통계적 성질 분석
  - Deep learning — generative 모델, XAI, 시계열 물리 데이터 응용
- **Topics**
  - 2D & 3D homogeneous isotropic turbulence (DNS, LES)
  - DL 모델 진화: CNN → U-Net → GAN → Diffusion model → FNO
  - Scale-dependent analysis + XAI for turbulence prediction
  - GPU-accelerated CFD
- **Funded Projects**
  - NRF Strategic Project, "Deep learning of turbulence" (Mar 2020 – Feb 2022), Participant
  - NRF Mid-sized Research Project, "Fundamental understanding and high-performance modeling of turbulent flows using deep learning" (Mar 2022 – Present), Participant
- **Industrial Bridge** (현재)
  - Data Center Cooling Control AI Agent @ LG CNS — CFD/열관리 도메인 + AI를 실제 제품에 적용

### Publications (`_pages/publications.md`)

표준 학술 publications 페이지, 카테고리별 그룹. 본인 이름은 굵게(bold) 표시.

**Journal Articles**

1. **Jiyeon Kim**, Changhoon Lee. "Dynamics prediction of isotropic turbulence using conditional diffusion probabilistic models." (In Preparation)
2. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of two-dimensional decaying turbulence using generative adversarial networks." *Journal of Fluid Mechanics*, Vol. 981, A19 (2024).
3. Junhyuk Kim, Hyojin Kim, **Jiyeon Kim**, Changhoon Lee. "Deep reinforcement learning for large-eddy simulation modeling in wall-bounded turbulence." *Physics of Fluids*, Vol. 34, 105132 (2022).
4. (Domestic) Changhoon Lee, **Jiyeon Kim**, Jun Park, Junhyuk Kim. THEME 03 "Utilization of artificial intelligence for turbulence analysis." *Journal of the KSME*, Vol. 64(4), 42–49 (2024).

**Conference Proceedings — International**

1. **Jiyeon Kim**, Changhoon Lee. "Prediction of isotropic turbulence using conditional diffusion probabilistic models." 77th APS DFD, Nov. 2024.
2. **Jiyeon Kim**, Changhoon Lee. "A conditional diffusion model for prediction of 2D turbulence." ICTAM 2024, Aug. 2024.
3. **Jiyeon Kim**, Changhoon Lee. "Application of denoising diffusion probabilistic models to turbulence prediction." 76th APS DFD, Nov. 2023.
4. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of 2D decaying turbulence using generative adversarial networks." 75th APS DFD, Nov. 2022.
5. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of turbulent flows using deep learning." TSFP12, Jul. 2022.
6. Junhyuk Kim, Hyojin Kim, **Jiyeon Kim**, Changhoon Lee. "Deep reinforcement learning for large-eddy simulation sub-grid scale modeling in turbulent channel flow." 75th APS DFD, Nov. 2022.
7. Junhyuk Kim, Hyojin Kim, **Jiyeon Kim**, Changhoon Lee. "Deep reinforcement learning for large-eddy simulation of wall-bounded turbulence." TSFP12, Jul. 2022.

**Conference Proceedings — Domestic**

1. **Jiyeon Kim**, Changhoon Lee. "Turbulence prediction using conditional diffusion probabilistic models." 13th National Congress on Fluids Engineering (13NCFE), Jul. 2024.
2. **Jiyeon Kim**, Changhoon Lee. "Application of denoising diffusion probabilistic model to turbulence problems." KSME Annual Meeting 2023, Nov. 2023.
3. **Jiyeon Kim**, Changhoon Lee. "Effect of adversarial training to dynamics prediction of 2D turbulence." KSME Fluid Engineering Division 2023 Spring Conference, May 2023.
4. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of 2D decaying turbulence using generative adversarial networks." 12NCFE, Jun. 2022.
5. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of 2D turbulence using deep learning." KSCSE 2022 Spring Conference, May 2022.
6. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of turbulent flows using deep learning." KSME Fluid Engineering Division 2021 Spring Conference, Aug. 2021.
7. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Advanced prediction of 2D turbulent flows using deep learning." KSCFE 2021 Spring Conference, May 2021.

**Grants & Honors**

1. Merit Academic Paper Award — Academic Field of Natural Science, Jul. 2024.
2. Graduate School Scholarship for Social Problem-Solving Courses — Design and Analysis of Energy System, Jun. 2021.
3. 2021 CSE Best Poster Award — The Second Prize, May 2021.

### Posts (`/`)

기존 Minimal Mistakes 기본 홈(=포스트 리스트) 그대로 사용. 별도 페이지 생성 없음. 네비게이션 메뉴에서 `/`로 링크.

## 구현 변경 사항

모든 경로는 repo root 기준.

### 새로 만들 파일

| 파일 | 용도 |
|---|---|
| `_pages/about.md` | About 페이지 (root `_pages/` 디렉터리부터 신규) |
| `_pages/experience.md` | Experience 페이지 |
| `_pages/research.md` | Research 페이지 |
| `_pages/publications.md` | Publications 페이지 |
| `assets/images/avatar.svg` | 'JK' 이니셜 아바타 SVG (`assets/images/` 디렉터리부터 신규) |

### 수정할 파일

| 파일 | 변경 |
|---|---|
| `_config.yml` | (1) `subtitle` → `"A Belated Journal of Dr. Kim"` ("Prospective" 제거). (2) `author:` 블록 정리 — `name`(Jiyeon Kim 유지), `bio` 한 줄 갱신, `avatar: "/assets/images/avatar.svg"`, `location: "Seoul, Republic of Korea"` 유지, `email` 주석 유지, `links`는 **Email / GitHub / LinkedIn / ORCID 4개만 남김** (Website/Twitter/Facebook/Instagram 항목 삭제 — Instagram은 사용자 합의로 제외). (3) `footer.links`도 동일 정책 적용 — GitHub/LinkedIn/ORCID 정도만 남기고 Twitter/Facebook/GitLab/Bitbucket placeholder 삭제. (4) `social.name: "Jiyeon Kim"` 채움, `social.links`에 공개 프로필 URL(GitHub/LinkedIn/ORCID) 등록 — SEO structured data 일관성. (5) `analytics.google.anonymize_ip: flase` → `false` 오타 수정. (6) `exclude:` 리스트에 `docs` 추가 (테마 자체 문서 사이트가 root 빌드에 섞이지 않게). (7) `defaults:` 블록에 `_pages` 스코프 추가 — `layout: single` + `author_profile: true` 기본값. |
| `_data/navigation.yml` | placeholder "Quick-Start Guide" 제거, 5탭 등록: `About → /about/`, `Experience → /experience/`, `Research → /research/`, `Publications → /publications/`, `Posts → /` |

### 건드리지 않을 것

- 테마 코어 (`_includes`, `_layouts`, `_sass`) — 콘텐츠 추가만으로 충분
- `docs/` 하위 일체 (`docs/_config.yml`, `docs/_pages/`, `docs/_data/` 등) — 테마 문서 사이트 샘플, 이번 작업과 무관. exclude로 빌드에서 제외만 함
- 기존 테스트 포스트 (`_posts/2024-03-27-first-test-upload.md`) — 그대로 유지
- 댓글 시스템(utterances) 설정 — 이미 `_config.yml`에 등록됨

## 페이지 메타데이터 규칙

`_config.yml`의 `defaults:` 블록에 `_pages` 스코프를 추가해 `layout: single` + `author_profile: true`를 기본값으로 고정한다.

```yaml
defaults:
  - scope:
      path: "_pages"
      type: pages
    values:
      layout: single
      author_profile: true
```

따라서 각 `_pages/*.md` front matter는 다음만 가진다:

```yaml
---
title: "<Page Title>"
permalink: /<slug>/
---
```

페이지별로 `layout`/`author_profile`을 front matter에 다시 적지 않는다 — 스타일 일관성 + 향후 일괄 수정 용이.

## 검증

순서대로 확인 (빠른 실패 → 통합 확인):

1. **Build-only check (빠른 실패)** — config/front matter 오류는 build 단계에서 즉시 잡힘:
   ```
   docker compose run --rm jekyll bundle exec jekyll build
   ```
   exit code 0 + 새 에러 없음 (기존 sass deprecation warning은 무관).
2. **Serve + 페이지 응답**:
   ```
   docker compose up -d
   curl -sI http://localhost:4000/{about,experience,research,publications}/ | head
   ```
   각 경로 HTTP 200.
3. **렌더링 확인** (브라우저):
   - 상단 네비게이션에 5탭(About/Experience/Research/Publications/Posts) 표시
   - 사이드바 author profile에 이름/아바타(JK)/4개 링크(Email/GitHub/LinkedIn/ORCID) 표시 — Website/Twitter/Facebook/Instagram 흔적 없음
   - Footer에 placeholder 링크 없음
   - 외부 링크 4개 실제 URL 연결 확인 (`mailto:jykim3994@gmail.com`, `github.com/jiyeon914`, `linkedin.com/in/jiyeon-kim-b4ba19314`, `orcid.org/0000-0001-6668-1951`)
4. **회귀 점검**:
   - 홈(`/`) 여전히 정상, 기존 테스트 포스트(`_posts/2024-03-27-first-test-upload.md`)도 렌더됨
   - `docs/` 하위 페이지(예: 테마 `/markup/`, `/category-archive/` 같은 샘플)가 빌드 결과(`_site/`)에 포함되지 않음

## Out of Scope

- 블로그 포스트 작성
- 카테고리/태그 분류 체계 정의
- 테마 색상/타이포그래피 커스터마이즈
- 댓글 시스템 동작 확인 (첫 포스트 작성 시 별도 확인)
- 분석 도구(Google Analytics 등) 추가
- 다국어(한/영 전환) 본격 지원 — About 페이지 인사말 한 곳에만 한국어
- GitHub Pages 배포 흐름 (별도 작업)

## Open Questions

없음 — 브레인스토밍에서 모두 합의됨.
