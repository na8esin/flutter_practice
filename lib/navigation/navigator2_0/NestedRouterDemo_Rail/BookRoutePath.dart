// Path
// enumを使うやり方もあるけど、呼び出すときにゴチャっとする
abstract class BookRoutePath {}

class BooksListPath extends BookRoutePath {}

class BooksSettingsPath extends BookRoutePath {}

class BooksDetailsPath extends BookRoutePath {
  final int id;
  BooksDetailsPath(this.id);
}

class AuthorsScreenPath extends BookRoutePath {}

class AuthorDetailScreenPath extends BookRoutePath {
  final int id;
  AuthorDetailScreenPath(this.id);
}
