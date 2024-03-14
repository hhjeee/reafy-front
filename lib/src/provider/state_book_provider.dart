import 'package:flutter/material.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';

class BookShelfProvider extends ChangeNotifier {
  List<String> thumbnailsForProgressState1 = [];
  List<String> thumbnailsForProgressState2 = [];
  List<String> thumbnailsForIsFavorite = [];

  Future<void> fetchData() async {
    try {
      thumbnailsForProgressState1 = await fetchBookshelfThumbnailsByState(1);
      thumbnailsForProgressState2 = await fetchBookshelfThumbnailsByState(2);
      thumbnailsForIsFavorite = await fetchBookshelfThumbnailsByFavorite();

      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchFavoriteThumbnailList() async {
    thumbnailsForIsFavorite = await fetchBookshelfThumbnailsByFavorite();
    print('aa');
    print(thumbnailsForIsFavorite);
    notifyListeners();
  }
}
