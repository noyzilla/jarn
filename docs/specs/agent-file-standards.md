---
title: Agent File Standards
status: active
tags: [spec, agent-rules, file-standards, context-window]
synapses: [".agents/rules/jarn-coding.md", ".agents/rules/jarn-governance.md", "REVIEW.md"]
---

# Specification: Agent File Standards

- **Status**: Active
- **Last Verified**: 2026-09-23
- **Target Audience**: Developers and AI Coding Agents
- **Parent Reference**: [CONTEXT.md](../../CONTEXT.md)
- **Related ADRs**: [docs/decisions/0004-consult-phase.md](../decisions/0004-consult-phase.md)

## Overview & Scope

This specification governs the authoring constraints for all files under `.agents/rules/` and `.agents/skills/`. It enforces two invariants that directly affect AI agent performance: language purity (English-only) and file size limits (context window budget). Both invariants exist to minimize token consumption per agent session and ensure reliable loading across all supported AI harnesses.

## Domain Context & Ubiquitous Language

- **Agent File**: Any file under `.agents/rules/` or `.agents/skills/` that is loaded as machine-readable instructions by an AI coding agent.
- **User-Facing Document**: Root-level documents (`AGENTS.md`, `README.md`, `ARCHITECTURE.md`, `DESIGN.md`, `CONTEXT.md`) and `docs/` content intended for human reading.
- **Soft Limit**: The character count threshold at which a file should be flagged for splitting. Crossing the soft limit is a warning.
- **Hard Limit**: The character count ceiling that must not be exceeded. Crossing the hard limit causes unreliable or truncated loading on constrained harnesses.
- **Thai Annotation**: A Thai-language phrase appended in brackets `[...]` after an English heading used in user-facing documents for human clarity.
- **Forbidden Synonym**: "bilingual agent file" — agent files are English-only; the bilingual standard applies only to user-facing documents.

## Business Rules & Logic Invariants

### Language Rule

- Agent files (`.agents/rules/*.md`, `.agents/skills/*/SKILL.md`) MUST use English only.
- Thai annotations in headings or inline brackets are strictly prohibited in agent files.
- Rationale: Thai annotations increase token count per heading without adding machine-readable value. Every unnecessary token consumed by rules reduces the context budget available for actual code and specs.
- User-facing documents (`AGENTS.md`, `README.md`, `ARCHITECTURE.md`, `DESIGN.md`, `CONTEXT.md`, `docs/**`) MUST use English as the lead language with Thai annotations `[...]` for human clarity.

### File Size Rule

- **Soft limit**: 8,000 characters per agent file.
- **Hard limit**: 12,000 characters per agent file.
- Rationale: Antigravity IDE always-on loading enforces a 12,000 character ceiling. Other harnesses may impose similar constraints. The soft limit provides a safety margin and triggers a split before truncation risk arises.
- When a file reaches the soft limit, the author must evaluate splitting into two focused files with a reference link between them.
- When a file reaches the hard limit, it MUST be split before merging.

### Split Strategy

When splitting an agent file:
- Each resulting file must have a single, clearly defined responsibility.
- The original file retains a one-line reference to the new file: `See [filename.md](filename.md) for <topic>.`
- Both files must independently satisfy the soft limit after the split.
- Update the AGENTS.md rule manifest and REVIEW.md checklist to reference both files.

## Interface & Data Contracts

### File Naming

- Rule files: `.agents/rules/jarn-<topic>.md`
- Skill files: `.agents/skills/jarn-<topic>/SKILL.md`
- New agent files must follow the `jarn-` prefix convention for discoverability and namespace isolation.

### Frontmatter

- Skill files require YAML frontmatter with `name` and `description` fields.
- Rule files do not require frontmatter but must begin with a level-1 heading.

## Dependency & Blast-Radius Matrix

- **Upstream Callers (Inbound)**: All AI coding agents reading `.agents/rules/` and `.agents/skills/` on session start or skill activation. AGENTS.md rule manifest. REVIEW.md checklist.
- **Downstream Dependencies (Outbound)**: No external dependencies. File size and language purity are authoring-time constraints only.
- **Bounded Blast Radius**: When this spec changes, verify `.agents/rules/jarn-coding.md` (language rule source), `REVIEW.md` (checklist enforcement), `AGENTS.md` (manifest), and all `.agents/` files for compliance.

## Verification & Acceptance Criteria

- **Targeted Verification Command**: `wc -m .agents/rules/jarn-*.md .agents/skills/jarn-*/SKILL.md`
- **Language Compliance Check**: `grep -rn '\[.*[ก-๙].*\]' .agents/rules/ .agents/skills/` must return no matches.
- **Size Compliance Check**: All files must show below 8,000 characters (soft limit) in `wc -m` output. Any file between 8,000–12,000 must have a documented split plan. No file may exceed 12,000.

### Acceptance Scenario — Compliant File

A new rule file is authored in English only, contains no Thai annotations in headings or inline brackets, and `wc -m` reports under 8,000 characters. `grep` for Thai characters returns no matches. REVIEW.md checklist passes.

### Acceptance Scenario — Violation Detected

`grep -rn '\[.*[ก-๙].*\]' .agents/` returns a match in a skill file. The author removes the Thai annotation, replaces it with an English-only heading, and re-runs verification to confirm zero matches before merging.
