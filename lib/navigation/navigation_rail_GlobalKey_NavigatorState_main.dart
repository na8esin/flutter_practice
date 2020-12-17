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
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends HookWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> _selectedIndex = useState(0);
    final navKey = GlobalObjectKey<NavigatorState>(context);
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex.value,
            onDestinationSelected: (int index) {
              _selectedIndex.value = index;
              switch (index) {
                case 0:
                  navKey.currentState.pushNamed(MailNavigator.inboxRoute);
                  break;
                case 1:
                  navKey.currentState.pushNamed(MailNavigator.composeRoute);
                  break;
                default:
                  navKey.currentState.pushNamed(MailNavigator.thirdRoute);
              }
            },
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
            child: Center(
              //child: Text('selectedIndex: ${_selectedIndex.value}'),
              // 引数で渡してもOK
              child: MailNavigator(navKey),
            ),
          )
        ],
      ),
    );
  }
}

class MailNavigator extends StatelessWidget {
  const MailNavigator(this.navKey);
  final navKey;

  static const inboxRoute = '/inbox';
  static const composeRoute = '/compose';
  static const thirdRoute = '/third';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      restorationScopeId: 'replyMailNavigator',
      // keyをコメントアウトするとアイコンを押すたびに↓が発生する
      // NoSuchMethodError: invalid member on null: 'pushNamed'
      key: navKey,
      initialRoute: inboxRoute,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case inboxRoute:
            return createInboxRoute(settings);
            break;
          case composeRoute:
            return createComposeRoute(settings);
            break;
          case thirdRoute:
            return createThirdRoute(settings);
            break;
        }
        return null;
      },
    );
  }

  static Route createInboxRoute(RouteSettings settings) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => const Scaffold(
        body: Text('inbox'),
      ),
      settings: settings,
    );
  }

  static Route createComposeRoute(RouteSettings settings) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => const Scaffold(
        body: Text('Compose'),
      ),
      settings: settings,
    );
  }

  static Route createThirdRoute(RouteSettings settings) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => const Scaffold(
        body: Text('Third'),
      ),
      settings: settings,
    );
  }
}
