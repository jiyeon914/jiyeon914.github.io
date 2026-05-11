# Profile Pages Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the 5-tab profile (About | Experience | Research | Publications | Posts) on `jiyeon914.github.io`, with a cleaned-up `_config.yml`, JK avatar SVG, and the navigation rewired to the new pages.

**Architecture:** Static content additions on top of Minimal Mistakes 4.24. No theme-core changes. All edits at repo root; `docs/` (theme docs sample) is already excluded from the build via `_config.yml` line 185.

**Tech Stack:** Jekyll 4.x + Minimal Mistakes 4.24, `ruby:3.2` in Docker (`docker-compose.yml`), Font Awesome brand icons (already configured by the theme).

**Source spec:** `docs/superpowers/specs/2026-05-11-blog-profile-pages-design.md`

---

## File Structure

Files this plan creates:

- `_pages/about.md` — About page (Korean greeting + English bio + contact)
- `_pages/experience.md` — Chronological education/industry/research/teaching timeline
- `_pages/research.md` — Thematic research interests, topics, projects, industrial bridge
- `_pages/publications.md` — Journal articles, conference proceedings (intl + domestic), grants & honors
- `assets/images/avatar.svg` — JK initials placeholder avatar

Files this plan modifies:

- `_config.yml` — subtitle, author block (avatar, bio, links), footer.links, social block, anonymize_ip typo, defaults
- `_data/navigation.yml` — replace placeholder with 5-tab top nav

Out of scope: anything under `docs/`, theme core (`_includes`, `_layouts`, `_sass`), the existing test post, the comments configuration (already set).

---

## Task 1: Clean up `_config.yml`

**Files:**
- Modify: `_config.yml`

- [ ] **Step 1.1: Update site subtitle** (line ~21)

Replace:
```yaml
subtitle                 : "A Belated Journal of Prospective Dr. Kim" # site tagline that appears below site title in masthead
```
with:
```yaml
subtitle                 : "A Belated Journal of Dr. Kim" # site tagline that appears below site title in masthead
```

- [ ] **Step 1.2: Fill in `social:` block** (around line 93)

Replace:
```yaml
social:
  type                   : # Person or Organization (defaults to Person)
  name                   : # If the user or organization name differs from the site's name
  links: # An array of links to social media profiles
```
with:
```yaml
social:
  type                   : Person
  name                   : "Jiyeon Kim"
  links:
    - "https://github.com/jiyeon914"
    - "https://www.linkedin.com/in/jiyeon-kim-b4ba19314/"
    - "https://orcid.org/0000-0001-6668-1951"
```

- [ ] **Step 1.3: Fix `anonymize_ip` typo** (line ~103)

Replace:
```yaml
    anonymize_ip         : flase # true, false (default)
```
with:
```yaml
    anonymize_ip         : false # true, false (default)
```

- [ ] **Step 1.4: Set `author.avatar` and update `author.bio`** (lines ~109–110)

Replace:
```yaml
  avatar           : # path of avatar image, e.g. "/assets/images/bio-photo.jpg"
  bio              : "My Github blog starting from scratch: Recording everything from daily life to my research."
```
with:
```yaml
  avatar           : "/assets/images/avatar.svg"
  bio              : "AI Scientist at LG CNS · PhD in Fluid Mechanics · Bridging CFD and deep learning"
```

- [ ] **Step 1.5: Replace `author.links` with the 4 approved links** (lines ~113–130)

Replace the entire `author:` `links:` array (currently Email + 5 placeholder/active entries: Website, Twitter, Facebook, GitHub, Instagram) with exactly these four:

```yaml
  links:
    - label: "Email"
      icon: "fas fa-fw fa-envelope-square"
      url: "mailto:jykim3994@gmail.com"
    - label: "GitHub"
      icon: "fab fa-fw fa-github"
      url: "https://github.com/jiyeon914"
    - label: "LinkedIn"
      icon: "fab fa-fw fa-linkedin"
      url: "https://www.linkedin.com/in/jiyeon-kim-b4ba19314/"
    - label: "ORCID"
      icon: "fab fa-fw fa-orcid"
      url: "https://orcid.org/0000-0001-6668-1951"
```

