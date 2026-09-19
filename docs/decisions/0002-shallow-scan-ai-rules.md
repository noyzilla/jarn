---
title: Shallow Scan AI Rules
status: active
tags: [ai, rules, customization, limit]
---

# ADR 0002: Flat AI Rule Directory Architecture

- **Date**: 2026-09-19
- **Status**: Proposed

## Context & Problem Statement
The Jarn framework initially organized its rules in a namespaced subdirectory: `.agents/rules/jarn/*.md`. This was designed to prevent file collisions with downstream projects that might adopt Jarn (e.g., preventing a clash between Jarn's `safety.md` and the user's `safety.md`). 

However, during early execution, we discovered **"Context Blindness"** in AI agents. AI Customization Engines (such as Antigravity, Cursor, and Claude) only perform a **shallow scan** of the `.agents/rules/` root directory. Because the Jarn rules were hidden inside the `jarn/` subdirectory, the AI failed to load them automatically, leading to critical safety violations (such as committing to the `main` branch).

Additionally, many AI customization systems impose a hard payload limit (often ~12,000 characters) per file. A secondary proposal to combine all Jarn rules into a single `jarn-blueprint.md` file was rejected because the combined payload (~27KB) would trigger silent truncation by the AI engine.

## Decision
We enforce a **Flat AI Rule Directory Architecture** for the Jarn framework:
1. **No Nested Subdirectories**: All Jarn rule files MUST reside directly at the root of the `.agents/rules/` directory.
2. **Prefix Namespacing**: To prevent collisions with downstream project rules, all Jarn rule files MUST be prefixed with `jarn-` (e.g., `jarn-governance.md`, `jarn-testing.md`).
3. **Chunked Files**: Rules MUST be kept split into granular files to ensure each file remains safely below the AI engine's 12,000-character payload limit.

## Consequences
- **Positive Consequences**: AI agents are guaranteed to natively load the full Jarn rule suite during initialization. Zero risk of silent truncation since files are split by domain. No collisions with downstream project rules due to prefixing.
- **Negative Consequences**: The `.agents/rules/` root directory will contain multiple `jarn-*.md` files rather than a single neat folder, which slightly clutters the top-level directory view.

## Alternatives Evaluated & Trade-offs
- **[Nested Subdirectories (`.agents/rules/jarn/*.md`)]**: The original architecture. Evaluated and **rejected** because it causes complete context blindness; the AI system ignores nested folders.
- **[Single Monolithic File (`.agents/rules/jarn.md`)]**: Proposed to solve the nesting issue while keeping the directory clean. Evaluated and **rejected** because combining the rules yields a 27KB file, which exceeds the 12KB token payload limit per file imposed by several AI tools, causing silent data truncation.
