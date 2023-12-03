import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/memo_card.dart';
import 'package:reafy_front/src/controller/board_controller.dart';
import 'package:reafy_front/src/models/memo.dart';
import 'package:reafy_front/src/pages/board/newmemo.dart';
import 'package:reafy_front/src/utils/constants.dart';

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
            height: 70,
            width: 120,
            child: FloatingActionButton(
              onPressed: () {
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
                    });
              },

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),

              /// 텍스트 컬러
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: ListView(
          children: [_memoList()],
        ));
  }
}
