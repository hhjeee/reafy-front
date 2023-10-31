import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';
import 'package:reafy_front/src/pages/book/bookshelf.dart';
import 'package:reafy_front/src/pages/home.dart';
import 'package:reafy_front/src/pages/mypage.dart';
import 'package:get/get.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              BookShelf(),
              Home(), //Container(child: Center(child: Text('홈'))),
              MyPage(),
              //IntroPage()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.pageIndex.value,
            elevation: 0,
            selectedLabelStyle: TextStyle(
                fontSize: 12, height: 2 // 선택된 페이지 라벨의 색상을 검정색(#000000)으로 지정
                ),
            unselectedLabelStyle: TextStyle(
                fontSize: 12, height: 2 // 선택된 페이지 라벨의 색상을 검정색(#000000)으로 지정
                ),
            selectedItemColor: Color(0xff808080),
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.bookOff, isSvg: true),
                activeIcon: ImageData(IconsPath.bookOn, isSvg: true),
                label: '서재',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.homeOff, isSvg: true),
                activeIcon: ImageData(IconsPath.homeOn, isSvg: true),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.mypageOff, isSvg: true),
                activeIcon: ImageData(IconsPath.mypageOn, isSvg: true),
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
