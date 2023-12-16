import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/repository/item_repository.dart';

class ItemProvider extends ChangeNotifier {
  List<ItemDto> _userItems = [];
  List<int> _ownedItemIds = [];

  List<ItemDto> get userItems => _userItems; //소유 아이템 리스트 (id, activation)
  List<int> get ownedItemIds => _ownedItemIds; //소유 아이템 아이디 리스트

  Future<void> fetchUserItems() async {
    try {
      _userItems = await getItemList();

      _ownedItemIds = _userItems.map((item) => item.itemId).toList();

      notifyListeners();
    } catch (e) {
      print('Failed to fetch user items: $e');
    }
  }
}
