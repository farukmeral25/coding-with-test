import 'package:flutter_app_test/features/news/domain/entity/article.dart';
import 'package:flutter_app_test/features/news/domain/service/i_news_service.dart';
import 'package:flutter_app_test/features/news/viewmodel/news_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../service/mock_news_service.dart';

void main() {
  late NewsViewModel newsViewModel;
  late INewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
    newsViewModel = NewsViewModel(mockNewsService);
  });

  test('İnitial values are correct', () {
    expect(newsViewModel.isLoading, false);
    expect(newsViewModel.articles, []);
  });

  group('fetchArticles', () {
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

    test('fetchs articles using the NewsService', () async {
      arrangeNewsServiceReturns3Articles();

      await newsViewModel.fetchArticles();

      verify(() => mockNewsService.fetchArticles()).called(1);
    });

    test(
      """indicates loading of data,
      sets articles to the ones from the service,
      indicates that data is not being loaded anymore""",
      () async {
        arrangeNewsServiceReturns3Articles();

        final future = newsViewModel.fetchArticles();

        expect(newsViewModel.isLoading, true);

        await future;

        expect(newsViewModel.articles, articlesFromService);

        expect(newsViewModel.isLoading, false);
      },
    );
  });
}
