import 'package:flutter/material.dart';

/// Centralized color palette based on Stitch Design System Tokens for Aura Fitness.
class AuraColors {
  // Midnight Indigo Base
  static const Color midnightIndigo = Color(0xFF0F0B2E);
  static const Color surfaceDark = Color(0xFF101415);
  static const Color surfaceContainerLowest = Color(0xFF0B0F10);
  static const Color surfaceContainerLow = Color(0xFF191C1E);
  static const Color surfaceContainer = Color(0xFF1D2022);
  static const Color surfaceContainerHigh = Color(0xFF272A2C);
  static const Color surfaceContainerHighest = Color(0xFF323537);

  // Vitality & Spirit Accents
  static const Color neonTeal = Color(0xFF00F5FF);
  static const Color neonTealDim = Color(0xFF00DCE5);
  static const Color electricViolet = Color(0xFF7000FF);
  static const Color lavenderGlow = Color(0xFFD1BCFF);
  static const Color softAmber = Color(0xFFFFB95F);
  static const Color errorRed = Color(0xFFFFB4AB);

  // Text & Neutrals
  static const Color ghostWhite = Color(0xFFF8FAFC);
  static const Color textPrimary = Color(0xFFE0E3E5);
  static const Color textSecondary = Color(0xFFC9C5CF);
  static const Color textMuted = Color(0xFF928F98);
  static const Color outlineVariant = Color(0xFF47464E);

  // Aura Signature Gradients
  static const LinearGradient peakAuraGradient = LinearGradient(
    colors: [neonTeal, electricViolet],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGlassGradient = LinearGradient(
    colors: [
      Color(0x331D2022),
      Color(0x1A0F0B2E),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient auraRingGradient = LinearGradient(
    colors: [neonTeal, electricViolet, lavenderGlow],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Customizable color themes supported by the AuraTheme engine.
enum AuraColorPalette {
  midnightIndigo,
  cyberpunkTeal,
  electricViolet,
  solarGold,
}

extension AuraColorPaletteExtension on AuraColorPalette {
  String get displayName {
    switch (this) {
      case AuraColorPalette.midnightIndigo:
        return 'Midnight Aura (Default)';
      case AuraColorPalette.cyberpunkTeal:
        return 'Cyberpunk Neon';
      case AuraColorPalette.electricViolet:
        return 'Electric Violet';
      case AuraColorPalette.solarGold:
        return 'Solar Radiance';
    }
  }

  Color get primaryAccent {
    switch (this) {
      case AuraColorPalette.midnightIndigo:
        return AuraColors.neonTeal;
      case AuraColorPalette.cyberpunkTeal:
        return const Color(0xFF00FF9D);
      case AuraColorPalette.electricViolet:
        return AuraColors.lavenderGlow;
      case AuraColorPalette.solarGold:
        return const Color(0xFFFFC043);
    }
  }

  Color get secondaryAccent {
    switch (this) {
      case AuraColorPalette.midnightIndigo:
        return AuraColors.electricViolet;
      case AuraColorPalette.cyberpunkTeal:
        return const Color(0xFF00E5FF);
      case AuraColorPalette.electricViolet:
        return const Color(0xFFFF52D9);
      case AuraColorPalette.solarGold:
        return const Color(0xFFFF5722);
    }
  }
}
