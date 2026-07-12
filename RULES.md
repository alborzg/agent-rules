# Personal agent rules

My universal building-style rules. They apply across every project, machine, and
agent (Claude Code, Codex, Gemini, and any other harness). Nothing here is
project-specific or private, this file is public, so never add secrets,
machine-specific paths, or client names. Those belong in per-project memory.

## Commits and attribution

- Author commits as me. Never add AI attribution: no `Co-Authored-By` line, no
  "Generated with" footer, no agent name in the author or committer fields.
- Commit messages and PR descriptions should read like I wrote them.

## Writing

- Never use em-dashes. They read as an AI default and feel robotic. Use a comma,
  parentheses, or two sentences instead.
- Plain and direct. No filler, no marketing voice, no padding.

## Referring to PRs and issues

- Always name the repo and number together, with a link:
  `owner/repo#123` plus the URL, never a bare "#123" or "PR 123".
  This applies in chat, commit messages, PR bodies, issue bodies, and docs,
  and matters most on multi-repo tasks where bare numbers are ambiguous.

## Technical decisions

- Do not over-weight development cost. For an agent, writing and changing code is
  cheap, so do not reach for a cheap, low-quality solution to "save effort".
  Optimize for the right design, correctness, and long-term maintainability.
- Prefer the simplest solution that is actually correct. Do not add speculative
  abstractions, but never trade away correctness, security, or quality just to
  write less code.

## Bug fixes

- Start by reproducing the bug end-to-end, as close as possible to how an end
  user hits it. Do not rely on unit tests alone to confirm a fix, verify the real
  product behavior.

## Verification

- Before committing, make it compile cleanly, format it, and pass the tests.
- Leave at least one runnable check behind for non-trivial logic.

## Repository hygiene

- Keep the repo root for config and entry points only. Feature docs, plans, and
  design references belong under `docs/`. Session notes and scratch files go
  there too or get gitignored, never left loose in the root.

## Security

- Sanitize anything that comes from a user or an external system before storing
  or rendering it. Prefer the framework's built-in escaping over hand-rolled
  sanitization.
- Verify webhook signatures on every inbound provider callback. Keep secrets
  server-side, never ship them to the client.

## Accessibility

- Cover the basics by default: keyboard navigation, semantic markup, labels on
  interactive controls, and WCAG AA color contrast.

@RTK.md
