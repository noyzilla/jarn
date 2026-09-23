# Jarn (จารย์)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![AI-Native](https://img.shields.io/badge/Architecture-AI--Native-000000.svg)](.agents/)

> **A foundational blueprint for harmonious collaboration between human developers and AI coding agents.**

**Jarn (`jarn`)** (ภาษาไทย: "จารย์" — คำเรียกสตรีทคูลของ "อาจารย์" หรือผู้เชี่ยวชาญ) คือ **พิมพ์เขียวต้นแบบโปรเจคสำหรับการพัฒนาซอฟต์แวร์ด้วย AI (AI-Driven Software Development Blueprint)**

โปรเจคนี้ไม่ได้เป็นเพียงคลังโค้ดแม่แบบทั่วไป แต่ถูกสร้างขึ้นเพื่อเป็น **สภาพแวดล้อมและคู่มือปฏิบัติการ** ที่ฝังเอาไว้ในระดับ Repository เพื่อให้ทั้งมนุษย์และ AI (เช่น Claude Code, Antigravity, Cursor) สามารถทำงานร่วมกันได้อย่างเป็นระบบ ราบรื่น และปลอดภัย

---

## Why Jarn? (ทำไมถึงต้องมีจารย์?)

> **Disclaimer**: โปรเจกต์นี้เกิดจากการถอดรหัส (Extract) รูปแบบการทำงานและ Pain points ของทีมเราเองออกมาเป็น Blueprint มันจึงมีรูปแบบการทำงานที่ชัดเจน (Highly Opinionated) และ **"อาจจะไม่ได้เหมาะสำหรับทุกคนหรือทุกโปรเจกต์"** แต่ถ้าคุณกำลังเจอปัญหาคล้ายๆ กัน เราหวังว่ามันจะช่วยคุณได้ครับ!

โลกของการเขียนโค้ดด้วย AI นั้นรวดเร็ว แต่ก็มักจะมาพร้อมกับโค้ดขยะ (Slop) หรือบั๊กที่เกิดจากการที่ AI ขาดบริบท การพยายามห้ามใช้ AI ไม่ใช่ทางออก Jarn จึงเกิดมาเพื่อเป็น "ผู้ช่วยจัดระเบียบ" ไม่ใช่เจ้านายที่มาตั้งกฎ โดยมีจุดเด่นคือ:

- 🤖 **AI-Native Governance**: ระเบียบปฏิบัติงานทั้งหมด (อยู่ใน `.agents/rules/`) ถูกเขียนมาเพื่อให้ AI อ่านโดยเฉพาะ ช่วยให้ AI เข้าใจบริบทโปรเจกต์คุณได้เร็วขึ้น ลดการเดาสุ่ม และลดภาระที่คุณต้องคอยพิมพ์ Prompt สั่งซ้ำๆ
- 🌊 **Fluid Collaboration (Event-Driven)**: รองรับตั้งแต่การลุยเดี่ยวจบในคนเดียว (Continuous Flow) ไปจนถึงการรับส่งงานภายในทีม (Handoff) อย่างไร้รอยต่อผ่านคำสั่ง Git Commit
- 🏗️ **3-Gate Operational Model**: เช็คลิสต์ 3 ขั้นตอนที่ช่วยให้เราและ AI วางแผนร่วมกันอย่างรอบคอบ (คิดสเปค -> ลงมือทำ -> ตรวจสอบ) ป้องกันความเสียหายก่อนถึง production
- 🛡️ **Zero-Conflict Seeding**: สามารถติดตั้ง Jarn ทับโปรเจกต์เดิมที่คุณมีอยู่แล้วได้อย่างปลอดภัย โดยไม่เข้าไปทำลายโค้ดหรือไฟล์เก่าของคุณ

---

## Core Philosophy & Workflow (ปรัชญาและรูปแบบการทำงาน)

ความลับที่ทำให้ Jarn ควบคุม AI ได้อย่างอยู่หมัด คือการเปลี่ยนจาก "สั่งให้ AI เขียนโค้ด" มาเป็น **"สั่งให้ AI คิดและวางแผนก่อนเขียนโค้ด"** ผ่านปรัชญาเหล่านี้:

