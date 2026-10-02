---
title: Adopt docs/adr Taxonomy for Architectural Decision Records
status: accepted
tags: [architecture, adr, taxonomy, documentation, naming]
synapses: ["ARCHITECTURE.md", "AGENTS.md", ".agents/rules/jarn-architecture.md", ".agents/rules/jarn-naming.md"]
---

# ADR 0008: Adopt docs/adr Taxonomy for Architectural Decision Records

- **Date**: 2026-10-02
- **Status**: Accepted
- **Parent Reference**: [ARCHITECTURE.md](../../ARCHITECTURE.md)

## Context & Problem Statement
Previously, Jarn organized architectural decision records under `docs/decisions/` to maintain explicit, fully written English names without acronyms.

However, across the global software engineering community and agent ecosystem, **ADR (Architectural Decision Record)** is the ubiquitous, industry-standard acronym. The convention `docs/adr/` offers distinct practical advantages:
1. **Industry Ubiquity**: Developers and AI agents immediately recognize `docs/adr/` without requiring explanation or onboarding overhead.
2. **Path Ergonomics**: Shorter directory paths improve readability in CLI logs, agent prompt footprints, and IDE trees.
3. **Ecosystem & Tooling Interoperability**: Compatible with standard ADR CLI tools, indexers, and community skills (such as `mattpocock/skills`).

## Decision
We adopt **`docs/adr/`** as the canonical taxonomy directory for Architectural Decision Records in Jarn, superseding `docs/decisions/`:

- Move `docs/decisions/` to `docs/adr/`.
- Move template directory `templates/docs/decisions/` to `templates/docs/adr/`.
- Retain the Zero-Token AI Filtering lifecycle invariant (`.superseded.md`, `.deprecated.md`).
- Update all rules, skills (`jarn-decisions`), documentation indexes, and synaptic links across the project.

## Consequences
- **Positive Consequences**:
  - Aligns Jarn documentation taxonomy with ubiquitous industry standards.
  - Shorter, cleaner file paths across the repository.
  - Enhanced compatibility with third-party agent skills and ADR tooling.
- **Negative Consequences / Trade-offs**:
  - Requires updating documentation links and synaptic references from `docs/decisions/` to `docs/adr/`.
