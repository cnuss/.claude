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
  PREFLIGHT+="⚠ saml-to missing (advisory)\n"
fi

# Advisory checks
if which aws > /dev/null 2>&1; then
  PREFLIGHT+="✓ aws"
else
  PREFLIGHT+="⚠ aws missing (advisory)"
fi

# Auto-configure marketplaces and install plugins
MARKETPLACES=(
  "anthropics/claude-plugins-official"
)

PLUGINS_TO_INSTALL=(
  "gopls-lsp@claude-plugins-official"
  "frontend-design@claude-plugins-official"
)

# Add marketplaces if not already configured
for marketplace in "${MARKETPLACES[@]}"; do
  if ! claude plugin marketplace list 2>/dev/null | grep -q "$marketplace"; then
    claude plugin marketplace add "$marketplace" 2>/dev/null || true
  fi
done

# Install plugins if missing
PLUGINS_FILE=~/.claude/plugins/installed_plugins.json
for plugin in "${PLUGINS_TO_INSTALL[@]}"; do
  if ! grep -q "\"$plugin\"" "$PLUGINS_FILE" 2>/dev/null; then
    claude plugin install "$plugin" --scope user 2>/dev/null || true
  fi
done

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
  "additionalContext": "✓ Preflight passed:\n$(echo -e "$PREFLIGHT")"
}
EOF
fi
