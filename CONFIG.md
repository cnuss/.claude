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
    "allow": ["Bash(git *)", "Bash(git *$*)"],
    "ask": ["Bash(git push *)"],
    "deny": ["Bash(rm -rf *)"]
  }
}
```

### Pattern Notes

| Pattern | Matches | Use Case |
| ------- | ------- | -------- |
| `git *` | Simple git commands | `git status`, `git add .` |
| `git *$*` | Commands with `$(...)` | Heredoc commit messages |

The `*$*` pattern is required because glob matching doesn't recognize command substitution within `git *`.

## Environment Variables

| Variable                               | Purpose                         |
| -------------------------------------- | ------------------------------- |
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | Enables agent team coordination |
