import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_aura/core/theme/aura_colors.dart';
import 'package:fitness_aura/core/theme/aura_theme.dart';
import 'package:fitness_aura/core/theme/aura_typography.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuraTheme Dynamic Engine Tests', () {
    test('Initial theme state defaults to Midnight Aura & Sora/Hanken typography', () {
      const state = AuraThemeState();
      expect(state.palette, AuraColorPalette.midnightIndigo);
      expect(state.fontFamily, AuraFontFamily.soraHanken);
      expect(state.isDarkMode, true);
    });

    test('Palette switching updates accent colors correctly', () {
      final notifier = AuraThemeNotifier();
      notifier.setPalette(AuraColorPalette.cyberpunkTeal);
      expect(notifier.state.palette, AuraColorPalette.cyberpunkTeal);

      notifier.setPalette(AuraColorPalette.solarGold);
      expect(notifier.state.palette, AuraColorPalette.solarGold);
      expect(notifier.state.palette.primaryAccent, const Color(0xFFFFC043));
    });

    test('Typography font family switching updates state', () {
      final notifier = AuraThemeNotifier();
      notifier.setFontFamily(AuraFontFamily.inter);
      expect(notifier.state.fontFamily, AuraFontFamily.inter);

      notifier.setFontFamily(AuraFontFamily.outfit);
      expect(notifier.state.fontFamily, AuraFontFamily.outfit);
    });

    test('ThemeData generation outputs valid ThemeData', () {
      const state = AuraThemeState(
        palette: AuraColorPalette.electricViolet,
        fontFamily: AuraFontFamily.poppins,
      );
      final themeData = state.themeData;
      expect(themeData.useMaterial3, true);
      expect(themeData.scaffoldBackgroundColor, AuraColors.surfaceDark);
    });
  });
}
