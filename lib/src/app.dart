import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';
import 'package:reafy_front/src/pages/book/bookshelf.dart';
import 'package:reafy_front/src/pages/home.dart';
import 'package:reafy_front/src/pages/mypage.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/utils/constants.dart';

class App extends StatelessWidget {
  //final StopwatchProvider stopwatchProvider = StopwatchProvider();

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.put(BottomNavController());

    return Obx(() => Scaffold(
          body: Navigator(
            //key: bottomNavController.navigatorKey,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) {
                  switch (bottomNavController.pageIndex.value) {
                    case 0:
                      return BookShelf(); // Your Library Page
                    case 1:
                      return Home(); // Your Home Page
                    case 2:
                      return MyPage(); // Your My Page
                    default:
                      return Home(); // Default Page
                  }
                },
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomNavController.pageIndex.value,
            onTap: (index) {
              bottomNavController.changeBottomNav(index);
            },
            elevation: 0,
            selectedLabelStyle: TextStyle(fontSize: 12, color: black),
            unselectedLabelStyle: TextStyle(fontSize: 12, color: gray),
            selectedItemColor: black,
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
        ));
  }
}
