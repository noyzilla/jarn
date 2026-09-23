# Contributing Guidelines

Thank you for contributing to this project. All contributors (human engineers and AI coding assistants) operate under the same engineering standards to ensure high architectural integrity.

## AI Usage Policy & Contributor Accountability

Contributions prepared with the assistance of generative AI tools are welcomed, under the following conditions:

- **Full Contributor Accountability**: The submitter is 100% responsible for every line of code, test, and documentation in the pull request.
- **No Incomplete AI Slop**: Pull requests containing incomplete implementations, speculative changes, unverified code, or starter scaffolding expecting others to finish will be closed immediately.
- **Focused Scope**: Submit single, focused changes linked to an approved issue or task. Do not include unrelated reformatting or stylistic churn.
- **Verification Mandatory**: All contributions must include test coverage and pass all automated verification checks before submission.

### Jarn Specific Guidelines
When contributing to this specific repository (`jarn`), please note:
- **Root `*.md` Files**: Describe the Jarn project itself.
- **`templates/` Directory**: Contains the generic versions of files that get copied to downstream projects when running `init.sh`. If you add a new project-level generic `.md` file, place it in `templates/` to prevent Jarn-specific metadata from leaking into downstream projects.

## Engineering Standards

This repository enforces unified engineering conventions:

- For commit formats and SemVer rules, see [.agents/rules/jarn-git.md](.agents/rules/jarn-git.md#commit-conventions).
- For documentation and commenting rules, see [.agents/rules/jarn-coding.md](.agents/rules/jarn-coding.md#documentation--commenting-rules).
- For ecosystem lifecycle guidelines, see [.agents/rules/jarn-architecture.md](.agents/rules/jarn-architecture.md#ecosystem-native-lifecycle-contract).

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
