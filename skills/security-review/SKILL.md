# Security Review Skill

## Overview
- **Name:** Security Review
- **Version:** 1.0.0
- **Description:** Comprehensive security audit. Find vulnerabilities before attackers do.
- **For Agent:** Auditor, AI-Security agents

---

## OWASP Top 10 Coverage

Always check for:
1. **Injection** - SQL, NoSQL, Command
2. **Broken Auth** - Session, Credentials
3. **Sensitive Data** - Exposure, Encryption
4. **XML External Entities** - XXE
5. **Broken Access Control** - IDOR, privilege
6. **Security Misconfig** - Headers, defaults
7. **XSS** - Stored, Reflected, DOM
8. **Insecure Deserialization**
9. **Using Components with Known Vulnerabilities**
10. **Insufficient Logging & Monitoring**

---

## Review Steps

### Step 1: Authentication Check
- [ ] Passwords properly hashed?
- [ ] Sessions secure?
- [ ] MFA available?
- [ ] Password reset secure?
- [ ] Brute force protection?

### Step 2: Authorization Check
- [ ] Role-based access?
- [ ] Object-level authorization?
- [ ] Privilege escalation prevented?
- [ ] Default deny?

### Step 3: Input Validation
- [ ] All inputs validated?
- [ ] Whitelist over blacklist?
- [ ] Length limits?
- [ ] Type checking?
- [ ] SQL injection prevented?

### Step 4: Output Encoding
- [ ] XSS prevented?
- [ ] HTML encoded?
- [ ] URLs encoded?
- [ ] JSON encoded?

### Step 5: Data Protection
- [ ] Sensitive data encrypted at rest?
- [ ] TLS in transit?
- [ ] Keys protected?
- [ ] Secrets not in code?
- [ ] PII handled properly?

### Step 6: API Security
- [ ] Rate limiting?
- [ ] CORS configured?
- [ ] CSRF tokens?
- [ ] Proper HTTP methods?
- [ ] Input limits?

### Step 7: Dependency Check
- [ ] Known CVEs?
- [ ] Outdated packages?
- [ ] Supply chain risks?

---

## Common Vulnerabilities

### Code Review Focus
```python
# BAD: SQL Injection
query = f"SELECT * FROM users WHERE id = {user_id}"

# GOOD: Parameterized
query = "SELECT * FROM users WHERE id = ?"
cursor.execute(query, (user_id,))

# BAD: Command Injection
os.system(f"ping {host}")

# GOOD: Subprocess with args
subprocess.run(["ping", host])

# BAD: Path Traversal
with open(f"/uploads/{filename}") as f:

# GOOD: Validate path
SAFE_DIR = "/uploads"
path = os.path.realpath(f"{SAFE_DIR}/{filename}")
if not path.startswith(SAFE_DIR):
    raise ValueError("Invalid path")
```

### Authentication Issues
- [ ] No default passwords
- [ ] Session timeout
- [ ] Secure cookie flags
- [ ] Password complexity
- [ ] Account lockout

---

## Output Format

```
# Security Audit: [Component]

## Critical Issues
| Issue | Severity | Location | Remediation |
|-------|----------|----------|-------------|
| ... | ... | ... | ... |

## High Issues
| Issue | Severity | Location | Remediation |
|-------|----------|----------|-------------|
| ... | ... | ... | ... |

## Medium Issues
| Issue | Severity | Location | Remediation |
|-------|----------|----------|-------------|
| ... | ... | ... | ... |

## Findings Summary
- Critical: X
- High: X
- Medium: X
- Low: X

## Recommended Actions
1. [Immediate] ...
2. [This Sprint] ...
3. [Next Sprint] ...

## Tools Used
- Static analysis
- Dependency scan
- Manual review
```

---

## Severity Levels

| Level | Description |
|-------|-------------|
| Critical | Immediate exploit, data breach risk |
| High | Serious vulnerability, likely exploitable |
| Medium | Moderate risk, needs fixing |
| Low | Minor issue, should fix |

---

## When to Use

- Before deploying to production
- After major code changes
- During security audits
- Before release
- After dependency updates
