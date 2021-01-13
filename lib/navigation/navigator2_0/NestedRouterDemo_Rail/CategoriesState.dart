import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'model/category.dart';

final categoriesProvider =
    StateNotifierProvider((ref) => CategoriesController(null));

class CategoriesController extends StateNotifier<Category> {
  CategoriesController(Category state) : super(state);

  // 1つのbookに複数のCategoryが紐づく
  final List<List<Category>> _models = [
    [
      Category(0, 'Society'),
      Category(0, 'Literature'),
    ],
    [
      Category(0, 'Literature'),
    ],
  ];

  // bookIdに紐づく全カテゴリ
  List<Category> getModelsByBookId(int id) {
    if (id > _models.length - 1) return [];
    return _models.elementAt(id);
  }
}
