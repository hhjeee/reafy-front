import 'dart:async';
import 'package:flutter/material.dart';

class BambooProvider extends ChangeNotifier {
  List<bool> giftVisibility = List.generate(6, (_) => false);

  void collectGift(int index) {
    giftVisibility[index] = false;
    notifyListeners();
  }

  void showNewGift() {
    for (int i = 0; i < giftVisibility.length; i++) {
      if (!giftVisibility[i]) {
        giftVisibility[i] = true;
        break;
      }
    }
    notifyListeners();
  }
}