- [ ] **Step 1.6: Replace `footer.links`** (around line 133+)

Replace the entire `footer:` block (currently Twitter/Facebook/GitHub/GitLab/Bitbucket — four of those with empty `url`) with:

```yaml
# Site Footer
footer:
  links:
    - label: "GitHub"
      icon: "fab fa-fw fa-github"
      url: "https://github.com/jiyeon914"
    - label: "LinkedIn"
      icon: "fab fa-fw fa-linkedin"
      url: "https://www.linkedin.com/in/jiyeon-kim-b4ba19314/"
    - label: "ORCID"
      icon: "fab fa-fw fa-orcid"
      url: "https://orcid.org/0000-0001-6668-1951"
```

- [ ] **Step 1.7: Add `_pages` scope to `defaults:`** (around line 282)

The existing `defaults:` block has only the `_posts` entry. Append a `_pages` entry so the block becomes:

```yaml
defaults:
  # _posts
  - scope:
      path: ""
      type: posts
    values:
      layout: single
      author_profile: true
      read_time: true
      comments: true
      share: true
      related: true
      show_date: true
  # _pages
  - scope:
      path: "_pages"
      type: pages
    values:
      layout: single
      author_profile: true
```

Scoping the path to `_pages` means existing `index.html` at the repo root is not affected.

- [ ] **Step 1.8: Verify build still succeeds**

Run:
```
docker compose run --rm jekyll bundle exec jekyll build
```

Expected: exit 0. Pre-existing sass deprecation warnings from Minimal Mistakes vendor stylesheets are unrelated and OK. There should be **no new YAML parse errors and no new permalink-conflict warnings**.

- [ ] **Step 1.9: Commit**

```
git add _config.yml
git commit -m "Clean up _config.yml: subtitle, author/footer/social, defaults, typo"
```

---

## Task 2: Add JK avatar SVG

**Files:**
- Create: `assets/images/avatar.svg`

- [ ] **Step 2.1: Create the directory**

```
mkdir -p assets/images
```

- [ ] **Step 2.2: Write `assets/images/avatar.svg`**

Content:

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200" role="img" aria-label="JK initials avatar">
  <circle cx="100" cy="100" r="100" fill="#2d3748"/>
  <text x="50%" y="52%" text-anchor="middle" dominant-baseline="middle" font-family="Georgia, 'Times New Roman', serif" font-size="92" font-weight="600" fill="#e2e8f0">JK</text>
</svg>
```

Dark slate background, light gray serif initials — readable on both dark and light skins.

- [ ] **Step 2.3: Verify the asset is picked up by the build**

```
docker compose run --rm jekyll bundle exec jekyll build
test -f _site/assets/images/avatar.svg && echo OK || echo MISSING
```

Expected: `OK`.

- [ ] **Step 2.4: Commit**

```
git add assets/images/avatar.svg
git commit -m "Add JK initials avatar SVG"
```

---

## Task 3: Add About page

**Files:**
- Create: `_pages/about.md`

- [ ] **Step 3.1: Write `_pages/about.md`**

Content:

```markdown
---
title: "About"
permalink: /about/
---

안녕하세요, 김지연입니다. 유체역학과 딥러닝 사이를 오가며 만난 것들, 그리고 그 너머 일상의 단편을 천천히 기록하는 공간이에요.

I'm an AI Scientist at **LG CNS**, currently working on the *Data Center Cooling Control AI Agent* — a system that bridges CFD-rooted thermal management with AI-driven control. I completed my **Ph.D. in Fluid Mechanics** at Yonsei University in August 2025 under Prof. Changhoon Lee, where my research centered on dynamics prediction of turbulent flows using generative and explainable deep-learning models.

This site is a slow-paced journal — part research log, part personal voyage.

### Contact

