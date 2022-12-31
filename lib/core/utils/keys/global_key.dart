import 'package:flutter/material.dart';

class GlobalContextKey {
  final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  static GlobalContextKey instance = GlobalContextKey._init();
  GlobalContextKey._init();
}
