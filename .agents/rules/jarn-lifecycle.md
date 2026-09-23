# Operational Lifecycle Gates

This document defines the four sequential phases every contributor and AI agent must follow from requirement discovery through knowledge capture. See [jarn-governance.md](jarn-governance.md) for safety boundaries and workflow rules.

## Lifecycle Overview

```
CONSULT → GATE 0 → GATE 1 → GATE 2
```

- **CONSULT**: Structured requirement discovery. AI leads inquiry, classifies scope, proposes options.
- **GATE 0**: Mission approval. Spec synthesized, implementation plan produced, human green light required.
- **GATE 1**: Surgical execution. Branch isolation, micro-commits, targeted verification.
- **GATE 2**: Knowledge capture. Code-spec parity, evidence attachment, TASK.md synchronization.

---

### CONSULT: Requirement Discovery (Pre-Gate-0)

- **Activate `jarn-consult` skill** before every spec-altering change (new features, behavioral shifts, API contract changes).
- Skip CONSULT only for spec-conforming bug fixes and internal refactors — changes where the spec is already correct and scope is unambiguous.
- The AI classifies the request (Spike, Bounded, or Architectural), probes intent through focused one-at-a-time questions, and proposes 2–3 implementation options with trade-offs before any spec work begins.
- **Output**: A confirmed agreement — intent, constraints, edge cases, chosen approach, and success criteria — ready to hand off to `jarn-spec`.
- CONSULT operates entirely within Inquiry Mode. No codebase mutations occur during this phase.

---

### GATE 0: Mission Approval (The Hard Stop)

- **Anti-Hallucination Discovery**: Empirically verify library versions, external APIs, and project configurations via terminal commands or official docs before proposing solutions. Never guess dependencies or symbols.
- Research the task using read-only operations.
- Produce or update the living specification in `docs/specs/<feature>.md` when defining or altering feature logic.
- Produce a structured implementation plan describing proposed technical changes, demarcating modified files and explicit verification steps.
- **Hard Stop**: Halt execution and wait for explicit human green light (Directive Mode) before touching codebase files. Refine the plan if feedback or counter-proposals are given.

---

### GATE 1: Self-Verification & Surgical Execution

- **Step 0 Branch Isolation**: Before modifying, creating, or deleting any codebase file, verify `git branch --show-current`. If on `main`, immediately execute `git checkout -b <type>/<slug>`. Working directly on `main` is strictly prohibited.
- **Incremental Micro-Commits**: Save commits in small, logical, atomic increments as intermediate milestones are verified. Never hold large uncommitted changes until final completion.
- Make minimal, modular edits focused strictly on the approved scope.
- **Targeted Verification**: Check `git status` before running verification commands. Execute project-native test suites and linters via terminal to verify Exit Code 0 and zero regression.

---

### GATE 2: Knowledge Capture & Parity

- **Code-Spec Parity Verification**: Ensure code implementations match living specs in `docs/specs/`.
- **Evidence Attachment**: Attach empirical test execution logs demonstrating clean passing results (Exit Code 0).
- **Task State Synchronization**: Before concluding any session or task, the agent MUST update `TASK.md` in the project root to reflect the newly completed milestones and immediate next actions.
- **Task State Quality Bar**: Every backlog item and next action in `TASK.md` must be specific enough for another contributor or agent to pick up without further clarification. Each item must include a clear deliverable scope (e.g., which files, modules, or contracts are affected). Vague entries such as "add configuration" or "improve tests" without qualifying which configuration or which test surface are prohibited.
- **Task State Pruning**: The `Completed Milestones` section in `TASK.md` acts as a short-term buffer. It MUST be cleared/pruned immediately after a formal Release is cut (and recorded in `CHANGELOG.md`) to prevent infinite file growth.
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
