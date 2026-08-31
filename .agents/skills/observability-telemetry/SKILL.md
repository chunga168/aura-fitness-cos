---
name: observability-telemetry
description: Runbook for configuring application observability, structured logging hygiene, severity filtering, runtime debug toggling, BI metrics, and log rotation (< 50MB).
---

# Observability & Telemetry Execution Runbook

Use this skill when initializing application logging frameworks, defining telemetry counters, setting up log rotation rules, or auditing log verbosity and storage limits.

---

## Observability Implementation Protocol

### 1. Structured Logging Setup
- All log outputs MUST format as structured JSON or clearly delimited key-value strings.
- Include mandatory fields: `timestamp`, `level`, `module`, `message`, and optional `metadata` context.
- Severity levels permitted: `DEBUG`, `INFO`, `WARN`, `ERROR`.

### 2. Default Log Filtering & Dynamic Debug Toggle
- Set default production/standard log level threshold to `INFO` (hiding all `DEBUG` logs).
- Provide a simple application flag or runtime environment configuration (`ENABLE_DEBUG_LOGS=true` or UI debug switch) that dynamically lowers the log threshold to `DEBUG` without requiring application rebuilds.

### 3. Log Rotation & Storage Footprint Management
- Implement automatic size-based log rotation:
  - Max single log file size: **5 MB**
  - Max log file retention count: **9 rotated backups** + **1 active file** (Total cap: **<= 50 MB**).
- Old log files exceeding 50 MB total must be purged automatically using FIFO (First-In, First-Out) retention.

### 4. Business Intelligence Telemetry
- Track key business events (`event_name`, `user_id_hash`, `timestamp`, `properties`).
- Ensure no Personally Identifiable Information (PII) or secrets are emitted in telemetry streams.
