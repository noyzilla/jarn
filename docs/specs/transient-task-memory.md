---
title: Transient Task Memory and Scratch Workspace
status: active
tags: [spec, scratch, tasks, issues, lifecycle, naming]
synapses: ["docs/adr/0009-transient-task-memory-and-scratch-architecture.md", ".agents/rules/jarn-lifecycle.md", ".agents/rules/jarn-naming.md", ".agents/rules/jarn-governance.md"]
---

# Specification: Transient Task Memory and Scratch Workspace

- **Status**: Active
- **Last Verified**: 2026-10-02
- **Target Audience**: Developers, Operators, and AI Coding Agents

## Overview & Scope
This specification defines the runtime structure, lifecycle postfix invariants, and workflow state machines for transient task execution workspaces residing under `.scratch/<task-slug>/`. It formalizes the discrete issue model, the Never Derail workflow, sandbox isolation for throwaway artifacts, and the zero-token filtering protocol for both CLI agents and GUI Kanban dashboards.

## Domain Context & Ubiquitous Language
- **Transient Memory**: Scratch space ignored from Git (`.gitignore`) dedicated to active in-flight task execution.
- **Task Workspace**: A dedicated directory `.scratch/<task-slug>/` scoped 1:1 to the active Git branch.
- **Issue Unit**: An isolated, vertical slice markdown file inside `issues/` containing explicit intent, target files, acceptance criteria, and targeted verification commands.
- **Lifecycle Postfix**: A semantic extension appended before `.md` (`XXXX-<slug>.<postfix>.md`) indicating issue state for zero-token scanning.
- **Zero Root Pollution**: A strict invariant prohibiting the creation of temporary scripts, mock payloads, or test runners directly in the repository root.

## Architecture & Directory Topology

```text
.scratch/<task-slug>/
├── plan.md               # Branch mission overview, scope bounds, and issue manifest
├── issues/               # Strictly discrete issue markdown files (XXXX-*.md)
│   ├── 0001-user-schema.done.md
│   ├── 0002-jwt-token.blocked.md
│   └── 0003-login-endpoint.md
└── tmp/                  # Strictly throwaway scripts, mock payloads, and diagnostic logs
    ├── repro.py
    ├── mock-payload.json
    └── trace.log
```

## Business Rules & Logic Invariants

### 1. Directory Structure Invariants
- **`issues/` Invariant**: Contains strictly `.md` issue files. Scripts, JSON payloads, and logs are strictly prohibited inside `issues/`.
- **`tmp/` Invariant**: Contains all temporary helper scripts (`.py`, `.sh`), payloads (`.json`, `.sql`), and log dumps. Loose throwaway files placed directly in `.scratch/<task-slug>/` or the repository root are strictly prohibited.
- **Root Cleanliness Invariant**: Zero temporary or scratch files permitted in the project root.
- **Dynamic Scoping & Template Archetypes**: The `.scratch/<task-slug>/` directory is created dynamically during GATE 1. Static blueprints for plans and issues reside in `.agents/templates/scratch/plan.md` and `.agents/templates/scratch/issue.md`. No static template files reside inside `.scratch/`.

### 2. Filename Lifecycle Postfix Invariants (Zero-Token Scanning)
The leading 4-digit zero-padded index (`XXXX-`) remains permanent and must not change during state transitions:

| Postfix | State | Description & Transition Rule |
| :--- | :--- | :--- |
| `[none]` (`.md`) | **Pending / Ready** | Active in queue, ready for implementation. |
| `.blocked.md` | **Blocked** | Blocked by prerequisite issue; must declare `blocked_by: [...]` in frontmatter. |
| `.done.md` | **Completed** | Code implemented, companion tests passing (Exit Code 0), and micro-committed. |
| `.deferred.md` | **Deferred** | Scope postponed to a subsequent branch/epic; recorded in root `TASK.md`. |
| `.dropped.md` | **Dropped / Won't Do** | Evaluated and cancelled (YAGNI). |

### 3. Anti-Deadlock & Safety Invariants
- **Anti-Cycle Invariant (DAG)**: Issue blocking relationships must form a Directed Acyclic Graph. Circular dependencies (`A -> B -> A`) are strictly invalid.
- **Max Block Depth = 2**: If an issue blocking chain exceeds depth 2 (Blocker's Blocker blocked), it signals an architectural foundation failure. The agent MUST trigger a Stop & Ask escalation, halt execution, and reset to GATE 1.

### 4. Never Derail Workflow
- When unexpected defects, missing helpers, or in-scope sub-tasks emerge during development (GATE 2), the agent creates a new issue file (`XXXX-<slug>.md`) in `issues/` rather than derailing the active work.
- The agent completes the current issue to clean `.done.md` before picking up the newly queued issue in sequence.

## Interface & YAML Frontmatter Schema

Each issue file in `.scratch/<task-slug>/issues/` must contain valid YAML frontmatter:

```yaml
---
id: "0001"
title: "Issue Title"
status: ready               # ready | in_progress | blocked | done | deferred | dropped
target_files:
  - "src/domain/user.ts"
  - "tests/domain/user.test.ts"
depends_on: []
blocked_by: []
tags: [auth, schema]
synapses: ["docs/specs/authentication.md"]
---
```

## Dependency & Blast-Radius Matrix

- **Upstream Callers (Inbound)**: AI coding agents during GATE 1 (Plan Synthesis), GATE 2 (Execution), and GATE 3 (Knowledge Capture). Local Kanban dashboards and mission control tools.
- **Downstream Dependencies (Outbound)**: Project-native test runners, linters, Git commit ceremonies.
- **Bounded Blast Radius**: `.scratch/` is git-ignored and leaves zero traces in production code or Git history.

## Targeted Verification & Acceptance Criteria

- **Git-Ignored Verification**: Verify `git status` shows zero uncommitted entries when writing to `.scratch/`.
- **Root Cleanliness Check**: `git status --short` must report no loose scratch files in the project root.
