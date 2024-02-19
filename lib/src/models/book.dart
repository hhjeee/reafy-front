import 'package:reafy_front/src/repository/bookshelf_repository.dart';

class Book {
  final String title;
  final String author;
  final String coverImageUrl;
  final String isbn13;

  Book({
    required this.title,
    required this.author,
    required this.coverImageUrl,
    required this.isbn13,
  });
}

Book convertToBook(SearchBookDto searchBook) {
  return Book(
    title: searchBook.title,
    author: searchBook.author,
    coverImageUrl: searchBook.thumbnailURL,
    isbn13: searchBook.isbn13,
  );
}
