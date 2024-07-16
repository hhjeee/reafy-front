import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';

class ExistingItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 320,
        height: 300,
        child: Column(children: [
          SizedBox(height: 30.0),
          Text(
            '대나무가 부족해요.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '독서를 통해 더 모아보세요!',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xff666666),
            ),
          ),
          Container(
            width: 123,
            height: 102,
            margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Image.asset(IconsPath.crying, width: 123),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffffd747),
              minimumSize: Size(286, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              '다른 가구 보러가기',
              style: const TextStyle(
                color: Color(0xff333333),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ]),
      ),
      actions: <Widget>[],
    );
  }
}
