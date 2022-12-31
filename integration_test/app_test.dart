import 'package:flutter/material.dart';
import 'package:flutter_app_test/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('Testing App Driver Tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Finding an item in the list', (tester) async {
      await tester.pumpWidget(const MyApp());

      final itemFinder = find.byKey(const ValueKey('text_25'));

      await tester.scrollUntilVisible(itemFinder, 500.0);

      expect(tester.widget<Text>(itemFinder).data, 'Item 25');
    });

    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(const MyApp());

      final itemFinder = find.byKey(const ValueKey('icon_0'));

      await tester.tap(itemFinder);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Added to favorites.'), findsOneWidget);

      await tester.tap(itemFinder);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Removed from favorites.'), findsOneWidget);
    });

    testWidgets('Verifying whether item gets added to favorites', (tester) async {
      await tester.pumpWidget(const MyApp());

      final itemFinder = find.byKey(const ValueKey('icon_5'));

      await tester.tap(itemFinder);

      await tester.pumpAndSettle();

      await tester.tap(find.text('Favorites'));

      await tester.pumpAndSettle();

      final itemFinderTwo = find.byKey(const ValueKey('favorites_text_5'));

      expect(
        tester.widget<Text>(itemFinderTwo).data,
        equals('Item 5'),
      );
    });
  });
}
