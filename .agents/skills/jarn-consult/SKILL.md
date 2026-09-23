---
name: jarn-consult
description: >-
  Activate before any spec-altering change to lead structured requirement discovery.
  Classifies the request, probes intent with focused questions, proposes implementation
  options, and hands off a clear agreement to jarn-spec for living spec synthesis.
---

# Jarn Consultation Workflow

> **Do not modify this file.** It is part of the Jarn framework and will be overwritten during framework updates (`jarn-framework-update` skill).

This skill defines the structured requirement discovery procedure executed before GATE 0 for all spec-altering changes. It ensures the AI leads the inquiry — not the human — making Jarn accessible to junior developers and producing better-scoped specs regardless of AI model.

## Core Philosophy

A living specification can only be as good as the requirements behind it. This skill exists to surface what the human has not yet articulated: edge cases, constraints, implicit assumptions, and architectural trade-offs. The AI acts as "จารย์" — an expert advisor who asks the right questions before prescribing a solution.

## When to Use This Skill

Activate this workflow when:
- Starting a new feature, subsystem, or capability (spec-altering change).
- Requirements feel unclear, incomplete, or contain implicit assumptions.
- A junior developer is initiating work and may not know what questions to ask.
- The request scope is ambiguous — could be a small fix or a large redesign.

Do NOT use this workflow when:
- Fixing a bug where the existing spec is already correct (spec-conforming fix — go straight to GATE 0).
- Performing internal refactoring or styling cleanup that preserves external behavior.
- Requirements have already been thoroughly discussed and a spec draft exists.

---

## Operational Execution Runbook

### Phase 0: Classification

Before asking any question, classify the request and **announce the classification out loud** so the human can override:

- **Spike** — A feasibility question or exploratory investigation. Output is an answer or recommendation, not a spec. Example: "Can we integrate X library?" or "Is this approach viable?"
  - Process: Ask one clarifying question if needed, investigate, report recommendation. No spec, no GATE 0.

- **Bounded** — A well-scoped change to an existing flow already present in the codebase. A single new flag, a small endpoint adjustment, a one-file behavioral change.
  - Process: Ask 2–3 focused questions, present a short in-chat design summary, get approval, hand off to `jarn-spec` for a compact living spec update.

- **Architectural** — A new subsystem, a new capability, changes that restructure how components interact, or anything that introduces new API contracts or state machines.
  - Process: Full consultation runbook below.

**Classification rule**: When in doubt between two levels, take the heavier path. Hidden complexity discovered mid-consultation upgrades the classification — stop, announce the upgrade, and restart the appropriate path.

---

### Phase 1: Discover Intent

Understand what the human is actually trying to accomplish before proposing anything.

- Read the request and available context (existing specs in `docs/specs/`, `CONTEXT.md`, `ARCHITECTURE.md`) to identify the intended outcome and who it serves.
- Ask **one focused question at a time**. Never dump multiple questions in a single message.
- Prioritize questions in this order:
  1. **Purpose**: Why is this needed? Who uses it? What does success look like?
  2. **Constraints**: What must not change? What are the performance, security, or compatibility boundaries?
  3. **Edge Cases**: What happens when input is missing, invalid, or arrives out of order?
  4. **Success Criteria**: How will we know it works correctly?

- Write back a short understanding summary after the first round of answers. Separate confirmed facts from assumptions. Invite correction before treating it as the brief.
- If the request describes multiple independent subsystems, flag this immediately and help decompose into sub-tasks before proceeding. Each sub-task follows its own Consultation cycle.

---

### Phase 2: Propose Options

Once intent is clear, present implementation approaches — do not propose a single solution.

- Propose **2–3 distinct approaches** with concrete trade-offs for each.
- Lead with a **clear recommendation** and explain why it fits this context.
- Apply YAGNI ruthlessly: remove unnecessary features, abstractions, or future-proofing from every option.
- Frame trade-offs in terms the human can evaluate: complexity, performance, maintainability, delivery speed.

Example structure:
```
Option A — [Name]: [One-line description]
  Trade-offs: [What you gain] vs [What you give up]

Option B — [Name]: [One-line description]
  Trade-offs: [What you gain] vs [What you give up]

Recommendation: Option A — because [specific reason tied to this project's context]
```

---

### Phase 3: Confirm Agreement

Before handing off, verify the agreed direction.

- Summarize the agreed intent, constraints, edge case handling, and chosen approach in 3–5 bullet points.
- Ask the human to confirm or correct. This is the last chance to adjust scope before spec writing begins.
- If the human requests changes, return to Phase 1 or Phase 2 as appropriate.

---

### Phase 4: Hand Off to jarn-spec

Once the human confirms the agreement:

- State clearly: "Consultation complete. Handing off to `jarn-spec` to synthesize the living specification."
- Pass the agreed context — intent, constraints, chosen option, edge cases, and success criteria — as the input brief for `jarn-spec`.
- Do NOT write the spec yourself. Spec synthesis is the responsibility of the `jarn-spec` skill.
- Activate `jarn-spec` to produce or update `docs/specs/<feature-slug>.md`.

---

## Red Flags

| Thought | Reality |
|---|---|
| "Requirements are clear enough, skip consultation" | Always classify first. Even a Spike needs a classification announcement. |
| "I'll ask all my questions at once to save time" | One question at a time. Batching overwhelms junior developers and produces shallow answers. |
| "I understand the request, I'll just propose a solution" | Probe intent first. Assumptions are the root cause of misaligned specs. |
| "This feels bounded, I'll skip the options step" | Bounded changes still need a short design presented for approval. |
| "The human approved the idea, so the spec is also approved" | Consultation approval permits spec drafting only. Spec approval is a separate gate in jarn-spec. |
| "I'll write a quick spec draft during consultation to save time" | Spec synthesis belongs to jarn-spec. Keep concerns separated. |
| "The scope grew, but I'm almost done asking" | Hidden complexity upgrades the classification mid-consultation. Announce and adjust. |

---

## Consultation Output Checklist

Before handing off to `jarn-spec`, verify all items are confirmed:

- [ ] Classification announced and accepted (Spike / Bounded / Architectural)
- [ ] Purpose and intended outcome confirmed
- [ ] Constraints and boundaries identified
- [ ] Key edge cases surfaced and agreed upon
- [ ] Success criteria defined
- [ ] 2–3 options proposed with trade-offs (Architectural path)
- [ ] Recommendation stated with reasoning
- [ ] Agreement summary confirmed by human
- [ ] Scope decomposed if multiple subsystems were identified
