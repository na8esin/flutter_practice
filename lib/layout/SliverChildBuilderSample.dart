import 'package:flutter/material.dart';

// Similar as ListView.separated
class SliverChildBuilderSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            return Text('${itemIndex}');
          }
          return Divider(height: 5, color: Colors.grey);
        }, semanticIndexCallback: (Widget widget, int localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          return null;
        }, childCount: 30 - 1),
      ),
    ]);
  }
}
