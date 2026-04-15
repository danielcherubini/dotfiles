---
name: execute-plan
description: Use when you have a written implementation plan to execute
---

# Execute Plan

Read the plan, create a feature branch, dispatch subagents per task, review the branch, open a PR.

## Branch Setup
- Create feature branch using gitflow conventions (load `gitflow-branching` skill if needed)
- Create a todo list with `manage_todo_list` with all tasks from the plan

## Task Dispatch Protocol

For each task, dispatch a `general` subagent (sequentially, not parallel):

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
- **DONE:** Mark task complete in todo list, move to next task
- **NEEDS_CONTEXT:** Provide missing info, re-dispatch
- **BLOCKED:** Assess blocker, provide help or escalate to user

**Important:** Dispatch tasks sequentially (not in parallel) to avoid file conflicts.

## After All Tasks Complete

Once all tasks are done, ask the user what to do next:

```
ask({
  questions: [{
    id: "next-step",
    question: "All tasks complete. What would you like to do next?",
    options: [
      { label: "Code review then PR" },
      { label: "Open PR only" },
      { label: "Code review only" },
      { label: "Finish plan" }
    ]
  }]
})
```

Then follow the user's choice immediately — do NOT ask for additional confirmation.

### Code Review then PR

1. Dispatch the **reviewer subagent** with: "Review the implementation against the plan at `docs/plans/YYYY-MM-DD-<feature>.md`. Check that all acceptance criteria are met and no planned work was missed."
2. Fix any critical/major issues from reviewer verdict
3. Load the `code-review` skill to run CodeRabbit review
4. Fix critical/warning issues ONE AT A TIME
5. Re-run CodeRabbit review once after all fixes
6. If issues persist, escalate to user
7. Then proceed to **Open PR** below

### Code Review only

1. Dispatch the **reviewer subagent** with: "Review the implementation against the plan at `docs/plans/YYYY-MM-DD-<feature>.md`. Check that all acceptance criteria are met and no planned work was missed."
2. Fix any critical/major issues from reviewer verdict
3. Load the `code-review` skill to run CodeRabbit review
4. Fix critical/warning issues ONE AT A TIME
5. Re-run CodeRabbit review once after all fixes
6. If issues persist, escalate to user

### Open PR only

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

### Finish Plan

Load the `finish-plan` skill to check PR status, merge to main, and update the plan index.

## Update Plan Index

After a PR is opened, update `docs/plans/README.md`:
1. Change the plan's status from 🚧 IN PROGRESS to ✅ COMPLETED
2. Add the PR number and key git commit refs to the entry
3. Decrement remaining count, increment completed count in Quick Stats
4. Commit this update with message: `docs: mark [plan-name] as completed`