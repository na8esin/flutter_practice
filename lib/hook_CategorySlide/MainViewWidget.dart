import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'CategorySlideWidget.dart';
import 'SegmentWidget.dart';

void main() => runApp(ProviderScope(
      child: Main(),
    ));

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainViewWidget(),
    );
  }
}

final iconDataProvider = StateProvider<IconData>((ref) {
  final segment = ref.watch(segmentProvider.state);
  bool isDay = segment == Segment.day;
  final categorySeasons = ref.watch(categorySeasonsProvider).state;
  switch (categorySeasons) {
    case CategorySeasons.spring:
      return isDay ? Icons.add_a_photo_outlined : Icons.add_a_photo;

    case CategorySeasons.summer:
      return isDay
          ? Icons.account_balance_wallet_outlined
          : Icons.account_balance_wallet;

    case CategorySeasons.autumn:
      return isDay ? Icons.account_box_outlined : Icons.account_box_rounded;

    case CategorySeasons.winter:
      return isDay ? Icons.account_tree_outlined : Icons.account_tree_rounded;
    default:
      return Icons.adb;
  }
});

class MainViewWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Title"),
      ),
      body: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            CategorySlideWidget(),
            SegmentWidget(),

            /*
             * コンテンツと想定
             */
            Expanded(
                child: Container(
              color: Colors.blue,
              // 画像は面倒なので、Iconを表示
              child: Icon(useProvider(iconDataProvider).state),
            ))
          ],
        ),
      ),
    );
  }
}
