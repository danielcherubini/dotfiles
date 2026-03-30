---
name: create-plan
description: Use when a feature or change needs an implementation plan with concrete tasks, file paths, and test steps before coding begins
---

# Create Plan

## Overview

Turn an agreed-upon design into a structured implementation plan with independent, commitable tasks. Each task specifies exact files and follows TDD steps.

**Write for a dumb agent.** The executing agent has no memory of your conversation, no knowledge of intent, and no ability to infer what you meant. Every task must be self-contained and complete enough that a capable but context-free agent can execute it without guessing. If something is ambiguous, spell it out. If something could be done multiple ways, specify which way. Leave nothing to interpretation.

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

**Context:**
A short paragraph explaining *why* this task exists, what problem it solves, and how it fits into the overall feature. Include any decisions already made and why. Do not assume the agent knows anything about the conversation.

**Files:**
- Create: `exact/path/file.ext`
- Modify: `exact/path/existing.ext`
- Test: `tests/path/test.ext`

**What to implement:**
A precise description of the change. Include:
- Exact function/struct/module names to add or modify
- Exact signatures, types, or field names where relevant
- Any specific logic, conditions, or edge cases to handle
- What NOT to change (if there's a risk of over-engineering)

**Steps:**
- [ ] Write failing test for [specific behavior] in `tests/path/test.ext`
- [ ] Run `[exact test command]`
  - Did it fail with [expected error]? If it passed unexpectedly, stop and investigate why.
- [ ] Implement [specific thing] in `exact/path/file.ext`
- [ ] Run `[exact test command]`
  - Did all tests pass? If not, fix the failures and re-run before continuing.
- [ ] Run `[exact format command]` (e.g. `cargo fmt`)
  - Did it succeed? If not, fix and re-run before continuing.
- [ ] Run `[exact build command]` (e.g. `cargo build`)
  - Did it succeed? If not, fix and re-run before continuing.
- [ ] Commit with message: "[suggested commit message]"

**Acceptance criteria:**
- [ ] [Specific, verifiable outcome]
- [ ] [Another specific outcome]
```

Each task must be independently commitable. The agent executing it has no context beyond what is written here — be exhaustive.

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