1. **Consult Before Code (ปรึกษาก่อนทำ)**: AI ของ Jarn ถูกกฎบังคับให้สวมหมวก "ที่ปรึกษา" เมื่อคุณสั่งงาน AI จะไม่รีบปั่นโค้ดมั่วๆ ออกมา แต่มันจะตั้งคำถาม ชวนคุณคิด หาจุดบอด และเสนอทางเลือกพร้อมข้อดีข้อเสียก่อนเสมอ
2. **Spec is Law (คุมงานด้วยสเปค)**: แหล่งอ้างอิงความจริงสูงสุดคือเอกสารใน `docs/specs/` AI จะเขียนสเปคให้เสร็จและรอให้คุณอนุมัติก่อนถึงจะเริ่มเขียนโค้ด การทำแบบนี้ช่วยจำกัดความเสียหาย (Blast Radius) ไม่ให้ AI ไปแก้ไฟล์อื่นที่ไม่เกี่ยวข้อง
3. **Record the "Why" (บันทึกการตัดสินใจด้วย ADR)**: ทุกการตัดสินใจสำคัญระดับสถาปัตยกรรมจะถูกเก็บไว้ใน `docs/decisions/` (Architectural Decision Records) เพื่อให้ AI ตัวใหม่ๆ หรือคนในทีมในอนาคต รู้ประวัติศาสตร์ว่า "ทำไมเราถึงเลือกใช้วิธีนี้"
4. **1 Branch = 1 Task (ภารกิจแยกส่วน)**: การทำงานทุกครั้งต้องแตก Branch ใหม่เสมอ และมีไฟล์ `TASK.md` คอยติดตามสถานะ (State Tracker) ภายใน Branch นั้นๆ
5. **Continuous & Brake Flow**: โดยค่าเริ่มต้น AI จะลุยงานตั้งแต่ต้นจนจบและ Merge โค้ดให้เลย (Continuous Flow) แต่หากคุณตั้งค่าให้มีผู้ตรวจสอบ (เช่น QA) AI จะส่งไม้ต่อด้วยคำสั่ง `git commit -m "handoff(qa): ..."` (Brake Flow) เพื่อหยุดรอให้คนมารับช่วงต่อ

---

## Installation & Usage (ใช้งานง่ายใน 1 Prompt)

Jarn ออกแบบมาให้ทำงานร่วมกับ AI Coding Agents เป็นหลัก คุณจึงไม่ต้องเหนื่อยตั้งค่าเอง แค่ก๊อปปี้ข้อความด้านล่างส่งให้ AI จัดการให้... แล้วเวทมนตร์จะเกิด!

### 1. Starting a New Project (สร้างโปรเจกต์ใหม่)
สร้างหรือเข้าไปที่โฟลเดอร์เปล่า แล้วส่ง Prompt นี้ให้ AI ของคุณ:

> *"Run this command to install the Jarn blueprint: `curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh`. After installation, please read all Jarn rules in `.agents/rules/`. Let's co-design the architecture for this project. Once we align, please update `AGENTS.md` (Language Presets), `README.md` (Project Identity), and `ARCHITECTURE.md` according to Jarn guidelines."*

### 2. Adopting into an Existing Project (ติดตั้งทับโปรเจกต์เดิม)
หากคุณมีโปรเจกต์อยู่แล้ว และอยากนำความมีระเบียบของ Jarn เข้าไปใช้:

> *"Run this command to adopt Jarn: `curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh`. Then, please load and read all Jarn rules in `.agents/rules/`. I want to adopt the Jarn blueprint into this existing project. First, study the current codebase. Then, perform a Shadow Merge from `.agents/.jarn-templates/` into the root. Finally, refactor and update our existing documentation to fully comply with the Jarn guidelines."*

*(**Tip**: หากติดตั้งจาก Private Repository ให้เปลี่ยนคำสั่ง `curl` ใน Prompt เป็น `gh api repos/noyzilla/jarn/contents/scripts/jarn.sh -H "Accept: application/vnd.github.raw+json" | sh`)*

### 3. Updating Jarn Standards (อัปเดตเวอร์ชัน)
หากมีการอัปเดตกฎใหม่ๆ จากส่วนกลาง คุณสามารถสั่งให้ AI อัปเดตตัวเองได้เลย:
> *"Update Jarn standards in this repository using the jarn-framework-update skill."*

---

## Repository Architecture

This repository is organized into distinct communication and governance layers:

| File / Directory | Target Audience | Purpose |
| :--- | :--- | :--- |
| **`README.md`** | Humans & Users | Project overview, Why Jarn philosophy, quick commands |
| **`CONTRIBUTING.md`** | Contributors (Human & AI) | Onboarding, Team Roles, and Event-Driven Handoff Playbook |
| **`AGENTS.md`** | AI Coding Agents | Operational commands, language presets, change routing |
| **`CONTEXT.md`** | Developers & AI Agents | Domain glossary, ubiquitous language, and naming rules |
| **`REVIEW.md`** | PR Authors & Reviewers | Pre-merge verification checklist and invariant audits |
| **`ARCHITECTURE.md`** | System Designers | High-level topology, module boundaries, data flow index |
| **`DESIGN.md`** | UI/UX & CLI Designers | Design tokens, component rules, terminal output styling |
| **`TASK.md`** | Active Collaborators | High-level project roadmap and backlog |
| **`CHANGELOG.md`** | Releases & Stakeholders | Historical log of releases following Keep a Changelog |
| **`.agents/`** | Agent Governance & Skills | Universal rules kernel, Jarn skills (`jarn-*`), and shadow templates (`.jarn-templates/`) |
| **`docs/`** | System Documentation Repository | Architecture, design system, living specs, ADR decisions, and runbooks |
| **`scripts/jarn.sh`** | Project Initialization & Update | Universal one-liner command to initialize or update a project |
