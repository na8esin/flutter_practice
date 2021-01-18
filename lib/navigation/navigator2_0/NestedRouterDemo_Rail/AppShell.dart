import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'InnerRouterDelegate.dart';
import 'AppState.dart';
import 'MyNavigationRail.dart';

final _backButtonDispatcherProvider =
    StateProvider.family<ChildBackButtonDispatcher, Router>((ref, router) {
  return router.backButtonDispatcher.createChildBackButtonDispatcher();
});

// Widget that contains the AdaptiveNavigationScaffold
class AppShell extends HookWidget {
  AppShell();

  @override
  Widget build(BuildContext context) {
    //final int selectedIndex = routerDelegate.appController.getIndex;
    final _backButtonDispatcher =
        useProvider(_backButtonDispatcherProvider(Router.of(context))).state;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();

    return Row(
      children: [
        MyNavigationRail(),
        VerticalDivider(thickness: 1, width: 1),
        // This is the main content.
        Expanded(
          child: Center(
            child: Scaffold(
              appBar: AppBar(),
              body: Router(
                // ここのDelegateの引数もcontextを追加してよさそうだが、
                // 手間があんまり変わんない
                routerDelegate: InnerRouterDelegate(context),
                backButtonDispatcher: _backButtonDispatcher,
              ),
            ),
          ),
        )
      ],
    );
  }
}
