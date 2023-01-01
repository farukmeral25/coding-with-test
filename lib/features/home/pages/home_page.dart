import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/utils/route_manager/data/repository/route_manager.dart';
import 'package:flutter_app_test/core/utils/route_manager/domain/entity/route.dart';
import 'package:flutter_app_test/features/home/pages/widgets/item_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing Sample"),
        leading: TextButton.icon(
          style: TextButton.styleFrom(backgroundColor: Colors.white),
          onPressed: () => Go.to.page(newsPageRoute),
          icon: const Icon(Icons.newspaper),
          label: const Text('News'),
        ),
        leadingWidth: 90,
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              Go.to.page(favoritePageRoute);
            },
            icon: const Icon(Icons.favorite_border),
            label: const Text('Favorites'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        cacheExtent: 20.0,
        controller: ScrollController(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => ItemTile(index),
      ),
    );
  }
}
