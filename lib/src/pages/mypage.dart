import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/login_page.dart';
import 'package:reafy_front/src/pages/profile/statistics.dart';
import 'package:reafy_front/src/pages/profile/team.dart';
import 'package:reafy_front/src/pages/profile/rating.dart';
import 'package:reafy_front/src/components/profile_name.dart';
import 'package:reafy_front/src/provider/user_provider.dart';

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
      body: Container(
          decoration: BoxDecoration(
            color: Color(0xfffaf9f7),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileName(),
              Container(
                //통계
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: 39.0, left: 31.0, bottom: 12.26),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(Statistics());
                        },
                        child: Row(
                          children: [
                            ImageData(IconsPath.statistic,
                                isSvg: true, width: 18.741),
                            const Padding(
                              padding: EdgeInsets.only(left: 9.26),
                              child: Text(
                                "통계",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff666666),
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
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          width: 162.115,
                          height: 167,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
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
                margin: EdgeInsets.only(left: 29.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(Team());
                  },
                  child: Row(
                    children: [
                      ImageData(IconsPath.Team, isSvg: true, width: 18),
                      const Padding(
                        padding: EdgeInsets.only(left: 17),
                        child: Text(
                          //padding left 14.26
                          "팀 소개",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff666666),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 21, bottom: 17.0),
                height: 4.0,
                color: Color(0xfff5f5f5),
              ),
              Container(
                margin: EdgeInsets.only(left: 27.0), //25
                child: GestureDetector(
                  onTap: () {
                    Get.to(Rating());
                  },
                  child: Row(
                    children: [
                      ImageData(IconsPath.star, isSvg: true, width: 20),
                      const Padding(
                        padding: EdgeInsets.only(left: 15), //13
                        child: Text(
                          "평점 남기기",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff666666),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 23.0, bottom: 15.0),
                height: 4.0,
                color: Color(0xfff5f5f5),
              ),

              Container(
                margin: EdgeInsets.only(left: 29.0),
                child: GestureDetector(
                  onTap: () async {
                    var user = context.read<UserProvider>();

                    if (user.isLogined) {
                      user.logout();
                      print('로그아웃 완료');
                    }
                    Get.off(() => LoginPage());
                    /*
                    //showAlertDialog();
                    var user = context.read<UserProvider>();
                    if (await user.isLogined) {
                      await user.logout();

                      Get.to(LoginPage());
                    } else {
                      showAlertDialog(context);
  
                    }*/
                  },
                  child: Row(
                    children: [
                      ImageData(IconsPath.Logout, isSvg: true, width: 19.995),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "로그아웃",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff666666),
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
