# ADR-001: Chief of Staff Multi-Agent Workspace Orchestration

- **Status**: Approved
- **Date**: 2026-08-31
- **Author**: System Architect & Chief of Staff

## Context
Building sustainable, production-grade applications requires structured coordination between system architecture, clean implementation, quality assurance, safety/security compliance, and enterprise version control. Without a clear governance model, rapid development can introduce technical debt, missing tests, security vulnerabilities, or messy git history.

## Decision
We adopt a **Chief of Staff (CoS) Multi-Agent Workspace Architecture** within `.agents/`, decomposing project development into 5 specialized role personas:
1. **Chief of Staff**: Sprint coordinator & task orchestrator.
2. **System Architect**: System boundaries, ADRs, stack design.
3. **Lead Developer**: Clean implementation, DRY/SOLID standards.
4. **QA Agent**: Test automation, edge cases, regression gates.
5. **Safety Agent**: Threat modeling, secret protection, OWASP auditing.
6. **DevOps Agent**: Conventional Commits, Git Flow, release management.

## Consequences
### Positive:
- High code maintainability and enterprise software quality.
- Zero untracked secrets or unverified test failures.
- Traceable commit history with standard version control.
- Clear separation of concerns across design, dev, QA, safety, and release.

### Negative:
- Minor operational overhead per task for multi-role sign-offs (mitigated by automated skills).
