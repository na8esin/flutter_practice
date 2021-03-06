import 'package:flutter/material.dart';

import 'detail_screen.dart';
import 'home_screen.dart';
import 'public_future_builder_screen.dart';
import 'public_hook_screen.dart';
import 'stream_builder_public_screen.dart';
import 'stream_hook_collectionGroup_detail_screen.dart';
import 'stream_hook_public_screen.dart';
import 'unknown_screen.dart';

// TODO: いろいろメタメタだから書き換えないと

const publicPath = 'public';
const publicStream = 'public_stream';

class Navigation extends StatelessWidget {
  final String _title;
  Navigation(this._title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'details') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => DetailScreen(id: id));
        }

        if (uri.pathSegments.first == publicPath) {
          return MaterialPageRoute(builder: (context) => PublicScreen());
        }
        if (uri.pathSegments.first == publicStream) {
          return MaterialPageRoute(builder: (context) => StreamPublicScreen());
        }
        if (uri.pathSegments.first == 'public_hook') {
          return MaterialPageRoute(builder: (context) => PublicView());
        }
        if (uri.pathSegments.first ==
            StreamRiverPodPublicScreen().toStringShort()) {
          return MaterialPageRoute(
              builder: (context) => StreamRiverPodPublicScreen());
        }
        if (uri.pathSegments.first == 'detail') {
          return MaterialPageRoute(builder: (context) => StreamDetailsScreen());
        }

        return MaterialPageRoute(builder: (context) => UnknownScreen());
      },
    );
  }
}
