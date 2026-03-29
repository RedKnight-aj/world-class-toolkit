# Ship Skill

## Overview
- **Name:** Ship
- **Version:** 1.0.0
- **Description:** Automated deployment. Sync, test, build, deploy, notify.
- **For Agent:** Coder agent for automated releases

---

## Prime Directives

1. **Never force push to main** - Only merge via PR
2. **Tests must pass** - No exceptions
3. **Small diffs** - Easier to review, safer to ship
4. **Rollback plan** - Know how to undo
5. **Notify user** - Always confirm completion

---

## Workflow Steps

### Step 1: Pre-flight Checks
```bash
# Check current branch
git branch

# Check diff size
git diff main --stat

# Check tests
npm test 2>&1 | tail -20

# Check lint
npm run lint 2>&1 | tail -10
```

### Step 2: Sync Main
```bash
# Fetch latest
git fetch origin main

# Check if main has advanced
git log --oneline origin/main -1
git log --oneline HEAD -1

# If main ahead, rebase or merge
git rebase origin/main
```

### Step 3: Run Tests
```bash
# Full test suite
npm test

# If tests fail, STOP and report
```

### Step 4: Build
```bash
# Production build
npm run build

# Verify build output exists
ls -la dist/
```

### Step 5: Commit & Push
```bash
# Stage changes
git add -A

# Commit with conventional message
git commit -m "feat: $(git diff --stat main | tail -1)"

# Push branch
git push -u origin HEAD
```

### Step 6: Create PR
```bash
# Create PR (using gh CLI)
gh pr create --fill
```

### Step 7: Wait for CI
```bash
# Wait for checks
gh pr checks

# If CI fails, STOP
```

### Step 8: Merge
```bash
# Merge after checks pass
gh pr merge --squash --auto
```

---

## Output Format

```
# Ship Report: [Branch]

## Pre-flight
- [✅] Tests pass
- [✅] Lint clean
- [✅] Build succeeds

## Changes
- Files: X
- Additions: +X
- Deletions: -X

## Deployment
- Branch pushed: [branch-name]
- PR created: [url]
- CI status: [pending/passing/failing]

## Result
- [SUCCESS] Merged to main
- [FAILED] Tests failed
```

---

## Rollback Procedure

If deployment fails:

```bash
# Option 1: Revert commit
git revert HEAD
git push origin main

# Option 2: Reset (if not pushed)
git reset --hard HEAD~1

# Option 3: Deploy previous tag
git checkout v1.2.3
git push --force origin main
```

---

## Notifications

After ship:
- ✅ Send Telegram message to user
- ✅ Update status
- ✅ Log to audit

---

## Rules

1. **Never skip tests** - No exceptions
2. **Never force push** - Main is sacred
3. **Small PRs** - Under 400 lines preferred
4. **Clear messages** - Conventional commits
5. **Verify before merge** - Wait for CI

---

## When to Use

- After feature complete
- After bug fixed
- After refactoring
- Before release
- On demand from user
