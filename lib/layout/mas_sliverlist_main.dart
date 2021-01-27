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
    return CustomScrollView(slivers: [
      // listviewじゃなくて、forでやれってことかなぁ
      SliverList(
        delegate: SliverChildListDelegate([
          for (int i = 0; i < 50; i++) Text('$i'),
          SizedBox(
            height: 20,
          ),
          for (int i = 0; i < 50; i++) Text('${i * 2}')
        ]),
      ),
    ]);
  }
}
