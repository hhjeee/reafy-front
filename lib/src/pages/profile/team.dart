import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';

class Team extends StatelessWidget {
  const Team({super.key});

  Widget _team_img() {
    return Container(
      width: 240,
      height: 240,
      child: ImageData(IconsPath.family),
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
            Text(
              "안녕하세요,\n 저희는 팀 Devkor입니다!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 23.0),
            _team_img(),
            SizedBox(height: 14.0),
            Text(
              "Devkor의 팀원이 궁금하다면?",
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 57.0),
            _programmer(),
            SizedBox(height: 40.0),
            _designer(),
          ],
        ),
      ),
    );
  }
}
