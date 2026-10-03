# System Architecture

## Overview
This document provides the high-level architecture, module boundaries, and design principles of the system.

## Architectural Principles
- **Contract-First Design**: Define interfaces, data schemas, and API contracts before implementation.
- **Linear Version Lifecycle**: Development proceeds forward on a single canonical line (`main`). A new release supersedes the previous release; Jarn does not maintain parallel version branches unless explicitly required by an external compatibility obligation ([ADR-0006](docs/adr/0006-linear-version-lifecycle.md)).
- **Minimizing Concurrent State**: Limit work-in-progress by executing tasks serially by default. Concurrency is permitted strictly when proven orthogonal ($\text{BlastRadius}(A) \cap \text{BlastRadius}(B) = \emptyset$) via the Dependency & Blast-Radius Matrix.
- **Separation of Concerns**: Isolate domain logic, operational orchestration, and external I/O into modular components.
- **Explicit Over Implicit**: Favor clear, observable code structures over hidden side effects or implicit magic.
- **Progressive Disclosure**: Keep high-level maps here at the root; extract deep-dive specifications into `docs/architecture/`.

## Core Modules
- **Unified Installer**: `scripts/jarn.sh` handles both greenfield initialization and brownfield adoption, including version resolution, archive download, Zero-Conflict Seeding, and Shadow Template synchronization.
- **Agent Rules Engine**: The `.agents/rules/` directory houses universal constraints for LLM agent operations, acting as the system's policy layer.
- **Skill Registry**: Modular, pluggable expert behaviors defined in `.agents/skills/` that extend the default capabilities of the AI agents.
- **Template System**: `templates/` houses generic markdown files (`README.md`, `CONTEXT.md`, etc.) that bootstrap downstream projects without leaking Jarn-specific metadata.

## System Documentation & Deep-Dives
In accordance with the Mirror Index Pattern and system documentation taxonomy in [docs/README.md](docs/README.md):
- **Living Specifications** (`docs/specs/`) - Feature and subsystem contracts combining domain rules, API schemas, and dependency blast-radius matrices (template: [.agents/templates/docs/spec.md](.agents/templates/docs/spec.md)).
- **Architectural Decisions** (`docs/adr/`) - Strategic architectural decision records (ADR) with explicit `.deprecated.md` and `.superseded.md` lifecycle naming (template: [.agents/templates/docs/adr.md](.agents/templates/docs/adr.md)).
- **Architecture Deep-Dives** (`docs/architecture/`) - Subsystem topologies, component interaction diagrams, and system data flows (template: [.agents/templates/docs/architecture.md](.agents/templates/docs/architecture.md)).
- **Design Specifications** (`docs/design/`) - Reusable component tokens, form styling, and accessibility standards (template: [.agents/templates/docs/design.md](.agents/templates/docs/design.md)).
- **Development Workflows** (`docs/development/`) - Developer onboarding, local environment setup, and migration runbooks (template: [.agents/templates/docs/development.md](.agents/templates/docs/development.md)).
