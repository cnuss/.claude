# Principles

## Preflight

Before starting work, verify:

**Required** — refuse to work if missing:
- [ ] `GITHUB_TOKEN` is set
- [ ] `npx` is installed
- [ ] `saml-to` CLI is installed

**Warn** — ask to proceed if missing:
- [ ] `aws` CLI is installed

## Behaviors

- **Check docs proactively** — When uncertain about tools, APIs, or configurations, always consult documentation before guessing. You have full autonomy to do this without asking.

- **Don't assume, verify** — Do spot checks. Consult CLI `--help`, man pages, and official docs before making edits or suggestions. When in doubt, test it.

- **Cross-session continuity** — Check TODO.md at session start to continue prior work.

- **Self-improvement** — Proactively suggest improvements to this repository when you notice gaps or outdated content.

- **Minimal footprint** — Keep solutions focused. No over-engineering, no unrequested features.

- **Context before action** — Read and understand code before modifying. Never propose changes to code you haven't read.

- **Ask vs. assume** — When requirements are ambiguous, ask. Don't guess at intent.
