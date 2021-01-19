import 'package:flutter/material.dart';

import 'BookRoutePath.dart';

// クラス名が悪いBookStoreとかBookLibraryにしないと
class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    //print(uri.pathSegments);

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'settings') {
      return BooksSettingsPath();
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'authors') {
      if (uri.pathSegments.length >= 2) {
        return AuthorDetailScreenPath(int.tryParse(uri.pathSegments[1]));
      }
      return AuthorsScreenPath();
    } else {
      if (uri.pathSegments.length >= 2) {
        if (uri.pathSegments[0] == 'books' &&
            uri.pathSegments.length >= 4 &&
            uri.pathSegments[2] == 'categories') {
          return CategoryDetailScreenPath(int.tryParse(uri.pathSegments[1]),
              int.tryParse(uri.pathSegments[3]));
        }
        if (uri.pathSegments[0] == 'books') {
          return BookDetailPath(int.tryParse(uri.pathSegments[1]));
        }
      }
      return BooksListPath();
    }
  }

  @override
  RouteInformation restoreRouteInformation(BookRoutePath configuration) {
    if (configuration is BooksListPath) {
      return RouteInformation(location: '/books');
    }
    if (configuration is BookDetailPath) {
      return RouteInformation(location: '/books/${configuration.id}');
    }
    if (configuration is AuthorsScreenPath) {
      return RouteInformation(location: '/authors');
    }
    if (configuration is AuthorDetailScreenPath) {
      return RouteInformation(location: '/authors/${configuration.id}');
    }
    if (configuration is BooksSettingsPath) {
      return RouteInformation(location: '/settings');
    }
    if (configuration is CategoryDetailScreenPath) {
      return RouteInformation(
          location:
              '/books/${configuration.bookId}/categories/${configuration.id}');
    }
    return null;
  }
}
