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

// https://qiita.com/tabe_unity/items/4c0fa9b167f4d0a7d7c2

// たくさんデータがあるとエラーが出てスクロールできない
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        // これがあってもなくても変わんない
        //mainAxisSize: MainAxisSize.min,
        children: [
          Text('one list view'),
          ListView.builder(
              shrinkWrap: true, //追加
              //physics: const NeverScrollableScrollPhysics(), //追加
              itemCount: 50,
              itemBuilder: (BuildContext context, int index) {
                return Text('item no:$index');
              }),
          SizedBox(
            height: 20,
          ),
          Text('two list view'),
          ListView.builder(
              shrinkWrap: true, //追加
              //physics: const NeverScrollableScrollPhysics(), //追加
              itemCount: 50,
              itemBuilder: (BuildContext context, int index) {
                return Text('item no:${index * 2}');
              }),
        ]);
  }
}
