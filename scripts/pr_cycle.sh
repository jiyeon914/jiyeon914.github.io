#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  scripts/pr_cycle.sh run \
    --branch <branch-name> \
    --commit <commit-message> \
    --title <pr-title> \
    --body-file <markdown-file> \
    [--review-file <markdown-file>] \
    [--base main] \
    [--add <path>]... \
    [--merge]

Purpose:
  Automate the repeated local flow:
  branch -> stage explicit paths -> commit -> push -> create PR -> optional review
  -> optional merge commit -> fetch --prune.

Notes:
  - Use --add for every file/path that should be staged.
  - If --add is omitted, the script uses the current staged changes.
  - --merge is intentionally explicit because it updates main.
  - PRs are merged with merge commits only, matching this repo's policy.
EOF
}

die() {
  echo "error: $*" >&2
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "missing required command: $1"
}

run_cmd() {
  echo "+ $*" >&2
  "$@"
}

mode="${1:-}"
if [[ "$mode" == "-h" || "$mode" == "--help" || -z "$mode" ]]; then
  usage
  exit 0
fi
[[ "$mode" == "run" ]] || die "unknown mode: $mode"
shift

branch=""
base="main"
commit_msg=""
title=""
body_file=""
review_file=""
merge_after=0
add_paths=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --branch)
      branch="${2:-}"; shift 2 ;;
    --base)
      base="${2:-}"; shift 2 ;;
    --commit)
      commit_msg="${2:-}"; shift 2 ;;
    --title)
      title="${2:-}"; shift 2 ;;
    --body-file)
      body_file="${2:-}"; shift 2 ;;
    --review-file)
      review_file="${2:-}"; shift 2 ;;
    --add)
      add_paths+=("${2:-}"); shift 2 ;;
    --merge)
      merge_after=1; shift ;;
    -h|--help)
      usage; exit 0 ;;
    *)
      die "unknown argument: $1" ;;
  esac
done

[[ -n "$branch" ]] || die "--branch is required"
[[ -n "$commit_msg" ]] || die "--commit is required"
[[ -n "$title" ]] || die "--title is required"
[[ -n "$body_file" ]] || die "--body-file is required"
[[ -f "$body_file" ]] || die "--body-file does not exist: $body_file"
if [[ -n "$review_file" && ! -f "$review_file" ]]; then
  die "--review-file does not exist: $review_file"
fi

need_cmd git
need_cmd gh

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

current_branch="$(git branch --show-current)"
if [[ "$current_branch" != "$branch" ]]; then
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    run_cmd git switch "$branch"
  else
    run_cmd git switch -c "$branch"
  fi
fi

if [[ ${#add_paths[@]} -gt 0 ]]; then
  run_cmd git add "${add_paths[@]}"
fi

if git diff --cached --quiet; then
  die "no staged changes. Pass --add <path> or stage changes before running."
fi

run_cmd git diff --cached --stat
run_cmd git commit -m "$commit_msg"
run_cmd git push -u origin "$branch"

pr_url="$(gh pr create \
  --base "$base" \
  --head "$branch" \
  --title "$title" \
  --body-file "$body_file")"
echo "$pr_url"

pr_number="$(gh pr view "$branch" --json number --jq '.number')"
[[ -n "$pr_number" ]] || die "could not determine PR number"

if [[ -n "$review_file" ]]; then
  run_cmd gh pr review "$pr_number" --comment --body-file "$review_file"
fi

if [[ "$merge_after" -eq 1 ]]; then
  run_cmd gh pr merge "$pr_number" --merge --delete-branch
  run_cmd git fetch --prune
  run_cmd git switch "$base"
  run_cmd git merge --ff-only "origin/$base"
fi

run_cmd git status --short --branch
