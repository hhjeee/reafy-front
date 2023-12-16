import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/repository/item_repository.dart';
import 'package:reafy_front/src/components/donetohome.dart';

class PurchaseDialog extends StatefulWidget {
  final int itemId;
  final String itemName;
  final String itemImagePath;

  PurchaseDialog({
    required this.itemId,
    required this.itemName,
    required this.itemImagePath,
  });

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
        width: 320,
        height: 357,
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
            margin: EdgeInsets.only(top: 18.0, bottom: 18.0),
            child: ImageData(widget.itemImagePath),
          ),
          Text(
            widget.itemName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff333333),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageData(
                IconsPath.bamboo,
                isSvg: true,
                width: 44,
              ),
              const Text(
                "53개", //나중에 죽순 계산하도록 수정
                style: TextStyle(
                  color: Color(0xff808080),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffebebeb),
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
              SizedBox(width: 6),
              ElevatedButton(
                //확인 버튼 누르는게 보유한 대나무 수가 해당 아이템 가격보다 많을때 가능하도록 하기
                onPressed: () async {
                  bool success = await postBookInfo(widget.itemId, true);
                  Navigator.pop(context);

                  if (success) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DoneDialog2();
                      },
                    );
                  } else {}
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
