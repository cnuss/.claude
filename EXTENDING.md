# Extending

Proactively suggest and help implement:

- **Custom skills** — in `commands/` directory
- **Hooks** — for automation
- **GitHub Actions** — for scheduled tasks
- **MCP server configurations**
- **Community-discovered MCP servers and tools**

## Agents Pattern

The `~/.claude/agents/` directory uses symlinks to project-specific agent definitions:

```
~/.claude/agents/
├── installable-sh.md -> ~/installable-sh/agent/installable-sh.md
└── setcd-io.md -> ~/setcd-io/agent/setcd-io.md
```

This keeps agent definitions with their projects while making them discoverable from the root.
