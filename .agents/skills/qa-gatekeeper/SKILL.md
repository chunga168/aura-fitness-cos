---
name: qa-gatekeeper
description: Quality Assurance runbook for generating unit/integration test suites, testing boundary conditions, and verifying 100% test passing before code merging.
---

# Quality Assurance & Test Verification Runbook

Use this skill to execute test commands, verify code coverage, analyze edge cases, and ensure zero regressions exist before releasing code changes.

---

## QA Execution Workflow

1. **Test Suite Discovery & Execution**:
   - Run the workspace test command (e.g., `npm test`, `pytest`, `flutter test`).
   - Read full test logs and verify 0 failures and 0 unhandled exceptions.

2. **Edge Case Injection Testing**:
   - Check boundary inputs: `null`, `undefined`, empty string `""`, max length strings, network timeouts, invalid JSON, concurrent async calls.
   - Verify fallback behaviors handle failures gracefully without crashing.

3. **Coverage Verification**:
   - Confirm critical business logic paths have test coverage (target: >85%).

4. **Regression Gate Seal**:
   - Sign off on QA gate in [docs/quality_security/QA_CHECKLIST.md](file:///d:/Projects/ChungaFitness%20-%20w%20Chief%20of%20Staff/docs/quality_security/QA_CHECKLIST.md).
