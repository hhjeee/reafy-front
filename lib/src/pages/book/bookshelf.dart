import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/controller/books_controller.dart';
import 'package:reafy_front/src/pages/book/addbook.dart';
import 'package:reafy_front/src/pages/book/lib_done.dart';
import 'package:reafy_front/src/pages/book/lib_reading.dart';
import 'package:reafy_front/src/pages/book/lib_wishlist.dart';

/// TODO
/// 3개 페이지 만들어서 스와이프로 연결

class BookShelf extends GetView<BookshelfController> {
  const BookShelf({Key? key}) : super(key: key);

  Widget _header() {
    return Padding(
        padding: const EdgeInsets.only(top: 45.0, left: 16.0, right: 16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
              onTap: () {
                Get.to(Addbook()); // '/itemshop' 페이지로 이동
              },
              child: ImageData(IconsPath.item, isSvg: true)),
          GestureDetector(
              onTap: () {
                //Get.to(ItemShop()); // '/itemshop' 페이지로 이동
              },
              child: ImageData(IconsPath.item, isSvg: true)),
        ]));
  }

  Widget _tabMenu() {
    return SliverToBoxAdapter(
      child: TabBar(
        controller: controller.tabController,
        indicatorColor: Colors.black,
        indicatorWeight: 1,
        tabs: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ImageData(
                IconsPath.bookshelf,
                isSvg: false,
              )),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ImageData(
                IconsPath.bookshelf,
                isSvg: false,
              )),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ImageData(
                IconsPath.bookshelf,
                isSvg: false,
              )),
        ],
      ),
    );
  }

  Widget _tabView() {
    return TabBarView(controller: controller.tabController, children: [
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        //shrinkWrap: true,
        itemCount: 100,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 20,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          );
        },
      ),
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 100,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 20,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          );
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              Wishlist(),
              Reading(), //Container(child: Center(child: Text('홈'))),
              Done(),
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
            onTap: controller.changeLibrary,
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

  /*
    return Padding(
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          //child: SingleChildScrollView(
          _header(),
          _tabMenu(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );*/

  /*
    return Scaffold(
      //appBar: AppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            _tabMenu(),
          ];
        },
        body: Container(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              // / Each content from each tab will have a dynamic height
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 100,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 10,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Container(),
              Container()
            ],
          ),
        ),
      ),
    );
  }*/
}
