import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';

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
        width: 248,
        height: 155,
        child: Column(children: [
          SizedBox(height: 14.0),
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
          ),
          SizedBox(height: 13.0),
          Text(
            "정말 삭제하시겠어요? \n 등록한 책이 영구적으로 사라져요!",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 29.0),
          ElevatedButton(
            onPressed: () {
              //Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xffffd747),
              minimumSize: Size(212, 42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              elevation: 0,
            ),
            child: Text(
              '삭제하기',
              style: const TextStyle(
                color: Color(0xff000000),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ]),
      ),
      actions: <Widget>[],
    );
  }
}
