import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'AuthorsState.dart';
import 'AppState.dart';
import 'AppShell.dart';
import 'BooksState.dart';
import 'BookRoutePath.dart';
import 'CategoriesState.dart';
import 'InnerRouterDelegate.dart';

// Navigatorあります
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  final _container = ProviderContainer();

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    _container.read(appProvider).addNotifyListeners(notifyListeners);
    _container.read(authorsProvider).addListener((state) {
      notifyListeners();
    });
    _container.read(booksProvider).addListener((state) {
      notifyListeners();
    });
    _container.read(categoriesProvider).addListener((state) {
      notifyListeners();
    });
  }

  @override
  BookRoutePath get currentConfiguration {
    final int selectedIndex = _container.read(appProvider.state);
    final authorsController = _container.read(authorsProvider);
    final booksController = _container.read(booksProvider);
    final categoriesController = _container.read(categoriesProvider);
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
        if (categoriesController.selectedModel != null) {
          var bookId = booksController.getSelectedModelById();
          return CategoryDetailScreenPath(
              bookId, categoriesController.getSelectedModelById(bookId));
        }
        return BooksDetailsPath(booksController.getSelectedModelById());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authorsController = _container.read(authorsProvider);
    final booksController = _container.read(booksProvider);
    final categoriesController = _container.read(categoriesProvider);
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          // ☆☆☆☆☆☆☆☆☆☆
          child: AppShell(InnerRouterDelegate(_container.read(appProvider),
              authorsController, booksController, categoriesController)),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // TODO: ここのソースがどんな意味かわかんね
        if (booksController.selectedModel != null) {
          booksController.selectedModel = null;
        }
        if (authorsController.selectedModel != null) {
          authorsController.selectedModel = null;
        }
        if (categoriesController.selectedModel != null) {
          categoriesController.selectedModel = null;
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
    final categoriesController = _container.read(categoriesProvider);

    if (path is BooksListPath) {
      controller.setIndex(0);
      booksController.selectedModel = null;
      categoriesController.selectedModel = null;
    } else if (path is BooksDetailsPath) {
      // https://gist.github.com/johnpryan/bbca91e23bbb4d39247fa922533be7c9#gistcomment-3511502
      // うまくいった！
      controller.setIndex(0); // This was missing!
      booksController.setSelectedModelById(path.id);
      // BooksDetail = categories
      categoriesController.selectedModel = null;
    } else if (path is AuthorsScreenPath) {
      controller.setIndex(2);
      authorsController.selectedModel = null;
    } else if (path is AuthorDetailScreenPath) {
      controller.setIndex(2);
      authorsController.setSelectedModelById(path.id);
    } else if (path is BooksSettingsPath) {
      controller.setIndex(1);
    } else if (path is CategoryDetailScreenPath) {
      controller.setIndex(0);
      categoriesController.setSelectedModelById(path.bookId, path.id);
    }
  }
}
