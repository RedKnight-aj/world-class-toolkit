# Master Workflow Skill

## Overview
- **Name:** Workflow Master
- **Description:** Orchestrates the complete development workflow using specialized skills
- **For Agent:** Main orchestrator

---

## Workflow Patterns

### Pattern 1: New Feature

```
User Request → CEO Review → Engineering Review → Implementation → QA Review → Ship
```

| Step | Skill | Purpose |
|------|-------|---------|
| 1 | CEO Review | Validate idea, find 10x opportunity |
| 2 | Engineering Review | Design architecture, plan implementation |
| 3 | Implementation | Write code using coder agent |
| 4 | QA Review | Test coverage, quality check |
| 5 | Ship | Deploy to production |

### Pattern 2: Bug Fix

```
Bug Report → Security Review → Fix → QA Review → Ship
```

| Step | Skill | Purpose |
|------|-------|---------|
| 1 | Understand | Read bug report, reproduce |
| 2 | Security Review | Check for security implications |
| 3 | Fix | Implement solution |
| 4 | QA Review | Verify fix works |
| 5 | Ship | Deploy |

### Pattern 3: Refactor

```
Scope → Security Review → Code Review → QA Review → Ship
```

| Step | Skill | Purpose |
|------|-------|---------|
| 1 | Define Scope | What needs refactoring? |
| 2 | Security Review | Check for vulnerabilities |
| 3 | Code Review | Quality check |
| 4 | QA Review | Ensure tests pass |
| 5 | Ship | Deploy |

---

## Skill Selection Guide

### When to Use CEO Review
- New project or major feature
- Unclear requirements
- Strategic decisions
- Scope undefined

### When to Use Engineering Review
- Designing APIs
- Creating data models
- New integrations
- Before implementation

### When to Use Security Review
- User authentication
- Data handling
- API endpoints
- Before production

### When to Use QA Review
- Before release
- After implementation
- Test coverage gaps
- Quality verification

### When to Use Ship
- Feature complete
- Tests passing
- Ready to deploy
- User approved

---

## Workflow Examples

### Example 1: Build New Feature

```
User: "Add user dashboard"

→ CEO Review
  "The dashboard should show analytics, not just stats. 
   10x version: Real-time metrics + AI insights."

→ Engineering Review  
  "Data flow: API → Transform → Cache → UI"
  "Failure modes: API timeout, cache miss, render error"

→ Implementation
  "Building dashboard with real-time updates..."

→ QA Review
  "Test coverage: 85%. Missing: empty state tests"

→ Ship
  "Deployed to production. Ready for user."
```

### Example 2: Security Audit

```
User: "Audit login system"

→ Security Review
  "Critical: Passwords use MD5 (should be bcrypt)
   High: No rate limiting on login endpoint
   Medium: Session timeout 24 hours (should be 1 hour)"
   
→ Report
  "Found 5 issues. 1 critical, 2 high, 2 medium."
```

---

## Integration Points

### With gstack Skills
These OpenClaw skills complement gstack:
- CEO Review = gstack plan-ceo-review
- Eng Review = gstack plan-eng-review
- Security Review = gstack review (expanded)
- QA Review = gstack qa
- Ship = gstack ship

### With Existing Agents
- CEO Review → Spawns researcher
- Engineering Review → Spawns coder
- Security Review → Spawns auditor
- QA Review → Spawns ai-tester
- Ship → Spawns coder with deployment

---

## Best Practices

1. **Never skip CEO Review** - Even for small features
2. **Security first** - Review auth/data before implementation
3. **Tests mandatory** - QA Review required before ship
4. **Small changes** - Easier to review, safer to ship
5. **Always notify** - User should know what's happening

---

## Quick Reference

| Command | Skill | When |
|---------|-------|------|
| `/review-strategy` | CEO Review | New projects |
| `/design` | Engineering Review | APIs, data models |
| `/audit` | Security Review | Auth, data, APIs |
| `/test` | QA Review | Pre-release |
| `/ship` | Ship | Ready to deploy |

---

## Version History

- v1.0.0 - Initial release with 5 skills
