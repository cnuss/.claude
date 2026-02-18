# .claude

![Status: WIP](https://img.shields.io/badge/status-WIP-yellow)

> **Work in Progress** — This repository is under active development. Structure and conventions may change.

Centralized "dotfiles"-style repository for Claude Code configuration.

## Features

### 🏛️ Constitution

A binding set of rules in [CONSTITUTION.md](CONSTITUTION.md) that govern Claude's behavior:

- **Preflight checks** — Required tools and tokens verified before work begins
- **Verification discipline** — Consult docs, don't assume; test when uncertain
- **Session continuity** — Check TODO.md to resume prior work
- **Minimal footprint** — Focused solutions, no over-engineering

### 🪝 Hooks

A `SessionStart` hook ([hooks/session-start.sh](hooks/session-start.sh)) bootstraps every session:

```
✓ GITHUB_TOKEN
✓ npx
✓ saml-to
✓ aws
```

- Runs preflight checks from the Constitution
- Blocks session if required checks fail
- Auto-configures plugin marketplaces
- Auto-installs configured plugins
- Injects TODO.md for session continuity

### 📜 Modular Rules

Reusable rules in `rules/` applied across all projects:

| Rule                  | Purpose                           |
| --------------------- | --------------------------------- |
| `aws-readonly.md`     | Restrict AWS to read-only by default |
| `code-style.md`       | Minimal footprint, context-first  |
| `commit-conventions.md` | Conventional commits format     |
| `git-workflow.md`     | Push confirmation, PR thresholds  |

### 🔌 Auto-Configured Plugins

Plugins are auto-installed on session start:

- `gopls-lsp` — Go language server integration
- `frontend-design` — Production-grade UI generation

### 🤖 Agent Teams

`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` enabled — spawn and coordinate specialized agents across repositories.

## Usage

```bash
# Clone to ~/.claude
git clone git@github.com:cnuss/.claude.git ~/.claude
```

## Structure

| File              | Purpose                            |
| ----------------- | ---------------------------------- |
| `CLAUDE.md`       | Root identity and entry point      |
| `CONSTITUTION.md` | Binding rules and preflight checks |
| `settings.json`   | Model, plugins, permissions        |
| `TODO.md`         | Cross-session task tracking        |

| Directory  | Purpose                              |
| ---------- | ------------------------------------ |
| `agents/`  | Custom agent definitions             |
| `skills/`  | Custom slash commands                |
| `rules/`   | Modular rules                        |
| `.claude/` | Symlinks for project-level discovery |

## Environments

- Local machines — clone to `~/.claude`
- GitHub Codespaces — mount to `~/.claude`
- Claude Code Environments
- Other agentic environments

## License

GPLv3
