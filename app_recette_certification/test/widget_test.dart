import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_certification_project/main.dart';

void main() {
  testWidgets('Certification Test: HomeScreen displays recipe Gboma Dessi', (WidgetTester tester) async {
    // Build our app with ProviderScope
    await tester.pumpWidget(
      const ProviderScope(
        child: RecipeApp(),
      ),
    );

    // Initial frame
    await tester.pump();

    // The app might use CachedNetworkImage which can be tricky in tests, 
    // but the text should be present in the list.
    // Wait for any animations or data loading if necessary
    await tester.pumpAndSettle();

    // Verify that the title "Gboma Dessi" is displayed
    expect(find.text('Gboma Dessi'), findsOneWidget);
    
    // Verify that the category "Dîner" is displayed near the recipe
    expect(find.text('Dîner'), findsAtLeastNWidgets(1));
  });

  testWidgets('Certification Test: Search filtering for Ayimolou', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: RecipeApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify search field exists
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    // Enter search query
    await tester.enterText(searchField, 'Ayimolou');
    await tester.pumpAndSettle();

    // Verify Ayimolou is found and others are filtered out
    expect(find.text('Ayimolou'), findsOneWidget);
    expect(find.text('Gboma Dessi'), findsNothing);
  });
}
