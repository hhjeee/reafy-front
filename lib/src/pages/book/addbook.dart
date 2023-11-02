import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/utils/constants.dart';

class Addbook extends StatefulWidget {
  const Addbook({super.key});

  @override
  State<Addbook> createState() => _AddbookState();
}

class _AddbookState extends State<Addbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "책을 추가해주세요!",
            style: TextStyle(
                color: Color(0xff333333),
                fontWeight: FontWeight.w800,
                fontSize: 20),
          ),
          foregroundColor: Color(0xff333333),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _search(),
                const Spacer(flex: 3),
                _character(),
                const Spacer(flex: 1),
              ]),
        )));
  }
}

Widget _search() {
  return Container(
      child: TextField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Color(0xffFFF7DA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Color(0xffFFF7DA)),
      ),
      hintText: "도서명를 입력해주세요",
      hintStyle: TextStyle(
          color: Color(0xff6A6A6A), fontSize: 14, fontWeight: FontWeight.w400),
      prefixIcon: Icon(
        Icons.search,
        color: Color(0xffFFCA0E),
      ),
    ),
  ));
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
