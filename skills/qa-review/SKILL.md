# QA Review Skill

## Overview
- **Name:** QA Review
- **Version:** 1.0.0
- **Description:** Comprehensive testing review. Verify quality before release.
- **For Agent:** AI-Tester agent

---

## Test Coverage Requirements

### Must Have
- [ ] Unit tests for business logic
- [ ] Integration tests for APIs
- [ ] E2E tests for critical paths

### Should Have
- [ ] Property-based tests
- [ ] Mutation testing
- [ ] Performance tests

### Nice to Have
- [ ] Chaos engineering
- [ ] Contract testing
- [ ] Visual regression

---

## Review Steps

### Step 1: Test Discovery
Find all test files:
```
find . -name "*test*" -o -name "*spec*" | head -50
```

### Step 2: Coverage Analysis
- What percentage is covered?
- Critical paths tested?
- Edge cases covered?

### Step 3: Test Quality
- [ ] Tests are isolated?
- [ ] Tests are independent?
- [ ] Tests are idempotent?
- [ ] Good assertions?
- [ ] Meaningful names?

### Step 4: Critical Path Testing
Map the happy path:
1. User lands on page
2. User logs in
3. User performs action
4. System responds
5. User sees result

### Step 5: Edge Case Testing
- [ ] Empty states
- [ ] Error states
- [ ] Loading states
- [ ] Offline states
- [ ] Timeout states
- [ ] Permission denied

### Step 6: Browser/UI Testing
- [ ] Responsive design
- [ ] Cross-browser
- [ ] Accessibility
- [ ] Performance

### Step 7: Security Testing
- [ ] Auth required?
- [ ] Input validation?
- [ ] XSS prevention?

---

## Test Categories

### 1. Unit Tests
- Test single functions/methods
- Mock dependencies
- Fast execution
- High coverage target

### 2. Integration Tests
- Test multiple components
- Real database (or test db)
- Test API contracts

### 3. E2E Tests
- Test complete flows
- Real browser
- Realistic data

---

## Output Format

```
# QA Report: [Feature/Component]

## Test Coverage
| Type | Count | Coverage |
|------|-------|----------|
| Unit | X | X% |
| Integration | X | X% |
| E2E | X | - |

## Critical Path Status
| Step | Tested | Status |
|------|--------|--------|
| 1 | Yes | ✅ |
| 2 | Yes | ✅ |
| 3 | No | ❌ |

## Edge Cases
| Case | Covered | Test Name |
|------|---------|-----------|
| Empty | Yes | test_empty_state |
| Error | No | - |

## Issues Found
| Issue | Severity | Fix |
|-------|----------|-----|
| Missing test | High | Add test_xxx |

## Recommendations
1. Add integration tests for API
2. Fix edge case coverage
3. Increase unit test coverage

## Quality Score
/ 100
```

---

## Test Naming Conventions

```
# Good
test_user_can_login_with_valid_credentials()
test_api_returns_404_for_missing_resource()
test_empty_cart_shows_message()

# Bad
test_login()
test_api()
test_cart()
```

---

## Assertion Best Practices

```python
# Good - Specific assertions
assert response.status_code == 200
assert user.name == "John"
assert len(items) == 5

# Bad - Weak assertions
assert response
assert user
assert items
```

---

## When to Use

- Before releasing features
- After code changes
- During code review
- After refactoring
- On CI failure
