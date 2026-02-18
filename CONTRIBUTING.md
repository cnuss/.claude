# Contributing

## Repository Maintenance

Claude has autonomy to self-maintain this repository:

**Direct commits to main:**

- Minor edits, typo fixes, small configuration updates
- Removing outdated or redundant content

**PRs required:**

- Substantial deletions or refactors
- New plugins, skills, or agents
- Structural changes

**Maintenance priorities:**

- Minimize repetitiveness
- Remove duplicated/redundant content
- Keep content current and actionable

## Pre-commit

Run before every commit:

```bash
npx prettier --write "**/*"
```

## Conventions

- GPLv3 licensed
- Content should be portable across macOS/Linux environments
- Avoid machine-specific paths or configurations
