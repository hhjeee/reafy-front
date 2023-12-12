import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/memo_card.dart';
import 'package:reafy_front/src/controller/board_controller.dart';
import 'package:reafy_front/src/models/memo.dart';
import 'package:reafy_front/src/pages/board/newmemo.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/photouploader.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class Board extends GetView<BoardController> {
  const Board({super.key});

  Widget _memoList() {
    return Obx(() => Column(
          children: List.generate(controller.memoList.length,
              (index) => MemoWidget(memo: controller.memoList[index])).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xff63B865)),
            onPressed: () {
              Get.back(); // Navigator.pop 대신 Get.back()을 사용합니다.
            },
          ),
          actions: [],
        ),
        extendBodyBehindAppBar: true,
        floatingActionButton: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            onPressed: () {
              _showAddMemoBottomSheet(context);
              /*
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  builder: (BuildContext bc) {
                    return NewMemo();
                  })*/
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            backgroundColor: yellow,
            child: Text(
              '+',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/green_bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            width: size.width,
            height: size.height,
            child: ListView(
              children: [_memoList()],
            )));
  }
}

Widget _add_memo(BuildContext context) {
  return GestureDetector(
    onTap: () {
      _showAddMemoBottomSheet(context);
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 26),
      width: 343,
      height: 33,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffB3B3B3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: ImageData(
          IconsPath.add_memo,
          isSvg: true,
        ),
      ),
    ),
  );
}

void _showAddMemoBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(left: 24),
        color: Color(0xffffffff),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 42),
            Row(
              children: [
                Container(
                  width: 13.333,
                  height: 13.333,
                  child: ImageData(
                    IconsPath.memo_date,
                    isSvg: true,
                  ),
                ),
                SizedBox(width: 3.67),
                Text(
                  "생성일",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff666666),
                  ),
                ),
                SizedBox(width: 14),
                Text(
                  "2023년 12월 3일",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff666666),
                  ),
                ),
                Text(
                  "02:04",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff666666),
                  ),
                ),
              ],
            ),
            SizedBox(height: 9.0),
            Row(
              children: [
                Container(
                  width: 13.333,
                  height: 13.333,
                  child: ImageData(
                    IconsPath.memo_tag,
                    isSvg: true,
                  ),
                ),
                SizedBox(width: 4.89),
                Text(
                  "태그",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff666666),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  width: 46,
                  height: 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xffFFECA6),
                  ),
                  child: Center(
                    child: Text(
                      "#경영",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  width: 46,
                  height: 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xffFFECA6),
                  ),
                  child: Center(
                    child: Text(
                      "#경영",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  width: 46,
                  height: 13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Color(0xffb3b3b3), width: 0.8)),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2.0),
                    child: ImageData(
                      IconsPath.add_tag,
                      isSvg: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 26.56),
            Container(
              width: 343,
              height: 179,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xfffbfbfb),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 13),
                    width: 317,
                    height: 128,
                    child: TextField(
                      maxLength: 400,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '메모를 입력해 주세요.',
                        hintStyle: TextStyle(
                          color: Color(0xffb3b3b3),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w500,
                      ),
                      buildCounter: (BuildContext context,
                          {required int currentLength,
                          required bool isFocused,
                          required int? maxLength}) {
                        return Text(
                          '$currentLength/$maxLength자',
                          style: TextStyle(
                            color: Color(0xffb3b3b3),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        width: 14,
                        height: 14,
                        child: ImageData(IconsPath.memo_pic, isSvg: true)),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                //Navigator.pop(context); /
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Color(0xFFFFD747),
                  shadowColor: Colors.black.withOpacity(0.1),
                  elevation: 5,
                  fixedSize: Size(343, 38)),
              child: Text(
                '게시하기',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
