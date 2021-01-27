import 'package:flutter/material.dart';

// 2つのリストがあってもちゃんとスクロールする
class TwoMasSliverlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverPadding(
        padding: EdgeInsets.all(8.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            for (int i = 0; i < 50; i++) Text('$i'),
            // ここになら入れられる
            // SizedBox(height: 0,)
          ]),
        ),
      ),
      // こういうのは入れられない
      //   SizedBox(height: 20,),
      // SliverListをpaddingで囲うのもむり
      SliverList(
        delegate: SliverChildListDelegate([
          for (int i = 0; i < 50; i++) Text('${i * 2}'),
        ]),
      ),
    ]);
  }
}
