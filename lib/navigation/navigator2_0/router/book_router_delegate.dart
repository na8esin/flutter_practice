import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'unknown_screen.dart';
import 'book_route_path.dart';
import 'books_list_screen.dart';
import 'book_details_page.dart';
import 'book.dart';
import 'books_app_state.dart';

// StateNotifierに書き換えると
// Missing concrete implementation of 'Listenable.removeListener'.
// ただ、StateNotifierはmixinで使えない
/**
   // removeListener, addListenerが実装できれば ChangeNotifierは
  // なくせる気がする
  @override
  void removeListener(listener) {}
  @override
  void addListener(listener) {}

 */
class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  // これをStateNotifierにしてもStateNotifierProviderが使えないなぁ
  BooksAppState appState = BooksAppState();

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  BookRoutePath get currentConfiguration {
    if (appState.show404) {
      return BookRoutePath.unknown();
    }
    return appState.selectedBook == null
        ? BookRoutePath.home()
        : BookRoutePath.details(appState.books.indexOf(appState.selectedBook));
  }

  // from RouterDelegate
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          // クラス名とかじゃダメなの？
          key: ValueKey('BooksListPage'),
          // ☆☆☆☆☆
          child: BooksListScreen(
            books: appState.books,
            onTapped: _handleBookTapped,
          ),
        ),
        if (appState.show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if (appState.selectedBook != null)
          BookDetailsPage(book: appState.selectedBook)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        appState.selectedBook = null;
        appState.show404 = false;
        notifyListeners();
        return true;
      },
    );
  }

  // ここには、もとからnotifyListeners()はない
  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    if (path.isUnknown) {
      appState.selectedBook = null;
      appState.show404 = true;
      return;
    }

    if (path.isDetailsPage) {
      if (path.id < 0 || path.id > appState.books.length - 1) {
        appState.show404 = true;
        return;
      }

      appState.selectedBook = appState.books[path.id];
    } else {
      appState.selectedBook = null;
    }

    appState.show404 = false;
  }

  void _handleBookTapped(Book book) {
    appState.selectedBook = book;
    notifyListeners();
  }
}
