import 'package:flutter/material.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';

class SelectedBooksProvider with ChangeNotifier {
  List<BookshelfBookInfo> _selectedBooks = [];

  List<BookshelfBookInfo> get selectedBooks => _selectedBooks;

  void addBook(BookshelfBookInfo book) {
    _selectedBooks.add(book);
    notifyListeners();
  }

  void removeBook(BookshelfBookInfo book) {
    _selectedBooks.remove(book);
    notifyListeners();
  }

  void clearBooks() {
    _selectedBooks.clear();
    notifyListeners();
  }
}
