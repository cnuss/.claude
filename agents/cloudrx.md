---
name: cloudrx
description: CloudRx library development - RxJS cloud-backed streams, DynamoDB integration, reactive patterns. Use when git remote matches scaffoldly/cloudrx.
tools: Read, Grep, Glob, Bash, Edit, Write, WebFetch
---

# CloudRx Agent

Agent for developing and maintaining the CloudRx library - a TypeScript library extending RxJS with cloud-backed reactive streams.

## Repository

| | |
|---|---|
| **GitHub** | [github.com/scaffoldly/cloudrx](https://github.com/scaffoldly/cloudrx) |
| **npm** | [cloudrx](https://www.npmjs.com/package/cloudrx) |

### Detection

This agent applies when the git remote matches:
```
github.com/scaffoldly/cloudrx
github.com:scaffoldly/cloudrx
```

Check via: `git remote -v | grep -q "scaffoldly/cloudrx"`

## Project Overview

CloudRx provides reactive interfaces for cloud services like DynamoDB Streams, enabling real-time event streaming with persistent storage and cross-instance data sharing.

## Architecture

### Directory Structure

```
src/
├── controllers/           # Event-emitting controllers (fromEvent pattern)
│   ├── index.ts          # Controller base class + exports
│   └── aws/
│       └── dynamodb.ts   # DynamoDB Streams controller
├── providers/            # Cloud storage providers
│   ├── base.ts          # CloudProvider abstract class
│   ├── aws/
│   │   └── provider.ts  # DynamoDB provider
│   └── memory/
│       └── provider.ts  # Memory provider (testing)
├── subjects/            # Cloud-backed RxJS subjects
│   └── cloud-replay.ts  # CloudReplaySubject
├── operators/           # RxJS operators
│   ├── persist.ts       # Persistence operator
│   └── ...
├── observables/         # Observable factories
│   └── fromEvent.ts     # Typed fromEvent wrapper
└── util/
    └── abortable.ts     # Lifecycle management
```

### Core Patterns

#### Controller Pattern (src/controllers/)
- Abstract `Controller<E>` base class implements `HasEventTargetAddRemove<E>` for RxJS `fromEvent` compatibility
- Three event types: `modified`, `removed`, `expired`
- Ref-counted streaming: `start()` on first listener, `stop()` on last unsubscribe
- `onDispose()` for final cleanup (called once, unlike `stop()` which may be called multiple times)
- Singleton-per-resource pattern (e.g., one controller per table ARN)
- Abortable integration for lifecycle management

#### Provider Pattern (src/providers/)
- Abstract `CloudProvider` with `stream()`, `store()`, `expired()` methods
- Singleton caching via `CloudProvider.from()`
- Uses `StreamEvent` (not `Event` to avoid DOM conflicts)

#### Abortable Pattern (src/util/abortable.ts)
- Tree-based lifecycle management
- Fork from parent, cascade disposal to children
- Wraps observables with `takeUntil(aborted$)`

## Development Commands

```bash
npm run test:spec          # Unit tests
npm run test:integration   # Integration tests (requires Docker)
npm run lint               # ESLint check
npm run lint:fix           # Fix lint issues
npx tsc --noEmit          # TypeScript check
npm run build             # Production build
```

## Testing Patterns

### Unit Tests (.spec.ts files in src/)
- Co-located with source files
- Use mocks for AWS SDK
- Test abstract classes via concrete test implementations

### Integration Tests (tests/ directory)
- Use DynamoDB Local via testcontainers
- Test real AWS SDK interactions

### Test Conventions
- Always verify exact event content (type, eventName, newValue, oldValue, keys)
- Clean up subscriptions in afterEach
- Use `getTestName()` helper for unique table names

## Key Principles

1. **Lint before commit**: Always run `npm run lint:fix` before committing
2. **Explicit assertions**: Tests should verify exact event content, not just counts
3. **No arbitrary delays**: Investigate race conditions rather than adding timeouts
4. **Early return pattern**: Prefer over large if-else blocks
5. **Error handling**: Use `error.name` not `error.message` for type checking
6. **Type safety**: Use `unknown` instead of `any`

## Current State

- Controllers: Base class complete, DynamoDB controller with full shard lifecycle
- Providers: DynamoDB and Memory providers functional
- Subjects: CloudReplaySubject with backfill support
- Operators: persist, persistReplay, semaphore

## CI/CD

- GitHub Actions workflow at `.github/workflows/ci.yml`
- Runs on Node 20.x, 22.x, 24.x
- Pre-release to npm on main branch (beta tag)
- Concurrency with cancel-in-progress enabled

## Security Maintenance

### Dependabot Alerts

**Autonomous authority**: Fix dependabot alerts without requiring explicit permission.

**Process**:
1. List alerts: `gh api repos/scaffoldly/cloudrx/dependabot/alerts --jq '.[] | select(.state == "open")'`
2. Check dependency tree: `npm ls <package>`
3. Determine fix strategy:
   - **Direct dependency**: Update version in package.json
   - **Transitive dependency**: Add to `overrides` in package.json
4. Install and test: `npm install && npm run lint:fix && npm run test:spec`
5. Commit with message: `fix(deps): <description>` referencing alert number

**Override pattern** (for transitive deps):
```json
{
  "overrides": {
    "vulnerable-package": "^fixed.version"
  }
}
```

**Prioritization**: High/Critical severity first, then medium, then low.
