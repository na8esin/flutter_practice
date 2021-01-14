import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'model/category.dart';

final categoriesProvider =
    StateNotifierProvider((ref) => CategoriesController(null));

final categoriesStreamProvider =
    StreamProvider.family<List<Category>, int>((ref, int bookId) {
  return categoriesStore(bookId);
});

// 疑似firestore
Stream<List<Category>> categoriesStore(int bookId) {
  final List<List<Category>> _models = [
    [
      Category(id: 0, name: 'Society'),
      Category(id: 1, name: 'Literature'),
    ],
    [
      Category(id: 2, name: 'Literature'),
    ],
  ];
  var streamController = StreamController<List<Category>>();
  streamController.sink.add(_models[bookId]);
  return streamController.stream;
}

class CategoriesController extends StateNotifier<Category> {
  CategoriesController(Category state) : super(state);

  Category get selectedModel => state;

  set selectedModel(Category model) {
    state = model;
  }

  // bookIdに紐づく全カテゴリ
  // _modelsがstreamで変化する場合はどうすればいいんだ？
  // モデルそのものを記録しておくんじゃなくて、IDを記録しないとだめなのか。
  // IDを記録したときIDが削除されて、新しく振り直しすると
  // ブラウザバックした時に別の画面になったりするから、やっぱりIDはUUIDみたいなのがいい。
  Future<List<Category>> getModelsByBookId(int id) async {
    var _models = await categoriesStore(id).last;
    return _models;
  }

  void setSelectedModelById(int bookId, int id) async {
    var models = await getModelsByBookId(bookId);
    if (id < 0 || id > models.length - 1) {
      return;
    }
    state = models[id];
  }

  Future<int> getSelectedModelById(int bookId) async {
    List<Category> modelList = await getModelsByBookId(bookId);
    if (!modelList.contains(state)) return 0;

    return modelList.indexOf(state);
  }

  onTapped(Category model) {
    state = model;
  }
}
