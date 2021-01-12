import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'AppState.dart';
import 'AuthorDetailScreen.dart';
import 'AuthorsScreen.dart';
import 'AuthorsState.dart';
import 'author.dart';
import 'BookRoutePath.dart';
import 'book.dart';
import 'BooksListScreen.dart';
import 'BookDetailScreen.dart';
import 'BooksState.dart';
import 'settings_screen.dart';
import 'FadeAnimationPage.dart';

// Navigatorあります
// currentConfigurationがないね
class InnerRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  @override // from PopNavigatorRouterDelegateMixin
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final _container = ProviderContainer();

  InnerRouterDelegate();

  // RouterDelegateのbuildはNavigatorを返すだけ
  @override
  Widget build(BuildContext context) {
    final appController = _container.read(appProvider);
    final authorsController = _container.read(authorsProvider);
    final booksController = _container.read(booksProvider);

    return Navigator(
      key: navigatorKey,
      pages: [
        if (appController.selectedIndex == 0) ...[
          FadeAnimationPage(
            child: BooksListScreen(
                books: booksController.models,
                onTapped: (Book book) {
                  booksController.selectedModel = book;
                  notifyListeners();
                }),
            key: ValueKey('BooksListPage'),
          ),
          if (booksController.selectedModel != null)
            MaterialPage(
              key: ValueKey(booksController.selectedModel),
              child: BookDetailScreen(book: booksController.selectedModel),
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
              models: authorsController.models,
              onTapped: (Author model) {
                authorsController.selectedModel = model;
                notifyListeners();
              },
            ),
            key: ValueKey('AuthorsScreen'),
          ),
          if (authorsController.selectedModel != null)
            MaterialPage(
              key: ValueKey(authorsController.selectedModel),
              child: AuthorDetailScreen(model: authorsController.selectedModel),
            ),
        ]
      ],
      onPopPage: (route, result) {
        booksController.selectedModel = null;
        // TODO: どんな意味かわかんね。
        // さっきはここが追加されてなかった。
        authorsController.selectedModel = null;
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
}
