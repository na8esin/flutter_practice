import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/*
 * カテゴリー
 */
enum CategorySeasons {
  spring,
  summer,
  autumn,
  winter,
}

final categorySeasonsProvider =
    StateProvider<CategorySeasons>((ref) => CategorySeasons.spring);

/*
 * カテゴリウィジェット
 */
class CategorySlideWidget extends HookWidget {
  final List<CategorySeasons> _categoryList = [
    CategorySeasons.spring,
    CategorySeasons.summer,
    CategorySeasons.autumn,
    CategorySeasons.winter,
  ];

  @override
  Widget build(BuildContext context) {
    final categorySeasonsController = useProvider(categorySeasonsProvider);
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
                categorySeasonsController.state = _categoryList[index];
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
