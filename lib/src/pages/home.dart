import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:reafy_front/src/components/chatbox.dart';
import 'package:reafy_front/src/components/image_data.dart';
//import 'package:reafy_front/src/components/switch.dart';
import 'package:reafy_front/src/pages/itemshop.dart';
import 'package:reafy_front/src/components/stopwatch.dart';
import 'package:reafy_front/src/utils/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget _character() {
    //final size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: double.infinity,
          height: 350, // 적절한 높이 설정
          /*decoration: BoxDecoration(
              gradient: RadialGradient(
            radius: 1.1086, // 110.86%의 크기
            colors: [
              Color(0xFFE2EEE0), // 시작 색상
              //bgColor // 끝 색상 (투명)
            ],
            stops: [0.2197, 0.5], // 각 색상의 정지점 (0.2197는 21.97%의 위치)
          )),*/
          child: ImageData(IconsPath.character),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffB6E0B7),
          elevation: 0,
          leadingWidth: 76, //90,
          toolbarHeight: 30,
          titleSpacing: 0,

          leading: Transform.translate(
              offset: Offset(16, 0),
              child: Container(
                  padding: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color(0xff63B865)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 6),
                      ImageData(IconsPath.bamboo, isSvg: true),
                      SizedBox(width: 4), // 코인 아이콘과 텍스트 사이의 간격 조절
                      Text(
                        '25',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xfffaf9f7),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ))),
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 16),
              icon: ImageData(IconsPath.item, isSvg: true),
              onPressed: () {
                Get.to(ItemShop());
              },
            ),
          ],
        ),
        body: SafeArea(
            //),
            child: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              transform: GradientRotation(90),
              colors: [Color(0xffB6E0B7), Color(0xff64C567)],
            ),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Flexible(
                  child: Center(
                    child: StopWatch(),
                  ),
                  flex: 2),
              Flexible(child: ChatBox(), flex: 4),
              Flexible(child: Container(), flex: 1),
              Flexible(child: _character(), flex: 9),
            ],
          ),
        )));
  }
}
