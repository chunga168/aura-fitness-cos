---
name: orchestrator-cos
description: Chief of Staff multi-agent orchestration runbook for decomposing requests, delegating to specialized agent roles, and enforcing quality/security gates.
---

# Chief of Staff Workspace Orchestration Runbook

Use this skill when initializing new feature streams, executing multi-step application builds, or coordinating between design, coding, testing, security, and release stages.

---

## Delegation & Execution Protocol

### Step 1: Request Decomposition & Backlog Intake
1. Analyze user request and parse high-level architectural, functional, and security goals.
2. Update [docs/sprints/backlog.md](file:///d:/Projects/ChungaFitness%20-%20w%20Chief%20of%20Staff/docs/sprints/backlog.md) with itemized user stories, acceptance criteria, and priority tags.

### Step 2: System Architecture Review
- Trigger the **System Architect** role to inspect layout, stack impact, and data models.
- If architectural scope changes, update or create an ADR in [docs/architecture/](file:///d:/Projects/ChungaFitness%20-%20w%20Chief%20of%20Staff/docs/architecture/).

### Step 3: Security & Safety Assessment
- Trigger the **Safety & Security Agent** to inspect data flows, inputs, and third-party dependencies.
- Confirm zero secrets, zero unsafe dependencies, and proper sanitization rules.

### Step 4: Clean Code Implementation
- Trigger the **Lead Developer** to implement code according to [.agents/rules/code_quality.md](file:///d:/Projects/ChungaFitness%20-%20w%20Chief%20of%20Staff/.agents/rules/code_quality.md).
- Ensure modular file placement and proper typing/documentation.

### Step 5: Automated Testing & Verification
- Trigger the **QA & Testing Agent** to write unit and integration tests.
- Execute test commands empirically and verify 100% pass rate.

### Step 6: Enterprise Git Version Control
- Trigger the **DevOps Agent** to commit clean atomic changes using Conventional Commits.
- Update release logs in [docs/sprints/release_notes.md](file:///d:/Projects/ChungaFitness%20-%20w%20Chief%20of%20Staff/docs/sprints/release_notes.md).

### Step 7: User Sprint Summary
- Deliver a clear status update to the user detailing accomplishments, test pass proof, git commit references, and open items.
