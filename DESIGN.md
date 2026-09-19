# Design System & Styling Guidelines



This document governs the visual tokens, UI components, and output styling across the project based on the machine-readable design system standard.

## Project Constraint: Headless Backend Library

> **This project is a Headless Backend Library.**
> There are NO graphical user interfaces (UI) and NO visual design tokens. AI agents MUST NOT create or inject UI elements, colors, typography, or styling rules into this project.

## Headless & CLI Output Guidelines
For CLI tools, background workers, or backend services without graphical interfaces, this document governs terminal output formatting:
- **Success Messages**: Printed in green or neutral white with descriptive context; no decorative icons.
- **Errors & Warnings**: Printed to stderr with clear causation, remediation hints, and non-zero exit codes.
- **Structured Output**: Support `--json` output flag for automated machine consumption.

## Deep-Dive Design Specifications
Because this is a headless library, deep-dive UI documents (such as `components.md`, `forms.md`) are explicitly excluded. The `docs/design/` directory is **N/A** for this project.
