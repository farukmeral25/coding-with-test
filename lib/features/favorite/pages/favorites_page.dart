import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/favorite/pages/widgets/favorite_item_tile.dart';
import 'package:flutter_app_test/features/favorite/viewmodel/favorites_viewmodel.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Consumer<FavoritesViewModel>(
        builder: (BuildContext context, FavoritesViewModel favoritesViewModel, Widget? child) => favoritesViewModel.items.isNotEmpty
            ? ListView.builder(
                itemCount: favoritesViewModel.items.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) => FavoriteItemTile(favoritesViewModel.items[index]),
              )
            : const Center(
                child: Text('No favorites added.'),
              ),
      ),
    );
  }
}
