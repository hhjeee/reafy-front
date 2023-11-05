import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:reafy_front/src/components/image_data.dart';

class Team extends StatelessWidget {
  const Team({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffcfcfc),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            Get.back(); // Navigator.pop 대신 Get.back()을 사용합니다.
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _team_img(),
            _introduction(),
            SizedBox(height: 46.0),
            Stack(
              children: [
                Container(
                  width: 390,
                  height: 302,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xfffff7da).withOpacity(0.5),
                        spreadRadius: 5, // 퍼짐 정도
                        blurRadius: 10, // blur 정도
                        offset: Offset(0, 5), // 위치 조절 (상단에 적용되도록)
                      ),
                    ],
                  ),
                ),
                Container(
                    width: 390,
                    height: 302,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 30.0), //31
                        _programmer(),
                        SizedBox(height: 47.0),
                        _designer(),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _team_img() {
  return Container(
    width: 288,
    height: 288,
    child: ImageData(IconsPath.family),
  );
}

Widget _introduction() {
  return Column(
    children: [
      Text(
        "안녕하세요,",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xff000000),
            fontSize: 16,
            fontWeight: FontWeight.w400),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "저희는 ",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "팀 Devkor",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 16,
                fontWeight: FontWeight.w800),
          ),
          Text(
            "입니다!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ],
  );
}

Widget _programmer() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "개발자",
        style: TextStyle(
            color: Color(0xff000000),
            fontSize: 14,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 12.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "김지호",
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
            ),
            padding: EdgeInsets.only(left: 17.0),
            constraints: BoxConstraints(),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "박정환",
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
            ),
            padding: EdgeInsets.only(left: 17.0),
            constraints: BoxConstraints(),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "윤현지",
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
            ),
            padding: EdgeInsets.only(left: 17.0),
            constraints: BoxConstraints(),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "황정민",
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
            ),
            padding: EdgeInsets.only(left: 17.0),
            constraints: BoxConstraints(),
          ),
        ],
      ),
    ],
  );
}

Widget _designer() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "디자이너",
        style: TextStyle(
            color: Color(0xff000000),
            fontSize: 14,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 12.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "김민채",
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
            ),
            padding: EdgeInsets.only(left: 17.0),
            constraints: BoxConstraints(),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "김지유",
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
            ),
            padding: EdgeInsets.only(left: 17.0),
            constraints: BoxConstraints(),
          ),
        ],
      ),
    ],
  );
}
