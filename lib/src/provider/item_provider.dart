import 'package:flutter/material.dart';
import 'package:reafy_front/src/repository/item_repository.dart';

class ItemProvider extends ChangeNotifier {
  List<int> _ownedItemIds = [];

  List<int> get ownedItemIds => _ownedItemIds;

  Future<void> fetchUserItems() async {
    try {
      _ownedItemIds = await getOwnedItemIds();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch user items: $e');
    }
  }
}
