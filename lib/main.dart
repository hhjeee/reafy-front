import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/binding/init_bindings.dart';
import 'package:reafy_front/src/root.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'reafy',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        fontFamily: 'NanumSquareRound',
      ),
      initialBinding: InitBinding(), // 앱 실행시 컨트롤러 다 접근 가능하도록
      home: const Root(),
    );
  }
}
