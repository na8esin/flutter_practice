import 'package:flutter/material.dart';
import 'author.dart';

class AuthorsState extends SelectedModel<Author> {
  AuthorsState(this.models);
  List<Author> models;
}

// 抽象化するならこういうのが必要そう
class SelectedModel<T> extends ChangeNotifier {
  T _selectedModel;
  List<T> models;
  T get selectedModel => _selectedModel;

  set selectedModel(T model) {
    _selectedModel = model;
    notifyListeners();
  }

  int getSelectedModelById() {
    if (!models.contains(_selectedModel)) return 0;
    return models.indexOf(_selectedModel);
  }

  void setSelectedModelById(int id) {
    if (id < 0 || id > models.length - 1) {
      return;
    }

    _selectedModel = models[id];
    notifyListeners();
  }
}
