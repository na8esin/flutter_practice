import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'model/category.dart';

final categoriesProvider =
    StateNotifierProvider((ref) => CategoriesController(null));

class CategoriesController extends StateNotifier<Category> {
  CategoriesController(Category state) : super(state);

  // 1つのbookに複数のCategoryが紐づく
  final List<List<Category>> _models = [
    [
      Category(id: 0, name: 'Society'),
      Category(id: 1, name: 'Literature'),
    ],
    [
      Category(id: 2, name: 'Literature'),
    ],
  ];
  Category get selectedModel => state;

  set selectedModel(Category model) {
    state = model;
  }

  // bookIdに紐づく全カテゴリ
  List<Category> getModelsByBookId(int id) {
    if (id > _models.length - 1) return [];
    return _models.elementAt(id);
  }

  void setSelectedModelById(int bookId, int id) {
    if (id < 0 || id > getModelsByBookId(bookId).length - 1) {
      return;
    }
    state = getModelsByBookId(bookId)[id];
  }

  int getSelectedModelById(int bookId) {
    List<Category> modelList = getModelsByBookId(bookId);
    if (!modelList.contains(state)) return 0;
    return getModelsByBookId(bookId).indexOf(state);
  }

  onTapped(Category model) {
    state = model;
  }
}
