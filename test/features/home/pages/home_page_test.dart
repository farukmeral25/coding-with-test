import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/utils/keys/global_key.dart';
import 'package:flutter_app_test/features/favorite/viewmodel/favorites_viewmodel.dart';
import 'package:flutter_app_test/core/utils/route_manager/domain/router.dart' as router;
import 'package:flutter_app_test/features/news/data/service/news_service.dart';
import 'package:flutter_app_test/features/news/viewmodel/news_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

Widget createHomeScreen() => MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoritesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsViewModel(NewsService()),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: router.generateRoute,
        navigatorKey: GlobalContextKey.instance.globalKey,
      ),
    );

void main() {
  group("Home Page Widget Test", () {
    testWidgets('Testing if ListView shows up', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.text('Item 0'), findsOneWidget);

      await tester.fling(find.byType(ListView), const Offset(0, -200), 3000);
      await tester.pumpAndSettle();

      expect(find.text('Item 0'), findsNothing);
    });

    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.byIcon(Icons.favorite), findsNothing);

      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Added to favorites.'), findsOneWidget);

      expect(find.byIcon(Icons.favorite), findsWidgets);

      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Removed from favorites.'), findsOneWidget);

      expect(find.byIcon(Icons.favorite), findsNothing);
    });

    testWidgets('Testing Navigation Favorites', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      final itemFinder = find.text('No favorites added.');

      expect(itemFinder, findsOneWidget);
    });

    testWidgets('Testing Navigation News', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      await tester.tap(find.byIcon(Icons.newspaper));

      await tester.pumpAndSettle();

      final itemFinder = find.text('News');

      expect(itemFinder, findsOneWidget);
    });
  });
}
