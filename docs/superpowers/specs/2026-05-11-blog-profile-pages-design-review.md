# Review — Blog Profile Pages Design Spec

**Date:** 2026-05-11
**Reviewer:** Codex
**Target:** `docs/superpowers/specs/2026-05-11-blog-profile-pages-design.md`
**Review stance:** 구현 전 설계·scope·파일 경로 리스크 검토

## Summary

Blog profile pages spec의 큰 방향은 적절하다. 현재 블로그가 Minimal Mistakes 샘플 상태에 가깝고, 첫 방문자가 사이트 주인의 현재 소속·연구 배경·연락처를 알기 어렵다는 문제 정의도 맞다. About / Experience / Research / Publications / Posts의 5탭 구성은 1차 콘텐츠 채움 범위로 충분하다.

다만 현재 spec은 `docs/` 아래에 저장되어 있고, repo에도 Minimal Mistakes 샘플용 `docs/` 디렉터리가 그대로 남아 있다. 실제 블로그 루트 파일과 `docs/` 샘플 파일을 혼동할 여지가 크다. 또한 LinkedIn URL과 CV 상세 publication 데이터처럼 구현자가 추측하면 안 되는 정보가 아직 문서에 없다.

구현 전에 아래 High 3건은 spec에 먼저 반영하는 것이 좋다.

## Findings

### 1. High — 구현 대상 경로가 root 기준인지 `docs/` 기준인지 혼동될 수 있다

**위치**

- Target spec: `구현 변경 사항`
- Target spec: `페이지 메타데이터 규칙`
- Current repo: root `_config.yml`
- Current repo: `docs/_config.yml`, `docs/_pages/about.md`

**문제**

Target spec은 `docs/superpowers/specs/`에 있고, 새 파일 경로를 `_pages/about.md`, `_config.yml`, `_data/navigation.yml`처럼 상대 경로로 적고 있다. 그런데 현재 repo에는 Minimal Mistakes 샘플 사이트용 `docs/_config.yml`, `docs/_pages/about.md`, `docs/_data/navigation.yml`도 존재한다.

실제 블로그는 repo root의 `_config.yml`, `_data/navigation.yml`, `index.html`, `_posts/`를 사용한다. root `_config.yml`에는 `/docs`가 exclude로 잡혀 있으므로, `docs/_pages`를 수정해도 실제 사이트에는 반영되지 않는다.

이대로 plan이나 구현으로 넘어가면 구현자가 spec 위치를 기준으로 `docs/_pages` 샘플 파일을 고칠 위험이 있다.

**권장 수정**

Target spec에 구현 경로 기준을 명시한다.

```text
모든 구현 경로는 repo root(`/home/jykim/project/gitblog`) 기준이다.
`docs/` 디렉터리는 Minimal Mistakes 샘플/문서 디렉터리이며 이번 구현 대상이 아니다.
```

그리고 파일 표도 root 기준임을 분명히 한다.

```text
_pages/about.md
_pages/experience.md
_pages/research.md
_pages/publications.md
assets/images/avatar.svg
_config.yml
_data/navigation.yml
```

### 2. High — LinkedIn URL과 publication 상세 데이터가 source로 고정되어 있지 않다

**위치**

- Target spec: `출처 자료`
- Target spec: `합의된 결정 사항`
- Target spec: `Publications`

**문제**

Spec은 LinkedIn 프로필 URL을 노출한다고 정했지만, 출처 자료에는 LinkedIn의 현 직장 텍스트만 있고 실제 URL은 없다. 또한 Publications 페이지는 "Journal Articles 4건", "Conference Proceedings 7건 + 7건", "Grants & Honors 3건"처럼 개수와 카테고리만 있고, 실제 제목·저자·venue·연도·DOI 여부가 없다.

CV 원본 경로도 Windows 로컬 절대경로라 현재 repo 작업 환경에서 접근할 수 없다.

이 상태에서 구현하면 다음 중 하나가 된다.

- LinkedIn 링크를 비워 두거나 임의 검색으로 추측한다.
- publication 항목을 개수만 맞춰 요약한다.
- CV 접근 가능성을 전제로 구현자가 막힌다.

모두 공개 프로필 페이지에는 부적절하다.

**권장 수정**

Spec에 구현 가능한 source data를 직접 붙인다.

- LinkedIn profile URL을 정확히 기입한다. 아직 모르면 `Open Questions`로 남기고 1차 구현에서 LinkedIn 링크를 제외한다.
- Publications / Conferences / Honors의 실제 항목을 spec에 모두 적는다.
- CV 파일을 repo에 넣지 않을 계획이면, 구현자가 필요한 텍스트만 spec에 전사한다.

민감정보 제외 정책은 유지하되, 공개할 학술 정보는 문서 자체에 source of truth로 남기는 편이 좋다.

### 3. High — `_config.yml` 정리 범위가 author block에만 치우쳐 샘플/빈 링크가 남을 수 있다

**위치**

- Target spec: `수정할 파일`
- Current repo: root `_config.yml`

**문제**

Spec은 `_config.yml`에서 subtitle, author block, `_pages` defaults를 수정한다고 한다. 하지만 현재 root `_config.yml`에는 author links 외에도 정리해야 할 값이 남아 있다.

- author links에 URL 없는 Website/Twitter/Facebook 항목이 있다.
- footer links에도 Twitter/Facebook/GitLab/Bitbucket 같은 빈 URL 항목이 있다.
- Instagram은 현재 노출되지만 spec의 4개 링크 정책에는 없다.
- `social.links`가 비어 있어 SEO social profile과 sidebar links가 어긋날 수 있다.
- `analytics.google.anonymize_ip`에 `flase` 오타가 있다.

