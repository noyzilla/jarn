---
title: Two-Tier Review Model and Working Tree Loop Protocol
status: accepted
tags: [architecture, review, pair-programming, workflow, lifecycle]
synapses: ["CONTRIBUTING.md", "AGENTS.md", ".agents/rules/jarn-lifecycle.md", ".agents/rules/jarn-git.md", ".agents/rules/jarn-governance.md"]
---

# ADR 0007: Two-Tier Review Model and Working Tree Loop Protocol

- **Date**: 2026-09-28
- **Status**: Accepted

## Context & Problem Statement
In AI-assisted engineering workflows, premature commits introduce significant operational friction:
1. **The Premature Commit Trap**: When an AI agent modifies code, runs a narrow targeted test, and immediately commits, any subsequent reviewer feedback (such as design adjustments, edge-case fixes, or extended full-system test regressions) requires undoing the commit (`git reset`) or stacking noisy fixup commits.
2. **Conflation of Plan Approval and Commit Authority**: Approving an implementation plan was previously interpreted by agents as blanket authorization to commit directly to Git history without pausing for code diff inspection.
3. **Lack of Role Separation**: Engineering workflows naturally operate across two distinct review tiers:
   - **Inner Loop (Dev Pairing)**: Driver and Navigator collaborating on cohesive sub-tasks.
   - **Outer Loop (Senior / Lead Audit)**: Tech lead or security specialist auditing system-wide integrity, security compliance, and spec parity before merging into `main`.

## Decision
We adopt the **Two-Tier Review Model** and establish the **Working Tree Loop as the default protocol** for all tasks:

### 1. Tier 1: Dev Pairing in the Working Tree Loop (Inner Loop — GATE 2)
- **Working Tree Loop by Default**: All changes across the codebase (regardless of task type, layer, or file extension) remain uncommitted in the working tree by default across all tasks.
- **Plan Approval is for Coding, Not Committing**: Approving an implementation plan authorizes editing files and running self-verification in the working tree. It does not authorize Git commits.
- **Sub-task Milestone Micro-Commits**: When a feature comprises multiple sub-tasks, the Driver agent completes Sub-task 1 in the working tree, presents the uncommitted diff and verification logs, and awaits explicit confirmation (e.g., "approved", "commit ได้") before committing. Only then does development advance to Sub-task 2.
- **Extended Verification on Demand**: Reviewers may request full-system test suites or downstream integration checks while code is in the working tree. Discovered defects are resolved immediately without undo-commit ceremony.
- **No Fixup Noise (Amend Invariant)**: If minor adjustments are requested on a recently completed commit within the branch, the agent amends or soft-resets (`git reset --soft HEAD~1`) to maintain a clean, atomic commit rather than littering the history.
- **Auto-Commit Exception**: Autonomous commits without stopping for review are permitted strictly when an explicit auto-commit directive was provided upfront.

### 2. Tier 2: Senior / Lead Pre-Merge Audit (Outer Loop — GATE 3)
- **Macro System Integrity & Security Audit**: Conducted before merging into `main`. Evaluates whole-system behavior, security posture (secrets, authentication, authorization), architecture invariants, and Code-Spec Parity.
- **Role Agnosticism**: Conducted by the Senior Lead (human tech lead currently, or specialized AI Auditor/Security agents in multi-agent topologies).

## Consequences
- **Positive Consequences**:
  - **Zero Undo Friction**: Eliminates the frustration of instructing AI agents to undo premature commits.
  - **Ergonomic IDE Visibility**: Modified files remain highlighted in IDE file trees, enabling intuitive side-by-side inspection before committing.
  - **Pristine, Bisectable History**: Every commit represents a verified, human-inspected sub-task milestone.
  - **Agent-to-Agent Ready**: The protocol abstracts roles into Driver and Reviewer, allowing seamless transition from human-AI pairing to autonomous multi-agent pairing.
- **Negative Consequences / Trade-offs**:
  - Requires active human confirmation to proceed past sub-task commit boundaries, unless the human explicitly declares auto-commit upfront.

## Alternatives Evaluated & Trade-offs
- **Immediate Micro-Commits (Status Quo)**: Rejected due to frequent commit pollution, undo-commit overhead, and loss of working tree diff visibility during iterative review.
- **Big-Bang Commit at Task Completion**: Rejected because it sacrifices granular rollback checkpoints and makes bisecting complex features difficult.
