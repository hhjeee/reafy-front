import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/pages/book/bookshelf.dart';

class DoneDialog extends StatefulWidget {
  @override
  _DoneDialogState createState() => _DoneDialogState();
}

class _DoneDialogState extends State<DoneDialog> {
  @override
  void initState() {
    super.initState();
    // initState에서 일정 시간이 지난 후에 다이얼로그를 닫습니다.
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      //title:
      content: Container(
        width: 196, //설정안됨
        height: 218,
        child: Center(
          child: Container(
            child: ImageData(
              IconsPath.done,
              isSvg: true,
              width: 116,
            ),
          ),
        ),
      ),
    );
  }
}
/////

