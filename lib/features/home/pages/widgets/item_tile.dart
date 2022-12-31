import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/favorite/viewmodel/favorites_viewmodel.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(this.itemNo, {super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesList = context.watch<FavoritesViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo',
          key: Key('text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: favoritesList.items.contains(itemNo) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
          onPressed: () {
            !favoritesList.items.contains(itemNo) ? favoritesList.add(itemNo) : favoritesList.remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(favoritesList.items.contains(itemNo) ? 'Added to favorites.' : 'Removed from favorites.'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
