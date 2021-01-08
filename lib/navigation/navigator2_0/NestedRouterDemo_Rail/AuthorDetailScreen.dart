import 'package:flutter/material.dart';
import 'author.dart';

class AuthorDetailScreen extends StatelessWidget {
  // 一つだけなら、modelって感じで抽象化しとくと他で使うときに修正が少なくなる
  final Author model;

  AuthorDetailScreen({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Back'),
            ),
            if (model != null) ...[
              Text(model.name, style: Theme.of(context).textTheme.headline6),
              Text("${model.age}",
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}
