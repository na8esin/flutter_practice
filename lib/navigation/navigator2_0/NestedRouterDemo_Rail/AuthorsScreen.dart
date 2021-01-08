import 'package:flutter/material.dart';
import 'author.dart';

class AuthorsScreen extends StatelessWidget {
  final List<Author> models;
  final ValueChanged<Author> onTapped;

  AuthorsScreen({
    @required this.models,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          for (var model in models)
            ListTile(
              title: Text(model.name),
              subtitle: Text('${model.age}'),
              onTap: () => onTapped(model),
            )
        ],
      ),
    );
  }
}
