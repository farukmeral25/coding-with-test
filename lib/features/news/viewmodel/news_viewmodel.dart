import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/news/domain/entity/article.dart';
import 'package:flutter_app_test/features/news/domain/service/i_news_service.dart';

class NewsViewModel with ChangeNotifier {
  final INewsService _newsService;

  NewsViewModel(this._newsService);

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();
    _articles = await _newsService.fetchArticles();
    _isLoading = false;
    notifyListeners();
  }
}
