import 'package:flutter/material.dart';

// columnで大量のデータを表示するとスクロールする？
//   -> No
class MassColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [for (int i = 0; i < 100; i++) Text('${i}')]);
  }
}
