---
title: Add Consultation Phase as Explicit Pre-Gate-0 Workflow
status: active
tags: [workflow, ai-agent, junior-developer, consultation]
synapses: [".agents/rules/jarn-governance.md", ".agents/skills/jarn-consult/SKILL.md"]
---

# ADR 0004: Add Consultation Phase as Explicit Pre-Gate-0 Workflow

- **Date**: 2026-09-23
- **Status**: Accepted
- **Parent Reference**: [ARCHITECTURE.md](../../ARCHITECTURE.md)

## Context & Problem Statement

Jarn's governance model assumes the human collaborator already holds a clear mental model of what they want to build. The `Interactive Design Debate` in `jarn-spec` and `Inquiry Mode` in `jarn-governance` provide a consultation mechanism, but neither enforces structured requirement discovery before spec writing begins.

In practice, two problems emerge:

1. **Model-dependent behavior**: Some AI models ask probing questions naturally; others jump straight to writing a spec based on assumptions. The quality of requirement discovery depends on the model, not the framework.
2. **Junior developer barrier**: Engineers without deep domain experience do not always know what questions to ask. They rely on the AI to surface edge cases, constraints, and trade-offs — but Jarn provides no explicit mechanism for the AI to lead that discovery.

The result is specs that miss edge cases, require multiple revision rounds, and demand Senior-level intervention to course-correct — undermining the goal of reducing oversight burden.

## Decision

Introduce `jarn-consult` as an explicit, named **GATE 1: Requirement Discovery & Brainstorming** that precedes GATE 2 (Living Spec & Mission Approval) for all spec-altering changes. The phase is codified as a modular skill under `.agents/skills/jarn-consult/SKILL.md`.

The Consultation Phase:
- **Classifies** the request as Spike, Bounded, or Architectural before any spec work begins.
- **Probes** intent, constraints, edge cases, and success criteria through focused, one-at-a-time questions led by the AI.
- **Proposes** 2–3 implementation options with trade-offs and a clear recommendation.
- **Hands off** the gathered context to `jarn-spec` (GATE 2) for living spec synthesis — it does not write the spec itself.

The phase name **Consultation** (not Brainstorming) was chosen deliberately to align with Jarn's identity as "จารย์" (an expert advisor) — structured, purposeful expert inquiry rather than open-ended ideation.

The lifecycle becomes:

```
GATE 1 → GATE 2 → GATE 3 → GATE 4
```

## Consequences

- **Positive Consequences**:
  - AI-led requirement discovery becomes consistent across all models and sessions, eliminating model-dependent variance.
  - Junior developers can engage productively without needing to know what questions to ask upfront — the AI leads the inquiry.
  - Reduces Senior intervention burden: specs arrive at review with edge cases already surfaced.
  - Preserves the async document review loop and living spec pattern — Consultation is additive, not a replacement.
  - Token-efficient relative to Superpowers brainstorming: classify-first skips deep consultation for Spike and Bounded tasks.

- **Negative Consequences**:
  - Adds a mandatory pre-coding phase for architectural changes, increasing time-to-spec for cases where requirements are already clear.
  - Requires discipline to skip Consultation only for non-spec-altering changes (bug fixes, refactors) — misclassification risks bypassing discovery.

## Alternatives Evaluated & Trade-offs

- **Adopt Superpowers brainstorming skill verbatim**: Rejected. Superpowers brainstorming uses append-only design docs and synchronous chat as the primary medium, conflicting with Jarn's living spec pattern and async document review loop. It also lacks blast-radius scoping and does not integrate with GATE 0/1/2.

- **Rely on model capability**: Rejected. Leaving requirement discovery to model behavior produces inconsistent results — a core Jarn invariant is that governance rules, not model quality, determine process outcomes.

- **Extend jarn-spec with question prompts**: Rejected. Mixing discovery and specification synthesis in one skill conflates two distinct concerns: understanding what to build vs. documenting what was agreed. Separation keeps each skill focused and testable.
