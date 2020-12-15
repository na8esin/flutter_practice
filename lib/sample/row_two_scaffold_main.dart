import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: RowTwoScaffold(),
  ));
}

class RowTwoScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // ExpandedがないとScaffoldを2つ並べられない
      Expanded(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Navigation menu',
              onPressed: null,
            ),
            title: Text('Example title'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                tooltip: 'Search',
                onPressed: null,
              ),
            ],
          ),
          // body is the majority of the screen.
          body: Center(
            child: Text('Hello, world!'),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add', // used by assistive technologies
            child: Icon(Icons.add),
            onPressed: null,
          ),
        ),
      ),
      Expanded(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Navigation menu',
              onPressed: null,
            ),
            title: Text('Example title'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                tooltip: 'Search',
                onPressed: null,
              ),
            ],
          ),
          // body is the majority of the screen.
          body: Center(
            child: Text('Hello, world!'),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add', // used by assistive technologies
            child: Icon(Icons.add),
            onPressed: null,
          ),
        ),
      ),
    ]);
  }
}
