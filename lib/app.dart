import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'navigation.dart';

class App extends HookWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigation('Welcome to Flutter');
  }
}
