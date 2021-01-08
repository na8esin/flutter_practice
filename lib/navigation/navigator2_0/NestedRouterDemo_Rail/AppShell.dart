import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'BooksAppState.dart';
import 'InnerRouterDelegate.dart';
import 'AuthorsState.dart';

// Widget that contains the AdaptiveNavigationScaffold
class AppShell extends StatefulWidget {
  final BooksAppState appState;
  final AuthorsState authorsState;

  // ここの引数渡しもウェーってなる。。。
  AppShell({
    @required this.appState,
    @required this.authorsState,
    // さらに出版社とか追加、publishersState,
  });

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  InnerRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  void initState() {
    super.initState();
    // ここはauthorsState追加しなくていいのか？よさそう。。。
    _routerDelegate = InnerRouterDelegate(widget.appState, widget.authorsState);
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = widget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer back button dispatching to the child router
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    var appState = widget.appState;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();

    return Row(
      children: [
        NavigationRail(
          selectedIndex: appState.selectedIndex,
          onDestinationSelected: (int newIndex) {
            appState.selectedIndex = newIndex;
          },
          labelType: NavigationRailLabelType.selected,
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: Text('BooksListScreen'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.bookmark_border),
              selectedIcon: Icon(Icons.book),
              label: Text('SettingsScreen'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.star_border),
              selectedIcon: Icon(Icons.star),
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
                routerDelegate: _routerDelegate,
                backButtonDispatcher: _backButtonDispatcher,
              ),
            ),
          ),
        )
      ],
    );
  }
}
