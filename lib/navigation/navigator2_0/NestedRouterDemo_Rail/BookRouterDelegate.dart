import 'package:flutter/material.dart';
import 'package:flutter_practice/navigation/navigator2_0/router/books_app_state_notifier.dart';

import 'AppShell.dart';
import 'AppState.dart';
import 'BookRoutePath.dart';
import 'AuthorsState.dart';
import 'BooksState.dart';

// Navigatorあります
// TODO: Controller.Controllerになったから長くなった
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppController appController = AppController(AppState(
      authorsController: AuthorsController(AuthorsState(selectedModel: null)),
      booksController: BooksController(BooksState(selectedModel: null)),
      selectedIndex: 0));

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appController.addListener((state) {
      notifyListeners();
    });
    appController.authorsController.addListener((state) {
      notifyListeners();
    });
    appController.booksController.addListener((state) {
      notifyListeners();
    });
  }

  @override
  BookRoutePath get currentConfiguration {
    if (appController.selectedIndex == 1) {
      return BooksSettingsPath();
    } else if (appController.selectedIndex == 2) {
      if (appController.authorsController.selectedModel == null) {
        return AuthorsScreenPath();
      } else {
        return AuthorDetailScreenPath(
            appController.authorsController.getSelectedModelById());
      }
    } else {
      if (appController.booksController.selectedModel == null) {
        return BooksListPath();
      } else {
        return BooksDetailsPath(
            appController.booksController.getSelectedModelById());
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
          child: AppShell(appController: appController),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (appController.booksController.selectedModel != null) {
          appController.booksController.selectedModel = null;
        }
        // TODO: ここのソースがどんな意味かわかんね
        if (appController.authorsController.selectedModel != null) {
          appController.authorsController.selectedModel = null;
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
      appController.selectedIndex = 0;
      appController.booksController.selectedModel = null;
    } else if (path is BooksDetailsPath) {
      // https://gist.github.com/johnpryan/bbca91e23bbb4d39247fa922533be7c9#gistcomment-3511502
      // うまくいった！
      appController.selectedIndex = 0; // This was missing!
      appController.booksController.setSelectedModelById(path.id);
    } else if (path is AuthorsScreenPath) {
      appController.selectedIndex = 2;
      appController.authorsController.selectedModel = null;
    } else if (path is AuthorDetailScreenPath) {
      appController.selectedIndex = 2;
      appController.authorsController.setSelectedModelById(path.id);
    } else if (path is BooksSettingsPath) {
      appController.selectedIndex = 1;
    }
  }
}
