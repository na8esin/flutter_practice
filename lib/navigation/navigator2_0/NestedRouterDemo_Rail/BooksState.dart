import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'book.dart';

final booksProvider = StateNotifierProvider(
    (ref) => BooksController(BooksState(selectedModel: null)));

class BooksState {
  BooksState({this.selectedModel});
  final Book selectedModel;
}

class BooksController extends StateNotifier<BooksState> {
  BooksController(BooksState state) : super(state);

  final List<Book> _models = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  Book get selectedModel => state.selectedModel;

  set selectedModel(Book model) {
    state = BooksState(
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
    state = BooksState(selectedModel: models[id]);
  }

  List<Book> get models => _models;

  int getSelectedBookByModel(Book selectedModel) {
    if (!_models.contains(selectedModel)) return -2;
    return _models.indexOf(selectedModel);
  }
}
