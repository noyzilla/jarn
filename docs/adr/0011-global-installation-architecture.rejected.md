---
title: Reject Global Installation Architecture
status: rejected
tags: [architecture, agent-protocol, framework-distribution]
synapses: ["ARCHITECTURE.md", "AGENTS.md"]
---

# ADR 0011: Reject Global Installation Architecture

- **Date**: 2026-10-09
- **Status**: Rejected

## Context & Problem Statement
We evaluated shifting the Jarn framework from a Local-first (`.agents/` inside the project) architecture to a Global-first (`~/.jarn/` or `~/.gemini/config/`) architecture, where projects simply declare a local manifest (e.g. `AGENTS.md` stating `jarn_version: v0.13.1`). The goal was to reduce boilerplate and eliminate the manual overhead of updating `.agents/` across multiple projects.

The core architectural problem is: How do we distribute and update agent framework rules across multiple repositories without sacrificing the guarantee that AI agents will actually read and follow the rules, regardless of the IDE, sandboxing, or team topology?

## Decision
**Reject** the Global Installation Architecture and **Retain** the Topology-Aware Local Framework architecture (keeping the `.agents/` directory inside every repository).

## Consequences
- **Positive Consequences**:
  - **Guaranteed Auto-Injection**: Modern agentic IDEs automatically inject local workspace rules (`.agents/rules/`) into the agent's system prompt immediately. The agent cannot skip learning the rules.
  - **Sandboxing Survival**: The framework operates flawlessly in sandboxed environments (Codespaces, CI/CD, restricted bots) where agents lack permission to read global files outside the workspace root.
  - **Zero-Setup Collaboration**: Any teammate cloning the repository gets the exact agent behavior with zero installation steps, preserving the "Clone and Run" philosophy.
- **Negative Consequences**:
  - **Update Boilerplate**: Requires running `jarn-framework-update` (or a multi-repo sync script) in every project repository whenever the framework updates.
  - **Repository Bloat**: The framework files remain visible alongside application code.

## Alternatives Evaluated & Trade-offs
- **Global Cache with Local Manifest (`~/.jarn/` + `AGENTS.md`)**:
  - *Rationale for Rejection*: Breaks Auto-Injection. LLMs are goal-oriented and lazy; forcing them to execute a tool call to fetch global rules before starting work introduces a severe risk of them skipping the step entirely, resulting in complete framework bypass.
- **Global IDE Config (`~/.gemini/config/`)**:
  - *Rationale for Rejection*: Breaks repository versioning. A single global configuration injects the same rules into every workspace, which forces all projects to use the same framework version simultaneously, potentially breaking older projects that relied on deprecated instructions.
