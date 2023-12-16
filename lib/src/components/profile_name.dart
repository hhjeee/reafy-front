import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';

class ProfileName extends StatefulWidget {
  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  bool isEditing = false;
  TextEditingController _textEditingController = TextEditingController();
  String _displayText = "푸바오";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 395,
              height: 166,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff64c567),
                    Color(0xffb6e0b7),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 92.0, left: 119.0, bottom: 21.53),
              width: 153.47,
              height: 153.47,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xfffcfcfc),
                  width: 5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 3.0,
                    blurRadius: 7.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: Container(
                  width: 148.47,
                  height: 148.47,
                  decoration: BoxDecoration(
                    color: Color(0xffe2eee0),
                  ),
                  child: FittedBox(
                    child: ImageData(IconsPath.profile),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          _displayText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xff000000),
          ),
        ),
      ],
    );
  }
}
