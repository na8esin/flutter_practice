import 'package:flutter/material.dart';

import 'book.dart';
import 'author.dart';
import 'AuthorsState.dart';

// StateNotifierに変更可能
class BooksAppState extends ChangeNotifier {
  // NavigationRailが変更されるたびに変わる
  int _selectedIndex;

  // ここが増えてくのかぁ。。。
  // getterとsetterもガンガン増えてくなぁ。
  Book _selectedBook;
  AuthorsState _authorsState;
  AuthorsState get authorsState => _authorsState;
  set authorsState(value) {
    _authorsState = value;
    notifyListeners();
  }

  final List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];
  final List<Author> authors = [
    Author(name: 'Robert A. Heinlein', age: 32, id: 0),
    Author(name: 'Isaac Asimov', age: 54, id: 1),
    Author(name: 'Ray Bradbury', age: 22, id: 2),
  ];

  // ここにauthorsをおきたくないね。。。

  BooksAppState() : _selectedIndex = 0 {
    _authorsState = AuthorsState(authors);
  }

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

  Book get selectedBook => _selectedBook;

  set selectedBook(Book book) {
    _selectedBook = book;
    notifyListeners();
  }

  int getSelectedBookById() {
    if (!books.contains(_selectedBook)) return 0;
    return books.indexOf(_selectedBook);
  }

  void setSelectedBookById(int id) {
    if (id < 0 || id > books.length - 1) {
      return;
    }

    _selectedBook = books[id];
    notifyListeners();
  }
}

// bookStateを分離するとbookは動かなくなるか検証
