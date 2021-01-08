import 'package:flutter/material.dart';
import 'author.dart';

class AuthorsState extends SelectedModel<Author> {}

// 抽象化するならこういうのが必要そう
class SelectedModel<T> extends ChangeNotifier {
  T _selectedModel;
  List<T> _models;
  T get selectedModel => _selectedModel;

  set selectedModel(T model) {
    _selectedModel = model;
    notifyListeners();
  }

  int getSelectedModelById() {
    if (!_models.contains(_selectedModel)) return 0;
    return _models.indexOf(_selectedModel);
  }

  void setSelectedModelById(int id) {
    if (id < 0 || id > _models.length - 1) {
      return;
    }

    _selectedModel = _models[id];
    notifyListeners();
  }
}
