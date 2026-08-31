# Enterprise Git & Version Control Rules

## 1. Commit Formatting Standards
- Every commit must follow Conventional Commit syntax: `<type>(<scope>): <summary>`.
- Types allowed: `feat`, `fix`, `sec`, `test`, `docs`, `refactor`, `chore`.

## 2. Branch Governance
- `main`: Production-ready code only.
- `develop`: Staging/integration branch.
- Feature work occurs on isolated branches (`feature/<name>`) and merges into `develop` via pull requests or verified commits.

## 3. Clean Workspace Maintenance
- Do not commit generated build artifacts, temporary log files, `.env` secret files, or node_modules.
- Maintain an up-to-date `.gitignore` at the repository root.
