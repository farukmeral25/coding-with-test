import 'package:flutter/material.dart';
import 'package:flutter_app_test/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('Testing App Performance Tests', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Scrolling test', (tester) async {
      await tester.pumpWidget(const MyApp());

      final listFinder = find.byType(ListView);
      final scroller = tester.widget<ListView>(listFinder).controller;

      await binding.watchPerformance(
        () async {
          await scroller?.animateTo(
            7000,
            duration: const Duration(seconds: 1),
            curve: Curves.linear,
          );

          await tester.pumpAndSettle();

          await scroller?.animateTo(
            -7000,
            duration: const Duration(seconds: 1),
            curve: Curves.linear,
          );

          await tester.pumpAndSettle();
        },
        reportKey: 'scrolling_summary',
      );
    });

    testWidgets('Favorites operations test', (tester) async {
      await tester.pumpWidget(const MyApp());

      await binding.watchPerformance(
        () async {
          final iconKeys = [
            'icon_0',
            'icon_1',
            'icon_2',
          ];

          for (var icon in iconKeys) {
            await tester.tap(find.byKey(ValueKey(icon)));

            await tester.pumpAndSettle(const Duration(seconds: 1));

            expect(find.text('Added to favorites.'), findsOneWidget);
          }

          await tester.tap(find.text('Favorites'));

          await tester.pumpAndSettle();

          final removeIconKeys = [
            'remove_icon_0',
            'remove_icon_1',
            'remove_icon_2',
          ];

          for (var icon in removeIconKeys) {
            await tester.tap(find.byKey(ValueKey(icon)));

            await tester.pumpAndSettle(const Duration(seconds: 1));

            expect(find.text('Removed from favorites.'), findsOneWidget);
          }
        },
        reportKey: 'favorites_operations_summary',
      );
    });
  });
}
