import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/utils/keys/global_key.dart';
import 'package:flutter_app_test/features/article/pages/article_page.dart';
import 'package:flutter_app_test/features/favorite/viewmodel/favorites_viewmodel.dart';
import 'package:flutter_app_test/features/news/domain/entity/article.dart';
import 'package:flutter_app_test/features/news/pages/news_page.dart';
import 'package:flutter_app_test/features/news/viewmodel/news_viewmodel.dart';
import 'package:flutter_app_test/main.dart';
import 'package:flutter_app_test/core/utils/route_manager/domain/router.dart' as router;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../test/features/news/viewmodel/news_viewmodel_test.dart';

void main() {
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
  });

  final articlesFromService = [
    Article(title: 'Test 1', content: 'Test 1 content'),
    Article(title: 'Test 2', content: 'Test 2 content'),
    Article(title: 'Test 3', content: 'Test 3 content'),
  ];

  void arrangeNewsServiceReturns3Articles() {
    when(() => mockNewsService.fetchArticles()).thenAnswer(
      (_) async => articlesFromService,
    );
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'News App',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => FavoritesViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => NewsViewModel(mockNewsService),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter App Testing',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          navigatorKey: GlobalContextKey.instance.globalKey,
          onGenerateRoute: router.generateRoute,
        ),
      ),
    );
  }

  group('Testing App Driver Tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("""Tapping on the first article excerpt opens the article page
    where the full article content is displayed""", (tester) async {
      arrangeNewsServiceReturns3Articles();

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.newspaper));

      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.text('Test 1 content'));

      await tester.pumpAndSettle();

      expect(find.byType(NewsPage), findsNothing);
      expect(find.byType(ArticlePage), findsOneWidget);

      expect(find.text('Test 1'), findsOneWidget);
      expect(find.text('Test 1 content'), findsOneWidget);
    });

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
