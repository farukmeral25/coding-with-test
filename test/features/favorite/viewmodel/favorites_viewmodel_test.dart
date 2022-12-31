import 'package:flutter_app_test/features/favorite/viewmodel/favorites_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing App Provider Tests', () {
    var favoriteViewModel = FavoritesViewModel();

    test('A new item should be added', () {
      var number = 21;

      favoriteViewModel.add(number);

      expect(favoriteViewModel.items.contains(number), true);
    });

    test('An item should be removed', () {
      var number = 45;

      favoriteViewModel.add(number);

      expect(favoriteViewModel.items.contains(number), true);

      favoriteViewModel.remove(number);

      expect(favoriteViewModel.items.contains(number), false);
    });
  });
}
