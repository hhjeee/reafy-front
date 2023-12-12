import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/utils/constants.dart';

class BambooMap extends StatefulWidget {
  const BambooMap({super.key});

  @override
  State<BambooMap> createState() => _BambooMapState();
}

class _BambooMapState extends State<BambooMap> {
  /*
  bool _isNightTime() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    return hour < 6 || hour > 18; // Assuming night time between 6 PM and 6 AM
  }*/

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
        _bamboo(),
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
                child: Column(
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
                        /// @todo 숫자 카운트 다운
                        "00:00",
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      )
                    ]))
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

Widget _bamboo() {
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
