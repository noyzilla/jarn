---
title: Event-Driven Handoff Protocol
status: accepted
tags: [architecture, collaboration, workflow]
synapses: ["AGENTS.md", "CONTRIBUTING.md"]
---

# ADR 0005: Event-Driven Handoff Protocol

- **Date**: 2026-09-23
- **Status**: Accepted
- **Parent Reference**: [CONTRIBUTING.md](../../CONTRIBUTING.md)

## Context & Problem Statement
Open-source projects and AI-driven development workflows require flexible collaboration models. Traditional rigid "Solo" vs "Team" configurations fail to capture the fluid nature of decentralized contributions. When an AI agent or a solo developer works on a task, they should not be burdened with bureaucratic handoff steps. However, when a project requires specific quality gates (e.g., QA testing) or when a human contributor wishes to intervene, there must be a standardized mechanism to pause the flow and hand over the context.

## Decision
We adopt the **Event-Driven Handoff Protocol**, moving away from strict "Solo vs Multi-Role" toggles. 

1. **Continuous Flow (Default)**: By default, developers and AI agents assume a single-flow execution model. They implement the code, run local verification, and merge autonomously without waiting for handoffs. This ensures zero friction for solo contributors.
2. **Brake Flow (Handoff Interruption)**: The continuous flow is interrupted only under two events:
   - **Defined Roles**: The project's `CONTRIBUTING.md` explicitly lists active roles (e.g., `qa`, `reviewer`) that mandate a handoff at a specific stage.
   - **Human Intervention**: A user explicitly commands the agent to halt and perform a handoff.
3. **Handoff Mechanism**: When a handoff is triggered, the contributor commits their work using the `handoff(<target>): <message>` convention (e.g., `git commit -m "handoff(qa): ready for UI testing"`), pushes to origin, and halts execution.

## Consequences
- **Positive Consequences**: 
  - Zero overhead for solo projects.
  - Seamless scalability from a single developer to a distributed multi-role team.
  - Clear, actionable triggers for both human engineers and AI agents reading `CONTRIBUTING.md`.
- **Negative Consequences**: 
  - Requires discipline in writing clear commit messages (`handoff(...)`) to trigger downstream actions.

## Alternatives Evaluated & Trade-offs
- **Strict Topology Configuration (Solo vs Multi-Role Toggle)**: We initially considered a project-level configuration switch. This was rejected because it imposes an artificial "closed-team" paradigm onto open-source projects, where anyone should be able to jump in and help at any time.
