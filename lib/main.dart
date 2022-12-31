import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/utils/keys/global_key.dart';
import 'package:flutter_app_test/core/utils/route_manager/domain/router.dart' as router;
import 'package:flutter_app_test/features/favorite/viewmodel/favorites_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesViewModel>(
      create: (context) => FavoritesViewModel(),
      child: MaterialApp(
        title: 'Flutter App Testing',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: GlobalContextKey.instance.globalKey,
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
