# Git Workflow

## Push Policy

`git push` requires user confirmation (configured in settings.json `ask` list).

## Commit Thresholds

| Change Type                              | Action                |
| ---------------------------------------- | --------------------- |
| Minor edits, typos, small config updates | Direct commit to main |
| Substantial deletions or refactors       | Create PR             |
| New plugins, skills, or agents           | Create PR             |
| Structural changes                       | Create PR             |
