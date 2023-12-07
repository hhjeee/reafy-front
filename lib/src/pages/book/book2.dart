import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/utils/constants.dart';

class Book2 extends StatelessWidget {
  const Book2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff5f7e9),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
            onPressed: () {
              Get.back(); // Navigator.pop 대신 Get.back()을 사용합니다.
            },
          ),
        ),
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/green_bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
              width: size.width,
              height: size.height),
        ));
  }
}
