# Observability & Logging Governance Rules

## 1. Severity Levels & Labeling
Every log statement MUST use one of the standard severity labels:
- `DEBUG`: Fine-grained diagnostic information for troubleshooting.
- `INFO`: Normal operational milestones and status updates.
- `WARN`: Non-fatal issues, performance warnings, or fallbacks.
- `ERROR`: Unhandled exceptions, failed operations, or critical crashes.

## 2. Hide Debug Logs by Default & Dynamic Switch
- `DEBUG` statements MUST be filtered out by default during normal application execution.
- Applications MUST expose a simple switch (e.g., `ENABLE_DEBUG_LOGS` flag or UI toggle) to enable `DEBUG` logging on demand.

## 3. Strict 50 MB Log Storage Cap
- Total log storage MUST NOT exceed 50 MB under any circumstances.
- Enforce size-based log rotation (e.g., 5 MB per file, max 9 rotated files).

## 4. Privacy & Telemetry Hygiene
- NEVER record sensitive information (passwords, tokens, personal health details, PII) in logs or BI event tracking.
