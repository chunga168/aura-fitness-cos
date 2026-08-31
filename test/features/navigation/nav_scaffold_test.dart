import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_aura/features/navigation/presentation/main_nav_scaffold.dart';

void main() {
  testWidgets('MainNavScaffold renders 5 tabs and initial Home screen with Aura title',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MainNavScaffold(),
        ),
      ),
    );

    // Verify 5 navigation tab labels exist
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Activities'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Social'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Verify "AURA" brand title appears on Home screen
    expect(find.text('AURA'), findsOneWidget);
    expect(find.text('DAILY AURA ENERGY'), findsOneWidget);

    // Switch to Activities tab
    await tester.tap(find.text('Activities'));
    await tester.pumpAndSettle();

    // Verify streamlined header (no redundant "AURA" title)
    expect(find.text('Activities & Workouts'), findsOneWidget);

    // Switch to History tab
    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();
    expect(find.text('History & Heatmap'), findsOneWidget);

    // Switch to Social tab
    await tester.tap(find.text('Social'));
    await tester.pumpAndSettle();
    expect(find.text('Community & Squad'), findsOneWidget);

    // Switch to Profile tab
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Profile & Aura Rank'), findsOneWidget);
  });
}
