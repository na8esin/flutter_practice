import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'book.dart';

class BooksStatus {
  BooksStatus({
    this.selectedBook,
    this.show404,
  });
  final Book selectedBook;
  final bool show404;

  final List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];
}

class BooksAppStateNotifier extends StateNotifier<BooksStatus> {
  BooksAppStateNotifier(state) : super(state);

  bool get show404 => state.show404;
  set show404(bool isShow) {
    state = BooksStatus(
      selectedBook: state.selectedBook,
      show404: isShow,
    );
  }

  Book get selectedBook => state.selectedBook;

  set selectedBook(Book book) {
    state = BooksStatus(
      selectedBook: book,
      show404: state.show404,
    );
  }

  int getSelectedBookById() {
    if (!state.books.contains(state.selectedBook)) return 0;
    return state.books.indexOf(state.selectedBook);
  }

  void setSelectedBookById(int id) {
    if (id < 0 || id > state.books.length - 1) {
      return;
    }
    state = BooksStatus(
      selectedBook: state.books[id],
      show404: state.show404,
    );
  }

  List<Book> get books => state.books;
}
