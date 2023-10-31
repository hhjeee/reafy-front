import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:reafy_front/src/components/image_data.dart';
//import 'package:reafy_front/src/components/switch.dart';
import 'package:reafy_front/src/pages/itemshop.dart';
import 'package:reafy_front/src/components/stopwatch.dart';
import 'package:reafy_front/src/utils/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget _header() {
    return Padding(
        padding: const EdgeInsets.only(top: 45.0, left: 16.0, right: 16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            child: Row(
              children: [
                ImageData(IconsPath.bamboo, isSvg: true),
                SizedBox(width: 2), // 코인 아이콘과 텍스트 사이의 간격 조절
                Text(
                  '25',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Get.to(ItemShop()); // '/itemshop' 페이지로 이동
              },
              child: ImageData(IconsPath.item, isSvg: true)),
        ]));
  }

  Widget _character() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: 390,
        height: 392, // 적절한 높이 설정
        decoration: BoxDecoration(
            gradient: RadialGradient(
          radius: 1.1086, // 110.86%의 크기
          colors: [
            Color(0xFFE2EEE0), // 시작 색상
            bgColor // 끝 색상 (투명)
          ],
          stops: [0.2197, 0.5], // 각 색상의 정지점 (0.2197는 21.97%의 위치)
        )),
        child: ImageData(IconsPath.character),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[_header()],
          ),
          Expanded(
            //child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SwitchButton(),
                Spacer(),
                _character(),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
