# System Architecture

## Overview
This document provides the high-level architecture, module boundaries, and design principles of the system.

## Architectural Principles
- **Contract-First Design**: Define interfaces, data schemas, and API contracts before implementation.
- **Separation of Concerns**: Isolate domain logic, operational orchestration, and external I/O into modular components.
- **Explicit Over Implicit**: Favor clear, observable code structures over hidden side effects or implicit magic.
- **Progressive Disclosure**: Keep high-level maps here at the root; extract deep-dive specifications into `docs/architecture/`.

## Core Modules
- **Initialization Scripts**: `scripts/init.sh` pulls the generic templates and Agent guidelines into downstream repositories.
- **Adoption Scripts**: `scripts/init.sh` orchestrates safe cross-repository skill merging via Git cherry-pick and patch application to prevent destructive overwrites.
- **Agent Rules Engine**: The `.agents/rules/` directory houses universal constraints for LLM agent operations, acting as the system's policy layer.
- **Skill Registry**: Modular, pluggable expert behaviors defined in `.agents/skills/` that extend the default capabilities of the AI agents.
- **Template System**: `templates/` houses generic markdown files (`README.md`, `CONTEXT.md`, etc.) that bootstrap downstream projects without leaking Jarn-specific metadata.

## System Documentation & Deep-Dives
In accordance with the Mirror Index Pattern and system documentation taxonomy in [docs/README.md](docs/README.md):
- [Living Specifications](docs/specs/0000-template.md) (`docs/specs/`) - Feature and subsystem contracts combining domain rules, API schemas, and dependency blast-radius matrices.
- [Architectural Decisions](docs/decisions/0000-template.md) (`docs/decisions/`) - Strategic architectural decision records (ADR) with explicit `.deprecated.md` and `.superseded.md` lifecycle naming.
- [Architecture Deep-Dives](docs/architecture/template.md) (`docs/architecture/`) - Subsystem topologies, component interaction diagrams, and system data flows.
- [Design Specifications](docs/design/template.md) (`docs/design/`) - Reusable component tokens, form styling, and accessibility standards.
- [Development Workflows](docs/development/0000-template.md) (`docs/development/`) - Developer onboarding, local environment setup, and migration runbooks.
