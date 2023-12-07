import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';

class BambooMap extends StatefulWidget {
  const BambooMap({super.key});

  @override
  State<BambooMap> createState() => _BambooMapState();
}

class _BambooMapState extends State<BambooMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          height: 720,
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 390,
                    height: 720,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(IconsPath.map),
                          fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 390,
                    height: 720,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 42.0),

                          SizedBox(height: 24.8),
                          _character(),
                          SizedBox(height: 260),
                          //_time2(),
                          Spacer(),
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget _character() {
  late AnimationController _animationController;

  return Container(
    margin: EdgeInsets.only(left: 180.0, top: 20),
    width: 69,
    height: 97, // 적절한 높이 설정
    child: ImageData(IconsPath.character2),
  );
}
