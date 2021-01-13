import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'AuthorsState.dart';
import 'AppState.dart';
import 'AppShell.dart';
import 'BooksState.dart';
import 'BookRoutePath.dart';

// Navigatorあります
// TODO: Controller.Controllerになったから長くなった
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  final _container = ProviderContainer();

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    _container.read(appProvider).addListener((state) {
      notifyListeners();
    });
    _container.read(authorsProvider).addListener((state) {
      notifyListeners();
    });
    _container.read(booksProvider).addListener((state) {
      notifyListeners();
    });
  }

  @override
  BookRoutePath get currentConfiguration {
    final int selectedIndex = _container.read(appProvider.state);
    final authorsController = _container.read(authorsProvider);
    final booksController = _container.read(booksProvider);
    if (selectedIndex == 1) {
      return BooksSettingsPath();
    } else if (selectedIndex == 2) {
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
    final authorsController = _container.read(authorsProvider);
    final booksController = _container.read(booksProvider);
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          // ☆☆☆☆☆☆☆☆☆☆
          child: AppShell(),
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
    final controller = _container.read(appProvider);
    final authorsController = _container.read(authorsProvider);
    final booksController = _container.read(booksProvider);

    if (path is BooksListPath) {
      controller.state = 0;
      booksController.selectedModel = null;
    } else if (path is BooksDetailsPath) {
      // https://gist.github.com/johnpryan/bbca91e23bbb4d39247fa922533be7c9#gistcomment-3511502
      // うまくいった！
      controller.setIndex(0); // This was missing!
      booksController.setSelectedModelById(path.id);
    } else if (path is AuthorsScreenPath) {
      controller.setIndex(2);
      authorsController.selectedModel = null;
    } else if (path is AuthorDetailScreenPath) {
      controller.setIndex(2);
      authorsController.setSelectedModelById(path.id);
    } else if (path is BooksSettingsPath) {
      controller.setIndex(1);
    }
  }
}
