import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'BookRouterDelegate.dart';
import 'BookRouteInformationParser.dart';

//final _routerDelegateProvider = StateProvider((ref) => BookRouterDelegate());
final _routeInformationParserProvider =
    StateProvider((ref) => BookRouteInformationParser());

class NestedRouterDemo extends HookWidget {
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
