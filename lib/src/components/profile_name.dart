import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';

class ProfileName extends StatefulWidget {
  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  bool isEditing = false;
  TextEditingController _textEditingController = TextEditingController();

  String _displayText = "Reafy";

  @override
  Widget build(BuildContext context) {
    var auth = context.read<AuthProvider>();
    return GestureDetector(
      onTap: () {
        if (isEditing) {
          setState(() {
            isEditing = false;
            _displayText = auth.nickname; //_textEditingController.text;
          });
        }
      },
      child: Column(
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

                      //image: DecorationImage(image:  )
                    ),
                    child: FittedBox(
                      child: ImageData(IconsPath.profile),
                      fit: BoxFit.fill,
                    ), /*Stack(
                      children: [
                        Positioned(
                          top: 10,
                          child: Container(
                              width: 147.62,
                              height: 167.27,
                              child: ImageData(
                                IconsPath.character,
                              )),
                        ),
                      ],
                    ),*/
                  ),
                ),
              ),
              Positioned(
                top: 199, //231,
                left: 231, //191.46,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xffffd747),
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isEditing = true;
                        _textEditingController.text = _displayText;
                      });
                    },
                    child: ImageData(IconsPath.pencil, isSvg: true),
                  ),
                ),
              ),
            ],
          ),
          isEditing
              ? Container(
                  width: 203.01,
                  child: TextField(
                      controller: _textEditingController,
                      onEditingComplete: () {
                        setState(() {
                          isEditing = false;
                          _displayText =
                              auth.nickname; //_textEditingController.text;
                        });
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffix: Text(
                          "${_textEditingController.text.length}/10",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8d8d8d),
                          ),
                        ),
                        contentPadding: EdgeInsets.only(top: 4.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffe1e1e1), width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffe1e1e1), width: 2),
                        ),
                      )))
              : Text(
                  _displayText,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff000000),
                  ),
                ),
        ],
      ),
    );
  }
}
