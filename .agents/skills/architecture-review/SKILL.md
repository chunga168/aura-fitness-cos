---
name: architecture-review
description: Technical architecture review runbook for validating system design, data modeling, scalability, and modular boundary definitions.
---

# Technical Architecture Review Runbook

Use this skill when evaluating framework selections, creating new major app modules, designing database schemas, or restructuring core components.

---

## Architectural Review Steps

1. **Boundary & Dependency Audit**:
   - Confirm components follow high cohesion, low coupling principles.
   - Verify state management, business logic, and UI layer separation.

2. **Architecture Decision Record (ADR) Generation**:
   - Write/update an ADR file in `docs/architecture/ADR-xxx.md`.
   - Include: Context, Decision Drivers, Considered Options, Chosen Decision, and Consequences.

3. **Performance & Scalability Check**:
   - Assess async handling, network round-trips, bundle size impact, and memory footprints.
   - Ensure dynamic math and responsive layouts are used rather than hardcoded magic offsets.

4. **Hand-off to Lead Developer**:
   - Provide clear interface definitions and contract specs for implementation.
