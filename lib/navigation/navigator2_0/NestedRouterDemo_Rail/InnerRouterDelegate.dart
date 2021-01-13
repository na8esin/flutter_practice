import 'package:flutter/material.dart';

import 'model/author.dart';
import 'model/book.dart';
import 'model/category.dart';
import 'page/FadeAnimationPage.dart';
import 'screen/BooksListScreen.dart';
import 'screen/BookDetailScreen.dart';
import 'screen/AuthorDetailScreen.dart';
import 'screen/AuthorsScreen.dart';
import 'screen/CategoryDetailScreen.dart';

import 'AppState.dart';
import 'AuthorsState.dart';
import 'BookRoutePath.dart';
import 'BooksState.dart';
import 'CategoriesState.dart';
import 'settings_screen.dart';

// Navigatorあります
// currentConfigurationがないね
class InnerRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  @override // from PopNavigatorRouterDelegateMixin
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  InnerRouterDelegate(this.appController, this.authorsController,
      this.booksController, this.categoriesController) {}
  AppController appController;
  BooksController booksController;
  AuthorsController authorsController;
  CategoriesController categoriesController;

  // RouterDelegateのbuildはNavigatorを返すだけ
  @override
  Widget build(BuildContext context) {
    final selectedIndex = appController.getIndex;
    return Navigator(
      key: navigatorKey,
      pages: [
        if (selectedIndex == 0) ...[
          FadeAnimationPage(
            child: BooksListScreen(
                books: booksController.models,
                onTapped: (Book book) {
                  booksController.selectedModel = book;
                }),
            key: ValueKey('BooksListPage'),
          ),
          if (booksController.selectedModel != null &&
              categoriesController.selectedModel != null) ...[
            // bookもcategoryも選択されているときは、categoryの詳細画面へ
            MaterialPage(
              key: ValueKey(categoriesController.selectedModel),
              child: CategoryDetailScreen(
                model: categoriesController.selectedModel,
              ),
            ),
          ] else if (booksController.selectedModel != null) ...[
            MaterialPage(
              key: ValueKey(booksController.selectedModel),
              child: BookDetailScreen(
                book: booksController.selectedModel,
                onTapped: (Category model) {
                  categoriesController.selectedModel = model;
                },
              ),
            ),
          ]
        ] else if (selectedIndex == 1) ...[
          FadeAnimationPage(
            child: SettingsScreen(),
            key: ValueKey('SettingsPage'),
          ),
        ] else if (selectedIndex == 2) ...[
          FadeAnimationPage(
            child: AuthorsScreen(
              models: authorsController.models,
              onTapped: (Author model) {
                authorsController.selectedModel = model;
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
        categoriesController.selectedModel = null;
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
