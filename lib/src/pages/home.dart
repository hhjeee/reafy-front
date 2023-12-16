import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/stop_dialog.dart';
import 'package:reafy_front/src/pages/board/board.dart';
import 'package:reafy_front/src/pages/itemshop.dart';
import 'package:reafy_front/src/components/stopwatch.dart';
import 'package:reafy_front/src/pages/map.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:reafy_front/src/components/poobao_home.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/provider/item_placement_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    StopwatchProvider stopwatch = Provider.of<StopwatchProvider>(context);

    final size = MediaQuery.of(context).size;
    Widget _memo() {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
            onTap: () {
              Get.to(() => Board());
            },
            child: Stack(children: [
              ImageData(
                IconsPath.home_bubble,
                width: 170,
                height: 130,
              ),
              Transform.scale(
                scale: 1.0, // Adjust scale factor as needed
                child: Lottie.asset('assets/lottie/loadingdot.json',
                    width: 170, height: 130),
              )
            ]))
      ]);
    }

    Widget _stopbutton() {
      return Center(
          child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StopDialog();
                  },
                );
              },
              child: Container(
                  width: 338,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: yellow,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10.0,
                        color: Color.fromRGBO(0, 0, 0, 0.10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "이제 그만 읽을래요",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: black,
                      ),
                    ),
                  ))));
    }

    Widget _time() {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 166,
              height: 60,
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color(0xfffaf9f7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ImageData(IconsPath.today,
                      isSvg: true, width: 44, height: 44),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "28분 16초",
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 6),
            Container(
              width: 166,
              height: 60,
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color(0xfffaf9f7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ImageData(IconsPath.total,
                      isSvg: true, width: 44, height: 44),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "37시간 20분",
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffaf9f7),
        elevation: 0,
        leadingWidth: 90,
        toolbarHeight: 44,
        leading: Container(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageData(IconsPath.bamboo, isSvg: true, width: 44, height: 44),
                Text(
                  '25',
                  style: TextStyle(
                    fontSize: 16,
                    color: green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )),
        actions: [
          IconButton(
            iconSize: 44,
            padding: EdgeInsets.only(right: 0),
            icon: ImageData(IconsPath.map_icon, isSvg: true),
            onPressed: () {
              Get.to(() => BambooMap());
            },
          ),
          IconButton(
            padding: EdgeInsets.only(right: 16),
            iconSize: 44,
            icon: ImageData(IconsPath.item, isSvg: true),
            onPressed: () {
              Get.to(() => ItemShop());
            },
          ),
        ],
      ),
      body: Container(
        width: size.width,
        decoration: BoxDecoration(color: Color(0xfffff9c1)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFAF9F7),
                Color.fromRGBO(250, 249, 247, 0.0),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              _memo(),
              Consumer<ItemPlacementProvider>(
                  builder: (context, itemPlacementProvider, child) {
                return Container(
                    width: size.width,
                    height: 332,
                    child: Stack(
                      children: [
                        //// Rug
                        Positioned(
                          top: 276,
                          left: 104,
                          child: Container(
                            width: 186,
                            height: 36,
                            child: ImageData(itemPlacementProvider.rugImagePath,
                                width: 186, height: 36),
                          ),
                        ),
                        //// Character
                        Positioned(
                          top: 64,
                          left: 102,
                          child: Container(
                            width: 186,
                            height: 248,
                            //color: yellow,
                            child: ImageData(IconsPath.character),
                          ),
                        ),
                        //// BookShelf
                        Positioned(
                          top: 28,
                          left: 13,
                          child: Container(
                              width: 110,
                              height: 230,
                              child: ImageData(
                                  itemPlacementProvider.bookshelfImagePath,
                                  width: 110,
                                  height: 230)),
                        ),
                        //// Clock
                        Positioned(
                          left: 165,
                          top: 0,
                          child: Container(
                              width: 64,
                              height: 64,
                              child: ImageData(
                                  itemPlacementProvider.clockImagePath,
                                  width: 64,
                                  height: 64)),
                        ),
                        //// Window
                        Positioned(
                          top: 34,
                          right: 13,
                          child: Container(
                            width: 100,
                            height: 100,
                            child: ImageData(
                              itemPlacementProvider.windowImagePath,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        //// Others
                        Positioned(
                          right: 23,
                          top: 148,
                          child: Container(
                            width: 90,
                            height: 110,
                            child: ImageData(
                                itemPlacementProvider.othersImagePath,
                                width: 90,
                                height: 110),
                          ),
                        ),
                      ],
                    ));
              }),

              /*Consumer<StopwatchProvider>(
                builder: (context, stopwatch, child) {
                  return Column(
                    children: [
                      stopwatch.isRunning ? const SizedBox() : _time(),
                      stopwatch.isRunning
                          ? const SizedBox()
                          : const SizedBox(height: 15),
                      Center(child: StopwatchWidget()),
                      stopwatch.isRunning
                          ? const SizedBox(height: 15)
                          : const SizedBox(),
                      stopwatch.isRunning ? _stopbutton() : const SizedBox(),
                    ],
                  );
                },
              ),*/
              //Spacer(),
              Container(
                  height: 140,
                  child: Column(
                    children: [
                      stopwatch.isRunning ? const SizedBox() : _time(),
                      stopwatch.isRunning
                          ? const SizedBox()
                          : const SizedBox(height: 15),
                      Center(child: StopwatchWidget()),
                      //_buildAnimatedWatch(stopwatch.isRunning)),
                      stopwatch.isRunning
                          ? const SizedBox(height: 15)
                          : const SizedBox(),
                      stopwatch.isRunning ? _stopbutton() : const SizedBox()
                      //_buildAnimatedStopButton(!stopwatch.isRunning)
                    ],
                  )),

              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

/*
Widget _title_text() {
  return Container(
    padding: EdgeInsets.only(top: 20, left: 26),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 20.0),
      Text(
        "반가워요!\n오늘도 같이 책읽을까요? ",
        style: TextStyle(
          fontSize: 22,
          height: 1.36364,
          color: Color(0xff333333),
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(height: 12.0),
      GestureDetector(
        onTap: () {
          Get.to(Board());
        },
        child: Text(
          "메모보드 자리 클릭!",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xff666666),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ]),
  );
}

/*
void Map(context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      builder: (BuildContext bc) {
        return Container(
          height: 720,
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 390,
                    height: 720,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(IconsPath.map),
                          fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 390,
                    height: 720,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffffffff),
                          Color.fromRGBO(255, 255, 255, 0.11),
                        ],
                        stops: [0.0, 0.3969],
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, -4.0),
                          blurRadius: 10.0,
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                        ),
                      ],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 42.0),
                          _progress(),
                          SizedBox(height: 24.8),
                          _character(),
                          SizedBox(height: 260),
                          //_time2(),
                          Spacer(),
                          _stopbutton(),
                          SizedBox(height: 24.8),
                          Center(
                            child: StopwatchWidget(),
                          ),
                          SizedBox(height: 80),
                        ]),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
*/
Widget _progress() {
  return Container(
    padding: EdgeInsets.only(left: 26.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "대나무 1개 받기까지",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            SizedBox(width: 203.0),
            Text(
              "70%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ), //변경
          ],
        ),
        Container(
          //나중엔 벡터 단위로 받아와서 조건 따라 색 변경해야 할듯
          width: 338.001,
          height: 45.197,
          child: ImageData(IconsPath.bamboo_bar),
        ),
      ],
    ),
  );
}

Widget _character() {
  late AnimationController _animationController;

  return Container(
    margin: EdgeInsets.only(left: 180.0, top: 20),
    width: 69,
    height: 97, // 적절한 높이 설정
    child: ImageData(IconsPath.character2),
  );
}
*/
/*
Widget _time2() {
  return Container(
    padding: EdgeInsets.only(top: 8.0, left: 26.0),
    child: Row(
      children: [
        Container(
          width: 166,
          height: 60,
          padding: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Color(0xfffaf9f7),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              ImageData(IconsPath.bamboo, isSvg: true, width: 44),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bamboo",
                    style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "15개",
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 6),
        Container(
          width: 166,
          height: 60,
          padding: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Color(0xfffaf9f7),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              ImageData(IconsPath.today, isSvg: true, width: 44),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "28분 16초",
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
*/


/*
    Widget _buildAnimatedStopButton(bool isrunning) {
      final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: Navigator.of(context),
      );
      final Animation<Offset> offsetAnimation;

      if (!stopwatch.animationApplied) {
        offsetAnimation = isrunning
            ? Tween<Offset>(
                    begin: Offset(0, 0.3), //: Offset(0, 0),
                    end: Offset.zero) //: Offset(0, 0))
                .animate(CurvedAnimation(
                parent: controller,
                curve: Curves.fastOutSlowIn,
              ))
            : Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0))
                .animate(CurvedAnimation(
                parent: controller,
                curve: Curves.fastOutSlowIn,
              ));

        controller.forward();
        stopwatch.applyAnimation();
      } else {
        offsetAnimation = isrunning
            ? Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0))
                .animate(CurvedAnimation(
                parent: controller,
                curve: Curves.fastOutSlowIn,
              ))
            : Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0))
                .animate(CurvedAnimation(
                parent: controller,
                curve: Curves.fastOutSlowIn,
              ));
        controller.forward();
        //controller.reverse();
        //stopwatch.applyAnimation();
      }

      controller.forward();

      return SlideTransition(
        position: offsetAnimation,
        child: isrunning ? const SizedBox() : _stopbutton(),
      );
    }
*/

/*
    Widget _buildAnimatedTime(bool isRunning) {
      final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: Navigator.of(context),
      );

      final Animation<Offset> offsetAnimation =
          Tween<Offset>(begin: Offset(0, -0.3), end: Offset(0, -0.3)).animate(
        CurvedAnimation(
          parent: controller,
          //curve: FadeTransition(opacity: 1),
        ),
      );

      controller.forward();

      return SlideTransition(
        position: offsetAnimation,
        child: isRunning ? const SizedBox() : _time(),
      );
    }
*/
   /*
    Widget _buildAnimatedWatch(bool isrunning) {
      final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: Navigator.of(context),
      );

      final Animation<Offset> offsetAnimation = Tween<Offset>(
              begin: isrunning ? Offset(0, 1) : Offset(0, 0),
              end: isrunning ? Offset(0, -0.3) : Offset(0, 0))
          .animate(CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ));

      stopwatch.applyAnimation();

      controller.forward();

      return SlideTransition(
        position: offsetAnimation,
        child: StopwatchWidget(),
      );
    }

    Widget _buildAnimatedStopButton(bool start) {
      final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: Navigator.of(context),
      );

      final Animation<Offset> offsetAnimation =
          Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.fastOutSlowIn,
        ),
      );
      controller.forward();

      return SlideTransition(
        position: offsetAnimation,
        child: start ? const SizedBox() : _stopbutton(),
      );
    }
*/
    
    /*
    
              Consumer<PoobaoHome>(
                builder: (context, poobaoHome, child) {
                  return Container(
                    //color: gray,
                    width: size.width,
                    height: 332,
                    child: Stack(
                      children: [
                        //// Rug
                        Positioned(
                          top: 276,
                          left: 104,
                          child: Container(
                            width: 186,
                            height: 36,
                            child: ImageData(poobaoHome.rug_imagePath,
                                width: 186, height: 36),
                          ),
                        ),

                        //// Character
                        Positioned(
                          top: 64,
                          left: 102,
                          child: Container(
                            width: 186,
                            height: 248,
                            //color: yellow,
                            child: ImageData(IconsPath.character),
                          ),
                        ),
                        //// BookShelf
                        Positioned(
                          top: 28,
                          left: 13,
                          child: Container(
                              width: 110,
                              height: 230,
                              child: ImageData(poobaoHome.bookshelf_imagePath,
                                  width: 110, height: 230)),
                        ),
                        //// Clock
                        Positioned(
                          left: 165,
                          top: 0,
                          child: Container(
                              width: 64,
                              height: 64,
                              child: ImageData(poobaoHome.clock_imagePath,
                                  width: 64, height: 64)),
                        ),
                        //// Window
                        Positioned(
                          top: 34,
                          right: 13,
                          child: Container(
                            width: 100,
                            height: 100,
                            child: ImageData(
                              poobaoHome.window_imagePath,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        //// Others
                        Positioned(
                          right: 23,
                          top: 148,
                          child: Container(
                            width: 90,
                            height: 110,
                            child: ImageData(poobaoHome.others_imagePath,
                                width: 90, height: 110),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            */ 