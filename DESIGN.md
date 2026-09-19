# Design System & Styling Guidelines

> **AI SHADOW MERGE DIRECTIVE:**
> - **If this project is a CLI, Library, or Backend (No UI):** You MUST REMOVE or IGNORE the "Design Tokens" and "Deep-Dive Design Specifications" sections entirely during Shadow Merge updates. Focus only on formatting rules in "Headless & CLI Output Guidelines". **Do not re-insert web UI tokens if they were previously removed.**
> - **If this project has a UI/Frontend:** Retain and adapt the Design Tokens to match the project's brand.

This document governs the visual tokens, UI components, and output styling across the project based on the machine-readable design system standard.

## Aesthetic Direction
- **Tone**: Clean, focused, high-precision engineering aesthetic.
- **Visual Hierarchy**: High-contrast typography, restrained color palette, purposeful whitespace.

## Design Tokens



## Headless & CLI Output Guidelines
For CLI tools, background workers, or backend services without graphical interfaces, this document governs terminal output formatting:
- **Success Messages**: Printed in green or neutral white with descriptive context; no decorative icons.
- **Errors & Warnings**: Printed to stderr with clear causation, remediation hints, and non-zero exit codes.
- **Structured Output**: Support `--json` output flag for automated machine consumption.

## Deep-Dive Design Specifications
In accordance with the Mirror Index Pattern and documentation taxonomy in [docs/README.md](docs/README.md), detailed design system specifications are extracted on demand into `docs/design/`:
- `docs/design/components.md` - Component library tokens, button variants, and state definitions.
- `docs/design/forms.md` - Form input styling, label positioning, and error message typography.
- `docs/design/tables.md` - Table layouts, row hover effects, and pagination controls.
- `docs/design/accessibility.md` - WCAG color contrast standards, focus rings, and keyboard navigation.
