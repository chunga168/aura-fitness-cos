import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'aura_colors.dart';

/// Font families supported by the customization engine.
enum AuraFontFamily {
  soraHanken,
  inter,
  outfit,
  poppins,
}

extension AuraFontFamilyExtension on AuraFontFamily {
  String get displayName {
    switch (this) {
      case AuraFontFamily.soraHanken:
        return 'Sora & Hanken Grotesk (Default)';
      case AuraFontFamily.inter:
        return 'Inter Clean';
      case AuraFontFamily.outfit:
        return 'Outfit Modern';
      case AuraFontFamily.poppins:
        return 'Poppins Geometric';
    }
  }
}

/// Centralized Typography hierarchy based on Stitch Design System specifications.
class AuraTypography {
  static TextTheme createTextTheme({
    AuraFontFamily fontFamily = AuraFontFamily.soraHanken,
    Color textColor = AuraColors.textPrimary,
  }) {
    String headlineFont;
    String bodyFont;

    switch (fontFamily) {
      case AuraFontFamily.soraHanken:
        headlineFont = 'Sora';
        bodyFont = 'Hanken Grotesk';
        break;
      case AuraFontFamily.inter:
        headlineFont = 'Inter';
        bodyFont = 'Inter';
        break;
      case AuraFontFamily.outfit:
        headlineFont = 'Outfit';
        bodyFont = 'Outfit';
        break;
      case AuraFontFamily.poppins:
        headlineFont = 'Poppins';
        bodyFont = 'Poppins';
        break;
    }

    return TextTheme(
      // Display / Aura XP Metrics
      displayLarge: GoogleFonts.getFont(
        headlineFont,
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.02,
        color: textColor,
      ),
      displayMedium: GoogleFonts.getFont(
        headlineFont,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02,
        color: textColor,
      ),
      // Headlines
      headlineLarge: GoogleFonts.getFont(
        headlineFont,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.01,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.getFont(
        headlineFont,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.01,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.getFont(
        headlineFont,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      // Titles
      titleLarge: GoogleFonts.getFont(
        headlineFont,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: GoogleFonts.getFont(
        bodyFont,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      // Body Copy
      bodyLarge: GoogleFonts.getFont(
        bodyFont,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.getFont(
        bodyFont,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: AuraColors.textSecondary,
      ),
      bodySmall: GoogleFonts.getFont(
        bodyFont,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AuraColors.textMuted,
      ),
      // Labels / Caps / Badges
      labelLarge: GoogleFonts.getFont(
        bodyFont,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05,
        color: textColor,
      ),
      labelMedium: GoogleFonts.getFont(
        bodyFont,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05,
        color: AuraColors.textSecondary,
      ),
      labelSmall: GoogleFonts.getFont(
        bodyFont,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AuraColors.textMuted,
      ),
    );
  }
}