- Email: [jykim3994@gmail.com](mailto:jykim3994@gmail.com)
- ORCID: [0000-0001-6668-1951](https://orcid.org/0000-0001-6668-1951)
- GitHub: [@jiyeon914](https://github.com/jiyeon914)
- LinkedIn: [jiyeon-kim](https://www.linkedin.com/in/jiyeon-kim-b4ba19314/)
```

- [ ] **Step 3.2: Build and verify the page renders**

```
docker compose run --rm jekyll bundle exec jekyll build
test -f _site/about/index.html && echo OK || echo MISSING
grep -o '<title>[^<]*</title>' _site/about/index.html | head -1
```

Expected: `OK` and `<title>About | …</title>`.

- [ ] **Step 3.3: Commit**

```
git add _pages/about.md
git commit -m "Add About page"
```

---

## Task 4: Add Experience page

**Files:**
- Create: `_pages/experience.md`

- [ ] **Step 4.1: Write `_pages/experience.md`**

Content:

```markdown
---
title: "Experience"
permalink: /experience/
---

## Education

- **Ph.D. in Fluid Mechanics**, Yonsei University (Mar 2020 – Aug 2025)
  - School of Mathematics and Computing (Computational Science and Engineering)
  - Advisor: Prof. Changhoon Lee
- **B.S. in Mechanical Engineering**, Yonsei University (Mar 2012 – Feb 2020)

## Industry

- **Professional AI Scientist**, LG CNS — Seoul, Republic of Korea (Jul 2025 – Present)
  - Project: *Data Center Cooling Control AI Agent* (ongoing)

## Academic Research

- **Graduate Student Researcher**, TURBULENCE Lab, Yonsei University (Mar 2020 – Aug 2025)
  - DNS and LES of 2D & 3D homogeneous isotropic turbulence; statistical analysis of turbulence data; deep-learning dynamics prediction across model families (CNN, U-Net, GAN, diffusion, FNO); scale-dependent analysis and explainable AI (XAI) for DL-based turbulence prediction.
- **Undergraduate Research Intern**, TURBULENCE Lab, Yonsei University (Jan 2019 – Feb 2020)
  - Numerical methods foundations for cavity flows; built a lid-driven cavity DNS solver in C; near-wall pressure prediction from off-wall velocity using MLP models.

## Teaching

- **Instructor**, CSE Undergraduate Research Program — CFD team (Summer/Winter 2022, Summer/Winter 2023)
- **Teaching Assistant**, Yonsei University
  - MEU3009: Undergraduate Research (Winter 2022)
  - MEU4400: Independent Study (Spring 2024, Fall 2024)
```

- [ ] **Step 4.2: Build and verify**

```
docker compose run --rm jekyll bundle exec jekyll build
test -f _site/experience/index.html && echo OK || echo MISSING
```

Expected: `OK`.

- [ ] **Step 4.3: Commit**

```
git add _pages/experience.md
git commit -m "Add Experience page"
```

---

## Task 5: Add Research page

**Files:**
- Create: `_pages/research.md`

- [ ] **Step 5.1: Write `_pages/research.md`**

Content:

```markdown
---
title: "Research"
permalink: /research/
---

## Research Interests

- **Fluid mechanics** — turbulence and CFD. High-fidelity fluid simulations and statistical analysis of turbulence data; GPU-accelerated CFD.
- **Deep learning** — generative AI and explainable AI. Leading-edge DL models applied to time-series physical data; analyzing and explaining the working principles of DL models in turbulence prediction.

## Topics

- 2D & 3D homogeneous isotropic turbulence (DNS, LES)
- Deep-learning dynamics prediction across model families: CNN → U-Net → GAN → conditional diffusion → FNO
- Scale-dependent analysis and explainable AI (XAI) for DL-based turbulence prediction
- GPU acceleration for CFD simulations

## Funded Projects

- **NRF Strategic Project** — *Deep learning of turbulence* (Mar 2020 – Feb 2022). Participant.
- **NRF Mid-sized Research Project** — *Fundamental understanding and high-performance modeling of turbulent flows using deep learning* (Mar 2022 – Present). Participant.

## Industrial Bridge

At LG CNS, the same CFD + AI direction is being extended into a production setting through the *Data Center Cooling Control AI Agent* project — taking thermal/fluid-flow modeling that traditionally lives in offline simulation, and embedding it into an AI control loop for live data center operations.
```

- [ ] **Step 5.2: Build and verify**

```
docker compose run --rm jekyll bundle exec jekyll build
test -f _site/research/index.html && echo OK || echo MISSING
```

Expected: `OK`.

- [ ] **Step 5.3: Commit**

```
git add _pages/research.md
git commit -m "Add Research page"
```

---

## Task 6: Add Publications page

**Files:**
- Create: `_pages/publications.md`

- [ ] **Step 6.1: Write `_pages/publications.md`**

Content:

```markdown
---
title: "Publications"
permalink: /publications/
---

> Author name in **bold** indicates me.

## Journal Articles

1. **Jiyeon Kim**, Changhoon Lee. "Dynamics prediction of isotropic turbulence using conditional diffusion probabilistic models." (In Preparation)
2. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of two-dimensional decaying turbulence using generative adversarial networks." *Journal of Fluid Mechanics*, **981**, A19 (2024).
3. Junhyuk Kim, Hyojin Kim, **Jiyeon Kim**, Changhoon Lee. "Deep reinforcement learning for large-eddy simulation modeling in wall-bounded turbulence." *Physics of Fluids*, **34**, 105132 (2022).
4. (Domestic) Changhoon Lee, **Jiyeon Kim**, Jun Park, Junhyuk Kim. THEME 03 "Utilization of artificial intelligence for turbulence analysis." *Journal of the KSME*, **64**(4), 42–49 (2024).

## Conference Proceedings — International

1. **Jiyeon Kim**, Changhoon Lee. "Prediction of isotropic turbulence using conditional diffusion probabilistic models." *77th APS DFD*, Nov. 2024.
2. **Jiyeon Kim**, Changhoon Lee. "A conditional diffusion model for prediction of 2D turbulence." *ICTAM 2024*, Aug. 2024.
3. **Jiyeon Kim**, Changhoon Lee. "Application of denoising diffusion probabilistic models to turbulence prediction." *76th APS DFD*, Nov. 2023.
4. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of 2D decaying turbulence using generative adversarial networks." *75th APS DFD*, Nov. 2022.
5. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of turbulent flows using deep learning." *TSFP12*, Jul. 2022.
6. Junhyuk Kim, Hyojin Kim, **Jiyeon Kim**, Changhoon Lee. "Deep reinforcement learning for large-eddy simulation sub-grid scale modeling in turbulent channel flow." *75th APS DFD*, Nov. 2022.
7. Junhyuk Kim, Hyojin Kim, **Jiyeon Kim**, Changhoon Lee. "Deep reinforcement learning for large-eddy simulation of wall-bounded turbulence." *TSFP12*, Jul. 2022.

## Conference Proceedings — Domestic

1. **Jiyeon Kim**, Changhoon Lee. "Turbulence prediction using conditional diffusion probabilistic models." *13th National Congress on Fluids Engineering (13NCFE)*, Jul. 2024.
2. **Jiyeon Kim**, Changhoon Lee. "Application of denoising diffusion probabilistic model to turbulence problems." *KSME Annual Meeting 2023*, Nov. 2023.
3. **Jiyeon Kim**, Changhoon Lee. "Effect of adversarial training to dynamics prediction of 2D turbulence." *KSME Fluid Engineering Division 2023 Spring Conference*, May 2023.
4. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of 2D decaying turbulence using generative adversarial networks." *12NCFE*, Jun. 2022.
5. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of 2D turbulence using deep learning." *KSCSE 2022 Spring Conference*, May 2022.
6. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Prediction and control of turbulent flows using deep learning." *KSME Fluid Engineering Division 2021 Spring Conference*, Aug. 2021.
7. **Jiyeon Kim**, Junhyuk Kim, Changhoon Lee. "Advanced prediction of 2D turbulent flows using deep learning." *KSCFE 2021 Spring Conference*, May 2021.

## Grants & Honors

1. Merit Academic Paper Award — Academic Field of Natural Science, Jul. 2024.
2. Graduate School Scholarship for Social Problem-Solving Courses — Design and Analysis of Energy System, Jun. 2021.
3. 2021 CSE Best Poster Award — The Second Prize, May 2021.
```

- [ ] **Step 6.2: Build and verify**

```
docker compose run --rm jekyll bundle exec jekyll build
test -f _site/publications/index.html && echo OK || echo MISSING
grep -c "Journal of Fluid Mechanics" _site/publications/index.html
grep -c "TSFP12" _site/publications/index.html
grep -c "Merit Academic Paper Award" _site/publications/index.html
```

Expected: `OK`, and each grep returns at least `1` (one canonical reference from each of journal / intl conf / honors sections).

- [ ] **Step 6.3: Commit**

```
git add _pages/publications.md
git commit -m "Add Publications page"
```

---

## Task 7: Replace top navigation with the 5 tabs

**Files:**
- Modify: `_data/navigation.yml`

- [ ] **Step 7.1: Rewrite `_data/navigation.yml`**

Replace the entire file (currently a placeholder "Quick-Start Guide" entry plus commented-out samples) with:

```yaml
# main links
main:
  - title: "About"
    url: /about/
  - title: "Experience"
    url: /experience/
  - title: "Research"
    url: /research/
  - title: "Publications"
    url: /publications/
  - title: "Posts"
    url: /
```

- [ ] **Step 7.2: Build and verify the menu items render**

```
docker compose run --rm jekyll bundle exec jekyll build
for t in About Experience Research Publications Posts; do
  printf '%-13s ' "$t"
  grep -c ">$t</a>" _site/index.html
done
```

Expected: each tab title appears at least once in `_site/index.html` (the masthead nav is on every page).

- [ ] **Step 7.3: Commit**

```
git add _data/navigation.yml
git commit -m "Set 5-tab navigation: About/Experience/Research/Publications/Posts"
```

---

## Task 8: Final verification

No code changes here. This task confirms end-to-end correctness against the spec's verification section.

- [ ] **Step 8.1: Clean build**

```
docker compose run --rm jekyll bundle exec jekyll build
```

Expected: exit 0, no new errors. (Pre-existing sass deprecation warnings unrelated.)

- [ ] **Step 8.2: Serve and curl each page**

```
docker compose up -d
sleep 8  # let serve come up if it was just restarted
for p in '' about experience research publications; do
  url="http://localhost:4000/${p}${p:+/}"
  printf '%-50s ' "$url"
  curl -sI "$url" | head -1
done
```

Expected: `HTTP/1.1 200 OK` for all 5 URLs.

- [ ] **Step 8.3: Visual check in the browser** at http://localhost:4000/about/

Confirm:
- Top nav shows exactly five tabs: About / Experience / Research / Publications / Posts (in that order).
- Sidebar (left column on `/about/`) shows: name "Jiyeon Kim", JK avatar, the bio one-liner, location "Seoul, Republic of Korea", and four link icons (Email / GitHub / LinkedIn / ORCID) — no Website / Twitter / Facebook / Instagram.
- Footer shows GitHub / LinkedIn / ORCID only.
- /about/ shows Korean greeting, then English bio paragraph, then Contact list.
- /publications/ shows all entries grouped under four headings.

- [ ] **Step 8.4: Regression check — existing posts still work**

The home page should still list `2024-03-27-first-test-upload`. Visit `/` and confirm the post card renders.

- [ ] **Step 8.5: Branch summary**

```
git log --oneline main..feature/profile-pages
git status
```

Expected: working tree clean. Branch holds the spec + per-task commits, ready for PR or local merge.

---

## Out of Scope (do not do in this plan)

- Blog post authoring beyond the existing test post
- Categories/tags taxonomy
- Theme color/typography customization beyond what `_config.yml` already provides
- Comments (utterances) live verification — deferred until the first real post
- Analytics setup beyond fixing the existing typo
- Full bilingual (Korean/English) page-switching — only the About greeting is in Korean
- Pushing the branch or opening the PR (decide separately with the user)
