---
title: Installer Asset Distribution
status: active
tags: [installer, distribution, release, blueprint]
synapses: ["CONTEXT.md", "docs/adr/0003-shadow-merge-architecture.md"]
---

# Specification: Installer Asset Distribution

- **Status**: Active
- **Last Verified**: 2026-10-05
- **Target Audience**: Developers and AI Coding Agents

## Overview & Scope
Defines the installation, update, and release packaging distribution lifecycle for the Jarn framework. Jarn delivers a lightweight blueprint (`.agents/` rules, skills, templates, and root starter templates) to greenfield and brownfield projects without transferring full repository source, git history, or build artifacts.

## Domain Context & Ubiquitous Language
- **Canonical Term: Root Installer (`install.sh`)**: The single public entrypoint script located at repository root for initializing and adopting Jarn.
- **Canonical Term: Blueprint Package (`jarn.tar.gz`)**: Release asset archive containing strictly `.agents/` and `templates/` for minimal bandwidth and fast initialization.
- **Canonical Term: Tarball Fallback**: Secondary download strategy using the repository-wide tarball (`/tarball/${VERSION}`) when pre-packaged release assets are unavailable.
- **Forbidden Synonym: `scripts/jarn.sh`**: Legacy path for the installer script.

## Business Rules & Logic Invariants
- **Root Entrypoint Invariant**: The primary installation script MUST reside at repository root as `install.sh`.
- **Asset Distribution Hierarchy**:
  - **Tier 1 (Primary - Release Asset)**: Fetch `jarn.tar.gz` directly from GitHub Releases (`releases/download/${VERSION}/jarn.tar.gz` or `releases/latest/download/jarn.tar.gz`).
  - **Tier 2 (Fallback - Full Tarball)**: If release asset is missing (HTTP non-200 or empty payload), fall back seamlessly to repository archive (`repos/${REPO}/tarball/${VERSION}`).
- **Payload Purity Invariant**: `jarn.tar.gz` MUST contain ONLY `.agents/` (rules, skills, templates) and `templates/`. It MUST NOT package internal scripts, workflows, or git histories.
- **Zero-Conflict Seeding & Shadow Merge**: Seeding un-instantiated templates to target root and preserving modified project files in `.agents/.jarn-templates/` remains strictly enforced.

## Flow & State Machine
- **Phase 1 — Parameter & Environment Detection**: Parse target directory and download method (`curl` vs `gh`).
- **Phase 2 — Version Resolution**: Query latest release tag if version is `latest`.
- **Phase 3 — Asset Download & Extraction**:
  - Attempt Tier 1 download of `jarn.tar.gz`.
  - On failure, trigger Tier 2 download of full repo tarball.
  - Extract into isolated temporary directory (`mktemp -d`).
- **Phase 4 — Core Invariant Synchronization**: Deploy `.agents/rules/jarn-*`, `.agents/skills/jarn-*`, `.agents/templates/`, and `.agents/.jarn-templates/`.
- **Phase 5 — Zero-Conflict Seeding**: Seed root files if not present; preserve existing files without overwriting.

## Interface & Data Contracts
- **Installation CLI Usage**:
  - `curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/install.sh | sh`
  - `curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/install.sh | sh -s -- <target-dir>`
  - `gh api repos/noyzilla/jarn/contents/install.sh -H "Accept: application/vnd.github.raw+json" | sh -s -- gh [target-dir]`
- **Release Packaging Contract**:
  - `COPYFILE_DISABLE=1 tar --exclude='.DS_Store' --exclude='*/.DS_Store' -czf dist/jarn.tar.gz -C . .agents templates`
  - Release Asset Name: `jarn.tar.gz` attached to `vX.Y.Z` release tag.

## Dependency & Blast-Radius Matrix
- **Upstream Callers**: End-user terminal sessions, CI workflows, AI initialization prompts.
- **Downstream Dependencies**: GitHub Releases API, `curl`, `tar`, `gh` CLI.
- **Bounded Blast Radius**: `install.sh`, `scripts/jarn.sh`, `.agents/skills/jarn-release/SKILL.md`, `README.md`, `ARCHITECTURE.md`, `AGENTS.md`, `docs/adr/`.

## Verification & Acceptance Criteria
- **Syntax Check**: `sh -n install.sh` passes with Exit Code 0.
- **Release Packaging Verification**: Generated `jarn.tar.gz` contains `.agents/` and `templates/` and extracts without errors.
- **Dry-run Execution**: Running `install.sh` in a temporary directory successfully bootstraps all rules, skills, and templates.
