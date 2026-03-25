---
name: brainstorming
description: Use before any creative work - creating features, building components, or modifying behavior
---

# Brainstorming

Turn ideas into designs through collaborative dialogue before writing any code.

**Hard gate:** Do NOT write code or invoke implementation skills until design is approved.

## Process

1. **Explore context** — check files, docs, recent commits
2. **Ask clarifying questions** — one at a time, prefer multiple choice
3. **Propose 2-3 approaches** — with trade-offs and your recommendation
4. **Present design** — section by section, get approval after each
5. **Write spec** — save to `docs/plans/YYYY-MM-DD-<topic>-spec.md`, commit
6. **Review** — dispatch **reviewer** subagent on the spec, fix issues
7. **User approves spec** — then transition to `create-plan` skill

## Principles

- One question per message
- YAGNI — remove unnecessary features
- Design for clear boundaries and single responsibilities
- In existing codebases, follow established patterns
- Scale detail to complexity — a few sentences if simple, more if nuanced
