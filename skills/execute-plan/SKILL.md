---
name: execute-plan
description: Use when you have a written implementation plan to execute
---

# Execute Plan

Read the plan, create a feature branch, dispatch subagents per task, review the branch, run coderabbit, open a PR.

## Process

### 1. Load plan
- Read the plan file
- Raise concerns with user if any
- Create a feature branch using gitflow conventions
- Create a TodoWrite with all tasks from the plan

### 2. Execute tasks with subagents
For each task in the plan, dispatch a **general** subagent:

```
Subagent prompt template:
  description: "Implement Task N: [task name]"
  prompt: |
    You are implementing a task in [project].

    ## Task
    [FULL TEXT of task from plan - paste it, don't make subagent read file]

    ## Context
    [Where this fits, dependencies, what's already done]

    ## Instructions
    - Implement exactly what the task specifies
    - Write tests (TDD: failing test first, then implementation)
    - Validate your work by running each step **independently and in order** — wait for each to finish before starting the next:
      1. Formatting (e.g. `cargo fmt`, `prettier`, etc.)
      2. Build / compile (e.g. `cargo build`, `npm run build`, etc.)
      3. Tests (e.g. `cargo test`, `npm test`, etc.)
    - If any step fails: **STOP. Do not re-run it yet.** Read the error output, read the relevant source files, then use Edit/Write tools to fix the root cause. Only re-run after you have made file changes.
    - **Loop-break rule:** If you run a step and it fails, and you have made no file edits since the last time it failed, you are looping. Stop immediately and report back with status BLOCKED — describe the error and what you tried.
    - Commit your work with a descriptive message
    - Work from: [directory]

    ## Report back with:
    - Status: DONE | BLOCKED | NEEDS_CONTEXT
    - What you implemented
    - Files changed
    - Any concerns
```

**Handle subagent responses:**
- **DONE:** Mark task complete in TodoWrite, move to next task
- **NEEDS_CONTEXT:** Provide missing info, re-dispatch
- **BLOCKED:** Assess blocker, provide help or escalate to user

**Important:** Dispatch tasks sequentially (not in parallel) to avoid file conflicts.

### 3. Review the branch
After all tasks complete, dispatch the **reviewer** subagent:

```
Review the feature branch [branch-name] against [base-branch].

Run: git diff [base-branch]...HEAD
Run: git log --oneline [base-branch]..HEAD

Check:
- Does the implementation match the plan?
- Are there bugs, missing error handling, or quality issues?
- Validate by running each step **independently and in order** — wait for each to finish before starting the next:
  1. Formatting (e.g. `cargo fmt --check`, `prettier --check`, etc.)
  2. Build / compile (e.g. `cargo build`, `npm run build`, etc.)
  3. Tests (e.g. `cargo test`, `npm test`, etc.)
- Run each step, wait for output, then decide whether to proceed. Do not batch them.
- Report any failures per step

Report: list of issues by severity (critical/warning/info), or approval
```

Fix any critical/warning issues by dispatching **general** subagent — **one issue at a time**, then re-review. **Maximum 2 fix attempts per issue.** If the same issue persists after 2 attempts, stop and escalate to the user with a clear description of what was tried and what failed. Do not loop.

### 4. CodeRabbit review
```bash
timeout 600 coderabbit review --prompt-only --base [base-branch]
```
Fix critical and warning issues — **one at a time**, waiting for each fix to complete before starting the next. Re-run only once after all fixes are applied. Do not re-run after every individual fix.

### 5. Open PR
```bash
git push -u origin [branch-name]
gh pr create --title "[title]" --body "$(cat <<'EOF'
## Summary
- [bullets]

## Test plan
- [ ] [verification steps]
EOF
)"
```

Report the PR URL to the user.
