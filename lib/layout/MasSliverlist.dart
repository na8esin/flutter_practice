import 'package:flutter/material.dart';

class MasSliverlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverList(
        delegate: SliverChildListDelegate([
          for (int i = 0; i < 50; i++) Text('$i'),
          // ここになら入れられる
          SizedBox(
            height: 20,
          )
        ]),
      ),
      // こういうのは入れられない
      // SizedBox(height: 20,),
      // paddingで囲うのもむり
      SliverList(
        delegate: SliverChildListDelegate([
          for (int i = 0; i < 50; i++) Text('${i * 2}'),
        ]),
      ),
    ]);
  }
}
