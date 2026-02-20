---
description: Audit and optimize ~/.claude for context window efficiency
---

Run a quick optimization audit of `~/.claude`. Check:

1. **Token budget** — measure auto-loaded content (CLAUDE.md + rules/*.md)

   ```bash
   echo "=== Auto-loaded files ===" && wc -l ~/.claude/CLAUDE.md ~/.claude/rules/*.md && echo "---" && cat ~/.claude/CLAUDE.md ~/.claude/rules/*.md | wc -l | xargs -I{} echo "Total: {} lines"
   ```

2. **Duplication** — scan for overlapping content across auto-loaded files

   ```bash
   for f in ~/.claude/CLAUDE.md ~/.claude/rules/*.md; do echo "=== $(basename $f) ===" && grep -i "^## \|^### " "$f"; done
   ```

3. **Agent validation** — verify agents match EXTENDING.md template

   ```bash
   for f in ~/.claude/agents/*.md; do
     name=$(basename "$f" .md)
     echo "=== $name ==="
     grep -q "## Repository" "$f" && echo "  ✓ Repository" || echo "  ✗ Repository"
     grep -q "### Detection" "$f" && echo "  ✓ Detection" || echo "  ✗ Detection"
     grep -q "## Project Overview" "$f" && echo "  ✓ Project Overview" || echo "  ✗ Project Overview"
     head -1 "$f" | grep -q "^---" && echo "  ✓ Frontmatter" || echo "  ✗ Frontmatter"
   done
   ```

4. **Broken references** — check for dead links in auto-loaded files

5. **Recommendations** — suggest what could move from rules (always-loaded) to commands (on-demand)

Present findings as a concise report and offer to fix any issues found.
