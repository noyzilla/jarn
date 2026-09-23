# Code Review & Pre-Merge Checklist [รายการตรวจทานโค้ดก่อนรวมงาน]

This document provides the standard pre-merge checklist for contributors and reviewers (human engineers and AI agents) before merging pull requests.

It inherits the **Universal Quality Gates & Pre-Merge Standard** from [.agents/rules/jarn-quality.md](.agents/rules/jarn-quality.md).

> **Do not modify `.agents/rules/jarn-*.md` or `.agents/skills/jarn-*/SKILL.md` directly.** Those files are part of the Jarn framework and will be overwritten during framework updates. Add project-specific checks in the "Project-Specific Review Extensions" section below only.

## How to Use This Checklist [วิธีใช้รายการตรวจทาน]

- Complete all universal gates in [.agents/rules/jarn-quality.md](.agents/rules/jarn-quality.md) first.
- Then check every applicable item in the project-specific section below.
- Any deliberate deviation or deferred check must be justified explicitly in the pull request description.

---

## Universal Quality Gates (Inherited from .agents/rules/jarn-quality.md)

Please review and check all items defined in the Universal Quality Gates: [.agents/rules/jarn-quality.md](.agents/rules/jarn-quality.md).

---

## Project-Specific Review Extensions [การส่วนขยายเฉพาะโปรเจกต์]

The items below apply to contributors modifying the **Jarn framework itself**. Downstream projects should replace these with their own project-specific checks.

- [ ] **Shell Script Compatibility**: Tested `jarn.sh` on both macOS (`zsh`) and Linux (`bash`).
- [ ] **No Unbound Variables**: Checked that all variables are correctly quoted and scripts run safely under `set -e`.
- [ ] **Template Sanitization**: Ensured that any new `.md` files that are project-specific are also placed into `templates/` as blank generics so downstream users don't inherit Jarn-specific metadata.
- [ ] **Agent File Size Compliance**: All `.agents/rules/` and `.agents/skills/` files are below the 8,000 character soft limit — verified with `wc -m .agents/rules/jarn-*.md .agents/skills/jarn-*/SKILL.md`. Any file between 8,000–12,000 characters has a documented split plan. No file exceeds the 12,000 character hard limit. See [docs/specs/agent-file-standards.md](docs/specs/agent-file-standards.md).
