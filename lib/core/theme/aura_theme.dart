import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'aura_colors.dart';
import 'aura_typography.dart';

/// State model for dynamic user theme preferences.
class AuraThemeState {
  final AuraColorPalette palette;
  final AuraFontFamily fontFamily;
  final bool isDarkMode;

  const AuraThemeState({
    this.palette = AuraColorPalette.midnightIndigo,
    this.fontFamily = AuraFontFamily.soraHanken,
    this.isDarkMode = true,
  });

  AuraThemeState copyWith({
    AuraColorPalette? palette,
    AuraFontFamily? fontFamily,
    bool? isDarkMode,
  }) {
    return AuraThemeState(
      palette: palette ?? this.palette,
      fontFamily: fontFamily ?? this.fontFamily,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  ThemeData get themeData {
    final textTheme = AuraTypography.createTextTheme(
      fontFamily: fontFamily,
      textColor: isDarkMode ? AuraColors.textPrimary : const Color(0xFF101415),
    );

    final bg = isDarkMode ? AuraColors.surfaceDark : const Color(0xFFF8F9FA);
    final surface = isDarkMode ? AuraColors.surfaceContainer : const Color(0xFFFFFFFF);
    final primary = palette.primaryAccent;
    final secondary = palette.secondaryAccent;

    return ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primary: primary,
        onPrimary: Colors.black,
        secondary: secondary,
        onSecondary: Colors.white,
        error: AuraColors.errorRed,
        onError: Colors.black,
        surface: surface,
        onSurface: isDarkMode ? AuraColors.textPrimary : Colors.black,
        surfaceContainer: surface,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineMedium,
        iconTheme: IconThemeData(color: isDarkMode ? AuraColors.ghostWhite : Colors.black),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}

/// Notifier for managing theme settings and user customization.
class AuraThemeNotifier extends StateNotifier<AuraThemeState> {
  AuraThemeNotifier() : super(const AuraThemeState());

  void setPalette(AuraColorPalette palette) {
    state = state.copyWith(palette: palette);
  }

  void setFontFamily(AuraFontFamily font) {
    state = state.copyWith(fontFamily: font);
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
}

/// Global provider for the application theme.
final auraThemeProvider = StateNotifierProvider<AuraThemeNotifier, AuraThemeState>((ref) {
  return AuraThemeNotifier();
});
