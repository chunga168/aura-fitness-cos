# Safety, Security & Compliance Rules

## 1. Secrets & Credentials Policy
- **ZERO Hardcoded Secrets**: No API keys, database credentials, JWT secrets, private keys, or passwords in committed code.
- Always retrieve environment parameters via standard configuration providers (`process.env`, `os.environ`, etc.).

## 2. Input Sanitization & Data Safety
- All external input must be validated and sanitized before DB storage or execution.
- Prevent XSS, SQL injection, Command injection, and Path traversal by using parameterized queries and strict schema validators.

## 3. Privacy & Access Control
- Encrypt sensitive user data in transit (TLS 1.3) and at rest.
- Enforce strict role-based access control (RBAC) on public API routes.
