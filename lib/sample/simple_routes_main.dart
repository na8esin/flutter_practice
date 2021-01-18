import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Route'),
          ),
        );
      },
      '/about': (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('About Route'),
          ),
        );
      },
      '/no_sca': (BuildContext context) {
        return Text('こんにちは');
      },
    },
  ));
}
