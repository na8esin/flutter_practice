/*
  https://gist.github.com/mono0926/404aed55890ef8628f9d6288bd31fff8
  
  GlobalKey<NavigatorState>
  を使うサンプル
*/

import 'package:flutter/material.dart';

void main() {
  final navigatorKey = GlobalKey<NavigatorState>();
  runApp(
    MyApp(
      navigatorKey: navigatorKey,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    Key key,
    @required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: () {
            // ここだと `Navigator.of(context)` 使えるので意味が無いが
            // 実際にはnavigatorKeyを取り回すことでどこでも呼べる
            navigatorKey.currentState.pushNamed("hoo");
          },
        ),
      ),
      navigatorKey: navigatorKey,
      onGenerateRoute: _handleRoutes,
    );
  }

  Route _handleRoutes(RouteSettings settings) {
    final name = settings.name;
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
      ),
    );
  }
}
