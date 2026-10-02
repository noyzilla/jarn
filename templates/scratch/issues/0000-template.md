---
id: "XXXX"
title: "[Issue Title]"
status: ready
target_files:
  - "src/..."
  - "tests/..."
depends_on: []
blocked_by: []
tags: [topic]
synapses: []
---

# Issue XXXX: [Issue Title]

## Intent & Context
Clear summary of the problem, required behavior, and scope for this discrete slice of work.

## Acceptance Criteria
- [ ] Explicit functional condition 1
- [ ] Explicit functional condition 2
- [ ] Error handling / edge case condition

## Blast Radius & Modified Files
- **Primary Source**: Main application files to create or modify
- **Companion Tests**: Unit or integration test files verifying the behavior
- **Living Spec Reference**: Direct link to the parent subsystem spec in `docs/specs/`

## Targeted Verification
Project-native command to run targeted verification for touched files (must exit with Code 0):
```bash
# Example: npm test tests/path/to/test.ts
# Example: go test ./pkg/path/...
```

## Technical Notes & Edge Cases
- Architectural constraints, configurations, or mock data requirements.
