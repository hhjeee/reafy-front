import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/utils/constants.dart';

class TagWidget extends StatefulWidget {
  @override
  _TagWidgetState createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  List<String> tags = [];
  final TextEditingController _tagController = TextEditingController();

  void _addTag() async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '태그를 추가하세요',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: _tagController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: '태그를 입력하세요',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              iconColor: yellow,
            ),
            onSubmitted: (value) => Navigator.of(context).pop(value),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffebebeb),
                    minimumSize: Size(120, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '취소',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 6),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_tagController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffffd747),
                    minimumSize: Size(120, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
    print(result);

    if (result != null && result.isNotEmpty) {
      print(result);
      setState(() {
        tags.add(result.toString());
      });
    }

    print(tags);
  }

  void _deleteTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        children: [
          ImageData(IconsPath.memo_tag, isSvg: true, width: 13, height: 13),
          SizedBox(width: 10),
          Text(
            "태그",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff666666),
            ),
          ),
          SizedBox(width: 16),
          Wrap(
            spacing: 8,
            children: tags.map((tag) {
              return Container(
                margin: EdgeInsets.only(left: 2),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xffFFECA6),
                ),
                height: 24,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "#$tag  ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff666666),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _deleteTag(tag),
                      child: Icon(Icons.close, size: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }).toList(),
          ), // Add tag button
          GestureDetector(
            onTap: _addTag,
            child: Container(
              margin: EdgeInsets.only(left: 4),
              width: 67,
              height: 24,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Color(0xffb3b3b3), width: 0.8)),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 2.0),
                child: ImageData(
                  IconsPath.add_tag,
                  isSvg: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
