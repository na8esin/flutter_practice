import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'AppState.dart';

class MyNavigationRail extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final int selectedIndex = useProvider(appProvider).getIndex;
    final controller = useProvider(appProvider);
    return NavigationRail(
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
    );
  }
}
