# Jarn (จารย์)

> **START HERE**: Configure your project's active commands in `AGENTS.md`, run dependency installation, and verify with your test suite.

An AI-driven software development blueprint and baseline environment designed for high-integrity collaboration between human engineers and autonomous AI coding agents on Linux and macOS.

---

## Why Jarn (จารย์)?

**Jarn (`jarn`)** (ภาษาไทย: "จารย์" — คำเรียกสตรีทคูลของ "อาจารย์" หรือผู้เชี่ยวชาญ) คือ **พิมพ์เขียวต้นแบบโปรเจคสำหรับการพัฒนาซอฟต์แวร์ด้วย AI (AI-Driven Software Development Blueprint)**

โปรเจคนี้ไม่ได้เป็นเพียงคลังโค้ดแม่แบบทั่วไป แต่ถูกสร้างขึ้นเพื่อเป็น **สภาพแวดล้อมพื้นฐานและรูปแบบการทำงาน (Foundational Environment & Workflow Blueprint)** ที่ฝังเอาไว้ล่วงหน้า เพื่อให้ทั้งมนุษย์และ AI Coding Agents สามารถเริ่มพัฒนาซอฟต์แวร์ร่วมกันได้ทันทีอย่างมีมาตรฐานและปลอดภัย

### แนวคิดและเสาหลักของ Jarn (`jarn`)
- **Street-Smart & Approchable ("จารย์ช่วยด้วย!")**: ออกแบบภายใต้แนวคิดผู้ช่วยและเพื่อนกูรูคู่นักพัฒนาที่เข้าถึงง่าย คอยกำกับมาตรฐานและอำนวยความสะดวกในทุกขั้นตอน
- **4-Letter Namespace (`jarn`)**: คำสั่งและ artifact มี prefix เดียวกัน ค้นหาและจดจำได้ง่าย (`jarn init`, `jarn adopt`)
- **Pre-Packaged AI Environment**: บรรจุกฎความปลอดภัย (Safety Guardrails), สกิลเฉพาะทาง (Skills Suite), เอกสารที่มีชีวิต (Living Specs), และเกณฑ์การตรวจคุณภาพ (Quality Gates) ไว้ครบถ้วนในโครงสร้างโปรเจค

---

## Quick Commands

### Install / Adopt Jarn (Greenfield & Brownfield)
Create a new project directory initialized with the complete Jarn blueprint, or safely adopt Jarn standards into an existing active project using the AI-driven Shadow Merge architecture (zero-conflict):

```bash
# Public / HTTP (Default)
curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh
curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh -s -- my-project-dir

# Private Repository (via GitHub CLI `gh`)
gh api repos/noyzilla/jarn/contents/scripts/jarn.sh -H "Accept: application/vnd.github.raw+json" | sh
gh api repos/noyzilla/jarn/contents/scripts/jarn.sh -H "Accept: application/vnd.github.raw+json" | sh -s -- my-project-dir
```

### Update Jarn Standards & Skills
In any existing downstream project, pull the latest `.agents/rules/jarn-` invariants, `jarn-*` skills, and shadow templates using the exact same unified installer command:

```bash
# Remote one-liner execution (Public / HTTP)
curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh

# Remote one-liner execution (Private Repository via GitHub CLI)
gh api repos/noyzilla/jarn/contents/scripts/jarn.sh -H "Accept: application/vnd.github.raw+json" | sh
```

---

## Overview

Jarn establishes a disciplined, reproducible foundation for software development where humans and AI agents work together as equal contributors under shared engineering standards, explicit safety boundaries, and progressive documentation architecture.

## How to Use This Blueprint

### Starting a New Project (Greenfield)
- **Run the Init Command**: Use `curl ... jarn.sh | sh` to scaffold all blueprint files into an empty directory.
- **Configure Language Presets**: Open `AGENTS.md`, select the matching language preset (Node.js, Java/Gradle, Python, Go, Rust), and copy the commands into the **Active Commands** block.
- **Set Project Identity**: Update the project title and executive summary in `README.md`.
- **Define Initial Architecture**: Fill in high-level modules and technical principles in `ARCHITECTURE.md`.
- **Verify Operational Baseline**: Run your project's native test and lint commands to confirm the environment is clean.

### Adopting into an Existing Project (Brownfield)
Adopting into an active project follows a safe **2-Stage AI Adoption Flow**:

- **Stage 1 (Zero-Conflict Seeding)**:
   Run the unified installer in your project root:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh
   ```
   - Unconditionally synchronizes `.agents/` rules and skills.
   - Downloads all Jarn root templates (e.g. `AGENTS.md`, `REVIEW.md`) into a hidden `.agents/.jarn-templates/` directory (Shadow Templates).
   - If a core file does not exist in your root project yet, it seeds it automatically. If it already exists, the script does absolutely nothing to your active files.

- **Stage 2 (Semantic Shadow Merge via AI Agent)**:
   Hand off the generated directive to your AI coding agent (Claude Code, Antigravity, Cursor, etc.):
   > *"Please compare the files in `.agents/.jarn-templates/` with the root project files. Carefully merge any missing standards, architectural updates, or new configurations into the project files without disrupting existing domain logic or active commands."*

---

## How to Update & Sync Standards

Because universal standards and Jarn skills are completely decoupled inside `.agents/`, downstream projects can receive updates from upstream without overwriting application code, custom rules, or project-specific architecture.

### Synchronizing via AI Coding Agent
Instruct your AI coding agent with the following directive:

```text
Update Jarn standards in this repository using the jarn-framework-update skill.
Run `curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh`, 
perform a Shadow Merge from `.agents/.jarn-templates/`, and verify file integrity.
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
| **`.agents/`** | Agent Governance & Skills | Universal rules kernel, Jarn skills (`jarn-*`), and shadow templates (`.jarn-templates/`) |
| **`docs/`** | System Documentation Repository | Architecture, design system, living specs, ADR decisions, and runbooks |
| **`scripts/jarn.sh`** | Project Initialization & Update | Universal one-liner command to initialize or update a project using Zero-Conflict Seeding and Shadow Templates |
