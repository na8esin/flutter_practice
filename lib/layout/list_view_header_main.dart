import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('header'),
        SizedBox(
          height: 50,
        ),
        Expanded(
          child: ListView(
            children: [
              Text('one'),
              Text('two'),
              Text('three'),
            ],
          ),
        )
      ],
    );
  }
}
