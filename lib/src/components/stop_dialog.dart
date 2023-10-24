import 'package:flutter/material.dart';
import 'dart:async';

class StopDialog extends StatelessWidget {
  final String totalTime;
  final List<String> dropdownList;
  final String selectedBook;

  StopDialog({
    required this.totalTime,
    required this.dropdownList,
    required this.selectedBook,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Text(
          totalTime,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              "독서를 중단하시겠어요?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  const Text(
                    "읽은 책:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  DropdownButton(
                      padding: EdgeInsets.only(left: 30.0),
                      value: selectedBook,
                      items: dropdownList.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (dynamic item) {
                        /////TODO : 
                        ///  setState(() {selectedBook = item;}
                      }),
                ],
              ),
            ),
            TextField(
              decoration: new InputDecoration(labelText: '시작 페이지'),
            ),
            TextField(
              decoration: new InputDecoration(labelText: '종료 페이지'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 286,
              height: 48,
              child: TextButton(
                child: const Text('독서 완료하기'),
                style: TextButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: Color(0xffd9d9d9),
                  primary: Color(0xff333333),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, "OK");
                },
              ),
            ),
            TextButton(
              child: Text('계속 읽기'),
              style: TextButton.styleFrom(
                alignment: Alignment.center,
                primary: Color(0xff333333),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
            ),
          ],
        )
      ],
    );
  }
}
