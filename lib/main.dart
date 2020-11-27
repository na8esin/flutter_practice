// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'detail_screen.dart';
import 'error.dart';
import 'home_screen.dart';
import 'loading.dart';
import 'public_screen.dart';
import 'stream_public_screen.dart';
import 'unknown_screen.dart';

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

class Navigation extends StatelessWidget {
  final String _title;
  Navigation(this._title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'details') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => DetailScreen(id: id));
        }

        if (uri.pathSegments.first == 'public') {
          return MaterialPageRoute(builder: (context) => PublicScreen());
        }
        if (uri.pathSegments.first == 'public_stream') {
          return MaterialPageRoute(builder: (context) => StreamPublicScreen());
        }

        return MaterialPageRoute(builder: (context) => UnknownScreen());
      },
    );
  }
}
