import 'package:flutter/material.dart';

import 'AuthorsState.dart';
import 'BooksState.dart';

// StateNotifierに変更可能
class BooksAppState extends ChangeNotifier {
  // NavigationRailが変更されるたびに変わる
  int _selectedIndex;

  AuthorsController _authorsController;
  AuthorsController get authorsController => _authorsController;
  set authorsController(controller) {
    _authorsController = controller;
    notifyListeners();
  }

  BooksController _booksController;
  BooksController get booksController => _booksController;
  set booksController(controller) {
    _booksController = controller;
    notifyListeners();
  }

  BooksAppState() : _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int idx) {
    _selectedIndex = idx;

    // _selectedIndex == 1の時って要するにsettingの時
    // BottomNavigationBarのstateをBooksAppStateみたいな名前のstateで
    // 管理してるのが違和感。。。
    if (_selectedIndex == 1) {
      // Remove this line if you want to keep the selected book when navigating
      // between "settings" and "home" which book was selected when Settings is
      // tapped.
      //selectedBook = null;
    }
    notifyListeners();
  }
}
