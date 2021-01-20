import 'package:flutter/material.dart';

import 'CategorySlideWidget.dart';
import 'SegmentWidget.dart';

void main() => runApp(Main());

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

class MainViewWidget extends StatefulWidget {
  @override
  _MainViewWidgetState createState() => _MainViewWidgetState();
}

class _MainViewWidgetState extends State<MainViewWidget> {
  // カテゴリー
  CategorySeasons _categorySeasons = CategorySeasons.spring;
  // セグメント
  Segment _segment = Segment.day;

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
            /*
             * カテゴリーウィジェット
             */
            CategorySlideWidget(
              (CategorySeasons season) {
                // ステート更新
                setState(() {
                  _categorySeasons = season;
                });
              },
            ),

            /*
             * セグメントウィジェット
             */
            SegmentWidget(_segment, (Segment segment) {
              // ステート更新
              setState(() {
                _segment = segment;
              });
            }),

            /*
             * コンテンツと想定
             */
            Expanded(
              child: Container(
                  color: Colors.blue, child: Icon(_getContentsImagePath())),
            )
          ],
        ),
      ),
    );
  }

  /*
   * 画像は面倒なのでICONに変更
   */
  IconData _getContentsImagePath() {
    bool isDay = _segment == Segment.day;
    print(isDay);
    switch (_categorySeasons) {
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
  }
}
