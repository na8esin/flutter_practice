import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_practice/navigation/navigator2_0/router_hook/books_app_state_notifier.dart';
import 'package:hooks_riverpod/all.dart';

import 'book.dart';

class BooksListScreen extends HookWidget {
  //final List<Book> books;
  final ValueChanged<Book> onTapped;

  BooksListScreen({
    //@required this.books,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    var booksState = useProvider(booksAppProvider);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var book in booksState.books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            )
        ],
      ),
    );
  }
}
