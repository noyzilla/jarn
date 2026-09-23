# Project Task State & Roadmap

This document serves as the shared real-time task board and scratchpad for collaborators. Update this document continuously across sessions.

## Current Mission
- Establish and verify the Jarn (`jarn`) AI-Driven Software Development Blueprint baseline v0.1.0.

## Handoff & Session Checkpoints
- **Last Successful Action**: Released v0.5.0 with composite release intent, English-only agent internals, scenario-aware installer output, and comprehensive .gitignore.
- **Immediate Next Action**: Pick up next backlog item.
- **Active Blockers**: None.

## In Progress
- None.

## Next Up (Backlog)
- Add `AGENTS.md` language preset section with ecosystem-native test runner, linter, and build commands for a concrete target stack (e.g., Go, TypeScript, or Python) to replace current `N/A` placeholders.
- Create a sample domain implementation under `src/` with accompanying unit tests to demonstrate the living spec workflow (`docs/specs/` code-spec parity, blast-radius matrix, and GATE 1-3 lifecycle).
- Add GitHub Actions CI workflow (`.github/workflows/ci.yml`) running `shellcheck scripts/*.sh` and Markdown link validation on push and PR.
- Extend `.editorconfig` with `[*.md]` section defining `max_line_length` and `trim_trailing_whitespace` rules for Markdown files, the primary artifact type of this project.
- Write Jarn's first living specification (`docs/specs/0001-jarn-installer.md`) documenting the `jarn.sh` lifecycle: version resolution, archive download, Zero-Conflict Seeding algorithm, and Shadow Template synchronization protocol.
- Configure GitHub branch protection rules on `main` (require PR, require status checks) to enforce Step 0 Branch Isolation Invariant.

## Completed Milestones
- Refactored Jarn Governance Lifecycle into unified 3-Gate Model (GATE 1: Living Spec & Mission Approval embedding `jarn-consult` → GATE 2: Surgical Execution & Self-Verification → GATE 3: Knowledge Capture & Pre-Merge Audit).
- Renamed `jarn-testing.md` to `jarn-quality.md` across rules, templates, and documentation.
- Upgraded `jarn-consult` with proactive Socratic coaching for junior developers, early viability triage, and emergency hotfix bypass.
- Codified Slug & Document Path Notation standards in `jarn-naming.md`.

## Blocked & Under Discussion
- None currently.
