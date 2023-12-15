import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PageName { LIBRARY, HOME, MYPAGE }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();
  RxInt pageIndex = 1.obs;
  //TabController? tabController;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  //lobalKey<NavigatorState> searchPageNaviationKey =
  //    GlobalKey<NavigatorState>();
  List<int> bottomHistory = [1];
  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.LIBRARY:
      case PageName.HOME:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
  }

  Future<bool> willPopAction() async {
    var page = PageName.values[bottomHistory.last];
    if (page == PageName.HOME) {
      print("exit");
      return true;
    } else {
      changeBottomNav(1, hasGesture: false); // Home 이 아니라면 홈으로 이동
      return false;
    }
  }
}