Spec의 "4개 링크 표시" 검증만 따르면 author sidebar는 고쳐도 footer나 SEO metadata에 낡은 placeholder가 남을 수 있다.

**권장 수정**

`_config.yml` 변경 범위를 더 구체화한다.

- `author.links`는 Email, GitHub, LinkedIn, ORCID만 남긴다.
- `footer.links`도 동일 정책으로 맞추거나, footer에서는 GitHub/LinkedIn/ORCID 정도만 남긴다고 명시한다.
- `social.name`, `social.links`를 공개 프로필과 일관되게 채운다.
- Instagram을 유지할지 제외할지 결정한다. 현재 spec 기준이면 제외가 맞다.
- `analytics.google.anonymize_ip: flase`는 `false`로 고친다.

### 4. Medium — `_pages` default와 page front matter 정책을 하나로 고정하는 편이 낫다

**위치**

- Target spec: `수정할 파일`
- Target spec: `페이지 메타데이터 규칙`
- Current repo: root `_config.yml`

**문제**

Spec은 `_config.yml` defaults에 `_pages` 기본값이 없으면 추가한다고 하면서도, 각 page front matter에 `layout: single`, `author_profile: true`를 넣을 수 있다고 열어둔다.

현재 root `_config.yml`에는 posts default만 있고 `_pages` default가 없다. 구현자가 일부 페이지에는 front matter를 넣고 일부는 defaults에 기대면 문서 스타일이 흔들릴 수 있다.

**권장 수정**

둘 중 하나를 명시적으로 선택한다. 추천은 `_config.yml` defaults에 `_pages`를 추가하는 방식이다.

```yaml
defaults:
  - scope:
      path: "_pages"
      type: pages
    values:
      layout: single
      author_profile: true
```

그러면 각 `_pages/*.md` front matter는 `title`, `permalink` 중심으로 단순하게 유지할 수 있다.

### 5. Medium — About은 "새로 만들 파일"이 아니라 기존 placeholder 교체다

**위치**

- Target spec: `새로 만들 파일`
- Current repo: root에는 `_pages/` 없음
- Current repo: `docs/_pages/about.md`

**문제**

실제 root에는 아직 `_pages/`가 없으므로 root 기준으로는 새 파일이 맞다. 하지만 repo 안에는 `docs/_pages/about.md` 샘플이 이미 있다. 이 때문에 "새로 만들 파일"이라는 표현이 경로 혼동을 더 키운다.

**권장 수정**

Finding 1의 경로 기준 문구와 함께 다음을 추가한다.

```text
Root `_pages/` 디렉터리를 새로 만들고 root `_pages/about.md`를 생성한다.
`docs/_pages/about.md`는 Minimal Mistakes 샘플 문서이므로 수정하지 않는다.
```

### 6. Low — 문서 상태값이 현재 요청 흐름과 맞지 않는다

**위치**

- Target spec: 문서 상단 metadata

**문제**

Status가 `Approved (pending user spec review)`로 되어 있다. "approved"와 "pending review"가 동시에 있어 상태가 애매하다.

**권장 수정**

현재 단계에서는 다음 중 하나가 더 명확하다.

```text
Status: Draft — pending review
```

리뷰 반영 후에는:

```text
Status: Approved — pending implementation
```

### 7. Low — 검증 절차에 build-only check가 있으면 빠른 실패를 잡기 쉽다

**위치**

- Target spec: `검증`
- Current repo: `docker-compose.yml`

**문제**

Spec은 `docker compose up`으로 로컬 서버를 띄운 뒤 URL을 확인한다고 한다. 이 검증은 필요하지만, config/front matter 오류를 빠르게 확인하는 build-only step도 있으면 좋다.

**권장 수정**

검증에 다음을 추가한다.

```text
bundle exec jekyll build
```

Docker 환경만 사용할 경우:

```text
docker compose run --rm jekyll bundle exec jekyll build
```

그 뒤 `docker compose up`으로 렌더링과 네비게이션을 확인하면 된다.

## Positive Notes

- 5탭 구성은 현재 블로그의 첫 콘텐츠 채움 범위로 적절하다.
- 주소, 전화번호, 추천인 연락처, 학교 이메일을 제외하기로 한 PII 정책은 안전하다.
- 기존 dark skin과 Minimal Mistakes 기본 layout을 유지하고 콘텐츠만 채우는 방향은 scope가 작고 구현 리스크가 낮다.
- Posts를 별도 페이지로 만들지 않고 root `/`의 기존 home layout을 유지하는 결정은 단순하다.

## Recommended Next Step

Plan 작성 또는 구현 전에 target spec에 아래 항목을 먼저 반영한다.

1. 모든 구현 경로가 repo root 기준이며 `docs/` 샘플 사이트는 수정 대상이 아니라고 명시한다.
2. LinkedIn URL과 publication/conference/honor 상세 항목을 spec에 직접 추가하거나, 미확정이면 Open Questions로 남긴다.
3. `_config.yml` 정리 범위를 author links뿐 아니라 footer links, social metadata, 빈 placeholder 링크, `anonymize_ip` 오타까지 포함하도록 확장한다.
4. `_pages` default와 page front matter 정책을 하나로 고정한다.
5. Status를 `Draft — pending review` 또는 리뷰 반영 후 `Approved — pending implementation`로 정리한다.

위 항목이 반영되면 이 spec은 profile pages 구현 plan의 기준 문서로 사용할 수 있다.
