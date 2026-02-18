# .claude

![Status: WIP](https://img.shields.io/badge/status-WIP-yellow)

> **Work in Progress** — This repository is under active development. Structure and conventions may change.

Centralized "dotfiles"-style repository for Claude Code configuration.

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
