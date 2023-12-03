import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/photouploader.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class NewMemo extends StatelessWidget {
  const NewMemo({super.key});

  Widget _info() {
    return Container(
        padding: EdgeInsets.only(top: 8.0, left: 26.0),
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: gray,
        ),
        child: Text("책제목 \n작가"));
  }

  Widget _memoeditor() {
    return Container(
        child: Column(children: [
      Container(
          padding: EdgeInsets.only(top: 8.0, left: 26.0),
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: yellow_light,
          ),
          child: Text("메모 입력란")),
      OutlinedButton(onPressed: () {}, child: Text("SAVE"))
    ]));
  }

  Widget _datepicker(context) {
    return OutlinedButton(
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
                          onDateTimeChanged: (DateTime date) {})),
                );
              },
              barrierDismissible: true);
        },
        child: Container(width: 200, height: 60, child: Text("작성일 입력")));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 720,
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 20),
        _info(),
        const SizedBox(height: 20),
        _datepicker(context),
        const SizedBox(height: 20),
        PhotoUploader(),
        const SizedBox(height: 20),
        _memoeditor(),
      ]),
    );
  }
}
