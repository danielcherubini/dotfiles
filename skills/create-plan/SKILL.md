---
name: create-plan
description: Use when a feature or change needs an implementation plan with concrete tasks, file paths, and test steps before coding begins
---

# Create Plan

## Overview

Turn an agreed-upon design into a structured implementation plan with independent, commitable tasks. Each task specifies exact files and follows TDD steps.

## When to Use

- After brainstorming/design is complete and user has approved the approach
- When work is large enough to benefit from task breakdown (2+ tasks)
- When you need to hand off to `execute-plan`

**Don't use when:**
- Idea isn't fleshed out yet — use `brainstorming` first
- Change is small enough to implement directly (single file, obvious fix)

## Process

### 1. Understand the idea
- Check project context (files, docs, recent commits)
- Ask clarifying questions one at a time
- Propose 2-3 approaches with trade-offs and your recommendation

### 2. Write the plan
- Once the design is agreed, write to `docs/plans/YYYY-MM-DD-<feature>.md`
- Dispatch the **reviewer** subagent to review the plan
- Fix issues, re-dispatch until approved (max 3 rounds)
- Ask user to review the plan before proceeding

**Plan format:**
```markdown
# [Feature] Plan

**Goal:** One sentence
**Architecture:** 2-3 sentences
**Tech Stack:** Key technologies

---

### Task N: [Name]

**Files:**
- Create: `exact/path/file.ext`
- Modify: `exact/path/existing.ext`
- Test: `tests/path/test.ext`

**Steps:**
- [ ] Write failing test
- [ ] Run test, verify it fails
- [ ] Write minimal implementation
- [ ] Run test, verify it passes
- [ ] Commit
```

Each task should be independent and produce a working commit.

### 3. Handoff
"Plan saved to `<path>`. Ready to execute with `execute-plan`?"

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Tasks that depend on each other's uncommitted work | Make each task independently commitable |
| Vague file paths ("update the config") | Use exact paths: `src/config/auth.ts` |
| Skipping TDD steps in task template | Every task needs failing test → implement → pass |
| Planning before design is agreed | Use `brainstorming` first to align on approach |
| Too many tasks (10+) | Group related changes; aim for 3-7 tasks |
