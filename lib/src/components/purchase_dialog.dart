import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/done.dart';
import 'package:reafy_front/src/components/existing_item.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/provider/coin_provider.dart';
import 'package:reafy_front/src/repository/item_repository.dart';

class PurchaseDialog extends StatefulWidget {
  final int itemId;
  final String itemName;
  final String itemImagePath;
  final int itemPrice;

  PurchaseDialog({
    required this.itemId,
    required this.itemName,
    required this.itemImagePath,
    required this.itemPrice,
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
        height: 370,
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
              Text(
                widget.itemPrice.toString(),
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
                  backgroundColor: Color(0xffebebeb),
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
                onPressed: () async {
                  var currentCoin =
                      Provider.of<CoinProvider>(context, listen: false).coins;
                  if (currentCoin >= widget.itemPrice) {
                    bool success =
                        await postItem(widget.itemId, false, widget.itemPrice);
                    Navigator.pop(context);

                    if (success) {
                      Provider.of<CoinProvider>(context, listen: false)
                          .setCoins(currentCoin - widget.itemPrice);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DoneDialog(onDone: () {
                            //BottomNavController.to.goToHome();
                            Navigator.pop(context);
                            ; // Navigate to Home
                          });
                          //return DoneDialog();
                        },
                      );
                    }
                  } else {
                    //코인 부족
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ExistingItem();
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffffd747),
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
