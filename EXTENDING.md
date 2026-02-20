# Extending

Proactively suggest and help implement:

- **Custom skills** — in `commands/` directory
- **Hooks** — for automation
- **GitHub Actions** — for scheduled tasks
- **MCP server configurations**
- **Community-discovered MCP servers and tools**

## Agents

### Directory Structure

Agent definitions live in `~/.claude/agents/` as the source of truth. Projects symlink to these:

```
~/.claude/agents/
├── cloudrx.md           # Source file
└── other-project.md     # Source file

~/project/agent/
└── cloudrx.md -> ../../../.claude/agents/cloudrx.md  # Relative symlink
```

### Agent Template

All agents should follow this structure:

```markdown
# {Project} Agent

Brief description of the project and agent purpose.

## Repository

| | |
|---|---|
| **GitHub** | [github.com/org/repo](https://github.com/org/repo) |
| **npm/package** | package-name (if applicable) |

### Detection

This agent applies when the git remote matches:
- `github.com/org/repo`
- `github.com:org/repo`

Check via: `git remote -v | grep -q "org/repo"`

## Project Overview

What the project does and its main purpose.

## Architecture

### Directory Structure
<!-- Tree view of key directories -->

### Core Patterns
<!-- Key architectural patterns used -->

## Development Commands

<!-- Common commands for development -->

## Testing Patterns

<!-- How tests are organized and run -->

## Key Principles

<!-- Numbered list of project-specific conventions -->

## Current State

<!-- Brief status of major components -->

## CI/CD

<!-- Build/deploy pipeline details -->
```

### Required Sections

Every agent MUST include:

1. **Repository** — GitHub URL and package registry links
2. **Detection** — Git remote pattern for identifying when agent applies
3. **Project Overview** — What the project does
4. **Development Commands** — How to build, test, lint
5. **Key Principles** — Project-specific conventions and rules

### Guidelines for Creating Agents

1. **Create agent when**: A project has distinct patterns, conventions, or domain knowledge worth preserving
2. **Source location**: `~/.claude/agents/{project}.md`
3. **Project symlink**: `{project}/agent/{project}.md` → `../../../.claude/agents/{project}.md` (relative path)
4. **Keep updated**: Update agent definitions as projects evolve — patterns change, new conventions emerge
5. **Lint before commit**: Always run project linters before committing changes

### Maintenance

**Discovering agents**: List active agents via `ls ~/.claude/agents/*.md`

**When updating agent structure or adding new standard sections**:
1. Update this template in EXTENDING.md
2. Discover all agents: `ls ~/.claude/agents/*.md`
3. Skip agents marked as archived (see below)
4. Retroactively update remaining agents to match new structure

### Archiving Agents

To mark an agent as archived (no longer actively maintained), add this signature at the top of the file:

```markdown
<!-- STATUS: ARCHIVED -->
```

Archived agents:
- Will not be retroactively updated when template changes
- Remain available for reference
- Can be un-archived by removing the signature
