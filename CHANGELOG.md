# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project adheres to Semantic Versioning.

## [Unreleased]

## [0.3.1] - 2026-09-19

### Fixes
- **Strict Template Whitelisting**: Updated `init.sh` and `jarn-update.sh` to use an exact filename whitelist for `docs/` and root templates, preventing internal Jarn project files (like ADRs) from leaking into downstream projects.

## [0.3.0] - 2026-09-19

### Features
- **Core Architecture Overhaul**: Flattened AI rules from `.agents/rules/jarn/*.md` to `.agents/rules/jarn-*.md` for shallow scan compatibility.
- **Template Modernization**: Standardized ADR and Specs templates with YAML frontmatter.
- **Update Engine Enhancements**: Upgraded `jarn-update.sh` with `.pending-merge` template synchronization.
- Unified `init.sh` and `adopt.sh` workflows.
- Introduced centralized `UPDATE_NOTES.md` to feed AI Directives for automated downstream migrations.

### Fixes
- Updated legacy rule paths in remaining docs (`CONTRIBUTING.md`, `README.md`, `CHANGELOG.md`).
- Fixed broken rule path references in Jarn skills.

## [0.2.4] - 2026-09-18

### Features
- support self-updating via internal exec state using `cmp` in `jarn-update.sh`

## [0.2.3] - 2026-09-18

### Changed
- Separated Jarn-specific documentation into root `*.md` files and provided generic templates in `templates/`.
- Fixed `adopt.sh` to correctly prioritize generic templates over root files during synchronization.

## [0.2.2] - 2026-09-18

### Fixes
- Added clean `README.md` and `CONTEXT.md` to `templates/` to prevent leaking Jarn-specific documentation into downstream projects during initialization.

## [0.2.1] - 2026-09-18

### Fixes
- **Docs**: Simplified installation instructions in `README.md` by removing the explicit `-- gh` flags, as the scripts now automatically detect private repositories and fallback to the GitHub CLI.

## [0.2.0] - 2026-09-18

### Features
- Added `jarn-release` AI skill to automate the GitHub Release lifecycle (SemVer calculation, CHANGELOG generation, and tag publishing).
- Switched default version targeting in `init.sh`, `adopt.sh`, and `jarn-update.sh` to rely on the GitHub `releases/latest` API instead of raw tags for safer consumption.
- Implemented auto-detection in installation scripts to seamlessly fallback to the `gh` CLI if the target repository is private or requires authentication.

### Fixes
- Removed fallback to `main` when tags/releases are missing; the installation scripts now fail safely with an explicit error message instead.

## [0.1.2] - 2026-09-18

### Added
- Created `templates/` directory to distribute clean stateful files (e.g., `TASK.md`, `CHANGELOG.md`) without polluting downstream projects.
- Updated `scripts/init.sh` to automatically deploy templates and remove the directory.
- Updated `scripts/adopt.sh` to safely exclude the `templates/` directory during integration.

## [0.1.1] - 2026-09-18

### Added
- **Ambiguous Directive Fallback (Safety Brake)** rule in `.agents/rules/jarn-workflow.md` to prevent execution of vague commands without prior context or explicit scoping.

## [0.1.0] - 2026-09-18

### Added
- Official **Jarn (`jarn`)** identity: AI-Driven Software Development Blueprint & Baseline Environment.
- Companion Test Invariant and Zero-Regression Guarantee in `AGENTS.md` and `REVIEW.md` requiring AI agents to automatically create unit/integration tests alongside logic modifications and verify zero breakage via Terminal logs before handoff.
- Architectural Decision Record `docs/decisions/0001-project-identity-jarn.md` documenting Jarn identity adoption.
- **Why Jarn (จารย์)** philosophy and background section in `README.md`.
- Jarn Skills Suite under `.agents/skills/jarn-*/`:
  - `jarn-spec`: Interactive runbook to debate, author, and maintain vertical slice living specifications (`docs/specs/`) with Code-Spec Parity and blast-radius matrices.
  - `jarn-decisions`: Manage the lifecycle of Architectural Decision Records (`docs/decisions/`) with zero-token filtering.
  - `jarn-review`: Autonomous quality gate audit runbook to inspect `git status`, map touched surfaces to the Change Routing Matrix, execute targeted verification, audit commit conventions, and synthesize pre-merge evidence.
  - `jarn-diagnostics`: Isolated defect investigation procedure bounded strictly to the living spec's blast-radius matrix without blind codebase scans.
- Jarn Update Utility script under `.agents/scripts/jarn-update.sh` for atomic downstream synchronization.
- Brownfield Adoption Command in `scripts/adopt.sh` providing a non-destructive installation workflow for existing projects: synchronizes core `.agents/` invariants, scaffolds missing governance files, stages conflicting files as `*.pending-merge`, and outputs an AI Adoption Directive for automated semantic merge.
- Non-Empty Safety Guard in `scripts/init.sh` to prevent accidental clobbering of existing codebases, rejecting non-empty targets and guiding developers to use `scripts/adopt.sh`.
- Mandatory Pre-Flight Action Guard in `AGENTS.md`, `safety.md`, and `workflow.md` strictly enforcing Step 0 Branch Isolation (`git checkout -b`) before any codebase modifications can take place.
- Mandatory Pre-Merge Audit Execution trigger in `AGENTS.md` requiring AI agents to activate `jarn-review` before declaring task completion.
- Universal Code Review & Pre-Merge Standard in `.agents/rules/jarn-review.md` extracting project-agnostic quality gates, safety invariants, targeted verification, and AI accountability rules into the syncable governance kernel.
- Targeted Verification Policy in `REVIEW.md`, `AGENTS.md`, and `.agents/rules/jarn-workflow.md` requiring verification commands to strictly match modified surfaces via `git status`.
- Semantic Numbering Invariant and Stable References Standard in `.agents/rules/jarn-standards.md`.
- System Documentation Taxonomy in `docs/README.md` (`architecture/`, `design/`, `specs/`, `decisions/`, `development/`).
- Default-to-Consultation State Machine in `AGENTS.md` and `.agents/rules/jarn-workflow.md`.
- Change Taxonomy Protocol distinguishing Spec-Altering Changes from Spec-Conforming Bug Fixes.
- Domain Glossary and Ubiquitous Language specification template in `CONTEXT.md`.
