# Contributing Guidelines

Thank you for contributing to this project. All contributors (human engineers and AI coding assistants) operate under the same engineering standards to ensure high architectural integrity.

## AI Usage Policy & Contributor Accountability

Contributions prepared with the assistance of generative AI tools are welcomed, under the following conditions:

- **Full Contributor Accountability**: The submitter is 100% responsible for every line of code, test, and documentation in the pull request.
- **No Incomplete AI Slop**: Pull requests containing incomplete implementations, speculative changes, unverified code, or starter scaffolding expecting others to finish will be closed immediately.
- **Focused Scope**: Submit single, focused changes linked to an approved issue or task. Do not include unrelated reformatting or stylistic churn.
- **Verification Mandatory**: All contributions must include test coverage and pass all automated verification checks before submission.

## Engineering Standards

This repository enforces unified engineering conventions:

- For commit formats and SemVer rules, see [.agents/rules/jarn-git.md](.agents/rules/jarn-git.md#commit-conventions).
- For documentation and commenting rules, see [.agents/rules/jarn-coding.md](.agents/rules/jarn-coding.md#documentation--commenting-rules).
- For ecosystem lifecycle guidelines, see [.agents/rules/jarn-architecture.md](.agents/rules/jarn-architecture.md#ecosystem-native-lifecycle-contract).

## Collaboration Topology (Team Roles & Workflow)

Projects following the Jarn framework can operate under two collaboration topologies. The appropriate workflow depends on team structure:

1. **Solo / Full-Stack Workflow (Default)**
   - **Structure**: A single human or AI agent owns the task from start to finish.
   - **Execution**: The agent writes code, verifies via tests, audits against `REVIEW.md` (GATE 3), and performs the merge independently. No handoff signals are required.

2. **Multi-Role Workflow (Opt-in for distributed teams)**
   - **Structure**: The project designates specific roles (e.g., Dev, QA, Reviewer) based on team composition.
   - **Task Scoping (1 Branch = 1 Task)**: Developers must create a branch-scoped `TASK.md` (using `templates/task.md`) when branching out. This file serves as the state machine for the branch.
   - **Handoff Execution**: Dev agents **MUST NOT** merge code themselves. When ready for testing or review, the Dev commits with the `handoff(<target>): <message>` convention (e.g., `handoff(qa): ready for UI tests`).
   - **QA / Review Cycle**: The target role pulls the branch, checks off items in the branch's `TASK.md`, and hands it back (`handoff(dev): failed tests`) or approves it for merge.

## Pull Request Workflow [ขั้นตอนการส่งงาน Pull Request]

### Branch Isolation & Lifecycle
All work must be conducted within isolated branches branched from `main`. Direct commits or pushes to `main` are strictly forbidden (Step 0 Invariant). See [.agents/rules/jarn-governance.md](.agents/rules/jarn-governance.md).

### Incremental Micro-Commits
See [.agents/rules/jarn-git.md](.agents/rules/jarn-git.md#commit-frequency--granularity-micro-commit-strategy).

### Pre-Submission Verification
Before opening a pull request, run the active verification commands configured for this project in [AGENTS.md](AGENTS.md#project-execution-commands).

### Pre-Merge Quality Checklist
Verify that your pull request satisfies all quality gates defined in the pre-merge checklist:
- Universal Pre-Merge Quality Gates: [.agents/rules/jarn-quality.md](.agents/rules/jarn-quality.md)
- Project Pre-Merge Checklist: [REVIEW.md](REVIEW.md)
