/// Flutter code sample for NavigationRail

// This example shows a [NavigationRail] used within a Scaffold with 3
// [NavigationRailDestination]s. The main content is separated by a divider
// (although elevation on the navigation rail can be used instead). The
// `_selectedIndex` is updated by the `onDestinationSelected` callback.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// This is the main application widget.
class MyApp extends HookWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample',
      home: MyHome(),
    );
  }
}

// Controllerとも言う
class StateSelectedStateNotifier extends StateNotifier<int> {
  StateSelectedStateNotifier() : super(0);

  // こんなセッターを定義すればうまくいくけど、
  // なんかダサい
  setIndex(int index) {
    state = index;
  }

  // こういうのを定義するとControllerって呼びたい気持ちがわかる
  onDestinationSelected(int index) {
    state = index;
  }
}

final stateSelectedProvider =
    StateNotifierProvider((ref) => StateSelectedStateNotifier());

/// This is the stateful widget that the main application instantiates.
class MyHome extends HookWidget {
  MyHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = useProvider(stateSelectedProvider.state);
    var contora = useProvider(stateSelectedProvider);
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: useProvider(stateSelectedProvider.state),
            onDestinationSelected: contora.onDestinationSelected,
            // これだと、NavigationRailDestinationのアイコンが切り替わらない
            // ただ、FABの方は反映されている
            // onDestinationSelected: (int index) => _selectedIndex = index
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('First'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('Second'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.star_border),
                selectedIcon: Icon(Icons.star),
                label: Text('Third'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Scaffold(
              body: Center(
                // ここ、変わらない -> 変わった
                child: Text('${_selectedIndex}'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  var text = '';
                  if (_selectedIndex == 0) {
                    text = 'First';
                  }
                  if (_selectedIndex == 1) {
                    text = 'Second';
                  }
                  if (_selectedIndex == 2) {
                    text = 'Third';
                  }

                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            // 変わる
                            title: Text(text),
                            children: <Widget>[Text('inbox')],
                          ));
                  return;
                },
                child: const Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}
