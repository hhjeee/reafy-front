import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:reafy_front/src/components/image_data.dart';

class Team extends StatelessWidget {
  const Team({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffaf9f7),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            Get.back();
          },
        ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 46.0),
              Container(
                margin: EdgeInsets.only(left: 36.0),
                child: _introduction(),
              ),
              SizedBox(height: 60.0),
              _member(),
              SizedBox(height: 123.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    width: size.width,
                    height: 365,
                    child: Image.asset(
                      IconsPath.team_img,
                      fit: BoxFit.cover,
                    )),

                //decoration: BoxDecoration(image: Image.asset(IconsPath.team_img ), ),
              ),
              /*Transform.rotate(
                angle: -18.994 * (3.141592653589793 / 180), // 라디안으로 변환
                child: Container(
                  width: 325.088,
                  height: 354.556,
                  child: ImageData(IconsPath.team_img),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

Widget _introduction() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "안녕하세요,",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 24,
            fontWeight: FontWeight.w400),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "저희는 ",
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: 24,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "팀 Devkor",
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: 24,
                fontWeight: FontWeight.w800),
          ),
          Text(
            "입니다!",
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: 24,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ],
  );
}

Widget _front_dev() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Front-end",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 14,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "김지호",
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
              height: 13.646,
            ),
            padding: EdgeInsets.only(left: 10.0),
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
                color: Color(0xff333333),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
              height: 13.646,
            ),
            padding: EdgeInsets.only(left: 10.0),
            constraints: BoxConstraints(),
          ),
        ],
      ),
    ],
  );
}

Widget _back_dev() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Back-end",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 14,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "박정환",
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
              height: 13.646,
            ),
            padding: EdgeInsets.only(left: 10.0),
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
                color: Color(0xff333333),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
              height: 13.646,
            ),
            padding: EdgeInsets.only(left: 10.0),
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
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Designer",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 14,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "김민채",
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
              height: 13.646,
            ),
            padding: EdgeInsets.only(left: 10.0),
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
                color: Color(0xff333333),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          IconButton(
            onPressed: () {},
            icon: ImageData(
              IconsPath.team_link,
              isSvg: true,
              width: 14,
              height: 13.646,
            ),
            padding: EdgeInsets.only(left: 10.0),
            constraints: BoxConstraints(),
          ),
        ],
      ),
    ],
  );
}

Widget _member() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 98,
        height: 88,
        padding: EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFFAF9F7),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: _front_dev(),
      ),
      Container(
        width: 98,
        height: 88,
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        padding: EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFFAF9F7),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: _back_dev(),
      ),
      Container(
        width: 98,
        height: 88,
        padding: EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFFAF9F7),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: _designer(),
      )
    ],
  );
}
