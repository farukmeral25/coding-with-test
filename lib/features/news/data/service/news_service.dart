import 'package:flutter_app_test/features/news/domain/entity/article.dart';
import 'package:flutter_app_test/features/news/domain/service/i_news_service.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class NewsService implements INewsService {
  //Simulating a remote database
  final _articles = List.generate(
    10,
    (_) => Article(
      title: lorem(paragraphs: 1, words: 3),
      content: lorem(paragraphs: 10, words: 500),
    ),
  );

  @override
  Future<List<Article>> fetchArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return _articles;
  }
}
