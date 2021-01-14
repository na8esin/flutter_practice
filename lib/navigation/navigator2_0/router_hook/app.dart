import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'book_route_information_parser.dart';
import 'book_router_delegate.dart';

final _routerDelegateProvider =
    StateProvider.family((ref, BuildContext context) {
  BookRouterDelegate(context);
});
final _routeInformationParserProvider =
    StateProvider((ref) => BookRouteInformationParser());

class BooksApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: BookRouterDelegate(context),
      routeInformationParser:
          useProvider(_routeInformationParserProvider).state,
    );
  }
}
