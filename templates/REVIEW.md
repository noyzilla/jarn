# Code Review & Pre-Merge Checklist [รายการตรวจทานโค้ดก่อนรวมงาน]

This document provides the standard pre-merge checklist for contributors and reviewers (human engineers and AI agents) before merging pull requests.

It inherits the **Universal Code Review & Pre-Merge Standard** from [.agents/rules/jarn-testing.md](.agents/rules/jarn-testing.md).

> **Do not modify `.agents/rules/jarn-*.md` or `.agents/skills/jarn-*/SKILL.md` directly.** Those files are part of the Jarn framework and will be overwritten during framework updates (`jarn-framework-update` skill). Add project-specific checks in the "Project-Specific Review Extensions" section below only.

## How to Use This Checklist [วิธีใช้รายการตรวจทาน]

- Complete all universal gates in [.agents/rules/jarn-testing.md](.agents/rules/jarn-testing.md) first.
- Then check every applicable item in the project-specific section below.
- Any deliberate deviation or deferred check must be justified explicitly in the pull request description.

---

## Universal Quality Gates (Inherited from .agents/rules/jarn-testing.md)

Please review and check all items defined in the Universal Quality Gates: [.agents/rules/jarn-testing.md](.agents/rules/jarn-testing.md).

---

## Project-Specific Review Extensions [การส่วนขยายเฉพาะโปรเจกต์]

Add custom review gates, domain compliance checks, performance budgets, or security audits specific to this project below. Do not copy items from `jarn-testing.md` — they are already covered by the universal gates above.

- [ ] **UI Visual Proof (When Applicable)**: For user-visible UI changes, before and after screenshots or recordings are attached in the PR description, complying with tokens in `DESIGN.md`.
- [ ] **Domain Invariants**: Business constraints and state transitions match the subsystem specification in `docs/specs/`.
