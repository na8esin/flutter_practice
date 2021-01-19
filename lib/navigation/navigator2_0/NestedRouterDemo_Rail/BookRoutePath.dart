// Path
// ここが本当はconfigurationだとしても、羅列すると
// 鬱陶しすぎる
// enumを使うやり方もあるけど、呼び出すときにゴチャっとする
abstract class BookRoutePath {}

class BooksListPath extends BookRoutePath {}

class BooksSettingsPath extends BookRoutePath {}

class BookDetailPath extends BookRoutePath {
  final int id;
  BookDetailPath(this.id);
}

class AuthorsScreenPath extends BookRoutePath {}

class AuthorDetailScreenPath extends BookRoutePath {
  final int id;
  AuthorDetailScreenPath(this.id);
}

class CategoryDetailScreenPath extends BookRoutePath {
  final int bookId;
  final int id;
  CategoryDetailScreenPath(this.bookId, this.id);
}
