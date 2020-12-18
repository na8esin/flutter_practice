import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: App(),
  ));
}

final navKey = GlobalKey<NavigatorState>();

// Navigatorが間にあっても遷移はする
class MyNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        restorationScopeId: 'replyMailNavigator',
        key: navKey,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute<void>(
                builder: (context) => App(),
              );
              break;
            default:
              return MaterialPageRoute<void>(
                builder: (context) => Scaffold(
                  body: Text('error'),
                ),
              );
          }
        });
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext _, VoidCallback openContainer) {
        return const _DetailsPage();
      },
      onClosed: (bool isMarkedAsDone) {
        if (isMarkedAsDone ?? false)
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Marked as done!'),
          ));
      },
      tappable: false,
      closedShape: const RoundedRectangleBorder(),
      closedElevation: 0.0,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return ListTile(
          leading: Image.asset(
            'assets/avatar_logo.png',
            width: 40,
          ),
          onTap: openContainer,
          title: Text('List item 1'),
          subtitle: const Text('Secondary text'),
        );
      },
    );
  }
}

class _DetailsPage extends StatelessWidget {
  const _DetailsPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details page'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () => Navigator.pop(context, true),
            tooltip: 'Mark as done',
          )
        ],
      ),
      body: Text('detail'),
    );
  }
}
