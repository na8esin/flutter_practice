import 'package:flutter/material.dart';

/*
 * カテゴリー
 */
enum CategorySeasons {
  spring,
  summer,
  autumn,
  winter,
}

/*
 * カテゴリーコールバック
 */
typedef CategoryCallback = void Function(CategorySeasons season);

/*
 * カテゴリウィジェット
 */
class CategorySlideWidget extends StatelessWidget {
  final List<CategorySeasons> _categoryList = [
    CategorySeasons.spring,
    CategorySeasons.summer,
    CategorySeasons.autumn,
    CategorySeasons.winter,
  ];

  // カテゴリー選択コールバック
  final CategoryCallback callback;

  CategorySlideWidget(this.callback) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 120.0,
            child: InkWell(
              onTap: () {
                if (callback != null) {
                  callback(_categoryList[index]);
                }
                print(
                    "on tap -> ${_categoryList[index].toString().split('.')[1]}");
              },
              child: Card(
                child: Center(
                  child: Text(
                    _categoryList[index].toString().split('.')[1],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: _categoryList.length,
      ),
    );
  }
}
