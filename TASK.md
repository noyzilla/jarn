# Project Roadmap & Backlog

This document serves as the high-level roadmap and backlog for the project. 

> **Task Execution Note:** Do not use this file for tracking active branch development. When starting a new task on a branch, create a branch-scoped `TASK.md` using `templates/task.md` to serve as the execution state machine.

## Current Mission
- Establish and verify the Jarn (`jarn`) AI-Driven Software Development Blueprint baseline v0.1.0.
- Establish Topology-Aware Collaboration Architecture for Jarn.

## High-Level Backlog
- Add `AGENTS.md` language preset section with ecosystem-native test runner, linter, and build commands for a concrete target stack (e.g., Go, TypeScript, or Python) to replace current `N/A` placeholders.
- Create a sample domain implementation under `src/` with accompanying unit tests to demonstrate the living spec workflow (`docs/specs/` code-spec parity, blast-radius matrix, and GATE 1-3 lifecycle).
- Add GitHub Actions CI workflow (`.github/workflows/ci.yml`) running `shellcheck scripts/*.sh` and Markdown link validation on push and PR.
- Extend `.editorconfig` with `[*.md]` section defining `max_line_length` and `trim_trailing_whitespace` rules for Markdown files, the primary artifact type of this project.
- Write Jarn's first living specification (`docs/specs/0001-jarn-installer.md`) documenting the `jarn.sh` lifecycle: version resolution, archive download, Zero-Conflict Seeding algorithm, and Shadow Template synchronization protocol.
- Configure GitHub branch protection rules on `main` (require PR, require status checks) to enforce Step 0 Branch Isolation Invariant.

## Completed Milestones
- None currently (Cleared after v0.6.0 release).

## Blocked & Under Discussion
- None currently.
