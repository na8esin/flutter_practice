import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'book_route_information_parser.dart';
import 'book_router_delegate.dart';

final _routerDelegateProvider = StateProvider((ref) => BookRouterDelegate());
final _routeInformationParserProvider =
    StateProvider((ref) => BookRouteInformationParser());

class BooksApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: useProvider(_routerDelegateProvider).state,
      routeInformationParser:
          useProvider(_routeInformationParserProvider).state,
    );
  }
}
