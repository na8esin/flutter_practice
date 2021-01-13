import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'book.dart';

final booksProvider = StateNotifierProvider((ref) => BooksController(Book()));

class BooksController extends StateNotifier<Book> {
  BooksController(Book state) : super(state);

  final List<Book> _models = [
    Book(title: 'Stranger in a Strange Land', author: 'Robert A. Heinlein'),
    Book(title: 'Foundation', author: 'Isaac Asimov'),
    Book(title: 'Fahrenheit 451', author: 'Ray Bradbury'),
  ];

  Book get selectedModel => state;

  set selectedModel(Book model) {
    state = model;
  }

  int getSelectedModelById() {
    if (!models.contains(state)) return 0;
    return models.indexOf(state);
  }

  void setSelectedModelById(int id) {
    if (id < 0 || id > models.length - 1) {
      return;
    }
    state = models[id];
  }

  List<Book> get models => _models;

  int getSelectedBookByModel(Book selectedModel) {
    if (!_models.contains(selectedModel)) return -2;
    return _models.indexOf(selectedModel);
  }
}
