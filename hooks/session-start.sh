#!/usr/bin/env bash
# SessionStart hook: surface where we left off for the current project.
# Prints the top of docs/WORKLOG.md (its "Next up" section) and open PRs.
# Best-effort and non-fatal by design, so no `set -e` and always exit 0.

if [ -f docs/WORKLOG.md ]; then
  echo "## Worklog (top of docs/WORKLOG.md)"
  head -n 40 docs/WORKLOG.md
  echo
fi

if command -v gh >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  prs="$(gh pr list --state open --limit 20 2>/dev/null)"
  if [ -n "$prs" ]; then
    echo "## Open PRs"
    echo "$prs"
  fi
fi

exit 0
