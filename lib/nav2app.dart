import 'package:flutter/material.dart';
import 'package:flutter_practice/public_screen.dart';
import 'package:flutter_practice/stream_public_screen.dart';

class Nav2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'details') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => DetailScreen(id: id));
        }

        if (uri.pathSegments.first == 'public') {
          return MaterialPageRoute(builder: (context) => PublicScreen());
        }
        if (uri.pathSegments.first == 'public_stream') {
          return MaterialPageRoute(builder: (context) => StreamPublicScreen());
        }

        return MaterialPageRoute(builder: (context) => UnknownScreen());
      },
    );
  }
}

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
              '/public',
            );
          },
        ),
        FlatButton(
          child: Text('View publics stream'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/public_stream',
            );
          },
        ),
      ])),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String id;

  DetailScreen({
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Viewing details for item $id'),
            FlatButton(
              child: Text('Pop!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
