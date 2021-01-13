import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../model/category.dart';

class CategoryDetailScreen extends HookWidget {
  final Category model;

  CategoryDetailScreen({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
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
            ],
          ],
        ),
      ),
    );
  }
}
