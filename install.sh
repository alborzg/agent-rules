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

# Claude Code agent definitions: whole-dir symlink, same treatment the
# skills repo gets. These are harness-specific bindings; the portable
# content they enforce lives in RULES.md and the skills repo.
AGENTS_DIR="$(cd "$(dirname "$0")" && pwd)/claude/agents"
AGENTS_TARGET="$HOME/.claude/agents"
if [ -L "$AGENTS_TARGET" ]; then
  rm "$AGENTS_TARGET"
elif [ -e "$AGENTS_TARGET" ]; then
  backup="$AGENTS_TARGET.bak.$(date +%s)"
  mv "$AGENTS_TARGET" "$backup"
  echo "backed up existing $AGENTS_TARGET -> $backup"
fi
ln -s "$AGENTS_DIR" "$AGENTS_TARGET"
echo "linked $AGENTS_TARGET -> $AGENTS_DIR"

echo
echo "optional: to surface each project's worklog + open PRs at session start,"
echo "add the SessionStart hook to ~/.claude/settings.json (see README), pointing at:"
echo "  bash $(cd "$(dirname "$0")" && pwd)/hooks/session-start.sh"
echo
echo "done."
