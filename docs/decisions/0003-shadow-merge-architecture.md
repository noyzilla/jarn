---
title: Shadow Merge Architecture
status: active
tags: [architecture, deployment, ai-agent, zero-conflict]
---

# ADR 0003: Zero-Conflict Seeding and Shadow Merge Architecture

- **Date**: 2026-09-19
- **Status**: Accepted

## Context & Problem Statement
Adopting a framework like Jarn into an existing project (Brownfield adoption) presents a significant risk of overwriting or destroying active user configurations, documentation (e.g., `README.md`), and custom scripts. 

Previously, the framework relied on separate scripts (`init.sh` for new projects, and a local `.agents/scripts/jarn-framework-update.sh` for updates). When updating templates in an active project, older iterations relied on generating `.pending-merge` files in the project root to prevent direct overwrites. This led to repository clutter, user confusion over dangling files, and a fragmented installation experience.

## Decision
We implement a **Unified Installer with Zero-Conflict Seeding and AI-Driven Shadow Merge**:

- **Unified Installer (`scripts/jarn.sh`)**: A single script handles both Greenfield initialization and Brownfield adoption/updates.
- **Zero-Conflict Seeding**: 
  - If a core template (e.g., `AGENTS.md`) does not exist in the root, it is seeded natively.
  - If it already exists, the script strictly bypasses the root file to prevent destruction.
- **Shadow Templates**: Instead of polluting the root directory with `.pending-merge` files, the installer silently downloads the complete Jarn template payload into a hidden directory (`.agents/.jarn-templates/`).
- **Git Invisibility**: The installer automatically generates `.agents/.gitignore` to ignore the `.jarn-templates/` directory, keeping the Git tree clean for the developer while remaining accessible to AI agents.
- **AI-Driven Shadow Merge**: The responsibility of resolving differences is shifted from dumb bash scripts to the AI coding agent (via the `jarn-framework-update` skill), which performs a semantic diff between the Shadow Templates and the active project files.

## Consequences
- **Positive Consequences**: 
  - Eradicates `.pending-merge` file clutter entirely.
  - Guarantees 100% safety for user data during adoption and updates (Zero-Conflict).
  - Centralizes the installation logic into a single, highly maintainable remote script.
  - Leverages the semantic reasoning capabilities of AI agents to merge rules without destroying active user commands.
- **Negative Consequences**: 
  - AI agents must be explicitly instructed to read the hidden `.jarn-templates/` directory to perform updates, placing reliance on the agent's ability to follow the `jarn-framework-update` skill correctly.
  - Slightly increases disk footprint by keeping a persistent, hidden copy of the template baseline in `.agents/`.

## Alternatives Evaluated & Trade-offs
- **[Overwriting Files Directly]**: Rejected due to catastrophic data loss in brownfield projects.
- **[.pending-merge Files in Root]**: The previous architecture. Rejected because it cluttered the root directory, frustrated developers, and forced users to manually clean up dangling files if the AI failed to merge them.
- **[Dedicated CLI Tool]**: Rejected because it violates the "Zero Python/Node dependency" rule for the bootstrap phase. The POSIX basic shell script (`jarn.sh`) ensures universal compatibility out-of-the-box.
