# Jarn (จารย์)

> **START HERE**: Configure your project's active commands in `AGENTS.md`, run dependency installation, and verify with your test suite.

**Jarn (`jarn`)** (ภาษาไทย: "จารย์" — คำเรียกสตรีทคูลของ "อาจารย์" หรือผู้เชี่ยวชาญ) คือ **พิมพ์เขียวต้นแบบโปรเจคสำหรับการพัฒนาซอฟต์แวร์ด้วย AI (AI-Driven Software Development Blueprint)**

โปรเจคนี้ไม่ได้เป็นเพียงคลังโค้ดแม่แบบทั่วไป แต่ถูกสร้างขึ้นเพื่อเป็น **สภาพแวดล้อมพื้นฐานและรูปแบบการทำงาน (Foundational Environment & Workflow Blueprint)** ที่ฝังเอาไว้ล่วงหน้า เพื่อให้ทั้งมนุษย์และ AI Coding Agents สามารถเริ่มพัฒนาซอฟต์แวร์ร่วมกันได้ทันทีอย่างมีมาตรฐานและปลอดภัย ภายใต้ขอบเขตความปลอดภัย (Safety Boundaries) และสถาปัตยกรรมเอกสารที่มีชีวิต (Progressive Documentation Architecture)

### แนวคิดและเสาหลักของ Jarn (`jarn`)
- **Street-Smart & Approachable ("จารย์ช่วยด้วย!")**: ออกแบบภายใต้แนวคิดผู้ช่วยและเพื่อนกูรูคู่นักพัฒนาที่เข้าถึงง่าย คอยกำกับมาตรฐานและอำนวยความสะดวกในทุกขั้นตอน
- **4-Letter Namespace (`jarn`)**: คำสั่งและ artifact มี prefix เดียวกัน ค้นหาและจดจำได้ง่าย (`jarn init`, `jarn adopt`)
- **Pre-Packaged AI Environment**: บรรจุกฎความปลอดภัย (Safety Guardrails), สกิลเฉพาะทาง (Skills Suite), เอกสารที่มีชีวิต (Living Specs), และเกณฑ์การตรวจคุณภาพ (Quality Gates) ไว้ครบถ้วนในโครงสร้างโปรเจค

---

## Installation & Usage (AI-First Workflow)

Jarn ออกแบบมาให้ทำงานร่วมกับ AI Coding Agents (เช่น Claude Code, Antigravity, Cursor) เป็นหลัก คุณจึงสามารถก๊อปปี้ Prompt ด้านล่างส่งให้ AI เป็นผู้รันคำสั่งติดตั้ง โหลดกฎ และตั้งค่าทุกอย่างให้รวดเดียวจบ

### 1. Starting a New Project (Greenfield)
สร้างหรือเข้าไปที่โฟลเดอร์โปรเจกต์เปล่า แล้วส่ง Prompt นี้ให้ AI ของคุณ:

> *"Run this command to install the Jarn blueprint: `curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh`. After installation, please read all Jarn rules in `.agents/rules/`. Let's co-design the architecture for this project. Once we align, please update `AGENTS.md` (Language Presets), `README.md` (Project Identity), and `ARCHITECTURE.md` according to Jarn guidelines."*

เมื่อ AI ตั้งค่าเสร็จแล้ว:
- **Verify Operational Baseline**: ลองรันคำสั่ง Test / Lint เพื่อตรวจสอบว่าโปรเจกต์พร้อมใช้งาน

### 2. Adopting into an Existing Project (Brownfield)
สำหรับการนำไปใช้กับโปรเจกต์ที่มีอยู่แล้ว (Zero-Conflict) คุณสามารถสั่ง AI รวดเดียวให้ติดตั้ง ศึกษาโปรเจกต์ ทำ Shadow Merge และปรับปรุงเอกสารให้เข้ากับ Jarn:

> *"Run this command to adopt Jarn: `curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh`. Then, please load and read all Jarn rules in `.agents/rules/`. I want to adopt the Jarn blueprint into this existing project. First, study the current codebase. Then, perform a Shadow Merge from `.agents/.jarn-templates/` into the root. Finally, refactor and update our existing documentation to fully comply with the Jarn guidelines."*

*(**Tip**: หากติดตั้งจาก Private Repository ให้เปลี่ยนคำสั่ง `curl` ใน Prompt เป็น `gh api repos/noyzilla/jarn/contents/scripts/jarn.sh -H "Accept: application/vnd.github.raw+json" | sh`)*

### 3. Updating Jarn Standards (สำหรับโปรเจกต์ที่มี Jarn อยู่แล้ว)
หากต้องการอัปเดตกฎและสกิลของ Jarn ให้เป็นเวอร์ชันล่าสุด **แนะนำให้อัปเดตผ่าน AI Skill** เพื่อความสะดวกและปลอดภัย โดยสั่ง AI ด้วยข้อความ:
> *"Update Jarn standards in this repository using the jarn-framework-update skill."*

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
