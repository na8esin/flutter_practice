import 'package:flutter/material.dart';

import 'book.dart';
import 'book_details_screen.dart';

/**
 * TODO: riverpodで書き換える
 * bookとか単位でこの量のソースが必要なの？
 */

// BookRouterDelegateに呼ばれる
class BookDetailsPage extends Page {
  final Book book;

  BookDetailsPage({
    this.book,
  }) : super(key: ValueKey(book));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BookDetailsScreen(book: book);
      },
    );
  }
}
