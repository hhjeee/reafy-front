import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:reafy_front/src/components/image_data.dart';
//import 'package:reafy_front/src/components/switch.dart';
import 'package:reafy_front/src/pages/itemshop.dart';
import 'package:reafy_front/src/components/stopwatch.dart';
import 'package:reafy_front/src/utils/constants.dart';

class Home extends StatelessWidget {
  //const Home({super.key});

  /*Widget _character() {
    //final size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: double.infinity,
          height: 350, // 적절한 높이 설정
          decoration: BoxDecoration(
              gradient: RadialGradient(
            radius: 1.1086, // 110.86%의 크기
            colors: [
              Color(0xFFE2EEE0), // 시작 색상
              //bgColor // 끝 색상 (투명)
            ],
            stops: [0.2197, 0.5], // 각 색상의 정지점 (0.2197는 21.97%의 위치)
          )),
          child: ImageData(IconsPath.character),
        ));
  }*/

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffaf9f7),
        elevation: 0,
        leadingWidth: 76, //90,
        toolbarHeight: 30,
        titleSpacing: 0,

        leading: Transform.translate(
            offset: Offset(16, 0),
            child: Container(
                padding: EdgeInsets.only(right: 16),
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
                        color: Color(0xff63b865),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title_text(),
              ElevatedButton(
                onPressed: () {
                  Map(context);
                },
                child: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
              //SizedBox(height: 60.0), //70
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: 334,
                    decoration: BoxDecoration(
                      color: Color(0xffd9d9d9),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 332,
                    child: ImageData(IconsPath.home_graffic),
                  ),
                ],
              ),
              _time(),
              Center(
                child: StopWatch(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _title_text() {
  return Container(
    padding: EdgeInsets.only(top: 20, left: 26),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 20.0),
      Text(
        "반가워요!\n오늘도 같이 책읽을까요?",
        style: TextStyle(
          fontSize: 22,
          height: 1.36364,
          color: Color(0xff333333),
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(height: 12.0),
      Text(
        "요즘은 '별들이 겹치는 순간'을 읽고있어요 :)",
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff666666),
          fontWeight: FontWeight.w400,
        ),
      ),
    ]),
  );
}

Widget _time() {
  return Container(
    padding: EdgeInsets.only(top: 8.0, left: 26.0),
    child: Row(
      children: [
        Container(
          width: 166,
          height: 60,
          padding: EdgeInsets.only(left: 10.0),
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
            children: [
              ImageData(IconsPath.today, isSvg: true, width: 44),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "28분 16초",
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 6),
        Container(
          width: 166,
          height: 60,
          padding: EdgeInsets.only(left: 10.0),
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
            children: [
              ImageData(IconsPath.total, isSvg: true, width: 44),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "37시간 20분",
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void Map(context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      builder: (BuildContext bc) {
        return Container(
          height: 660,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 390,
                    height: 660,
                    child: ImageData(IconsPath.map),
                  ),
                  Container(
                    width: 390,
                    height: 660,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffffffff),
                          Color.fromRGBO(255, 255, 255, 0.11),
                        ],
                        stops: [0.0, 0.3969],
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, -4.0),
                          blurRadius: 10.0,
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                        ),
                      ],
                    ),
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 42.0),
                          _progress(),
                          SizedBox(height: 24.8),
                          _character(),
                          SizedBox(height: 260),
                          _time2(),
                          Center(
                            child: StopWatch(),
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

Widget _progress() {
  return Container(
    padding: EdgeInsets.only(left: 26.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "대나무 1개 받기까지",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            SizedBox(width: 203.0),
            Text(
              "70%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ), //변경
          ],
        ),
        Container(
          //나중엔 벡터 단위로 받아와서 조건 따라 색 변경해야 할듯
          width: 338.001,
          height: 45.197,
          child: ImageData(IconsPath.bamboo_bar),
        ),
      ],
    ),
  );
}

Widget _character() {
  return Container(
    margin: EdgeInsets.only(left: 41.0),
    width: 69,
    height: 97, // 적절한 높이 설정
    child: ImageData(IconsPath.character),
  );
}

Widget _time2() {
  return Container(
    padding: EdgeInsets.only(top: 8.0, left: 26.0),
    child: Row(
      children: [
        Container(
          width: 166,
          height: 60,
          padding: EdgeInsets.only(left: 10.0),
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
            children: [
              ImageData(IconsPath.bamboo, isSvg: true, width: 44),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bamboo",
                    style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "15개",
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 6),
        Container(
          width: 166,
          height: 60,
          padding: EdgeInsets.only(left: 10.0),
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
            children: [
              ImageData(IconsPath.today, isSvg: true, width: 44),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "28분 16초",
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
