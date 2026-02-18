# Commit Conventions

## Format

```
<type>[optional scope]: <summary>

[optional body]

Co-Authored-By: Claude <noreply@anthropic.com>
```

## Types

| Type       | Usage                                   |
| ---------- | --------------------------------------- |
| `feat`     | New feature                             |
| `fix`      | Bug fix                                 |
| `docs`     | Documentation only                      |
| `chore`    | Maintenance, dependencies               |
| `refactor` | Code change that neither fixes nor adds |
| `test`     | Adding or updating tests                |
| `ci`       | CI/CD changes                           |

## Scope (optional)

Use to indicate area: `feat(constitution):`, `fix(settings):`, `docs(readme):`

## Guidelines

- Summary: imperative mood, lowercase, no period, ~50 chars
- Body: explain "why" not "what" when needed
- Co-Author: always include when Claude contributes
