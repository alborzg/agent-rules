#!/usr/bin/env bash
# Link RULES.md into each agent's global instruction file.
# Existing files are backed up (never deleted). Safe to re-run.
set -euo pipefail

RULES="$(cd "$(dirname "$0")" && pwd)/RULES.md"

link() {
  local target="$1"
  mkdir -p "$(dirname "$target")"
  if [ -L "$target" ]; then
    rm "$target"
  elif [ -e "$target" ]; then
    local backup="$target.bak.$(date +%s)"
    mv "$target" "$backup"
    echo "backed up existing $target -> $backup"
  fi
  ln -s "$RULES" "$target"
  echo "linked $target -> $RULES"
}

link "$HOME/.claude/CLAUDE.md"
link "$HOME/.codex/AGENTS.md"
# link "$HOME/.gemini/GEMINI.md"   # uncomment if you use Gemini CLI

echo
echo "optional: to surface each project's worklog + open PRs at session start,"
echo "add the SessionStart hook to ~/.claude/settings.json (see README), pointing at:"
echo "  bash $(cd "$(dirname "$0")" && pwd)/hooks/session-start.sh"
echo
echo "done."
