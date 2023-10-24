import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/pages/itemshop.dart';
import 'package:reafy_front/src/components/stopwatch.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget _header() {
    return Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 16.0, right: 16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
            onTap: () {
              // TO DO : 30분마다 코인 얼마 준다는 내용 팝업
            },
            child: Row(
              children: [
                ImageData(IconsPath.coin, isSvg: true),
                SizedBox(width: 8), // 코인 아이콘과 텍스트 사이의 간격 조절
                Text(
                  '45',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Get.to(ItemShopPage()); // '/itemshop' 페이지로 이동
              },
              child: ImageData(IconsPath.item, isSvg: true)),
        ]));
  }

  Widget _character() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
            height: 326,
            decoration: BoxDecoration(color: Color(0xffd9d9d9)),
            child: Text("") //ImageData(IconsPath.character),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header(),
            const SizedBox(height: 29),
            StopWatch(
              ////// TO DO 스탑워치 고치기
              value: false,
              onChanged: (bool newValue) {},
            ),
            const SizedBox(height: 106),
            _character()
          ],
        ),
      ),
    );
  }
}

/*
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 투명한 배경색
        elevation: 0, // 앱바 그림자 제거
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // TO DO : 30분마다 코인 얼마 준다는 내용 팝업으로 띄우
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ImageData(IconsPath.coin, width: 30)),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(ItemShopPage()); // '/itemshop' 페이지로 이동
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ImageData(IconsPath.item, width: 30)),
              ),
            ],
          ),
        ],
      ),

      */

/*bottomNavigationBar: SizedBox(
        height: 70,
        //padding: EdgeInsets.only(bottom: 5, top: 5),
        child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: primaryColor,
            labelColor: primaryColor,
            unselectedLabelColor: gray,
            labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            tabs: [
              Tab(
                icon: _selectedIndex == 0 ? icon: ImageData(IconsPath.bookOff) : Icons.person_2_outlined, 
                text: '서재',
              ),
              Tab(
                icon: Container(
                    height: 28,
                    child:
                        SvgPicture.asset('assets/svg/home_y.svg', height: 26)),
                text: '홈',
              ),
              Tab(
                icon: Container(
                    height: 28,
                    child: SvgPicture.asset('assets/svg/profile_g.svg',
                        height: 26)),
                text: '프로필',
              )
            ]),
      ),
  ///////////////////////
        Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: BottomNavigationBar(
              elevation: 8, // 그림자의 깊이를 지정

              items: [
                BottomNavigationBarItem(
                  icon: Container(
                      height: 28,
                      child: SvgPicture.asset('assets/svg/shelf_g.svg',
                          height: 26)),
                  label: '서재',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      height: 28,
                      child: SvgPicture.asset('assets/svg/home_y.svg',
                          height: 26)),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      height: 28,
                      child: SvgPicture.asset('assets/svg/profile_g.svg',
                          height: 26)),
                  label: '프로필',
                ),
              ],
            )));*/
