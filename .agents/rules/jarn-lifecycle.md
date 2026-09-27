# Operational Lifecycle Gates

> **Do not modify this file.** It is part of the Jarn framework and will be overwritten during framework updates (`jarn-framework-update` skill). Extend project-specific gates through your project's `REVIEW.md` only.

This document defines the three sequential operational gates every contributor and AI agent must follow from requirement discovery and specification through knowledge capture. See [jarn-governance.md](jarn-governance.md) for safety boundaries and workflow rules.

## Lifecycle Overview

```
GATE 1 → GATE 2 → GATE 3
```

- **GATE 1: Living Spec & Mission Approval**: Requirement discovery, brainstorming, and living spec synthesis. The AI leads inquiry and brainstorms options (`jarn-consult`), acts as a Socratic coach, and synthesizes living specs (`jarn-spec`) and implementation plans. Human green light required before touching application code.
- **GATE 2: Surgical Execution & Self-Verification**: Branch isolation, micro-commits, targeted verification, test suite Exit Code 0.
- **GATE 3: Knowledge Capture & Pre-Merge Audit**: Code-spec parity, TASK.md synchronization, universal quality gate checklist audit (`jarn-review`).

---

### GATE 1: Living Spec & Mission Approval (The Specification Gate)

- **Consultation & Brainstorming Protocol**:
  - Activate `jarn-consult` skill before every spec-altering change (new features, behavioral shifts, API contract changes).
  - Skip consultation only for spec-conforming bug fixes, internal refactors, or emergency production hotfixes where the spec is already correct and scope is unambiguous.
  - The AI classifies the request (Spike, Bounded, or Architectural), probes intent through focused one-at-a-time questions, brainstorms creative and architectural approaches, challenges assumptions, and proposes 2–3 implementation options with concrete trade-offs before any spec work begins.
  - Evaluates viability early: determines whether the request should proceed, be deferred, or marked "won't do" (YAGNI filter).
- **Anti-Hallucination Discovery & Research**:
  - Empirically verify library versions, external APIs, and project configurations via terminal commands or official docs before proposing solutions. Never guess dependencies or symbols.
  - Research the task using read-only operations.
- **Living Spec & Plan Synthesis**:
  - Produce or update the living specification in `docs/specs/<feature>.md` using `docs/specs/0000-template.md` (`jarn-spec`).
  - Produce a structured implementation plan describing proposed technical changes, demarcating modified files and explicit verification steps.
- **Hard Stop**: Halt execution and wait for explicit human green light (Directive Mode) before touching codebase files. If review feedback or inline comments are received on the spec, iterate within GATE 1 until consensus is reached.
- GATE 1 operates entirely within Inquiry Mode. No codebase mutations occur during this gate.

---

### GATE 2: Surgical Execution & Self-Verification (The Dev Pairing Gate)

- **Step 0 Branch Isolation**: Before modifying, creating, or deleting any codebase file, verify `git branch --show-current`. If on `main`, immediately execute `git checkout -b <type>/<slug>`. Working directly on `main` is strictly prohibited.
- **Working Tree Loop by Default**: All changes across the codebase (regardless of task type, layer, or file extension) remain in the working tree uncommitted by default. Approving an implementation plan (GATE 1 green light) authorizes coding and self-verification in the working tree only; it does NOT grant blanket commit authority.
- **Sub-task Micro-Commit Sequencing**: When a task encompasses multiple sub-tasks, the Driver agent works on Sub-task 1 in the working tree, runs targeted verification, and presents the uncommitted diff and status for the Navigator (Human Lead or Peer Reviewer Agent) to review. Only upon explicit confirmation (e.g., "approved", "commit ได้") does the agent commit Sub-task 1 before advancing to Sub-task 2.
- **Extended Verification on Demand**: The Navigator may request whole-system tests, downstream regression checks, or integration inspections while code is in the working tree. Defect fixes occur immediately in the working tree with zero undo-commit overhead.
- **No Fixup Noise (Amend Invariant)**: If adjustments are requested on a recently completed commit within the active branch, amend or soft-reset (`git reset --soft HEAD~1`) to maintain clean, atomic commits rather than stacking fragmented fixup commits.
- **Auto-Commit Exception**: The agent may commit automatically without stopping for review only when an explicit auto-commit directive was provided upfront.
- **Surgical Edits**: Make minimal, modular edits focused strictly on the approved scope.
- **Targeted Verification**: Check `git status` before running verification commands. Execute project-native test suites and linters via terminal to verify Exit Code 0 and zero regression.

---

### GATE 3: Knowledge Capture & Pre-Merge Audit (The Senior / Lead Review Gate)

- **Senior / Lead Authority**: Macro-level system inspection conducted by the Senior Lead (human tech lead currently, or specialized AI Auditor/Security agent in multi-agent topologies) before integrating changes into `main`.
- **System-wide Integrity & Security**: Verify that modified modules do not cause downstream regressions, secret leaks, or contract breakages across the entire application.
- **Code-Spec Parity Verification**: Ensure code implementations match living specs in `docs/specs/`.
- **Evidence Attachment**: Attach empirical test execution logs demonstrating clean passing results (Exit Code 0).
- **Pre-Merge Audit Execution**: Activate and fulfill the universal quality gate checklist in [jarn-quality.md](jarn-quality.md) and project extensions in `REVIEW.md` via the `jarn-review` skill.
- **Continuous Flow (Default)**: By default, agents complete GATE 3, audit against `REVIEW.md`, and execute the merge autonomously once authorized by the Senior/Lead role.
- **Handoff Interruption (Brake Flow)**: An agent MUST NOT merge the code, and instead MUST halt execution and perform a handoff if:
  - `CONTRIBUTING.md` explicitly lists project roles that mandate a handoff at this stage (e.g., a required QA step).
  - The human user explicitly instructs the agent to halt or perform a handoff.
- **Handoff Execution**: To hand off work, the agent must:
  - Update the branch-scoped `TASK.md` to reflect the completed state for the next role.
  - Execute a `handoff(<target>): <message>` commit (e.g., `git commit -m "handoff(qa): ready for testing"`).
  - Push to origin and halt execution, waiting for the target role to pick up the branch.
- **Task State Pruning**: Before final merge into `main`, branch-scoped `TASK.md` files should be deleted (or their checklists cleared) to keep the repository history clean. The root `TASK.md` serves only as a high-level project roadmap.
- Provide a concise walkthrough of changes and test results, then conclude the task cleanly.

---

## Definition of Done (DoD)

A task is considered complete only when all the following criteria are satisfied:

- **Evidence-Based Completion**: Concrete empirical evidence (passing test suite output, compiler logs, or behavioral confirmation) must be produced. A task is never marked done based solely on code generation without verification.
- **Blast-Radius Verification**: Verification commands strictly matched the modified surfaces without executing unrelated checkers.
- All unit and integration tests pass without failure.
- Static analysis and code formatting checks pass cleanly.
- New or modified logic includes adequate test coverage.
- Related documentation (`ARCHITECTURE.md`, `DESIGN.md`, or `docs/`) is synchronized.
- Git commit messages comply with project commit conventions.
