import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/done.dart';

class ModifyDialog extends StatefulWidget {
  @override
  _ModifyDialogState createState() => _ModifyDialogState();
}

class _ModifyDialogState extends State<ModifyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      //title:
      content: Container(
        width: 320,
        height: 190,
        child: Column(children: [
          /*SizedBox(height: 16.0),
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
            "상태를 변경해 주세요!",
            style: const TextStyle(
              color: Color(0xff333333),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BookStatusButtonGroup(),
            ],
          ),
          SizedBox(height: 40),
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
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DoneDialog();
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

/////

class BookStatusButtonGroup extends StatefulWidget {
  @override
  _BookStatusButtonGroupState createState() => _BookStatusButtonGroupState();
}

class _BookStatusButtonGroupState extends State<BookStatusButtonGroup> {
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 266,
          height: 30,
          decoration: BoxDecoration(
              color: Color(0xfffaf9f7),
              borderRadius: BorderRadius.circular(100)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
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
        )
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
    return Stack(children: <Widget>[
      Container(
        width: 89,
        height: 30,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: isSelected ? Color(0xffFFECA6) : Color(0xFFfaf9f7),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
      )
    ]);
  }
}
