import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_certification_project/main.dart';

void main() {
  testWidgets('Certification: HomeScreen displays recipes after async load', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const ProviderScope(child: RecipeApp()));

    // Wait for async load (simulated delay in repository)
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    // Verify "Gboma Dessi" from JSON is present
    expect(find.text('Gboma Dessi'), findsOneWidget);
    expect(find.textContaining('Tous les Recettes'), findsOneWidget);
  });

  testWidgets('Certification: Navigation to Settings works', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: RecipeApp()));
    await tester.pumpAndSettle();

    // Find and tap settings icon
    final settingsIcon = find.byIcon(Icons.settings);
    expect(settingsIcon, findsOneWidget);
    
    await tester.tap(settingsIcon);
    await tester.pumpAndSettle();

    // Verify we are on SettingsScreen
    expect(find.text('Paramètres'), findsOneWidget);
    expect(find.text('Mode Sombre'), findsOneWidget);
  });
}
