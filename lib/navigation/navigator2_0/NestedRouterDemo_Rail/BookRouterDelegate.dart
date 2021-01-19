import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'AuthorsState.dart';
import 'AppState.dart';
import 'AppShell.dart';
import 'BookRoutePath.dart';
import 'CategoriesState.dart';

// Navigatorあります
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  ProviderContainer container;

  BookRouterDelegate(BuildContext context)
      : navigatorKey = GlobalKey<NavigatorState>() {
    container = ProviderScope.containerOf(context);
    container.read(appProvider).addNotifyListeners(notifyListeners);
    container.read(authorsProvider).addListener((state) {
      notifyListeners();
    });
    container.read(categoriesProvider).addListener((state) {
      notifyListeners();
    });
  }

  @override
  BookRoutePath get currentConfiguration {
    final int selectedIndex = container.read(appProvider.state).index;
    final appController = container.read(appProvider);
    final authorsController = container.read(authorsProvider);
    final categoriesController = container.read(categoriesProvider);
    if (selectedIndex == 1) {
      return BooksSettingsPath();
    } else if (selectedIndex == 2) {
      if (authorsController.selectedModel == null) {
        return AuthorsScreenPath();
      } else {
        return AuthorDetailScreenPath(authorsController.getSelectedModelById());
      }
    } else {
      if (appController.books.selectedModel == null) {
        return BooksListPath();
      } else {
        if (categoriesController.selectedModel != null) {
          var bookId = appController.books.getSelectedModelById();
          return CategoryDetailScreenPath(
              bookId, categoriesController.selectedModel.id);
        }
        return BookDetailPath(appController.books.getSelectedModelById());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = container.read(appProvider);
    final authorsController = container.read(authorsProvider);
    final booksController = controller.books;
    final categoriesController = container.read(categoriesProvider);
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
    final controller = container.read(appProvider);
    final authorsController = container.read(authorsProvider);
    final categoriesController = container.read(categoriesProvider);

    if (path is BooksListPath) {
      controller.setIndex(0);
      controller.books.selectedModel = null;
      categoriesController.selectedModel = null;
    } else if (path is BookDetailPath) {
      // https://gist.github.com/johnpryan/bbca91e23bbb4d39247fa922533be7c9#gistcomment-3511502
      // うまくいった！
      controller.setIndex(0); // This was missing!
      controller.books.setSelectedModelById(path.id);
      // BooksDetail = categories
      categoriesController.selectedModel = null;
    } else if (path is CategoryDetailScreenPath) {
      controller.setIndex(0);
      categoriesController.setSelectedModelById(path.bookId, path.id);
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
