import 'package:flutter/material.dart';

// 2つのリストがあってもちゃんとスクロールする
class TwoMasSliverlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(slivers: [
        // headerの代わり
        SliverAppBar(
          backgroundColor: Colors.blueGrey[200],
          title: Text('one'),
          automaticallyImplyLeading: false,
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              for (int i = 0; i < 50; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$i'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text('detail'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text('detail2'),
                    )
                  ],
                ),
              // ここになら入れられる
              // SizedBox(height: 0,)
            ]),
          ),
        ),
        // こういうのは入れられない
        //   SizedBox(height: 20,),
        // SliverListをpaddingで囲うのもむり
        SliverAppBar(
          backgroundColor: Colors.blueGrey[200],
          title: Text('two'),
          automaticallyImplyLeading: false,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            for (int i = 0; i < 50; i++) Text('${i * 2}'),
          ]),
        ),
      ]),
    );
  }
}
