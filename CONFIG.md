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
    "allow": ["Bash(git *)"],
    "ask": ["Bash(git push *)"],
    "deny": ["Bash(rm -rf *)"]
  }
}
```

## Environment Variables

| Variable                               | Purpose                         |
| -------------------------------------- | ------------------------------- |
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | Enables agent team coordination |
