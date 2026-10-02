---
title: Linear Version Lifecycle and Graph-Governed Concurrency
status: accepted
tags: [architecture, git, versioning, workflow, lifecycle]
synapses: ["ARCHITECTURE.md", "README.md", "CONTRIBUTING.md", ".agents/rules/jarn-governance.md"]
---

# ADR 0006: Linear Version Lifecycle and Graph-Governed Concurrency

- **Date**: 2026-09-27
- **Status**: Accepted
- **Parent Reference**: [ARCHITECTURE.md](../../ARCHITECTURE.md)

## Context & Problem Statement
In an AI-native engineering environment, managing codebase and task concurrency requires high predictability, deterministic reference points, and minimal context ambiguity. Multi-track branching structures with long-lived parallel integration branches and unbounded task concurrency introduce several operational challenges:
1. **Context Drift & Ambiguity**: Long-lived parallel branches obscure the canonical source of truth, increasing AI hallucination risks and wasting token context.
2. **Cross-Branch Synchronization Overhead**: Maintaining multiple concurrent branches increases synchronization friction and integration complexities.
3. **Unbounded Concurrency**: In engineering workflows, tasks are often parallelized arbitrarily despite overlapping dependencies. For AI agents, concurrent edits on coupled modules trigger race conditions and invalidate working assumptions.

## Decision
We adopt a unified architectural model that couples a **Linear Version Lifecycle** with **Graph-Governed Concurrency**, minimizing concurrent state across both code evolution and task execution:

1. **Linear Version Model**:
   > *"A new release supersedes the previous release. Development proceeds forward on a single canonical line; Jarn does not maintain parallel version branches unless explicitly required by an external compatibility obligation."*
   - `main` serves as the single canonical line of development and the absolute source of truth.
   - Once a new version is released, previous versions are treated as immutable historical snapshots rather than parallel maintenance lines.
   - Hotfixes follow standard forward progression: branch from `main`, apply the surgical fix through GATE 1 → GATE 2 → GATE 3, and merge forward.
   - Maintenance branches for older versions are treated as explicit, justified exceptions governed by external contractual or regulatory obligations (e.g., Enterprise LTS SLA), never as the default topology.

2. **Serial by Default Task Execution**:
   - Tasks flow sequentially in cohesive vertical slices. Limiting work-in-progress (WIP) ensures the codebase context remains stationary and deterministic during an agent's execution lifecycle.

3. **Graph-Governed Concurrency**:
   - Concurrency is strictly permitted only when the living specification's **Dependency & Blast-Radius Matrix** proves that tasks are mathematically orthogonal:
     $$\text{Allow Parallelism} \iff \text{BlastRadius}(Task_A) \cap \text{BlastRadius}(Task_B) = \emptyset$$
   - If tasks share affected files, domain boundaries, or shared schema contracts, execution must be serialized.

## Consequences
- **Positive Consequences**:
  - **Deterministic AI Context**: AI agents always reference a stationary, settled baseline on `main`, eliminating moving-ground hallucinations.
  - **Zero Cross-Branch Drift**: Development advances on a single timeline without branch divergence.
  - **Automated SemVer**: Versioning flows monotonically from Conventional Commits directly on `main` via `jarn-release`.
  - **Clean Cognitive Load**: Human engineers and agents reason about one timeline instead of juggling divergent branch states.
- **Negative Consequences / Trade-offs**:
  - Organizations requiring simultaneous multi-minor backporting must explicitly manage maintenance branches outside the standard automated loop.
  - Requires rigor during GATE 1 to map the Dependency & Blast-Radius Matrix before attempting concurrent execution.

## Alternatives Evaluated & Trade-offs
- **Multi-Track Long-Lived Branching**: Evaluated and set aside due to branch drift, context duplication, and friction with AI agent token windows.
- **Unbounded Trunk Parallelism**: Evaluated and rejected because allowing multiple agents or developers to touch coupled modules concurrently without graph governance leads to silent regressions and integration failures.
