# agent-rules

My universal, agent-agnostic building style. One file, [`RULES.md`](RULES.md),
loaded into every coding-agent session on every machine by symlinking it as each
agent's global instruction file.

This is the top layer of a three-layer setup:

| Layer | Scope | Lives in |
|-------|-------|----------|
| **Universal personal rules** (this repo) | every project, machine, agent | `RULES.md`, symlinked as the global instruction file |
| Per-agent global | every project on one machine | `~/.claude/CLAUDE.md`, `~/.codex/AGENTS.md`, ... (the symlink targets) |
| Per-project | one repo | that repo's own `CLAUDE.md` / `AGENTS.md`, committed with the project |

Skills (on-demand capabilities) live in a separate repo. This repo is only the
always-loaded rules.

## Setup on a new machine

```sh
git clone git@github.com:alborzg/agent-rules.git ~/Projects/agent-rules
cd ~/Projects/agent-rules
./install.sh
```

`install.sh` symlinks `RULES.md` to each agent's global instruction file. If a
target already exists, it is backed up to `<file>.bak.<timestamp>` first, never
deleted. Re-running is safe.

After linking, update the rules by editing `RULES.md` here and pushing. Every
machine that has cloned this repo picks up the change on its next agent session,
no per-machine edits needed.

## What gets linked

- `~/.claude/CLAUDE.md` -> `RULES.md` (Claude Code, user-global)
- `~/.codex/AGENTS.md` -> `RULES.md` (Codex)
- `~/.gemini/GEMINI.md` -> `RULES.md` (Gemini CLI, commented out by default)

### Claude alternative: import instead of symlink

If you want `~/.claude/CLAUDE.md` to keep machine-specific notes *and* pull in
these rules, skip the symlink for Claude and add this line to your existing
`~/.claude/CLAUDE.md` instead:

```
@~/Projects/agent-rules/RULES.md
```

Claude Code resolves `@path` imports, so the rules load while the rest of the
file stays local to that machine. Symlinking is the portable fallback for agents
that do not support imports.

## Keep it public-safe

This repo is public. `RULES.md` must stay free of secrets, tokens, client names,
and machine-specific paths. Anything private or project-specific goes in the
per-project layer, not here.
