import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/favorite/pages/favorites_page.dart';
import 'package:flutter_app_test/features/favorite/viewmodel/favorites_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

late FavoritesViewModel favoritesViewModel;

Widget createFavoritesScreen() {
  return ChangeNotifierProvider<FavoritesViewModel>(
    create: (context) {
      favoritesViewModel = FavoritesViewModel();
      return favoritesViewModel;
    },
    child: const MaterialApp(
      home: FavoritesPage(),
    ),
  );
}

void main() {
  group('Testing App State Management Tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    var number = 45;

    testWidgets('Verifying add method', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());

      favoritesViewModel.add(number);

      await tester.pumpAndSettle();

      expect(find.text('Item $number'), findsOneWidget);
    });

    testWidgets('Verifying remove method', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());

      favoritesViewModel.remove(number);

      await tester.pumpAndSettle();

      expect(find.text('Item $number'), findsNothing);
    });
  });
}
