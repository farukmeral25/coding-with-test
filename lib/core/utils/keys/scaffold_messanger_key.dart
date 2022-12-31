import 'package:flutter/material.dart';

class GlobalScaffoldMessangerKey {
  final GlobalKey<ScaffoldMessengerState> globalKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalScaffoldMessangerKey instance =
      GlobalScaffoldMessangerKey._init();
  GlobalScaffoldMessangerKey._init();
}
