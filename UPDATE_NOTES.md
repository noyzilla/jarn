# Jarn Update Notes

## [v0.3.0] - Core Rules Architecture Overhaul
This update provides critical migration instructions for downstream projects to align with the new Jarn rules architecture.

### Rule Directory Flattening (Shallow Scan Compatibility)
To ensure compatibility with AI agents that only perform shallow scans of customization roots, the `jarn` rules have been flattened from `.agents/rules/jarn/*.md` to `.agents/rules/jarn-*.md`.

**AI Directive**:
1. Scan the project's root `AGENTS.md` file, as well as any custom skills, for references to `.agents/rules/jarn/` and rewrite them to `.agents/rules/jarn-`. (e.g., `.agents/rules/jarn/review.md` becomes `.agents/rules/jarn-testing.md`).
2. Delete the old `.agents/rules/jarn/` directory.

### Anti-Duplication Action Required
If your project currently has hardcoded Jarn rules (e.g. Pre-Merge Quality Gates checklists) in the `REVIEW.md` or `CONTRIBUTING.md` files at the root of your project, you must remove them.

The new standard dictates a single-source-of-truth. Replace any duplicated content with direct Markdown links to the central standard files:
- `[.agents/rules/jarn-testing.md](.agents/rules/jarn-testing.md)`
- `[.agents/rules/jarn-coding.md](.agents/rules/jarn-coding.md)`

**AI Directive**: Proactively check the project's root `REVIEW.md` and `CONTRIBUTING.md`. If they contain redundant checklists or rules, remove them and replace them with standard Jarn links. Ask the user for permission to apply the fix automatically.

### Document Template Modernization
The templates for Architectural Decision Records (ADRs) and Living Specifications have been standardized to require YAML Frontmatter and to eliminate redundant system rules (such as `Filename Lifecycle`).

**AI Directive**: 
1. Scan the `docs/decisions/` and `docs/specs/` directories to add standard YAML frontmatter to any markdown files missing it, and remove any inline `- **Filename Lifecycle**:` sections.
2. Scan the `docs/` and `templates/` directories for any `*.pending-merge` files. These contain upstream template updates. Intelligently merge the structural changes from the `.pending-merge` files into the existing files without destroying user-specific customizations, then delete the `.pending-merge` files.
Ask the user for permission to apply these format standardizations and merges.
