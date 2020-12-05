import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'auth_widget.dart';
import 'login.dart';
import 'navigation.dart';

class App extends HookWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      home: AuthWidget(
        signedInBuilder: (_) => Navigation('Welcome to Flutter'),
        nonSignedInBuilder: (_) => Login(),
      ),
    );
  }
}
