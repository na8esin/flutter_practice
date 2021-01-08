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
        if (uri.pathSegments[0] == 'book') {
          return BooksDetailsPath(int.tryParse(uri.pathSegments[1]));
        }
      }
      return BooksListPath();
    }
  }

  @override
  RouteInformation restoreRouteInformation(BookRoutePath configuration) {
    if (configuration is BooksListPath) {
      return RouteInformation(location: '/home');
    }
    if (configuration is BooksDetailsPath) {
      return RouteInformation(location: '/book/${configuration.id}');
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
    return null;
  }
}
