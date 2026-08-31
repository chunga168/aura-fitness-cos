import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/aura_theme.dart';
import 'features/navigation/presentation/main_nav_scaffold.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  runApp(const ProviderScope(child: FitnessAuraApp()));
}

class FitnessAuraApp extends ConsumerWidget {
  const FitnessAuraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(auraThemeProvider);

    return MaterialApp(
      title: 'Fitness Aura',
      debugShowCheckedModeBanner: false,
      theme: themeState.themeData,
      home: const MainNavScaffold(),
    );
  }
}
