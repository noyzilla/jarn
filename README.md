# Jarn (จารย์)

> **START HERE**: Configure your project's active commands in `AGENTS.md`, run dependency installation, and verify with your test suite.

An AI-driven software development blueprint and baseline environment designed for high-integrity collaboration between human engineers and autonomous AI coding agents on Linux and macOS.

---

## Why Jarn (จารย์)?

**Jarn (`jarn`)** (ภาษาไทย: "จารย์" — คำเรียกสตรีทคูลของ "อาจารย์" หรือผู้เชี่ยวชาญ) คือ **พิมพ์เขียวต้นแบบโปรเจคสำหรับการพัฒนาซอฟต์แวร์ด้วย AI (AI-Driven Software Development Blueprint)**

โปรเจคนี้ไม่ได้เป็นเพียงคลังโค้ดแม่แบบทั่วไป แต่ถูกสร้างขึ้นเพื่อเป็น **สภาพแวดล้อมพื้นฐานและรูปแบบการทำงาน (Foundational Environment & Workflow Blueprint)** ที่ฝังเอาไว้ล่วงหน้า เพื่อให้ทั้งมนุษย์และ AI Coding Agents สามารถเริ่มพัฒนาซอฟต์แวร์ร่วมกันได้ทันทีอย่างมีมาตรฐานและปลอดภัย

### แนวคิดและเสาหลักของ Jarn (`jarn`)
- **Street-Smart & Approchable ("จารย์ช่วยด้วย!")**: ออกแบบภายใต้แนวคิดผู้ช่วยและเพื่อนกูรูคู่นักพัฒนาที่เข้าถึงง่าย คอยกำกับมาตรฐานและอำนวยความสะดวกในทุกขั้นตอน
- **4-Letter CLI Ergonomics (`jarn`)**: คำสั่งสั้น กระชับ พิมพ์ลื่นมือ (`jarn init`, `jarn adopt`, `jarn-update.sh`)
- **Pre-Packaged AI Environment**: บรรจุกฎความปลอดภัย (Safety Guardrails), สกิลเฉพาะทาง (Skills Suite), เอกสารที่มีชีวิต (Living Specs), และเกณฑ์การตรวจคุณภาพ (Quality Gates) ไว้ครบถ้วนในโครงสร้างโปรเจค

---

## Quick Commands

### Initialize a New Project (Greenfield)
Create a new project directory initialized with the complete Jarn blueprint:

```bash
# In an empty directory
curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/init.sh | sh

# Or specify a target directory name
curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/init.sh | sh -s -- my-new-project
```

### Adopt into an Existing Project (Brownfield)
Safely adopt Jarn standards into an active project without clobbering existing code or documentation:

```bash
# In your existing project directory
curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/adopt.sh | sh
```

### Update Jarn Standards & Skills (.agents Only)
In any existing downstream project, pull the latest `.agents/rules/jarn/` invariants and `jarn-*` skills:

```bash
# Local execution (if .agents already exists)
./.agents/scripts/jarn-update.sh

# Or remote one-liner execution
curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/.agents/scripts/jarn-update.sh | sh
```

---

## Overview

Jarn establishes a disciplined, reproducible foundation for software development where humans and AI agents work together as equal contributors under shared engineering standards, explicit safety boundaries, and progressive documentation architecture.

## How to Use This Blueprint

### Starting a New Project (Greenfield)
- **Run the Init Command**: Use `scripts/init.sh` to scaffold all blueprint files into an empty directory.
- **Configure Language Presets**: Open `AGENTS.md`, select the matching language preset (Node.js, Java/Gradle, Python, Go, Rust), and copy the commands into the **Active Commands** block.
- **Set Project Identity**: Update the project title and executive summary in `README.md`.
- **Define Initial Architecture**: Fill in high-level modules and technical principles in `ARCHITECTURE.md`.
- **Verify Operational Baseline**: Run your project's native test and lint commands to confirm the environment is clean.

### Adopting into an Existing Project (Brownfield)
Adopting into an active project follows a safe **2-Stage AI Adoption Flow**:

1. **Stage 1 (Deterministic Scaffolding)**:
   Run the adoption script in your project root:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/adopt.sh | sh
   ```
   - Unconditionally synchronizes `.agents/` (rules, `jarn-*` skills, and updater).
   - Creates missing files (`REVIEW.md`, `TASK.md`, `CONTEXT.md`, `docs/specs/`, `docs/decisions/`).
   - For files that already exist (e.g. `AGENTS.md`, `.gitignore`, `CONTRIBUTING.md`), it stages them non-destructively as `<file>.pending-merge` without touching your original files.

2. **Stage 2 (Semantic Merge via AI Agent)**:
   Hand off the generated directive to your AI coding agent (Claude Code, Antigravity, Cursor, etc.):
   > *"Scan for all files matching `*.pending-merge`. For each file, intelligently upgrade and merge its blueprint structure, universal standards, and invariants into the base file (by stripping `.pending-merge`), preserving all existing project commands, configurations, and domain context. Once merged, delete the `*.pending-merge` file and verify with `git status`."*

---

## How to Update & Sync Standards

Because universal standards and Jarn skills are completely decoupled inside `.agents/`, downstream projects can receive updates from upstream without overwriting application code, custom rules, or project-specific architecture.

### Self-Contained Local Update
Downstream repositories contain `.agents/scripts/jarn-update.sh` by default. Update standards directly with:

```bash
./.agents/scripts/jarn-update.sh
```

### Synchronizing via AI Coding Agent
Instruct your AI coding agent with the following directive:

```text
Update Jarn standards in this repository using:
./.agents/scripts/jarn-update.sh
Verify file integrity and record the update in CHANGELOG.md under [Unreleased].
```

---

## Repository Architecture

This repository is organized into distinct communication and governance layers:

| File / Directory | Target Audience | Purpose |
| :--- | :--- | :--- |
| **`README.md`** | Humans & Users | Project overview, Why Jarn philosophy, quick commands |
| **`CONTRIBUTING.md`** | Contributors (Human & AI) | Onboarding, AI usage policy, pull request guidelines |
| **`AGENTS.md`** | AI Coding Agents | Operational commands, language presets, change routing |
| **`CONTEXT.md`** | Developers & AI Agents | Domain glossary, ubiquitous language, and naming rules |
| **`REVIEW.md`** | PR Authors & Reviewers | Pre-merge verification checklist and invariant audits |
| **`ARCHITECTURE.md`** | System Designers | High-level topology, module boundaries, data flow index |
| **`DESIGN.md`** | UI/UX & CLI Designers | Design tokens, component rules, terminal output styling |
| **`TASK.md`** | Active Collaborators | Real-time state tracker, active sprints, and task backlog |
| **`CHANGELOG.md`** | Releases & Stakeholders | Historical log of releases following Keep a Changelog |
| **`.agents/`** | Agent Governance & Skills | Universal rules kernel, Jarn skills (`jarn-*`), and `.agents/scripts/jarn-update.sh` |
| **`docs/`** | System Documentation Repository | Architecture, design system, living specs, ADR decisions, and runbooks |
| **`scripts/init.sh`** | Project Scaffolding | One-liner command to initialize a full new project |
| **`scripts/adopt.sh`** | Project Adoption | One-liner command to adopt blueprint into an existing project with non-destructive staging |
