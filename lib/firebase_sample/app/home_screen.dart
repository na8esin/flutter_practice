import 'package:flutter/material.dart';
import 'navigation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: new ListView(children: [
        FlatButton(
          child: Text('View Details'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/details/1',
            );
          },
        ),
        FlatButton(
          child: Text('View publics'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/${publicPath}',
            );
          },
        ),
        FlatButton(
          child: Text('View publics stream'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/${publicStream}',
            );
          },
        ),
        FlatButton(
          child: Text('View publics_hook future'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/public_hook',
            );
          },
        ),
        FlatButton(
          child: Text('detail'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/detail',
            );
          },
        ),
      ])),
    );
  }
}
