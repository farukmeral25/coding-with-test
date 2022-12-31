import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/favorite/pages/favorites_page.dart';
import 'package:flutter_app_test/features/favorite/viewmodel/favorites_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

late FavoritesViewModel favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<FavoritesViewModel>(
      create: (context) {
        favoritesList = FavoritesViewModel();
        return favoritesList;
      },
      child: const MaterialApp(
        home: FavoritePage(),
      ),
    );

void addItems() {
  for (var i = 0; i < 5; i++) {
    favoritesList.add(i);
  }
}

void main() {
  group('Favorite Page Widget Tests', () {
    testWidgets('Test if Placeholder shows in case of empty list', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());

      expect(find.text('No favorites added.'), findsOneWidget);
    });

    testWidgets('Test if ListView shows up', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());

      addItems();

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing Remove Button', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());

      addItems();

      await tester.pumpAndSettle();

      final totalItems = tester.widgetList(find.byIcon(Icons.close)).length;

      await tester.tap(find.byIcon(Icons.close).first);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Removed from favorites.'), findsOneWidget);

      expect(tester.widgetList(find.byIcon(Icons.close)).length, lessThan(totalItems));
    });
  });
}
