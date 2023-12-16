import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';
import 'package:reafy_front/src/pages/book/bookshelf.dart';
import 'package:reafy_front/src/pages/home.dart';
import 'package:reafy_front/src/pages/mypage.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/utils/constants.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("This is App");
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              BookShelf(),
              Home(),
              MyPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.pageIndex.value,
            elevation: 0,
            selectedLabelStyle: TextStyle(fontSize: 12, color: black),
            unselectedLabelStyle: TextStyle(fontSize: 12, color: gray),
            selectedItemColor: black,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.bookOff,
                    isSvg: true, width: 44, height: 44),
                activeIcon: ImageData(IconsPath.bookOn,
                    isSvg: true, width: 44, height: 44),
                label: '서재',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.homeOff,
                    isSvg: true, width: 44, height: 44),
                activeIcon: ImageData(IconsPath.homeOn,
                    isSvg: true, width: 44, height: 44),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.mypageOff,
                    isSvg: true, width: 44, height: 44),
                activeIcon: ImageData(IconsPath.mypageOn,
                    isSvg: true, width: 44, height: 44),
                label: '프로필',
              ),
            ],
          ),
        ),
      ),
      onWillPop: controller.willPopAction, // 뒤로가기 눌렀을 때 이벤트 실행되도록
    );
  }
}
