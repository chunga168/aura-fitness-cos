# Release Notes & Sprint Changelogs

## Sprint 1 Release (v0.1.0-alpha)
*Date: 2026-08-31*

### ✨ Features & Architecture
- **Centralized Design System**: Extracted Stitch design tokens into `AuraColors`, `AuraTypography` (Sora & Hanken Grotesk), and `AuraGlass` reusable glassmorphic components.
- **Dynamic Theme Customization Engine**: Built `AuraThemeNotifier` supporting real-time switching between 4 color palettes (*Midnight Aura, Cyberpunk Neon, Electric Violet, Solar Radiance*) and 4 typography systems (*Sora/Hanken, Inter, Outfit, Poppins*).
- **Floating 5-Tab Glass Navigation Shell**: Implemented `MainNavScaffold` with blurred backdrop and dual-tone glowing active icons.
- **Home Screen**: Prominent **"Aura"** brand header with animated concentric daily Aura progress rings, micro-habit quest checklist (+XP rewards), streak shield counter, and quick weight entry widget.
- **Activities Screen**: Streamlined header (maximizing vertical real-estate), live workout tracker card, muscle group category filters, and past session logs with total volume calculations.
- **History Screen**: Streamlined header with interactive GitHub/Duolingo-style monthly consistency heatmap matrix and streak metrics.
- **Social Screen**: Streamlined header with friend activity feed, interactive cheer interactions (🔥 / 👏), and Co-op Squad Challenges.
- **Profile Screen**: Streamlined header with Aura level XP progression, unlocked achievement badges, and gamified "Cloud Shield" guest account upgrade quest (+100 XP).

### 🧪 Quality Assurance & Gates
- 100% automated test pass rate across unit and widget test suites (`test/core/theme_test.dart`, `test/features/navigation/nav_scaffold_test.dart`, `test/features/home/home_screen_test.dart`, `test/features/profile/profile_test.dart`).
- Architecture Decision Record documented in [ADR-002](file:///d:/Projects/ChungaFitness%20-%20w%20Chief%20of%20Staff/docs/architecture/ADR-002-offline-first-flutter-powersync-theme-engine.md).
