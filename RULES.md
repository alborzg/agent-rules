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

- Always name the repo and number together, with a link, and add the title or a
  short label: `owner/repo#123 (Stripe billing)` plus the URL, never a bare
  "#123" or "PR 123". The repo and number keep it unambiguous on multi-repo
  tasks; the title or label saves the reader a lookup.
- This applies everywhere the reference appears: chat, commit messages, PR
  bodies, issue bodies, planning docs, and cross-links between issues.

## Technical decisions

- Do not over-weight development cost. For an agent, writing and changing code is
  cheap, so do not reach for a cheap, low-quality solution to "save effort".
  Optimize for the right design, correctness, and long-term maintainability.
- Prefer the simplest solution that is actually correct. Do not add speculative
  abstractions, but never trade away correctness, security, or quality just to
  write less code.

## Shared checkouts and parallel work

- A project checkout is shared state: the human or another agent may switch
  branches under you at any time. Verify the current branch immediately before
  committing; never assume it is where you left it.
- When dispatching agents or running parallel tasks against the same repo, give
  each concurrent actor its own git worktree or clone. The primary checkout
  belongs to the human.
- Claim a tracked issue before starting it: comment "Taken: <who/session>,
  <date>" on the issue, or self-assign. Local state (a dirty tree, a branch)
  is invisible to other machines and sessions; the claim must live where the
  issue lives. This matters most when a delivery crosses repos or layers
  (backend + mobile app, service + infra): another actor picking up the
  sibling task cannot see your checkout at all. Remove or resolve the claim
  when you finish or abandon the work.
- Symmetrically, before picking up an issue, check for an existing claim:
  assignee, a claim comment, an open PR, or the issue's designated branch
  already existing. Any of these means someone may be mid-flight; coordinate
  or monitor instead of duplicating the work.

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

## Deploys and configuration

- When you add a runtime environment variable that code reads (`System.fetch_env!`,
  `process.env`, `os.environ`, and the like), wire it through every layer that must
  forward it, not just the code: the deploy manifest (docker-compose `environment:`,
  Kubernetes manifest, Procfile), the `.env.example`, and the secrets store. A
  variable set only in a hosting UI never reaches a container whose compose file
  enumerates its env explicitly.
- Treat this as a review checkpoint. Before shipping a change that adds or renames a
  required env var, confirm the real deploy target actually passes it. Local runs
  read the environment directly and will not catch a missing passthrough, so the gap
  surfaces only as a production boot crash.

@RTK.md
