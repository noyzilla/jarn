# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project adheres to Semantic Versioning.

## [Unreleased]

### Rules
- **3-Gate Operational Lifecycle**: Re-architected operational gates into a clean, unified, 1-based **GATE 1 → GATE 2 → GATE 3** model in `jarn-lifecycle.md` and `jarn-governance.md` (GATE 1: Living Spec & Mission Approval embedding `jarn-consult`, GATE 2: Surgical Execution & Self-Verification, GATE 3: Knowledge Capture & Pre-Merge Audit).
- **jarn-quality.md (Universal Standard)**: Renamed `jarn-testing.md` to `jarn-quality.md` (`# Universal Quality Gates & Pre-Merge Standard`) to accurately reflect its role as the universal pre-merge quality and review standard across all three gates.
- **Jarn File Immutability Invariant**: Added `Do not modify this file` notice to all `jarn-*.md` rule files and `jarn-*/SKILL.md` skill files. Downstream projects must not edit these files directly — they will be overwritten by `jarn-framework-update`. Project-specific extensions belong in `REVIEW.md` and `AGENTS.md` only.
- **Agent File Size Compliance**: Added size limit enforcement — soft limit 8,000 characters, hard limit 12,000 characters per agent file — with `wc -m` verification command in GATE 3 checklist.
- **Agent Language Purity**: Strengthened Bilingual Annotation Standard checklist item with explicit `grep` verification command to enforce English-only in `.agents/` files.

