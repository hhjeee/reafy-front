import 'package:flutter/material.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/items.dart';
import 'package:get/get.dart';
import 'dart:async';

class ItemShop extends StatefulWidget {
  const ItemShop({super.key});
  @override
  State<ItemShop> createState() => _ItemShopState();
}

class _ItemShopState extends State<ItemShop> {
  late List<Color> buttonColors;
  late int selectedIndex;

  void initState() {
    super.initState(); // 초기값 설정
    buttonColors = List.filled(6, Color(0xff808080));
    selectedIndex = 0;
    buttonColors[selectedIndex] = Color(0xff63d865);
  }

  void handleButtonPress(int index) {
    setState(() {
      for (int i = 0; i < buttonColors.length; i++) {
        if (i == index) {
          buttonColors[i] = Color(0xff63d865);
        } else {
          buttonColors[i] = Color(0xff808080);
        }
        selectedIndex = index;
      }
    });
  }

  /*String getImageUrl(int index) {
    return 'url or filepath';
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            Get.back(); // Navigator.pop 대신 Get.back()을 사용합니다.
          },
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: 280,
              height: 255,
              color: Color(0xffd9d9d9),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              height: 1.0,
              color: Color(0xffd9d9d9),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      handleButtonPress(0);
                    },
                    child: Text(
                      '배경',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: buttonColors[0],
                      ),
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.only(
                        left: 30.0,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      handleButtonPress(1);
                    },
                    child: Text(
                      '러그',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: buttonColors[1],
                      ),
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      handleButtonPress(2);
                    },
                    child: Text(
                      '소파',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: buttonColors[2],
                      ),
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      handleButtonPress(3);
                    },
                    child: Text(
                      '시계',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: buttonColors[3],
                      ),
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      handleButtonPress(4);
                    },
                    child: Text(
                      '창문',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: buttonColors[4],
                      ),
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      handleButtonPress(5);
                    },
                    child: Text(
                      '쇼룸',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: buttonColors[5],
                      ),
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.only(
                        right: 30.0,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ],
            ),
            Items(),
          ])),
    );
  }
}
