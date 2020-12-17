/// Flutter code sample for RestorationMixin

// This example demonstrates how to make a simple counter app restorable by
// using the [RestorationMixin] and a [RestorableInt].

import 'package:flutter/material.dart';

void main() => runApp(RestorationExampleApp());

class RestorationExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The [RootRestorationScope] can be removed once it is part of [MaterialApp].
    return RootRestorationScope(
      restorationId: 'root',
      child: MaterialApp(
        title: 'Restorable Counter',
        home: RestorableCounter(restorationId: 'counter'),
      ),
    );
  }
}

class RestorableCounter extends StatefulWidget {
  RestorableCounter({Key key, this.restorationId}) : super(key: key);

  final String restorationId;

  @override
  _RestorableCounterState createState() => _RestorableCounterState();
}

// The [State] object uses the [RestorationMixin] to make the current value
// of the counter restorable.
class _RestorableCounterState extends State<RestorableCounter>
    with RestorationMixin {
  // The current value of the counter is stored in a [RestorableProperty].
  // During state restoration it is automatically restored to its old value.
  // If no restoration data is available to restore the counter from, it is
  // initialized to the specified default value of zero.
  RestorableInt _counter = RestorableInt(0);

  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    // All restorable properties must be registered with the mixin. After
    // registration, the counter either has its old value restored or is
    // initialized to its default value.
    registerForRestoration(_counter, 'count');
  }

  void _incrementCounter() {
    setState(() {
      // The current value of the property can be accessed and modified via
      // the value getter and setter.
      _counter.value++;
    });
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restorable Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_counter.value}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
