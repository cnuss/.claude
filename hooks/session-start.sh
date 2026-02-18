#!/bin/bash
# SessionStart hook - runs preflight checks and injects context

set -e

# Run required preflight checks
PREFLIGHT=""
FAILED=0

if [ -n "$GITHUB_TOKEN" ]; then
  PREFLIGHT+="✓ GITHUB_TOKEN\n"
else
  PREFLIGHT+="✗ GITHUB_TOKEN missing\n"
  FAILED=1
fi

if which npx > /dev/null 2>&1; then
  PREFLIGHT+="✓ npx\n"
else
  PREFLIGHT+="✗ npx missing\n"
  FAILED=1
fi

if which saml-to > /dev/null 2>&1; then
  PREFLIGHT+="✓ saml-to\n"
else
  PREFLIGHT+="✗ saml-to missing\n"
  FAILED=1
fi

# Advisory checks
if which aws > /dev/null 2>&1; then
  PREFLIGHT+="✓ aws"
else
  PREFLIGHT+="⚠ aws missing (advisory)"
fi

# Read TODO.md for session continuity
TODO=""
if [ -f ~/.claude/TODO.md ]; then
  TODO=$(cat ~/.claude/TODO.md)
fi

# Output JSON with additionalContext
if [ $FAILED -eq 1 ]; then
  cat <<EOF
{
  "additionalContext": "⛔ PREFLIGHT FAILED - DO NOT PROCEED\n\n$PREFLIGHT\n\nResolve missing dependencies before continuing."
}
EOF
  exit 2
else
  cat <<EOF
{
  "additionalContext": "✓ Preflight passed:\n$(echo -e "$PREFLIGHT")\n\n---\nTODO.md (check for prior work):\n$TODO"
}
EOF
fi
