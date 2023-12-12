import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/utils/constants.dart';

class BambooMap extends StatefulWidget {
  const BambooMap({super.key});
  @override
  State<BambooMap> createState() => _BambooMapState();
}

class _BambooMapState extends State<BambooMap> {
  List<Offset> giftPositions = [
    Offset(157, 133),
    Offset(13, 163),
    Offset(47, 223),
    Offset(144, 265),
    Offset(263, 259),
    Offset(228, 157),
  ];

  Widget bamboo_collect(context) {
    StopwatchProvider stopwatch = Provider.of<StopwatchProvider>(context);
    print(stopwatch.itemCnt);

    List<bool> generateVisibilityList(int i) {
      return List.generate(6, (index) => index < i);
    }

    List<bool> giftVisibility = generateVisibilityList(stopwatch.itemCnt);

    return Stack(
      children: List.generate(giftPositions.length, (index) {
        return AnimatedPositioned(
          duration: Duration(milliseconds: 1000),
          curve: Curves.bounceOut,
          left: giftVisibility[index] ? giftPositions[index].dx : 212,
          bottom: giftVisibility[index] ? giftPositions[index].dy : 450,
          width: giftVisibility[index] ? 115 : 0,
          height: giftVisibility[index] ? 115 : 0,
          child: GestureDetector(
              onTap: () {
                // 대나무 증가 요청 보내기
                setState(() {
                  giftVisibility[index] = false;
                });
                Future.delayed(Duration(milliseconds: 1000))
                    .then((onValue) => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _dialog();
                        }));
              },
              child: ImageData(IconsPath.bambooicon, width: 115, height: 115)),
        );
      }),
    );
  } /*
Visibility(
                  //maintainAnimation: ,
                  visible: giftVisibility[index],
                  child:*/

  @override
  Widget build(BuildContext context) {
    //bool isNight = _isNightTime();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(IconsPath.bamboomap),
                //isNight ? IconsPath.bamboomap_night : IconsPath.bamboomap_day)
                fit: BoxFit.cover),
          ),
        ),
        _bubble(),
        Positioned(
          bottom: -30,
          //left: 38,
          child: Container(
              width: size.width, height: 500, child: bamboo_collect(context)),
        ),
        _bottombar(),
      ],
    ));
  }
}

Widget _bubble() {
  return Positioned(
      top: 221,
      left: 176,
      child: GestureDetector(
          onTap: () {
            //Get.to(Board());
          },
          child: Stack(children: [
            ImageData(
              IconsPath.map_bubble,
              width: 112,
              height: 77,
              isSvg: true,
            ),
            Container(
                width: 112,
                height: 63,
                child: Consumer<StopwatchProvider>(
                    builder: (context, stopwatch, child) {
                  if (!stopwatch.isRunning) {
                    return Container(
                        child: Center(
                            child: Text(
                      " . . . ",
                      style: TextStyle(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    )));
                  } else if (stopwatch.isRunning && !stopwatch.isFull) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "다음 대나무까지",
                            style: TextStyle(
                              color: black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            stopwatch.remainTimeString,
                            style: TextStyle(
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                            ),
                          )
                        ]);
                  } else {
                    return Container(
                        child: Text(
                      "선물 받기!",
                      style: TextStyle(
                        color: black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ));
                  }
                }))
          ])));
}

Widget _character() {
  return Container(
    //margin: EdgeInsets.only(left: 180.0, top: 20),
    width: 69,
    height: 97, // 적절한 높이 설정
    child: ImageData(IconsPath.character2),
  );
}

Widget _bottombar() {
  return Positioned(
    bottom: 51, // Adjust the value as needed
    left: 34,
    child: Row(
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            onPressed: () {
              Get.back();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: green,
            child: ImageData(
              IconsPath.back_arrow,
              //width: 44,
              //height: 44,
              isSvg: true,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 245,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 54, vertical: 14),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "내가 가진 대나무",
                style: TextStyle(
                  color: dark_gray,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "15개",
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        /*
        Positioned(
          top: 8,
          left: 8,
          child: IconButton(
            icon: ImageData(
              IconsPath.back_arrow,
              width: 44,
              height: 44,
              isSvg: true,
            ),
            onPressed: () {
              Get.back();
            },
            color: Colors.white,
          ),
        ),*/
      ],
    ),
  );
}

Widget _dialog() {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    contentPadding: EdgeInsets.zero,
    content: Container(
      width: 228,
      height: 213,
      padding: EdgeInsets.fromLTRB(17, 30, 17, 17),
      child: Column(children: [
        //SizedBox(height: 30.0),
        Text(
          "대나무 줍기 완료!",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 18.0),
        Text(
          "현재 대나무 수",
          //poobaoHome.selectedItemName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageData(
              IconsPath.bamboo,
              isSvg: true,
              width: 44,
            ),
            const Text(
              "53개", //나중에 죽순 계산하도록 수정
              style: TextStyle(
                color: Color(0xff808080),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        ElevatedButton(
          onPressed: () {
            /// TODO
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xffffd747),
            minimumSize: Size(140, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            '확인',
            style: const TextStyle(
              color: Color(0xff333333),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ]),
    ),
  );
}
