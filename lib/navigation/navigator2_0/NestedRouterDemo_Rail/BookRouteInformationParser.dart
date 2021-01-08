import 'package:flutter/material.dart';

import 'BookRoutePath.dart';

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    // ここってbookだけじゃなくてもっと汎用的に使えると思うけどなー。
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'settings') {
      return BooksSettingsPath();
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'authors') {
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
    if (configuration is BooksSettingsPath) {
      return RouteInformation(location: '/settings');
    }
    if (configuration is AuthorsScreenPath) {
      return RouteInformation(location: '/authors');
    }
    if (configuration is BooksDetailsPath) {
      return RouteInformation(location: '/book/${configuration.id}');
    }
    return null;
  }
}
