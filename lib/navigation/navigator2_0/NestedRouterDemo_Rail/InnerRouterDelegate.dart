import 'package:flutter/material.dart';

import 'BookRoutePath.dart';
import 'BooksAppState.dart';
import 'book.dart';
import 'BooksListScreen.dart';
import 'BookDetailScreen.dart';
import 'AuthorDetailScreen.dart';
import 'AuthorsScreen.dart';
import 'author.dart';
import 'settings_screen.dart';
import 'FadeAnimationPage.dart';

// Navigatorあります
// currentConfigurationがないね
class InnerRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  @override // from PopNavigatorRouterDelegateMixin
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // この辺見るとうぇーってなる
  BooksAppState get appState => _appState;
  BooksAppState _appState;
  set appState(BooksAppState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState);

  // RouterDelegateのbuildはNavigatorを返すだけ
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          FadeAnimationPage(
            child: BooksListScreen(
              books: appState.books,
              onTapped: _handleBookTapped,
            ),
            key: ValueKey('BooksListPage'),
          ),
          if (appState.selectedBook != null)
            MaterialPage(
              key: ValueKey(appState.selectedBook),
              child: BookDetailScreen(book: appState.selectedBook),
            ),
        ] else if (appState.selectedIndex == 1) ...[
          FadeAnimationPage(
            child: SettingsScreen(),
            key: ValueKey('SettingsPage'),
          ),
        ] else if (appState.selectedIndex == 2) ...[
          // toStringShort()は「Instance of 」がとれてAuthorsScreenだけになる
          // でも引数が必要な時は使えない
          FadeAnimationPage(
            child: AuthorsScreen(
              models: [
                Author(name: 'Robert A. Heinlein', age: 32, id: 0),
                Author(name: 'Isaac Asimov', age: 54, id: 1),
                Author(name: 'Ray Bradbury', age: 22, id: 2),
              ],
              onTapped: _handleAuthorTapped,
            ),
            key: ValueKey('AuthorsScreen'),
          ),
          if (appState.authorsState.selectedModel != null)
            MaterialPage(
              key: ValueKey(appState.authorsState.selectedModel),
              child: AuthorDetailScreen(
                  model: appState.authorsState.selectedModel),
            ),
        ]
      ],
      onPopPage: (route, result) {
        appState.selectedBook = null;
        // TODO: どんな意味かわかんね。
        // さっきはここが追加されてなかった。
        appState.authorsState.selectedModel = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    // This is not required for inner router delegate because it does not
    // parse route
    assert(false);
  }

  void _handleBookTapped(Book book) {
    appState.selectedBook = book;
    notifyListeners();
  }

  void _handleAuthorTapped(Author model) {
    appState.authorsState.selectedModel = model;
    notifyListeners();
  }
}
