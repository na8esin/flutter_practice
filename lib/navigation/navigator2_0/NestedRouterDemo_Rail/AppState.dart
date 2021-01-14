import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'BooksState.dart';

final appProvider = StateNotifierProvider(
    (ref) => AppController(AppState(BooksController(null), null, null, 0)));

class AppState {
  AppState(this.books, this.authors, this.categories, this.index);
  final BooksController books;
  final authors;
  final categories;
  final int index;
}

class AppController extends StateNotifier<AppState> {
  AppController(state) : super(state);

  addNotifyListeners(VoidCallback notifyListeners) {
    addListener((state) {
      notifyListeners();
    });
    state.books.addListener((state) {
      notifyListeners();
    });
  }

  get books => state.books;

  onDestinationSelected(int newIndex) {
    setIndex(newIndex);
  }

  setIndex(int value) {
    state = AppState(state.books, state.authors, state.categories, value);
  }

  get getIndex => state.index;
}
