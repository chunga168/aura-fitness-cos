import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_aura/features/home/presentation/home_screen.dart';

void main() {
  testWidgets('HomeScreen renders Aura brand title, micro-habits, and weight logger',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Verify Aura title & daily habit quests
    expect(find.text('AURA'), findsOneWidget);
    expect(find.text('DAILY AURA ENERGY'), findsOneWidget);
    expect(find.text('MICRO-HABITS QUESTS'), findsOneWidget);
    expect(find.text('CURRENT WEIGHT'), findsOneWidget);

    // Toggle a habit
    final habitFinder = find.text('High Protein Lunch (+30g)');
    expect(habitFinder, findsOneWidget);
    await tester.tap(habitFinder);
    await tester.pumpAndSettle();
  });
}
