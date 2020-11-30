// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'error.dart';
import 'loading.dart';
import 'navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // Appはconstじゃなくても起動はするみたい
    ProviderScope(child: App()),
  );
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(title: 'Welcome to Flutter', home: Error());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Navigation('Welcome to Flutter');
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(title: 'Welcome to Flutter', home: Loading());
      },
    );
  }
}
