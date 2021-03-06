import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../model/book.dart';
import '../model/category.dart';
import '../CategoriesState.dart';

class BookDetailScreen extends HookWidget {
  final Book book;
  final ValueChanged<Category> onTapped;

  BookDetailScreen({
    @required this.book,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookDetailScreen'),
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
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 20),
              Text('categories', style: Theme.of(context).textTheme.headline6),
              ...useProvider(categoriesStreamProvider(book.id)).when(
                  data: (data) {
                    return data
                        .map((category) => ListTile(
                              title: Text(category.name),
                              onTap: () => onTapped(category),
                            ))
                        .toList();
                  },
                  loading: () => [ListTile(title: Text('loading'))],
                  error: (o, s) => [ListTile(title: Text('error'))])
            ],
          ],
        ),
      ),
    );
  }
}
