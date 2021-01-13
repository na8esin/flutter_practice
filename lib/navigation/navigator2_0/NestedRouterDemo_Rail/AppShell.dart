import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'AppState.dart';
import 'AuthorsState.dart';
import 'BooksState.dart';
import 'InnerRouterDelegate.dart';

/*
final _routerDelegateProvider = StateProvider<InnerRouterDelegate>((ref) {
  int index = ref.watch(appProvider.state);
  AuthorsController authorsController = ref.watch(authorsProvider);
  BooksController booksController = ref.watch(booksProvider);
  return InnerRouterDelegate(index, authorsController, booksController);
});
*/

final _backButtonDispatcherProvider =
    StateProvider.family<ChildBackButtonDispatcher, Router>((ref, router) {
  return router.backButtonDispatcher.createChildBackButtonDispatcher();
});

/*
  ここのHookWidget化は難しそう
  AppShellはBookRouterDelegateから呼ばれるので、
*/
// Widget that contains the AdaptiveNavigationScaffold
class AppShell extends HookWidget {
  AppShell(this.routerDelegate);
  final InnerRouterDelegate routerDelegate;

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = routerDelegate.appController.getIndex;
    final controller = routerDelegate.appController;
    final _backButtonDispatcher =
        useProvider(_backButtonDispatcherProvider(Router.of(context))).state;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();

    return Row(
      children: [
        NavigationRail(
          selectedIndex: selectedIndex,
          onDestinationSelected: controller.onDestinationSelected,
          labelType: NavigationRailLabelType.selected,
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: Text('BooksListScreen'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book_outlined),
              selectedIcon: Icon(Icons.book),
              label: Text('SettingsScreen'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: Text('AuthorsScreen'),
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
                routerDelegate: routerDelegate,
                backButtonDispatcher: _backButtonDispatcher,
              ),
            ),
          ),
        )
      ],
    );
  }
}
