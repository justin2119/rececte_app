import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_certification_project/main.dart';

void main() {
  testWidgets('HomeScreen displays title and recipe list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: RecipeApp(),
      ),
    );

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the AppBar title is present
    expect(find.textContaining('Tous les Recettes'), findsOneWidget);

    // Verify that the search field is present
    expect(find.byType(TextField), findsOneWidget);

    // Verify that we have some recipes displayed (at least the first one)
    expect(find.text('Gboma Dessi'), findsOneWidget);
    
    // Verify categories are present
    expect(find.text('Petit-déjeuner'), findsAtLeastNWidgets(1));
  });

  testWidgets('Search filtering works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: RecipeApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Enter search text
    await tester.enterText(find.byType(TextField), 'Ayimolou');
    await tester.pumpAndSettle();

    // Check if filtered result is shown
    expect(find.text('Ayimolou'), findsOneWidget);
    
    // Gboma Dessi should be gone
    expect(find.text('Gboma Dessi'), findsNothing);
  });
}
