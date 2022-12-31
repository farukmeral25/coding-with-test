import 'package:flutter/cupertino.dart';
import 'package:flutter_app_test/core/utils/route_manager/domain/entity/route.dart';
import 'package:flutter_app_test/features/favorite/pages/favorites_page.dart';
import 'package:flutter_app_test/features/home/pages/home_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePageRoute:
      return CupertinoPageRoute(builder: (_) => const HomePage());
    case favoritePageRoute:
      return CupertinoPageRoute(builder: (_) => const FavoritePage());
    default:
      return CupertinoPageRoute(builder: (_) => const HomePage());
  }
}
