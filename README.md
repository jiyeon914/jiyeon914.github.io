# Jiyeon's Voyage

Personal blog at [jiyeon914.github.io](https://jiyeon914.github.io) — a slow-paced journal where I record research notes, reading, and bits of work as an AI Scientist (LG CNS) with a Ph.D. in fluid mechanics.

## Stack

- Jekyll 4 + Minimal Mistakes 4.24 (theme files vendored in this repo)
- Hosted on GitHub Pages
- Comments via [utterances](https://utteranc.es)

## Local development

The repository ships a Docker setup, so no host-level Ruby/Bundler install is required.

```sh
docker compose up
```

Then open `http://localhost:4000`. The first run pulls `ruby:3.2` and installs ~30 gems (5–10 minutes); subsequent runs start in seconds because the bundle cache lives in a named Docker volume.

Build-only check (no server):

```sh
docker compose run --rm jekyll bundle exec jekyll build
```

## Repo layout

- `_config.yml` — site-wide settings (title, author, navigation defaults, exclusions)
- `_data/navigation.yml` — top-bar tabs
- `_pages/` — standalone pages (About / Experience / Research / Publications)
- `_posts/` — blog entries
- `assets/css/main.scss` — site-level CSS overrides on top of Minimal Mistakes defaults
- `_includes/`, `_layouts/`, `_sass/` — theme core, vendored from Minimal Mistakes
- `scripts/pr_cycle.sh` — automation for the recurring branch → commit → push → PR → review → merge → prune workflow
- `docs/superpowers/` — design specs, implementation plans, and review notes for non-trivial changes
- `AGENTS.md`, `CLAUDE.md` — operating rules shared by coding agents (Codex, Claude Code)

## Credits

Built on the [Minimal Mistakes](https://github.com/mmistakes/minimal-mistakes) theme by Michael Rose, distributed under the MIT License. Theme source files are vendored into this repo (`_includes/`, `_layouts/`, `_sass/`, `assets/`); see [`LICENSE`](LICENSE) for the upstream license.

Site content © Jiyeon Kim.
