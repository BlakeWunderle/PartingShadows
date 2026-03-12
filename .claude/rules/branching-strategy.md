# Branching Strategy

## Branch Types

### `main`
- Production-ready code. Every commit on `main` should build and run.
- Releases are cut from `main` by tagging (e.g., `git tag v1.0.0`).
- **Never force-push to main.**
- Direct commits to `main` are only allowed for trivial hotfixes (typo, broken build).

### `dev`
- Primary integration branch. Feature branches merge here first.
- When `dev` is stable and tested, it merges into `main` via PR.
- Stays close to `main` -- merge `main` back into `dev` after each release.

### `feature/*`
- Short-lived branches for individual features or tasks.
- Branch from `dev`, merge back into `dev` via PR.
- Naming: `feature/<short-description>` (e.g., `feature/settings-system`, `feature/story-4-act1`).
- Delete after merge.

### `fix/*`
- Bug fix branches. Same workflow as feature branches.
- Naming: `fix/<short-description>` (e.g., `fix/save-corruption`, `fix/balance-monk`).

### `release/*`
- Optional. Used when preparing a release that needs stabilization.
- Branch from `dev`, only bug fixes allowed, merges into both `main` and `dev`.
- Naming: `release/v1.0.0`.

## Workflow

### Starting new work
```bash
git checkout dev
git pull origin dev
git checkout -b feature/my-feature
```

### Finishing a feature
1. Push the feature branch: `git push -u origin feature/my-feature`
2. Create PR: `feature/my-feature` -> `dev`
3. After merge, delete the feature branch

### Cutting a release
1. Merge `dev` into `main` via PR
2. Tag on `main`: `git tag v1.0.0 && git push origin v1.0.0`
3. CI/CD builds and creates a draft GitHub Release automatically
4. Merge `main` back into `dev` to pick up the tag

## Rules for Claude Code

- When starting a new task, check if a `dev` branch exists. If so, branch from `dev`.
- If no `dev` branch exists yet, create it from `main` before starting work.
- Always confirm with the user before creating PRs or pushing branches.
- Commit messages follow the conventions in `commit-workflow.md`.
- Do not merge branches without user approval.
