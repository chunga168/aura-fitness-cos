# ADR-002: Offline-First Flutter Architecture, PowerSync Sync Engine & Dynamic Theme System

## Status
Accepted

## Context
"Fitness Aura" requires:
1. Multiplatform availability across Web (PWA) and Native Mobile (iOS & Android) with high performance and 60/120fps fluid micro-animations.
2. 0ms offline-first responsiveness for logging daily micro-habits, weight entries, workouts, and consistency streaks.
3. A centralized, consolidated design system based on Stitch design specifications (Midnight Indigo `#0F0B2E`, Neon Teal `#00F4FE`, Electric Violet `#7000FF`, Sora & Hanken Grotesk fonts).
4. Future-proof theme architecture allowing user-customizable color palettes and typography.
5. Gamified progression (Duolingo-style Aura XP, streaks, level-ups) with seamless guest-to-registered cloud migration.

## Decision

### 1. Technology Stack
* **Framework**: Flutter 3.x (Dart 3.x) targeting Mobile & Web PWA.
* **State Management**: `flutter_riverpod` for declarative, testable, and compile-safe state handling.
* **Local Offline Storage & Sync**: `powersync` with `sqlite3` for local-first reads/writes and bidirectional background sync.
* **Cloud Backend & Auth**: `supabase_flutter` for Postgres database, Row Level Security, user authentication (Email, Google, Apple), and Supabase Storage for encrypted media.

### 2. Design System & Theme Engine
* Centralized theme tokens in `lib/core/theme/`:
  * `AuraColors`: Named color tokens and gradients.
  * `AuraTypography`: Standardized Sora headlines and Hanken Grotesk body text.
  * `AuraTheme`: Theme provider supporting light/dark modes and user-selectable accent palettes.
  * `AuraGlass`: Reusable glassmorphic card containers and subtle glow effects.

### 3. Screen Hierarchy & Header Rules
* **Home Screen**: Features the primary **"Aura"** branding header, animated concentric Aura progress rings, daily habit checklist, and quick weight entry.
* **Activities, History, Social, Profile Screens**: Use streamlined, minimal headers without redundant "Aura" branding to maximize vertical screen real-estate.

## Consequences
* Immediate offline responsiveness on all devices.
* Zero data loss for guest users through local SQLite storage.
* High maintainability with centralized UI tokens and clean modular architecture.
