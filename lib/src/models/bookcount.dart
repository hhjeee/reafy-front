import 'package:flutter/material.dart';

class BookModel extends ChangeNotifier {
  Set<String> selectedBooks = {};

  void toggleBookSelection(String bookTitle) {
    if (selectedBooks.contains(bookTitle)) {
      selectedBooks.remove(bookTitle);
    } else {
      selectedBooks.add(bookTitle);
    }
    notifyListeners();
  }
}
