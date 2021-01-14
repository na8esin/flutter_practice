import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_practice/navigation/navigator2_0/NestedRouterDemo_Rail/AppState.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'InnerRouterDelegate.dart';

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
    final int selectedIndex = useProvider(appProvider).getIndex;
    final controller = useProvider(appProvider);
    final _backButtonDispatcher =
        useProvider(_backButtonDispatcherProvider(Router.of(context))).state;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();

    return Row(
      children: [
        // 分離はできるけど、controllerは引数渡しになる
        NavigationRail(
          selectedIndex: selectedIndex,
          // TODO: 押したところのモデルはnullにした方がいいのか？
          onDestinationSelected: controller.onDestinationSelected,
          labelType: NavigationRailLabelType.selected,
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: Text('Books'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book_outlined),
              selectedIcon: Icon(Icons.book),
              label: Text('Settings'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: Text('Authors'),
            ),
          ],
        ),
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
