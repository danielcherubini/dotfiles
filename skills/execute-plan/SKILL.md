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
    - Run tests to verify
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
- Do all tests pass? (run the test suite)

Report: list of issues by severity (critical/warning/info), or approval
```

Fix any critical/warning issues by dispatching **general** subagent, then re-review.

### 4. CodeRabbit review
```bash
timeout 600 coderabbit review --prompt-only --base [base-branch]
```
Fix critical and warning issues. Re-run until clean or only info-level remains.

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
