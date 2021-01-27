import 'package:flutter/material.dart';

// ListViewが一つなら、たくさんデータがあっても、スクロールできる
class MassDataListview extends StatelessWidget {
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
