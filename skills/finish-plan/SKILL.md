---
name: finish-plan
description: Use when a plan's PR is ready to merge — marks the plan completed, checks PR status, merges to main, and syncs local main
---

# Finish Plan

Complete the plan lifecycle: mark it done, merge the PR, sync local main.

## When to Use

- After a plan's PR is open and all reviews/CI have passed
- When the user says "merge this", "ship it", "finish up", or "land this"
- After `execute-plan` has opened the PR

**Don't use when:**
- PR has failing CI — fix issues first
- Plan doesn't have a PR yet — use `execute-plan` to create one
- Design isn't approved yet — use `brainstorming`

## Process

### 1. Check PR Status

```bash
gh pr view [PR-NUMBER] --json state,statusCheckRollup,reviewDecision,mergeable
```

Verify all of:
- **State**: `OPEN`
- **CI checks**: All passing (green)
- **Reviews**: Approved (or no review required)
- **Mergeable**: `MERGEABLE`

If any check fails, **stop and report**. Do not force-merge.

### 2. Merge the PR

```bash
gh pr merge [PR-NUMBER] --squash --delete-branch
```

Use squash merge by default to keep main history clean. If the user prefers merge commits, use `--merge` instead.

### 3. Sync Local Main

```bash
git checkout main
git pull origin main
```

### 4. Update Plan Index

Edit `docs/plans/README.md`:

1. Change the plan's status emoji from 🚧 to ✅
2. Add the PR number and key git refs to the entry (if not already present)
3. Update Quick Stats: decrement remaining count, increment completed count
4. If the plan was in the "Remaining Work" table, move it to the appropriate "Completed Plans" category

Commit the update:

```bash
git add docs/plans/README.md
git commit -m "docs: mark [plan-name] as completed (PR #[number])"
```

### 5. Report

Tell the user:
- PR was merged (with link)
- Local main is synced
- Plan index is updated
- Any follow-up items noted in the plan

## Common Issues

| Issue | Action |
|-------|--------|
| CI still running | Wait and re-check, or ask user if they want to proceed |
| Review requested but not approved | Ask user if they want to merge anyway |
| Merge conflicts on PR | Do NOT merge locally. Ask user to resolve on the branch. |
| PR already merged | Skip merge step, sync main, update index |
| Plan not in README.md | Add it as ✅ COMPLETED with the PR number |

## Rules

- **Never force-merge a PR with failing CI** — always report the issue
- **Always sync main after merge** — prevents stale branch issues
- **Always update the plan index** — this is the single source of truth for plan status
- **Use squash merge by default** — keeps main history clean
