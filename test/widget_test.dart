import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_certification_project/main.dart';

void main() {
  testWidgets('Final Audit Test: App renders and has core widgets', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: RecipeApp()));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // SearchBar check
    expect(find.byType(TextField), findsAtLeastNWidgets(1));
    
    // FloatingActionButton check
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
