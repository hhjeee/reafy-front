import 'package:flutter/material.dart';
//import 'package:reafy_front/src/controller/auth_controller.dart';
//import 'package:reafy_front/src/models/instagram_user.dart';
import 'package:get/get.dart';

enum PageName { WISH, READING, DONE }

class BookshelfController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  RxInt pageIndex = 1.obs;

  //Rx<IUser> targetUser = IUser().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    //_loadData();
  }
/*
  void setTargetUser() {
    var uid = "1"; // 임시
    //var uid = Get.parameters['targetUid'];

    if (uid == null) {
      //targetUser(AuthController.to.user.value);
    } else {
      //TODO 상대 uid 로 users collection 조회
    }
  }

  void _loadData() {
    setTargetUser();
    // 포스트 리스트 로드
    // 사용자 정보 로드
  }
*/

  void changeLibrary(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.WISH:
      case PageName.READING:
      case PageName.DONE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
  }

  Future<bool> willPopAction() async {
    return true;
  }
}

/*
class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();

  RxInt pageIndex = 1.obs;
  //TabController? tabController;

  GlobalKey<NavigatorState> searchPageNaviationKey =
      GlobalKey<NavigatorState>();

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.WISH:
      case PageName.READING:
      case PageName.DONE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
  }

  Future<bool> willPopAction() async {
    return true;
  }
}
*/