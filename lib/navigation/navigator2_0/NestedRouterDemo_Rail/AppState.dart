import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'AuthorsState.dart';
import 'BooksState.dart';

class AppState {
  AppState({this.selectedIndex, this.authorsController, this.booksController});
  // NavigationRailが変更されるたびに変わる
  final int selectedIndex;
  final AuthorsController authorsController;
  final BooksController booksController;
}

// StateNotifierに変更可能
class AppController extends StateNotifier<AppState> {
  AppController(AppState state) : super(state);

  AuthorsController get authorsController => state.authorsController;
  set authorsController(controller) {
    state = AppState(
        authorsController: controller,
        booksController: booksController,
        selectedIndex: selectedIndex);
  }

  BooksController get booksController => state.booksController;
  set booksController(controller) {
    state = AppState(
        authorsController: authorsController,
        booksController: controller,
        selectedIndex: selectedIndex);
  }

  int get selectedIndex => state.selectedIndex;

  set selectedIndex(int idx) {
    state = AppState(
      selectedIndex: idx,
      authorsController: authorsController,
      booksController: booksController,
    );

    // _selectedIndex == 1の時って要するにsettingの時
    // BottomNavigationBarのstateをBooksAppStateみたいな名前のstateで
    // 管理してるのが違和感。。。
    //if (_selectedIndex == 1) {
    // Remove this line if you want to keep the selected book when navigating
    // between "settings" and "home" which book was selected when Settings is
    // tapped.
    //selectedBook = null;
    //}
  }
}
