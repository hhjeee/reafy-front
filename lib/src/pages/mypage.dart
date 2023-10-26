import 'package:flutter/material.dart';
import 'package:reafy_front/src/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/pages/profile/statistics.dart';
import 'package:reafy_front/src/pages/profile/team.dart';
import 'package:reafy_front/src/pages/profile/rating.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    void showAlertDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('logout'),
            actions: [],
          );
        },
      );
    }

    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              //프로필사진
              child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 84.0, bottom: 21.53),
                    width: 148.47,
                    height: 148.47,
                    decoration: const BoxDecoration(
                      color: Color(0xfff0f0f0),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Positioned(
                    top: 180, //231,
                    left: 105, //191.46,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(Statistics());
                        },
                        child: ImageData(IconsPath.statistic, isSvg: true),
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "꼬물이",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff000000),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 34.0, bottom: 23.0),
                height: 4.0,
                color: Color(0xfff5f5f5),
              ),
            ],
          )), //프로필사진

          Container(
            //통계
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 31.0, bottom: 12.26),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(Statistics());
                    },
                    child: Row(
                      children: [
                        ImageData(IconsPath.statistic,
                            isSvg: true, width: 18.741),
                        const Padding(
                          padding: EdgeInsets.only(left: 14.26),
                          child: Text(
                            "통계",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16.77),
                      width: 162.115,
                      height: 167,
                      decoration: BoxDecoration(
                        color: Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      width: 162.115,
                      height: 167,
                      decoration: BoxDecoration(
                        color: Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 32.0, bottom: 19.0),
                  height: 4.0,
                  color: Color(0xfff5f5f5),
                ),
              ],
            ),
          ), //통계

          Container(
            margin: EdgeInsets.only(left: 31.0),
            child: GestureDetector(
              onTap: () {
                Get.to(Team());
              },
              child: Row(
                children: [
                  ImageData(IconsPath.statistic, isSvg: true, width: 18.741),
                  const Padding(
                    padding: EdgeInsets.only(left: 14.26),
                    child: Text(
                      //padding left 14.26
                      "팀 소개",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 20.26, bottom: 15.0),
            height: 4.0,
            color: Color(0xfff5f5f5),
          ),
          Container(
            margin: EdgeInsets.only(left: 31.0),
            child: GestureDetector(
              onTap: () {
                Get.to(Rating());
              },
              child: Row(
                children: [
                  ImageData(IconsPath.star, isSvg: true, width: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 14.26),
                    child: Text(
                      "평점 남기기",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 19.0, bottom: 15.0),
            height: 4.0,
            color: Color(0xfff5f5f5),
          ),

          Container(
            margin: EdgeInsets.only(left: 31.0),
            child: GestureDetector(
              onTap: () {
                showAlertDialog(context);
              },
              child: Row(
                children: [
                  ImageData(IconsPath.statistic, isSvg: true, width: 18.741),
                  const Padding(
                    padding: EdgeInsets.only(left: 14.26),
                    child: Text(
                      "로그아웃",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
