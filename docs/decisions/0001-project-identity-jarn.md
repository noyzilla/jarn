---
title: Adopt Jarn as AI-Driven Software Development Blueprint Identity
status: active
tags: [identity, branding, cli]
synapses: []
---

# ADR 0001: Adopt Jarn as AI-Driven Software Development Blueprint Identity

- **Date**: 2026-09-18
- **Status**: Accepted

## Context & Problem Statement

Building complex software with autonomous AI coding agents requires a shared, reproducible foundation — a blueprint project template that embeds development environments, agent rules, safety guardrails, living documentation, and targeted quality gates. 

The baseline template needed a distinct identity and branding that reflects an approachable, knowledgeable, and street-smart AI-driven development environment for developers and AI agents.

## Decision

Adopt **Jarn (`jarn`)** as the official name, CLI identifier, and project blueprint identity.

- **Name**: Jarn (ภาษาไทย: "จารย์")
- **CLI / Package Prefix**: `jarn` (4-character lowercase identifier)
- **Role**: AI-Driven Software Development Blueprint & Baseline Environment (พิมพ์เขียวต้นแบบโปรเจคสำหรับการพัฒนาซอฟต์แวร์ด้วย AI)

## Consequences

- **Positive Consequences**:
  - Establishes a friendly, accessible, and street-smart developer identity ("จารย์ช่วยด้วย!") that fosters high-integrity human-AI collaboration.
  - 4-letter CLI identifier (`jarn init`, `jarn adopt`, `jarn audit`) provides clean command ergonomics.
  - Clean visual separation in directory structures and skill prefixes (`.agents/skills/jarn-*`, `.agents/scripts/jarn-framework-update.sh`).
- **Negative Consequences**:
  - Requires updating template baseline references and updater script names from legacy placeholders to `jarn`.

## Alternatives Evaluated & Trade-offs

- **Generic Baseline Template**: Rejected due to lack of distinct identity, making skill naming and CLI tooling generic and ambiguous.
