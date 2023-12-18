import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:io";
import 'package:image_picker/image_picker.dart';
import 'package:reafy_front/src/components/image_picker.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/tag_input.dart';

class NewMemo extends StatefulWidget {
  const NewMemo({super.key});

  @override
  State<NewMemo> createState() => _NewMemoState();
}

class _NewMemoState extends State<NewMemo> {
  DateTime selectedDate = DateTime.now();

  final List<String> dropdownList = ['미드나잇 라이브러리', '별들이 겹치는 순간', '너 없는 동안'];
  String selectedBook = '별들이 겹치는 순간';
  int currentLength = 0;

  Widget _datepicker(context) {
    return Container(
      height: 34,
      child: Row(
        children: [
          ImageData(
            IconsPath.memo_date,
            isSvg: true,
            width: 13,
            height: 13,
          ),
          SizedBox(width: 10),
          Text(
            "작성일",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xff666666),
            ),
          ),
          SizedBox(width: 4),
          TextButton(
              onPressed: () {
                showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: white,
                          height: 300,
                          child: CupertinoDatePicker(
                              initialDateTime: selectedDate,
                              mode: CupertinoDatePickerMode.dateAndTime,
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() {
                                  selectedDate = newDate;
                                });
                              }),
                        ),
                      );
                    },
                    barrierDismissible: true);
              },
              child: Text(
                "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일 ${selectedDate.hour.toString().padLeft(2, '0')}:${selectedDate.minute.toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff666666),
                ),
              ))
        ],
      ),
    );
  }

  Widget _bookselect() {
    return Container(
      height: 40,
      child: Row(
        children: [
          ImageData(
            IconsPath.memo_book,
            isSvg: true,
            width: 13,
            height: 13,
          ),
          SizedBox(width: 10),
          Text(
            "도서",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xff666666),
            ),
          ),
          SizedBox(width: 18),
          Container(
            width: 266,
            height: 30,
            decoration: BoxDecoration(
              color: bg_gray,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1.0,
                  blurRadius: 7.0,
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  isExpanded: true,
                  underline: Container(),
                  value: selectedBook,
                  //icon: ImageData(IconsPath.dropdown),
                  items: dropdownList.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0), // 내부 패딩 설정
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: black,
                          ),
                        ),
                      ),
                      //child: Text(item),
                    );
                  }).toList(),
                  onChanged: (dynamic item) {
                    setState(() {
                      selectedBook = item;
                    });
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget _memoeditor() {
    return Container(
      width: 343,
      height: 201,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 13),
              width: 317,
              child: TextField(
                maxLength: 500,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '메모를 입력해 주세요.',
                  hintStyle: TextStyle(
                    color: Color(0xffb3b3b3),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextStyle(
                    color: dark_gray,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.3),
                onChanged: (text) {
                  setState(() {
                    currentLength = text.length;
                  });
                },
              ),
            ),
          ),
          /* Container(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: GestureDetector(
              onTap: showImagePickerOption(context),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ImageData(IconsPath.memo_pic,
                      isSvg: true, width: 20, height: 20),
                  height: 44),
            ),
          ),*/
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 35, horizontal: 23),
      color: bg_gray,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PickImage(),
          SizedBox(height: 25),
          _bookselect(),
          SizedBox(height: 6.0),
          _memoeditor(),
          SizedBox(height: 16.0),
          _datepicker(context),
          TagWidget(),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              //Navigator.pop(context); /
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Color(0xFFFFD747),
                shadowColor: Colors.black.withOpacity(0.1),
                elevation: 5,
                fixedSize: Size(343, 38)),
            child: Text(
              '게시하기',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

void showAddMemoBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows full screen modal
    backgroundColor:
        Colors.transparent, // Makes the modal's background transparent
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
      ),
    ),
    builder: (BuildContext context) {
      return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: bg_gray, // Your desired background color
          child: NewMemo(),
        ),
      );
    },
  );
}
