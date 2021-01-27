import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'Column_listview.dart';
import 'ListViewHeader.dart';
import 'TwoMasSliverlist.dart';
import 'mass_data_listview.dart';
import 'SliverlistSample.dart';
import 'SliverChildBuilderSample.dart';
import 'MassColumn.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: MyApp())));
}

List<Map<String, dynamic>> listListTile = [
  titleBuilder(MassColumn()),
  titleBuilder(ColumnListview()),
  titleBuilder(ListViewHeader()),
  titleBuilder(MassDataListview()),
  titleBuilder(TwoMasSliverlist()),
  titleBuilder(SliverlistSample()),
  titleBuilder(SliverChildBuilderSample()),
];

titleBuilder(Widget clazz) {
  return {'title': Text(clazz.toStringShort()), 'builder': clazz};
}

class MyApp extends HookWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            itemCount: listListTile.length,
            separatorBuilder: (context, index) => const SizedBox(height: 3),
            itemBuilder: (context, index) {
              return ListTile(
                  title: listListTile[index]['title'],
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: listListTile[index]['builder'],
                              ))));
            }));
  }
}
