import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../model/book.dart';
import '../CategoriesState.dart';

class BookDetailScreen extends HookWidget {
  final Book book;

  BookDetailScreen({
    @required this.book,
  });

  @override
  Widget build(BuildContext context) {
    var categoriesController = useProvider(categoriesProvider);
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
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 20),
              Text('categories', style: Theme.of(context).textTheme.headline6),
              for (var category
                  in categoriesController.getModelsByBookId(book.id))
                ListTile(
                  title: Text(category.name),
                )
            ],
          ],
        ),
      ),
    );
  }
}
