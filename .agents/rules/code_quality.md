# Code Quality & Clean Engineering Rules

## 1. Modular Architecture & Clean Code
- **Single Responsibility Principle**: Each class, module, or function must fulfill one dedicated purpose.
- **DRY (Don't Repeat Yourself)**: Extract common logic into reusable utility modules; audit before creating duplicate helper functions.
- **Explicit Interfaces**: Use static typing (TypeScript, Dart, Python type hints) for all public functions, arguments, and return types.

## 2. Defensive Programming & Error Handling
- Never swallow exceptions silently or return dummy fallback values that obscure root causes.
- Provide descriptive, actionable error logging with structured context.
- Always inspect object state and non-null bounds before property dereferencing.

## 3. UI & Styling Aesthetics
- Use modern typography, cohesive HSL color schemes, dynamic layout calculations, glassmorphism, and smooth micro-animations.
- Avoid hardcoded magic numbers or static pixel offsets when calculating responsive UI element boundaries.