### Skills
- **jarn-consult Skill (GATE 1)**: Integrated `jarn-consult` into GATE 1 with proactive **Brainstorming & Socratic Coaching** for junior developers (scaffolding questions for security, race conditions, edge cases, and performance), early viability triage (Proceed, Defer, or Won't Do YAGNI filter), and emergency hotfix bypass clause.
- **jarn-review Skill (GATE 3)**: Aligned review runbook to audit against `jarn-quality.md` and verify GATE 1..3 DoD compliance.

### Templates
- **templates/REVIEW.md & templates/AGENTS.md & templates/CONTRIBUTING.md**: Synchronized all templates with the 3-Gate operational model and `jarn-quality.md` universal rule references.

### Specs & Decisions
- **ADR-0004**: Updated architectural record reflecting the 3-Gate lifecycle evolution and GATE 1 Consultation/Brainstorming integration.

## [0.5.0] - 2026-09-23

### Governance
- **TASK.md Quality Bar**: Added quality criteria to GATE 2 and review checklist requiring backlog items to include specific deliverable scope. Vague entries are now explicitly prohibited.
- **Release Exception on Main**: Added explicit exception to the Step 0 Branch Isolation rule allowing `chore(release):` commits directly on `main` as a post-merge ceremony.
- **English-Only Agent Internals**: Removed all Thai heading annotations from `.agents/rules/` and `.agents/skills/` files. Clarified bilingual annotation scope to user-facing documents only, reducing token consumption per agent session.

### Skills
- **Release Composite Intent**: Redesigned `jarn-release` skill with two trigger levels: `release` (inform & confirm) and `จบงาน release` (execute full pipeline). Agent now automatically resolves pre-conditions (uncommitted changes, non-main branch) without stopping to ask at each step, while preserving all quality gates.
- **Release Branch Removal**: Release preparation now commits directly on `main` instead of requiring a `chore/release-*` branch, eliminating unnecessary ceremony for mechanical changelog-only commits.

### Scripts
- **Scenario-Aware Output**: `jarn.sh` now detects installation scenario (Greenfield, Brownfield, Update-Same, Update-Upgrade) and displays tailored output with context-appropriate next steps instead of a one-size-fits-all adoption directive.
- **Version Upgrade Hint**: Cross-version upgrades now show `v0.x.x -> v0.y.y` transition and link to CHANGELOG.md.
- **SC2115 Safety Fix**: Added `${var:?}` guard on `SHADOW_DIR` to prevent catastrophic `rm -rf /*` if the variable is empty.
- **Visual Hygiene**: Replaced emoji in script output with plain text prefixes.

### Templates
- **Standard .gitignore**: Added language-agnostic `.gitignore` template covering OS-generated files (`.DS_Store`, `Thumbs.db`) and environment secrets (`.env`, `.env.local`).

### Documentation
- **README.md**: Removed emoji from tip marker to comply with Visual Hygiene Invariant.
- **ARCHITECTURE.md**: Consolidated stale `init.sh`/`adopt.sh` references into a single Unified Installer entry pointing to `scripts/jarn.sh`.
- **TASK.md**: Refined all backlog items with specific deliverable scope per the new Quality Bar.

## [0.4.5] - 2026-09-20

### Documentation & Templates
- **Universal Documentation Templates**: Seeded standard `0000-template.md` across all 5 taxonomy directories (`docs/specs/`, `docs/decisions/`, `docs/development/`, `docs/architecture/`, and `docs/design/`).
- **Development Workflow Runbooks**: Added `0000-template.md` for developer onboarding, migration runbooks, and SOPs with standard 4-digit numbering (`docs/development/0001-*.md`).
- **Architecture & Design Templates**: Added comprehensive deep-dive templates for system topologies (`docs/architecture/0000-template.md`) and UI components (`docs/design/0000-template.md`).
- **Frontmatter Synapses Alignment**: Aligned YAML frontmatter `synapses` with header parent and related references across all templates for deterministic AI knowledge graph indexing.

## [0.4.4] - 2026-09-20

### Chores & Documentation
- **Templates**: Added a `Self-Destruct` instruction to the `DESIGN.md` AI Shadow Merge Directive to prevent meta-instructions from persisting in downstream projects.
- **Documentation**: Applied the strict Headless Constraint block to Jarn's own root `DESIGN.md` to properly represent the repository's headless nature and remove the UI-specific sections.

## [0.4.3] - 2026-09-20

### Chores & Documentation
- **Templates**: Enhanced the AI Shadow Merge Directive in `DESIGN.md` to provide a concrete, strict "Headless Backend Library" constraint block example for downstream agents to adopt when initializing non-UI projects.

## [0.4.2] - 2026-09-20

### Chores & Documentation
- **Documentation**: Refactored `README.md` to use an AI-First workflow for installation and adoption.
- **Documentation**: Removed Jarn unified installer snippet from `REVIEW.md` templates.
- **Skill Workflows**: Updated `jarn-framework-update` skill to instruct AI to be context-aware during shadow merges.
- **Templates**: Added an AI Shadow Merge Directive to `DESIGN.md` to prevent UI tokens from leaking into CLI/Backend projects.

## [0.4.1] - 2026-09-19

### Chores & Documentation
- **License**: Added MIT License to the project.
- **Documentation**: Explicitly codified TASK.md pruning rules after a release.

## [0.4.0] - 2026-09-19

### Changed
- **Agent Bootstrap**: Require downstream agents to discover and read every active Jarn rule before starting work.
- **Rule Manifest**: Designate dynamic rule discovery as authoritative while retaining a synchronized navigation manifest.
- **Skill Workflows**: Add approval checkpoints before skills modify files, update frameworks, or publish releases.
- **Framework Update Naming**: Unified installer under `scripts/jarn.sh` for unambiguous framework synchronization and shadow merge.
- **Verification Routing**: Match updater scripts under `.agents/scripts/*.sh` in the Agent Change Routing Matrix.
- **Garbage Collection**: Added automatic cleanup of legacy `.agents/rules/jarn*` and `.agents/skills/jarn-*` files in `jarn.sh` before synchronization to prevent orphaned files when Jarn renames or deletes rules.

## [0.3.2] - 2026-09-19

### Fixes
- **Scripts**: Skip `pending-merge` for project-specific root files.

## [0.3.1] - 2026-09-19

### Fixes
- **Strict Template Whitelisting**: Updated `init.sh` and `jarn-update.sh` to use an exact filename whitelist for `docs/` and root templates, preventing internal Jarn project files (like ADRs) from leaking into downstream projects.

## [0.3.0] - 2026-09-19

### Features
- **Core Architecture Overhaul**: Flattened AI rules from `.agents/rules/jarn/*.md` to `.agents/rules/jarn-*.md` for shallow scan compatibility.
- **Template Modernization**: Standardized ADR and Specs templates with YAML frontmatter.
- **Update Engine Enhancements**: Upgraded `jarn-update.sh` with `.pending-merge` template synchronization.
- Unified `init.sh` and `adopt.sh` workflows.


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
