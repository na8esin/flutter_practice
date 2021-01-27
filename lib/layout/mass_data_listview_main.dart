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

// ListViewが一つなら、たくさんデータがあっても、スクロールできる
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 4),
        shrinkWrap: false,
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return Text('item no:$index');
        });
  }
}
