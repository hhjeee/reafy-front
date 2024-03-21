import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/pages/intro.dart';
import 'package:reafy_front/src/pages/login_page.dart';
import 'package:reafy_front/src/pages/profile/statics.dart';
import 'package:reafy_front/src/pages/profile/team.dart';
import 'package:reafy_front/src/components/profile_name.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                margin: EdgeInsets.only(top: 30, left: 29.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(Statics()); //TutorialScreen()); //
                    //TutorialScreen
                  },
                  child: Row(
                    children: [
                      ImageData(IconsPath.statistic,
                          isSvg: true, width: 26, height: 26),
                      const Padding(
                        padding: EdgeInsets.only(left: 17),
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                height: 4.0,
                color: Color(0xfff5f5f5),
              ),
              Container(
                margin: EdgeInsets.only(left: 29.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(Team());
                  },
                  child: Row(
                    children: [
                      ImageData(IconsPath.Team,
                          isSvg: true, width: 26, height: 26),
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
              /*Container(
                margin: EdgeInsets.symmetric(vertical: 16),
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
                      ImageData(IconsPath.star,
                          isSvg: true, width: 26, height: 26),
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
             */
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                height: 4.0,
                color: Color(0xfff5f5f5),
              ),
              Container(
                margin: EdgeInsets.only(left: 29.0),
                child: GestureDetector(
                  onTap: () async {
                    var user = context.read<AuthProvider>();
                    user.logout();
                    Get.off(() => LoginPage());
                  },
                  child: Row(
                    children: [
                      ImageData(IconsPath.Logout,
                          isSvg: true, width: 26, height: 26),
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
