---
name: git-workflow
description: DevOps runbook for enforcing enterprise Git branching strategies, Conventional Commit syntax, release tagging, and clean repository maintenance.
---

# Git Workflow & Release Management Runbook

Use this skill when preparing code for staging, creating atomic Git commits, building release tags, or managing project branches.

---

## Git Operations Protocol

1. **Branch Hygiene**:
   - Primary branches: `main` (production stable), `develop` (staging/integration).
   - Topic branches: `feature/feature-name`, `fix/bug-name`, `sec/security-fix`.

2. **Conventional Commit Protocol**:
   All commit messages MUST adhere to the following schema:
   ```text
   <type>(<scope>): <short summary>

   [optional body explaining rationale and background]
   ```
   **Allowed Types**:
   - `feat`: New feature
   - `fix`: Bug fix
   - `sec`: Security enhancement or patch
   - `test`: Adding or updating test suites
   - `docs`: Documentation update
   - `refactor`: Code rewrite without functionality change
   - `chore`: Project tooling or build system maintenance

3. **Atomic Commits**:
   - Never combine unrelated changes in a single commit.
   - Stage exact files explicitly (`git add path/to/file`) rather than dumping all changes with `git add .` blindly.

4. **Release Notes & Tagging**:
   - Update [docs/sprints/release_notes.md](file:///d:/Projects/ChungaFitness%20-%20w%20Chief%20of%20Staff/docs/sprints/release_notes.md) when tagging releases (e.g., `v1.0.0`).
