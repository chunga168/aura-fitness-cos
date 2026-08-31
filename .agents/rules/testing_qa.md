# QA & Automated Testing Rules

## 1. Test Verification Mandate
- No feature is considered completed until all accompanying unit and integration tests are passing cleanly.
- Never comment out, bypass, or delete failing tests to force a build to pass.

## 2. Test Coverage & Edge Cases
- Test happy paths, boundary parameters (0, null, max values), error paths, network failures, and edge cases.
- Maintain a target test coverage of >85% for core business logic.

## 3. Log Inspection Before Diagnosis
- Inspect complete error tracebacks before forming hypotheses for test failures.
- Fix underlying contracts rather than patching symptoms with superficial fallback wrappers.
