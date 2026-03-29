# Engineering Review Skill

## Overview
- **Name:** Engineering Review
- **Version:** 1.0.0
- **Description:** Technical architecture review. Lock in data flow, edge cases, diagrams, failure modes.
- **For Agent:** Coder, Architect agents

---

## Prime Directives

1. **Architecture first** - Before code, design
2. **Data flow mapping** - Every input to every output
3. **Failure modes** - Everything that can go wrong must be handled
4. **Edge cases** - Zero, empty, null, overflow, timeout
5. **Observability** - Logs, metrics, traces for every new path

---

## Review Steps

### Step 0: System Audit
Run:
```
- Check recent commits: git log --oneline -10
- Check existing architecture docs
- Check current tests
- Check dependencies
```

### Step 1: Data Flow Design
Map every data path:
- Input sources
- Processing steps
- Output destinations
- Error paths
- Async boundaries

### Step 2: State Machines
For any entity with states:
- All possible states
- Valid transitions
- Invalid transitions (what happens?)
- Timeouts

### Step 3: Failure Modes
For each component:
- What can fail?
- How is failure detected?
- How is failure handled?
- What does user see?
- Is it tested?

### Step 4: Edge Cases
- Null inputs
- Empty inputs
- Very large inputs
- Very small inputs
- Slow responses
- Fast responses
- Duplicate requests
- Race conditions
- Network failures
- Partial failures

### Step 5: Security Review
- Input validation
- Authentication
- Authorization
- Data sanitization
- SQL injection
- XSS
- CSRF

### Step 6: Diagram Required
Create ASCII diagrams for:
- Data flow pipelines
- State machines
- Request/response cycles
- Database schemas
- API contracts

---

## Output Format

```
# Engineering Review: [Component/Feature]

## Architecture
[ASCII diagram]

## Data Flow
| Input | Process | Output | Error |
|-------|---------|--------|-------|
| ... | ... | ... | ... |

## Failure Modes
| Failure | Detection | Handling | User Impact |
|---------|-----------|----------|-------------|
| ... | ... | ... | ... |

## Edge Cases
- [ ] Case 1
- [ ] Case 2

## Security
- [ ] Input validated
- [ ] Auth checked
- [ ] Data sanitized

## Tests Needed
1. Unit: [X]
2. Integration: [X]
3. E2E: [X]

## Observability
- Logs: [X]
- Metrics: [X]
- Traces: [X]
```

---

## Rules

1. **Diagrams mandatory** - No complex flow without diagram
2. **Name specific exceptions** - Not "handle errors" but "TimeoutException: after 30s"
3. **Test matrix** - What combinations need testing?
4. **Backward compatibility** - Any API changes?
5. **Performance** - Latency, throughput, scale

---

## When to Use

- Before implementing new features
- When designing APIs
- When creating data models
- Before database migrations
- When adding new integrations
