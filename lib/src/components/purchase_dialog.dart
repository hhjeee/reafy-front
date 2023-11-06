import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';

class PurchaseDialog extends StatefulWidget {
  @override
  _PurchaseDialogState createState() => _PurchaseDialogState();
}

class _PurchaseDialogState extends State<PurchaseDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 358,
        height: 363,
        child: Column(children: [
          SizedBox(height: 30.0),
          Text(
            "구매하시겠습니까?",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            width: 136,
            height: 126,
            color: Color(0xffd9d9d9),
            margin: EdgeInsets.only(top: 18.0, bottom: 18.0),
          ),
          Text(
            "하늘하늘 소파",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageData(
                IconsPath.bamboo,
                isSvg: true,
              ),
              const Text(
                "53개", //나중에 죽순 계산하도록 수정
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe6e6e6),
                  minimumSize: Size(140, 48), //158, 48
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
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  //Navigator.pop(context);
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
                    color: Color(0xff333333),
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
