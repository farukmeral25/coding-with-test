import 'package:flutter_app_test/features/news/domain/entity/article.dart';

abstract class INewsService {
  Future<List<Article>> fetchArticles();
}
