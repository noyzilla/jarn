---
title: Token-Optimized Draft Lifecycle
status: active
tags: [workflow, tokens, ai-collaboration, ux]
synapses: ["docs/README.md"]
---

# ADR 0010: Token-Optimized Draft Lifecycle

- **Date**: 2026-10-08
- **Status**: Accepted

## Context & Problem Statement

Drafting complex documents (such as Living Specifications or ADRs) using AI coding agents often relies on web-based "Artifact" UI modes. While these modes offer a visually appealing initial output, they suffer from critical flaws during the iteration phase:
1. **Massive Output Token Waste**: Editing even a single word in an Artifact typically forces the AI to regenerate and rewrite the entire document from scratch.
2. **Context Bloat**: Continuously passing large, fully rendered Artifacts back and forth severely inflates the Input Token context window, leading to high costs and degraded AI memory span.
3. **Suboptimal Developer UX**: Artifacts live in a disconnected web/chat UI panel, breaking the developer's native flow. It prevents standard IDE capabilities like surgical inline-commenting, code-lens, and native Git diffing.

A highly efficient, token-aware workflow is required to collaborate with AI agents on living specifications without incurring exponential token costs or sacrificing native IDE ergonomics.

## Decision

Adopt the **Token-Optimized Draft Lifecycle** for all document ideation and specification drafting. The use of web-based "Artifact Mode" for iterative drafting is strictly deprecated in favor of a native file-patching workflow.

The workflow consists of three phases:
1. **Initiate (Drafting)**: The AI generates the initial draft directly into the project filesystem under `docs/drafts/<slug>.md` (without numeric prefixes).
2. **Iterate (Targeted Patching)**: The human developer reviews the draft inside their native IDE. For structural or logic changes, the developer highlights specific blocks or copies snippets into the chat and directs the AI. The AI MUST respond using targeted patching tools (e.g., `replace_file_content`) to surgically edit only the requested lines.
3. **Finalize (Promotion & Archival)**: Once consensus is achieved, the specification is generated in its proper taxonomy (e.g., `docs/specs/` or `docs/adr/XXXX-slug.md`). The raw draft is migrated to `docs/archived/<slug>.md` if it contains valuable unextracted architectural reasoning (The Non-Subtractive Principle) or deleted if obsolete.

## Consequences

- **Positive Consequences**:
  - **Drastic Token Savings**: Output token consumption is reduced from thousands of tokens (full file rewrite) to mere tens of tokens (targeted diff patch) per iteration.
  - **Superior Ergonomics**: Developers remain in their primary IDE, leveraging native syntax highlighting, split views, and local inline-commenting patterns.
  - **Clean State Management**: Adheres seamlessly to Jarn's Step 0 Branch Isolation and Working Tree Loop rules.
- **Negative Consequences**:
  - **Workflow Adjustment**: Requires developers to transition away from conversational web-UI habits and adopt explicit, targeted chat instructions for patching.
  
## Alternatives Evaluated & Trade-offs

- **Artifact Mode Iteration**: Evaluated as the default behavior of many modern LLM chatbots. Rejected because the high output token cost per iteration and the disconnected UX heavily outweigh the visual convenience of the side-panel widget.
- **Manual Human-Only Edits**: Evaluated for minor typo corrections. Accepted as a complementary action (developers should fix minor typos manually without invoking the AI), but rejected as the sole workflow, as AI assistance is crucial for restructuring and evaluating deep logical trade-offs.