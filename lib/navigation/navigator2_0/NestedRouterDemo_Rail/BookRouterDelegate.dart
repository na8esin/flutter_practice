import 'package:flutter/material.dart';

import 'AppShell.dart';
import 'BooksAppState.dart';
import 'BookRoutePath.dart';
import 'AuthorsState.dart';

// Navigatorあります
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  BooksAppState appState = BooksAppState();

  // ここにAuthorsStateとか追加していくかんじかぁ。。。それなら、
  // appStateに集約しててもいいのかぁ。
  // まずは、集約しないパターンで。
  AuthorsState authorsState = AuthorsState();

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
    authorsState.addListener(notifyListeners);
  }

  @override
  BookRoutePath get currentConfiguration {
    if (appState.selectedIndex == 1) {
      return BooksSettingsPath();
    } else if (appState.selectedIndex == 2) {
      if (authorsState.selectedModel == null) {
        return AuthorsScreenPath();
      } else {
        return AuthorDetailScreenPath(authorsState.getSelectedModelById());
      }
    } else {
      if (appState.selectedBook == null) {
        return BooksListPath();
      } else {
        return BooksDetailsPath(appState.getSelectedBookById());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          // ☆☆☆☆☆☆☆☆☆☆
          child: AppShell(appState: appState, authorsState: authorsState),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (appState.selectedBook != null) {
          appState.selectedBook = null;
        }
        if (authorsState.selectedModel != null) {
          authorsState.selectedModel = null;
        }

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    if (path is BooksListPath) {
      appState.selectedIndex = 0;
      appState.selectedBook = null;
    } else if (path is BooksDetailsPath) {
      // https://gist.github.com/johnpryan/bbca91e23bbb4d39247fa922533be7c9#gistcomment-3511502
      // うまくいった！
      appState.selectedIndex = 0; // This was missing!
      appState.setSelectedBookById(path.id);
    } else if (path is AuthorsScreenPath) {
      appState.selectedIndex = 2;
      authorsState.selectedModel = null;
    } else if (path is AuthorDetailScreenPath) {
      appState.selectedIndex = 2;
      authorsState.setSelectedModelById(path.id);
    } else if (path is BooksSettingsPath) {
      appState.selectedIndex = 1;
    }
  }
}
