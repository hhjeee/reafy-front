import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/done.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';
import 'package:reafy_front/src/pages/book/bookshelf.dart';
import 'package:reafy_front/src/pages/book/category_bookshelf.dart';

class DeleteDialog extends StatefulWidget {
  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 320,
        height: 160,
        child: Column(children: [
          /*SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Dialog를 닫음
                },
                child: ImageData(IconsPath.x, isSvg: true, width: 10),
              ),
              SizedBox(width: 19.0),
            ],
          ),*/
          SizedBox(height: 40.0),
          Text(
            "정말 삭제하시겠어요? \n 등록한 책이 영구적으로 사라져요!",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff333333),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffebebeb),
                  minimumSize: Size(140, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '취소',
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(width: 6),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // DeleteDialog 닫기
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DoneDialog(onDone: () {
                        BottomNavController.to.goToBookShelf();
                      });
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffffd747),
                  minimumSize: Size(140, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '확인',
                  style: const TextStyle(
                    color: Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      actions: <Widget>[],
    );
  }
}
