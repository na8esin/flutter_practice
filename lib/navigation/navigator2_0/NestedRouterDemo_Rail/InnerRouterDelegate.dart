import 'package:flutter/material.dart';

import 'BookRoutePath.dart';
import 'AppState.dart';
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
  AppController _appController;
  AppController get appController => _appController;
  set appState(AppController value) {
    if (value == _appController) {
      return;
    }
    _appController = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appController);

  // RouterDelegateのbuildはNavigatorを返すだけ
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appController.selectedIndex == 0) ...[
          FadeAnimationPage(
            child: BooksListScreen(
              books: appController.booksController.models,
              onTapped: _handleBookTapped,
            ),
            key: ValueKey('BooksListPage'),
          ),
          if (appController.booksController.selectedModel != null)
            MaterialPage(
              key: ValueKey(appController.booksController.selectedModel),
              child: BookDetailScreen(
                  book: appController.booksController.selectedModel),
            ),
        ] else if (appController.selectedIndex == 1) ...[
          FadeAnimationPage(
            child: SettingsScreen(),
            key: ValueKey('SettingsPage'),
          ),
        ] else if (appController.selectedIndex == 2) ...[
          // toStringShort()は「Instance of 」がとれてAuthorsScreenだけになる
          // でも引数が必要な時は使えない
          FadeAnimationPage(
            child: AuthorsScreen(
              models: appController.authorsController.models,
              onTapped: _handleAuthorTapped,
            ),
            key: ValueKey('AuthorsScreen'),
          ),
          if (appController.authorsController.selectedModel != null)
            MaterialPage(
              key: ValueKey(appController.authorsController.selectedModel),
              child: AuthorDetailScreen(
                  model: appController.authorsController.selectedModel),
            ),
        ]
      ],
      onPopPage: (route, result) {
        appController.booksController.selectedModel = null;
        // TODO: どんな意味かわかんね。
        // さっきはここが追加されてなかった。
        appController.authorsController.selectedModel = null;
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
    appController.booksController.selectedModel = book;
    notifyListeners();
  }

  void _handleAuthorTapped(Author model) {
    appController.authorsController.selectedModel = model;
    notifyListeners();
  }
}
