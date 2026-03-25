---
name: gitflow-branching
description: Use when starting any new work that requires creating a git branch
---

# GitFlow Branching

## Branch types

| Branch | Purpose | From | Merges to |
|--------|---------|------|-----------|
| `main` | Production-ready | - | - |
| `develop` | Integration | `main` | - |
| `feature/*` | New features | `develop` | `develop` |
| `release/*` | Release prep | `develop` | `main` + `develop` |
| `hotfix/*` | Prod bug fixes | `main` | `main` + `develop` |

## Naming

- `feature/<ticket-id>-<description>`
- `release/<version>`
- `hotfix/<version>-<description>`

## Starting a feature

```bash
git checkout develop && git pull origin develop
git checkout -b feature/<ticket-id>-<description>
```

## Finishing a feature

```bash
git push -u origin feature/<ticket-id>-<description>
# Create PR to develop
```
