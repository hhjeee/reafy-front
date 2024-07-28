import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                child: _introduction(size),
              ),
              SizedBox(height: size.height * 0.05),
              _member(size),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    width: size.width,
                    height: size.height * 0.5,
                    child: Image.asset(
                      IconsPath.team_img,
                      fit: BoxFit.cover,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _introduction(Size size) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "안녕하세요,",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: size.width * 0.05,
            fontWeight: FontWeight.w400),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "저희는 ",
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "팀 Devkor",
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w800),
          ),
          Text(
            "입니다!",
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ],
  );
}

Widget _front_dev(Size size) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Front-end",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: size.width * 0.03,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8.0),
      Text(
        "김지호",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: size.width * 0.03,
            fontWeight: FontWeight.w400),
      ),
      Text(
        "윤현지",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: size.width * 0.03,
            fontWeight: FontWeight.w400),
      ),
    ],
  );
}

Widget _back_dev(Size size) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Back-end",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: size.width * 0.03,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8.0),
      Text(
        "박정환",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: size.width * 0.03,
            fontWeight: FontWeight.w400),
      ),
      Text(
        "황정민",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: size.width * 0.03,
            fontWeight: FontWeight.w400),
      ),
    ],
  );
}

Widget _designer(Size size) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Designer",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: size.width * 0.03,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8.0),
      Text(
        "김민채",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: size.width * 0.03,
            fontWeight: FontWeight.w400),
      ),
      Text(
        "김지유",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: size.width * 0.03,
            fontWeight: FontWeight.w400),
      ),
    ],
  );
}

Widget _member(Size size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: size.width * 0.25,
        height: size.width * 0.25,
        padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
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
        child: _front_dev(size),
      ),
      Container(
        width: size.width * 0.25,
        height: size.width * 0.25,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
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
        child: _back_dev(size),
      ),
      Container(
        width: size.width * 0.25,
        height: size.width * 0.25,
        padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
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
        child: _designer(size),
      )
    ],
  );
}
