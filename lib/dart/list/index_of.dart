void main() {
  Book selectedBook = books[1];
  print(books.indexOf(selectedBook));
}

final List<Book> books = [
  Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
  Book('Foundation', 'Isaac Asimov'),
  Book('Fahrenheit 451', 'Ray Bradbury'),
];

class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}
