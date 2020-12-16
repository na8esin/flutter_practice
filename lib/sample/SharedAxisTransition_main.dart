import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/*
  https://pub.dev/documentation/animations/latest/animations/SharedAxisTransition-class.html
*/

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyState();
}

class MyState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Color> _colors = [Colors.white, Colors.red, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Transition Example'),
      ),
      body: PageTransitionSwitcher(
        // reverse: true, // uncomment to see transition in reverse
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            child: child,
          );
        },
        child: Container(
            key: ValueKey<int>(_selectedIndex),
            color: _colors[_selectedIndex],
            child: Center(
              child: FlutterLogo(size: 300),
            )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('White'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Red'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Yellow'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
