import 'package:flutter/material.dart';
import 'package:reafy_front/src/repository/coin_repository.dart';

class CoinProvider with ChangeNotifier {
  int _coins = 0;

  int get coins => _coins;

  void setCoins(int newCoins) {
    _coins = newCoins;
    notifyListeners();
  }

  Future<void> updateCoins() async {
    try {
      int fetchedCoins = await getUserCoin();
      setCoins(fetchedCoins);
    } catch (e) {
      print("코인 정보를 가져오는데 실패했습니다: $e");
    }
  }
}
