import 'package:flutter/material.dart';

import 'AppState.dart';
import 'AppShell.dart';
import 'BookRoutePath.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Navigatorあります
// TODO: Controller.Controllerになったから長くなった
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  final _container = ProviderContainer();

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    final controller = _container.read(appProvider);
    controller.addListener((state) {
      notifyListeners();
    });
    controller.authorsController.addListener((state) {
      notifyListeners();
    });
    controller.booksController.addListener((state) {
      notifyListeners();
    });
  }

  @override
  BookRoutePath get currentConfiguration {
    final controller = _container.read(appProvider);
    if (controller.selectedIndex == 1) {
      return BooksSettingsPath();
    } else if (controller.selectedIndex == 2) {
      if (controller.authorsController.selectedModel == null) {
        return AuthorsScreenPath();
      } else {
        return AuthorDetailScreenPath(
            controller.authorsController.getSelectedModelById());
      }
    } else {
      if (controller.booksController.selectedModel == null) {
        return BooksListPath();
      } else {
        return BooksDetailsPath(
            controller.booksController.getSelectedModelById());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _container.read(appProvider);
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          // ☆☆☆☆☆☆☆☆☆☆
          child: AppShell(appController: controller),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (controller.booksController.selectedModel != null) {
          controller.booksController.selectedModel = null;
        }
        // TODO: ここのソースがどんな意味かわかんね
        if (controller.authorsController.selectedModel != null) {
          controller.authorsController.selectedModel = null;
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

    if (path is BooksListPath) {
      controller.selectedIndex = 0;
      controller.booksController.selectedModel = null;
    } else if (path is BooksDetailsPath) {
      // https://gist.github.com/johnpryan/bbca91e23bbb4d39247fa922533be7c9#gistcomment-3511502
      // うまくいった！
      controller.selectedIndex = 0; // This was missing!
      controller.booksController.setSelectedModelById(path.id);
    } else if (path is AuthorsScreenPath) {
      controller.selectedIndex = 2;
      controller.authorsController.selectedModel = null;
    } else if (path is AuthorDetailScreenPath) {
      controller.selectedIndex = 2;
      controller.authorsController.setSelectedModelById(path.id);
    } else if (path is BooksSettingsPath) {
      controller.selectedIndex = 1;
    }
  }
}
