---
title: Transient Task Memory and .scratch Directory Architecture
status: accepted
tags: [architecture, workflow, ai-agent, scratch, tasks, issues, naming]
synapses: ["ARCHITECTURE.md", "AGENTS.md", ".agents/rules/jarn-lifecycle.md", ".agents/rules/jarn-governance.md", ".agents/rules/jarn-naming.md", "docs/specs/agent-file-standards.md"]
---

# ADR 0009: Transient Task Memory and .scratch Directory Architecture

- **Date**: 2026-10-02
- **Status**: Accepted

## Context & Problem Statement
In autonomous AI pair-programming and complex software engineering, three operational frictions frequently emerge:

- **Monolithic Task Pollution**: Consolidating all tasks and sub-tasks into a single root `TASK.md` creates token-heavy markdown files, lacks granular acceptance criteria, and forces awkward pre-merge cleanup ceremonies.
- **Root Directory Clutter**: AI coding agents habitually create temporary scratch files, mock JSON payloads, reproduction scripts, and debug logs directly in the project root, creating noise in `git status` and risking accidental commits.
- **Derailment on Mid-flight Discoveries**: When unexpected bugs or new sub-requirements emerge during development, agents frequently lose focus on the active task, descending into recursive fixes without clear bounds.

## Decision
We establish the **Transient Task Memory Architecture** using a Git-ignored `.scratch/<task-slug>/` directory scoped 1:1 per branch/task:

- **Strict Task Workspace Layout**:
  - `plan.md`: Mission objective, scope, and dependency manifest for the active branch.
  - `issues/`: Discrete, vertical slice issue markdown files (`XXXX-<slug>.<postfix>.md`) with isolated context, acceptance criteria, and verification commands.
  - `tmp/`: Dedicated sandbox for all temporary scripts (`.py`, `.sh`), mock payloads (`.json`, `.sql`), and diagnostic logs. Creating throwaway files in the project root is strictly prohibited.
- **Zero-Token Filename Lifecycle Postfixes**:
  - `[None]` (`.md`): Ready / Pending in queue.
  - `.done.md`: Completed, self-verified (Exit Code 0), and committed.
  - `.blocked.md`: Blocked by a prerequisite issue (explicitly declared via `blocked_by: [...]`).
  - `.deferred.md`: Postponed to a subsequent branch/epic.
  - `.dropped.md`: Cancelled or marked won't do (YAGNI).
- **Safety Invariants & Anti-Deadlock**:
  - **Anti-Cycle Invariant (DAG)**: Circular blocking relationships are strictly prohibited.
  - **Max Block Depth = 2**: If an issue chain exceeds depth 2 (Blocker's Blocker blocked), it indicates architectural failure. The agent must halt (Stop & Ask Escalation) and reset to GATE 1.
- **Never Derail Workflow**: Mid-flight discoveries are appended as new issue files in `issues/` rather than derailing the active work.
- **Clean GATE 3 Knowledge Capture**: When all issues in `.scratch/<task-slug>/issues/` are `.done.md`, living specs in `docs/specs/` and `CHANGELOG.md` are updated, while `.scratch/` remains git-ignored with zero git cleanup ceremony.

## Consequences
- **Positive Consequences**:
  - Project root remains 100% pristine and free of temporary AI artifacts.
  - Zero git diff pollution during task tracking and sub-task sequencing.
  - Discrete issue files conserve AI context tokens and eliminate derailment.
  - Deterministic status tracking enables local-first Kanban dashboards and multi-project mission control tools.
- **Negative Consequences / Trade-offs**:
  - Requires developers and AI agents to adhere strictly to `.scratch/<task-slug>/` layout rather than placing throwaway files arbitrarily.
