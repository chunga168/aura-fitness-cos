---
name: security-compliance
description: Security & compliance audit runbook for scanning hardcoded secrets, inspecting OWASP Top 10 vulnerabilities, and verifying input sanitization.
---

# Security & Compliance Audit Runbook

Use this skill to audit project code, configuration files, and dependencies for security risks, privacy leaks, and vulnerability vulnerabilities.

---

## Security Audit Checklist

1. **Secret & Credential Scan**:
   - Grep search for patterns: `API_KEY=`, `SECRET=`, `PASSWORD=`, `PRIVATE_KEY=`, `Bearer `, `sk_live_`.
   - Ensure all sensitive keys reside in `.env` or secret stores, and `.env` is listed in `.gitignore`.

2. **OWASP Input & Payload Audit**:
   - Verify input fields sanitize against XSS, SQL injection, script injection, and path traversal (`../`).
   - Confirm authentication headers and token expirations are validated securely.

3. **Dependency Vulnerability Scan**:
   - Inspect package manifests for vulnerable or deprecated packages.

4. **Security Gate Sign-off**:
   - Update threat log in [docs/quality_security/SECURITY_THREAT_MODEL.md](file:///d:/Projects/ChungaFitness%20-%20w%20Chief%20of%20Staff/docs/quality_security/SECURITY_THREAT_MODEL.md).
