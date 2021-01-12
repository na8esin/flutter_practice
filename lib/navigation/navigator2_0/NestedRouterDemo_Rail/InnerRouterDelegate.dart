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
              models: appState.authors,
              onTapped: _handleAuthorTapped,
            ),
            key: ValueKey('AuthorsScreen'),
          ),
          if (appState.selectedAuthor != null)
            MaterialPage(
              key: ValueKey(appState.selectedAuthor),
              child: AuthorDetailScreen(model: appState.selectedAuthor),
            ),
        ]
      ],
      onPopPage: (route, result) {
        appState.selectedBook = null;
        // TODO: どんな意味かわかんね。
        // さっきはここが追加されてなかった。
        appState.selectedAuthor = null;
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
    appState.selectedAuthor = model;
    notifyListeners();
  }
}
