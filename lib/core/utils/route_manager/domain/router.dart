import 'package:flutter/cupertino.dart';
import 'package:flutter_app_test/core/utils/route_manager/domain/entity/route.dart';
import 'package:flutter_app_test/features/article/pages/article_page.dart';
import 'package:flutter_app_test/features/favorite/pages/favorites_page.dart';
import 'package:flutter_app_test/features/home/pages/home_page.dart';
import 'package:flutter_app_test/features/news/domain/entity/article.dart';
import 'package:flutter_app_test/features/news/pages/news_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePageRoute:
      return CupertinoPageRoute(builder: (_) => const HomePage());
    case favoritePageRoute:
      return CupertinoPageRoute(builder: (_) => const FavoritesPage());
    case newsPageRoute:
      return CupertinoPageRoute(builder: (_) => const NewsPage());
    case articlePageRoute:
      var article = settings.arguments as Article;
      return CupertinoPageRoute(builder: (_) => ArticlePage(article: article));
    default:
      return CupertinoPageRoute(builder: (_) => const HomePage());
  }
}
