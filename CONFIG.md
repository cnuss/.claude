# Configuration

## Files

| File                  | Purpose                                           |
| --------------------- | ------------------------------------------------- |
| `settings.json`       | Claude Code settings, model, plugins, permissions |
| `settings.local.json` | Machine-specific overrides (not synced)           |
| `TODO.md`             | Cross-session task tracking                       |

## Permissions

Evaluation order: `deny` → `ask` → `allow` (first match wins)

```json
{
  "permissions": {
    "allow": ["Bash(git *)", "Bash(git -C * *)", "Bash(git *$*)"],
    "ask": ["Bash(git push *)", "Bash(git -C * push *)", "Bash(git -C * push)"],
    "deny": ["Bash(rm -rf *)"]
  }
}
```

### Pattern Notes

### Allow Patterns

| Pattern | Matches | Use Case |
| ------- | ------- | -------- |
| `git *` | Simple git commands | `git status`, `git add .` |
| `git -C * *` | Commands with `-C path` | `git -C /path status` |
| `git *$*` | Commands with `$(...)` | Heredoc commit messages |

### Ask Patterns

| Pattern | Matches | Use Case |
| ------- | ------- | -------- |
| `git push *` | Direct push | `git push origin main` |
| `git -C * push *` | Push with `-C path` | `git -C /path push origin` |
| `git -C * push` | Push with `-C`, no args | `git -C /path push` |

## Environment Variables

| Variable                               | Purpose                         |
| -------------------------------------- | ------------------------------- |
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | Enables agent team coordination |
