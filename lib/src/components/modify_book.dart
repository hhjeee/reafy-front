import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';

class ModifyDialog extends StatefulWidget {
  @override
  _ModifyDialogState createState() => _ModifyDialogState();
}

class _ModifyDialogState extends State<ModifyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //alert말고 다른 dialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      //title:
      content: Container(
        width: 248,
        height: 322,
        child: Column(children: [
          SizedBox(height: 15.0),
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
          SizedBox(height: 41.0),
          Text(
            "정보를 수정해 주세요!",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SizedBox(width: 17),
              BookStatusButtonGroup(),
            ],
          ),
          SizedBox(height: 78),
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
              '확인',
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

/////

class BookStatusButtonGroup extends StatefulWidget {
  @override
  _BookStatusButtonGroupState createState() => _BookStatusButtonGroupState();
}

class _BookStatusButtonGroupState extends State<BookStatusButtonGroup> {
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BookStatusButton(
          status: '읽은 책',
          isSelected: selectedButtonIndex == 0,
          onPressed: () {
            setState(() {
              selectedButtonIndex = 0;
            });
          },
        ),
        BookStatusButton(
          status: '읽는 중',
          isSelected: selectedButtonIndex == 1,
          onPressed: () {
            setState(() {
              selectedButtonIndex = 1;
            });
          },
        ),
        BookStatusButton(
          status: '읽을 책',
          isSelected: selectedButtonIndex == 2,
          onPressed: () {
            setState(() {
              selectedButtonIndex = 2;
            });
          },
        ),
      ],
    );
  }
}

class BookStatusButton extends StatelessWidget {
  final String status;
  final bool isSelected;
  final VoidCallback onPressed;

  const BookStatusButton({
    required this.status,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 71,
      height: 28,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: isSelected ? Color(0xffFFECA6) : Color(0xFFFFF7DA),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: isSelected ? Color(0xFFffd747) : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
