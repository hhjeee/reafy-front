import 'package:flutter/material.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemShopPage extends StatelessWidget {
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
        child:
            ///////////////// TODO
            Text(
          "ITEMSHOP",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
