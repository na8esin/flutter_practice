import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'author.dart';

class AuthorsState {
  AuthorsState({this.selectedModel});
  final Author selectedModel;
}

class AuthorsController extends StateNotifier<AuthorsState> {
  AuthorsController(AuthorsState state) : super(state);

  final List<Author> _models = [
    Author(name: 'Robert A. Heinlein', age: 32, id: 0),
    Author(name: 'Isaac Asimov', age: 54, id: 1),
    Author(name: 'Ray Bradbury', age: 22, id: 2),
  ];

  Author get selectedModel => state.selectedModel;

  set selectedModel(Author model) {
    state = AuthorsState(
      selectedModel: model,
    );
  }

  int getSelectedModelById() {
    if (!models.contains(state.selectedModel)) return 0;
    return models.indexOf(state.selectedModel);
  }

  void setSelectedModelById(int id) {
    if (id < 0 || id > models.length - 1) {
      return;
    }
    state = AuthorsState(selectedModel: models[id]);
  }

  List<Author> get models => _models;

  int getSelectedBookByModel(Author selectedModel) {
    if (!_models.contains(selectedModel)) return -2;
    return _models.indexOf(selectedModel);
  }
}
