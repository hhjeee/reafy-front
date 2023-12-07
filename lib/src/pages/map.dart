import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/utils/constants.dart';

class BambooMap extends StatefulWidget {
  const BambooMap({super.key});

  @override
  State<BambooMap> createState() => _BambooMapState();
}

class _BambooMapState extends State<BambooMap> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: gray, elevation: 0),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(IconsPath.bamboomap), fit: BoxFit.fitWidth),
            ),
          ),
          Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 24.8),
              _character(),
              SizedBox(height: 260),
              _bamboo(),
              Spacer(),
            ]),
          ),
        ],
      ),
    );
  }
}

Widget _character() {
  return Container(
    margin: EdgeInsets.only(left: 180.0, top: 20),
    width: 69,
    height: 97, // 적절한 높이 설정
    child: ImageData(IconsPath.character2),
  );
}

Widget _bamboo() {
  return Container(
    padding: EdgeInsets.only(top: 8.0, left: 26.0),
    child: Container(
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
          ImageData(IconsPath.bamboo, isSvg: true, width: 44, height: 44),
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
  );
}
