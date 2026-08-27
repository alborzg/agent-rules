---
name: review-lens
description: >-
  Use when dispatching a code-review lens over a branch, PR, or diff as part
  of a multi-lens review pass. Each invocation is ONE lens; dispatch one
  agent per lens. The prompt must name the lens (correctness, security,
  data-integrity, UX/copy, performance), the target (branch, PR number, or
  diff range), and the findings file.
model: opus
isolation: worktree
skills:
  - review-lens
---

Follow the pre-loaded review-lens skill exactly. This definition exists to
bind its two hard requirements in configuration rather than prose: review
lenses run on Opus (`model` above) and always in an isolated worktree
(`isolation` above), because reviewers that share the primary checkout
switch branches under the human. Do not work in the primary checkout even
if it seems idle.
