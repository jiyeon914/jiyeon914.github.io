# Agent Instructions

This file is the project-level entry point for coding agents. Keep it short, operational, and specific to this repository.

## Read First

- [README.md](README.md) for the project identity.
- [_config.yml](_config.yml) for site-wide Jekyll and Minimal Mistakes settings.
- [_data/navigation.yml](_data/navigation.yml) before changing top navigation.
- Relevant files under `_pages/`, `_posts/`, `assets/`, `_includes/`, `_layouts`, and `_sass/` for the touched area.

## Project Context

- This is the public GitHub Pages repository for `jiyeon914.github.io`.
- The site is a Jekyll blog based on Minimal Mistakes 4.24.0, with theme files vendored in the repo.
- Root-level Jekyll files are the live site source.
- It is fine to create project documentation under `docs/`, such as specs, plans, reviews, and journals.
- Do not accidentally restore the old Minimal Mistakes upstream sample `docs/` site or theme-development `test/` fixture tree when making unrelated changes. Reintroduce those deleted upstream files only if the user explicitly asks or a current toolchain genuinely requires them.
- Current primary content is a personal academic and professional profile: About, Experience, Research, Publications, and Posts.

## Environment

- Prefer Docker for Ruby, Bundler, and Jekyll commands. Do not require host-level Ruby/Jekyll installs for normal work.
- This is not a Python project. Do not add a Python virtual environment, `pyproject.toml`, or Python tooling unless the user explicitly introduces a Python-based workflow.
- `Gemfile.lock`, `_site/`, `.jekyll-cache/`, and `.jekyll-metadata` are local build artifacts and are ignored.
- Docker Compose uses a named `bundle_cache` volume for installed gems, so gem installation should stay outside the repository tree.

## Hard Rules

- Treat this as a public repository. Do not commit private local filesystem paths, application-material context, phone numbers, home addresses, private CV files, secrets, analytics credentials beyond already-public config, or unreviewed personal data.
- Keep source material references generic unless the user explicitly wants a public citation.
- Do not add generated site output from `_site/`, Jekyll caches, logs, or local build artifacts.
- Do not delete or rewrite user-authored content, profile pages, posts, or local agent settings unless explicitly asked.
- Keep Minimal Mistakes customizations scoped. Prefer content/config changes over theme core edits when possible.
- If work uncovers an out-of-scope issue, mention it to the user or record it in the relevant spec/review note instead of silently widening the patch.

## Workflow Expectations

- Keep changes small and directly tied to the user's request.
- Before larger content or layout changes, check whether there is an active spec or PR discussion.
- Preserve a clear reasoning trail in spec/review docs when decisions affect public profile content, privacy, navigation, or deployment behavior.
- Write GitHub PR titles, bodies, review comments, and merge notes in Korean unless the user requests otherwise.
- Be careful with branch state. This repo may have user changes; do not revert unrelated work.

## Verification

- For content/config changes, run a Docker-based Jekyll build when practical:

  ```sh
  docker compose run --rm jekyll bundle exec jekyll build
  ```

- If the user has intentionally installed Ruby/Bundler on the host, the equivalent host command is:

  ```sh
  bundle exec jekyll build
  ```

- For rendered-page checks, run:

  ```sh
  docker compose up
  ```

  Then verify relevant pages on `http://localhost:4000/`.

- If verification cannot be run, state exactly why and what remains unverified.

## Git Policy

- Keep commits focused and avoid committing unrelated user changes.
- Before committing, inspect `git status --short` and stage only the intended files.
- Do not commit `_site/`, `.jekyll-cache/`, `.jekyll-metadata`, or local-only settings.
- Use concise commit messages, for example `docs: add agent instructions` or `site: update profile navigation`.
- Default merge strategy: **merge commit** via `gh pr merge <num> --merge --delete-branch`. Preserve the feature-branch story when it is useful for history.
- Use **squash merge** only when intermediate commits contain sensitive content (private paths, personal context, secrets) that should not enter `main`'s history. This is an exception, not the default.
- Never force-push to `main`. Force-push on feature branches only when explicitly requested.
- For the repeated branch → commit → push → PR → review → merge → prune flow, use `scripts/pr_cycle.sh` so Claude and Codex follow the same pattern. See `scripts/pr_cycle.sh --help` for usage.
