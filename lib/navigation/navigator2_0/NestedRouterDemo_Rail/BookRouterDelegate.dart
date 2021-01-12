import 'package:flutter/material.dart';
import 'package:flutter_practice/navigation/navigator2_0/router/books_app_state_notifier.dart';

import 'AppShell.dart';
import 'BooksAppState.dart';
import 'BookRoutePath.dart';
import 'AuthorsState.dart';
import 'BooksState.dart';

// Navigatorあります
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  BooksAppState appState = BooksAppState();

  AuthorsController authorsController =
      AuthorsController(AuthorsState(selectedModel: null));

  BooksController booksController =
      BooksController(BooksState(selectedModel: null));

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
    authorsController.addListener((state) {
      notifyListeners();
    });
    booksController.addListener((state) {
      notifyListeners();
    });
    appState.authorsController = authorsController;
    appState.booksController = booksController;
  }

  @override
  BookRoutePath get currentConfiguration {
    if (appState.selectedIndex == 1) {
      return BooksSettingsPath();
    } else if (appState.selectedIndex == 2) {
      if (authorsController.selectedModel == null) {
        return AuthorsScreenPath();
      } else {
        return AuthorDetailScreenPath(authorsController.getSelectedModelById());
      }
    } else {
      if (booksController.selectedModel == null) {
        return BooksListPath();
      } else {
        return BooksDetailsPath(booksController.getSelectedModelById());
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
          child: AppShell(appState: appState),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (booksController.selectedModel != null) {
          booksController.selectedModel = null;
        }
        // TODO: ここのソースがどんな意味かわかんね
        if (authorsController.selectedModel != null) {
          authorsController.selectedModel = null;
        }

        notifyListeners();
        return true;
      },
    );
  }

  // 継承元の引数の名前は、configurationなのかよ！
  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    if (path is BooksListPath) {
      appState.selectedIndex = 0;
      booksController.selectedModel = null;
    } else if (path is BooksDetailsPath) {
      // https://gist.github.com/johnpryan/bbca91e23bbb4d39247fa922533be7c9#gistcomment-3511502
      // うまくいった！
      appState.selectedIndex = 0; // This was missing!
      booksController.setSelectedModelById(path.id);
    } else if (path is AuthorsScreenPath) {
      appState.selectedIndex = 2;
      authorsController.selectedModel = null;
    } else if (path is AuthorDetailScreenPath) {
      appState.selectedIndex = 2;
      authorsController.setSelectedModelById(path.id);
    } else if (path is BooksSettingsPath) {
      appState.selectedIndex = 1;
    }
  }
}
