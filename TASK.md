# Project Task State & Roadmap

This document serves as the shared real-time task board and scratchpad for collaborators. Update this document continuously across sessions.

## Current Mission
- Establish and verify the Jarn (`jarn`) AI-Driven Software Development Blueprint baseline v0.1.0.

## Handoff & Session Checkpoints
- **Last Successful Action**: Audited all `.md` files for Markdown invariants, replaced sequential execution numbering with semantic bullets, documented ADR 0003 for Shadow Merge, and updated governance rules to enforce `TASK.md` state synchronization.
- **Immediate Next Action**: Perform pre-merge verification check (`sh -n` for shell scripts, link checks) and create clean Initial Release commit.
- **Active Blockers**: None.

## In Progress
- Finalizing Jarn baseline v0.1.0 release branch (`feat/refactor-jarn-baseline`).

## Next Up (Backlog)
- Add project-specific language configuration when adopting for concrete projects.
- Add sample domain implementation and unit test suite.

## Completed Milestones
- Refactored project identity to **Jarn (`jarn`)** as the AI-driven software development blueprint.
- Created ADR 0001 (`docs/decisions/0001-project-identity-jarn.md`) for Jarn identity adoption.
- Designed universal architecture, safety boundaries, and workflow protocols.
- Established the Mirror Index Pattern for documentation scalability.
- Generated baseline Jarn blueprint repository structure.
- Replaced rigid Makefile with Ecosystem-Native Lifecycle Contracts and multi-language presets in `AGENTS.md`.
- Integrated core brain invariants: Non-Subtractive Principle, Discovery First, Evidence-Based DoD, Golden Path, and Handoff Checkpoints.
- Created `scripts/init.sh` for one-liner full project initialization from GitHub.
- Replaced local update script with unified installer `scripts/jarn.sh` and zero-conflict Shadow Merge architecture.
- Standardized all automation scripts on pure POSIX basic shell (`/bin/sh`) with zero Python dependency.
- Codified Branch Isolation Protocol (no direct main commits) and Incremental Micro-Commit Protocol (atomic checkpoints).
- Integrated `CONTEXT.md` (Domain Glossary), `REVIEW.md` (Pre-Merge Checklist), and Change Routing Matrix in `AGENTS.md`.
- Established Living Specifications governance (`docs/specs/`) and eliminated obsolete ADR context pollution.
- Codified Collaborative Spec Protocol (Design Debate -> Spec Synthesis -> Surgical Execution -> Blast-Radius Scoping).
- Codified Default-to-Consultation State Machine preventing AI eager-action code modifications without explicit directive triggers.
- Codified Change Taxonomy Protocol distinguishing Spec-Altering Changes from Spec-Conforming Bug Fixes.
- Designated Git Commit Message as the authoritative Granular Engineering Logbook with intent-based defect root-cause tracking.
- Unified documentation into the System Documentation Taxonomy in `docs/README.md`.
- Reintroduced Architectural Decision Records (`docs/decisions/`) with explicit filename lifecycle (`.deprecated.md` and `.superseded.md`) for zero-token AI filtering.
- Formalized On-Demand (JIT) Directory Creation protocol, eliminating empty placeholder directories and ghost `.gitkeep` files.
- Codified Stable References standard and Semantic Numbering Invariant in `.agents/rules/jarn-coding.md`.
- Codified Targeted Verification Policy requiring blast-radius scoping via `git status`.
- Established the Jarn Skills suite (`jarn-spec`, `jarn-decisions`, `jarn-review`, `jarn-diagnostics`) under `.agents/skills/jarn-*/`.
- Enforced `TASK.md` state synchronization in GATE 2 (`.agents/rules/jarn-governance.md` and `.agents/rules/jarn-testing.md`).

## Blocked & Under Discussion
- None currently.
