# Blog Profile Pages Design

- **Date:** 2026-05-11
- **Status:** Approved (pending user spec review)
- **Branch:** `feature/profile-pages`

## 목표

`jiyeon914.github.io` (Minimal Mistakes 기반 Jekyll 블로그)에 사이트 주인의 프로필/이력 정보를 노출하는 페이지를 추가한다. 현재 사이트는 콘텐츠가 거의 비어있고 네비게이션은 theme 템플릿의 placeholder("Quick-Start Guide")만 남아있어, 첫 방문자가 사이트 주인이 누구인지 알 수 없다. 이번 작업은 *콘텐츠 1차 채움*에 해당하며, 추가 포스트 작성은 별도 작업.

## 출처 자료

- 학술 CV: `D:\Personal\01_커리어\경력 이직\2026 상반기 삼성전자 DX부문\지원서\CV_Jiyeon Kim.pdf` (2025-08 기준, 3 페이지)
- LinkedIn 현 직장 정보 (수동 제공): "Professional AI Scientist, LG CNS, Full-time, Jul 2025 – Present, Seoul · On-site, Project: Data Center Cooling Control AI Agent (Ongoing)"

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

표준 학술 publications 페이지, 카테고리별 그룹.

- **Journal Articles** (4건: In Preparation 1, JFM 2024, Physics of Fluids 2022 공저, KSME Journal 2024 domestic)
- **Conference Proceedings — International** (7건: APS DFD 75th/76th/77th, ICTAM 2024, TSFP12 — Jiyeon 1저자 5건 + 공저 2건)
- **Conference Proceedings — Domestic** (7건: NCFE 12·13, KSME 2023, KSCSE 2022, KSCFE 2021, KSME Fluid Eng 2021·2023)
- **Grants & Honors** (3건: Merit Academic Paper Award 2024, Graduate Scholarship 2021, CSE Best Poster 2nd 2021)

### Posts (`/`)

기존 Minimal Mistakes 기본 홈(=포스트 리스트) 그대로 사용. 별도 페이지 생성 없음. 네비게이션 메뉴에서 `/`로 링크.

## 구현 변경 사항

### 새로 만들 파일

| 파일 | 용도 |
|---|---|
| `_pages/about.md` | About 페이지 |
| `_pages/experience.md` | Experience 페이지 |
| `_pages/research.md` | Research 페이지 |
| `_pages/publications.md` | Publications 페이지 |
| `assets/images/avatar.svg` | 'JK' 이니셜 아바타 SVG (`assets/images/` 디렉토리부터 신규 생성) |

### 수정할 파일

| 파일 | 변경 |
|---|---|
| `_config.yml` | (1) `subtitle` 수정: `"A Belated Journal of Dr. Kim"`. (2) `author:` 블록 채우기 — `name`, `bio`(한 줄), `avatar` 경로, `location: "Seoul, Korea"`, `links` 4개 (Email/GitHub/LinkedIn/ORCID). (3) `defaults:` 블록 확인 — `_pages`에 `layout: single` + `author_profile: true` 기본값이 없으면 추가 |
| `_data/navigation.yml` | placeholder "Quick-Start Guide" 제거, 5탭 등록: `About → /about/`, `Experience → /experience/`, `Research → /research/`, `Publications → /publications/`, `Posts → /` |

### 건드리지 않을 것

- 테마 코어 (`_includes`, `_layouts`, `_sass`) — 콘텐츠 추가만으로 충분
- 기존 테스트 포스트 (`_posts/2024-03-27-first-test-upload.md`) — 그대로 유지
- 댓글 시스템(utterances) 설정 — 이미 `_config.yml`에 등록됨

## 페이지 메타데이터 규칙

각 `_pages/*.md` 파일의 front matter는 다음 패턴을 따른다:

```yaml
---
title: "<Page Title>"
permalink: /<slug>/
layout: single
author_profile: true
---
```

`layout`/`author_profile`은 `_config.yml`의 `defaults:` 블록으로 기본값 잡으면 각 페이지 front matter에서 생략 가능. 구현 시 둘 중 어느 방식이 깔끔한지 본다.

## 검증

구현 완료 후 다음 확인:

- `docker compose up`으로 로컬 서버 띄움
- `http://localhost:4000/about/`, `/experience/`, `/research/`, `/publications/` 각각 200 응답 + 정상 렌더링
- 상단 네비게이션에 5탭 표시
- 사이드바 author profile에 이름/아바타/4개 링크 표시
- 외부 링크(GitHub/LinkedIn/ORCID/mailto) 실제 URL 연결 확인
- 빌드 로그에 새 에러 없음 (기존 sass deprecation warning은 무관)

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
