import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/utils/constants.dart';

class Rating extends StatelessWidget {
  const Rating({super.key});

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
        body: Center(
          child: Text("rating"),
        ));
  }
}
