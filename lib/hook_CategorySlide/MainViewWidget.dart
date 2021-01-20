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
                color: Colors.blue,
                child: Image.asset(_getContentsImagePath()),
              ),
            )
          ],
        ),
      ),
    );
  }

  /*
   * コンテンツに表示する画像のパス文字列を返す
   */
  String _getContentsImagePath() {
    // TODO : このあたりは仮なので適当に実装しました。
    bool isDay = _segment == Segment.day;
    switch (_categorySeasons) {
      case CategorySeasons.spring:
        return isDay ? "images/spring-day.jpg" : "images/spring-night.jpg";

      case CategorySeasons.summer:
        return isDay ? "images/summer-day.jpg" : "images/summer-night.jpg";

      case CategorySeasons.autumn:
        return isDay ? "images/autumn-day.jpg" : "images/autumn-night.jpg";

      case CategorySeasons.winter:
        return isDay ? "images/winter-day.jpg" : "images/winter-night.jpg";
    }
  }
}
