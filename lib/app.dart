import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'error.dart';
import 'loading.dart';
import 'navigation.dart';

class App extends HookWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshot = useFuture(Firebase.initializeApp());
    if (snapshot.hasError) {
      return MaterialApp(title: 'Welcome to Flutter', home: Error());
    }
    if (snapshot.hasData) {
      return Navigation('Welcome to Flutter');
    }
    // Otherwise, show something whilst waiting for initialization to complete
    return MaterialApp(title: 'Welcome to Flutter', home: Loading());
  }
}
