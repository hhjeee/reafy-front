import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/done.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/models/memo.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:reafy_front/src/pages/board/newmemo.dart';
import 'package:reafy_front/src/utils/constants.dart';

class MemoCard extends StatelessWidget {
  final Memo memo;
  const MemoCard({Key? key, required this.memo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
      decoration: BoxDecoration(
        color: Color(0xFFfbfbfb),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: gray.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 20,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      width: 343,
      //height: memo.imageUrl != null && memo.imageUrl!.isNotEmpty ? 450 : 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MemoTitle(title: memo.title),
          MemoImage(imageUrl: memo.imageUrl),
          const SizedBox(height: 10),
          MemoDescription(content: memo.content),
          const SizedBox(height: 10),
          MemoDateAgo(dateText: "2023년 12월 23일")
        ],
      ),
    );
  }
}

/*
class MemoTitle extends StatelessWidget {
  final String? title;
  const MemoTitle({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        margin: EdgeInsets.only(bottom: 9),
        child: Row(children: [
          Text(
            title ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.w800, color: black, fontSize: 12),
          ),
          Spacer(),
          ImageData(IconsPath.menu, isSvg: true, width: 13, height: 3)
        ]));
  }
}
*/

class MemoTitle extends StatelessWidget {
  final String? title;
  const MemoTitle({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        margin: EdgeInsets.only(bottom: 9),
        child: Row(children: [
          Text(
            title ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.w800, color: black, fontSize: 12),
          ),
          Spacer(),
          SizedBox(
              width: 50,
              child: PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'edit') {
                    showAddMemoBottomSheet(context);
                  } else if (value == 'delete') {
                    _showDeleteDialog(context);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'edit', 'delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                        value: choice,
                        height: 40,
                        child: SizedBox(
                          width: 30,
                          child: Text(
                            choice == 'edit' ? "수정" : "삭제",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ));
                  }).toList();
                },
                icon: ImageData(IconsPath.menu,
                    isSvg: true, width: 13, height: 3),
              ))
        ]));
  }
}

class MemoImage extends StatelessWidget {
  final String? imageUrl;
  const MemoImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null && imageUrl!.isNotEmpty
        ? GestureDetector(
            onTap: () => showImageDialog(context, imageUrl!),
            child: Card(
              color: Color(0xffFAF9F7),
              elevation: 0,
              child: Container(
                width: 319,
                height: 270,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          )
        : SizedBox.shrink();
  }

  void showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imageUrl),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "뒤로가기",
                  style: TextStyle(color: gray, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MemoDescription extends StatelessWidget {
  final String? content;
  const MemoDescription({Key? key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 81,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ExpandableText(
        content ?? '',
        prefixStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: black,
            fontSize: 12,
            height: 1.5),
        expandText: '더보기',
        collapseText: '접기',
        maxLines: 5,
        expandOnTextTap: true,
        collapseOnTextTap: true,
        linkColor: Colors.grey,
      ),
    );
  }
}

class MemoDateAgo extends StatelessWidget {
  final String dateText;
  const MemoDateAgo({Key? key, required this.dateText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(children: [
          Hashtag(label: "#경영"),
          Hashtag(label: "#경영"),
          Hashtag(label: "#경영"),
          Spacer(),
          Text(
            dateText,
            style: const TextStyle(color: Colors.grey, fontSize: 9),
          ),
        ]));
  }
}

class Hashtag extends StatelessWidget {
  final String label;
  const Hashtag({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4),
      width: 46,
      height: 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xffFFECA6),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w400,
            color: Color(0xff666666),
          ),
        ),
      ),
    );
  }
}

Widget _showDeleteDialog(context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    contentPadding: EdgeInsets.zero,
    content: Container(
      width: 320,
      height: 160,
      child: Column(children: [
        SizedBox(height: 40.0),
        Text(
          "정말 삭제하시겠어요? \n 작성한 메모는 영구적으로 사라져요!",
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Color(0xff333333),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.2),
        ),
        SizedBox(height: 40.0),
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
            SizedBox(width: 6),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // DeleteDialog 닫기
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DoneDialog(onDone: () {});
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
                  color: Color(0xff000000),
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

/*
class MemoContent extends StatelessWidget {
  final Memo memo;
  const MemoContent({Key? key, required this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MemoTitle(title: memo.title),
        MemoImage(imageUrl: memo.imageUrl),
        MemoDescription(content: memo.content),
        MemoDateAgo(dateText: "2023년 12월 23일") // Replace with actual date
      ],
    );
  }
}

*/












/*


  Widget _dateAgo() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(children: [
          hashtag(),
          hashtag(),
          hashtag(),
          Spacer(),
          Text(
            "2023년 12월 23일",
            //timeago.format(//memo.createdAt!),
            style: const TextStyle(color: Colors.grey, fontSize: 9),
          ),
        ]));
  }

Widget hashtag() {
  return Container(
    margin: EdgeInsets.only(left: 4),
    width: 46,
    height: 13,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Color(0xffFFECA6),
    ),
    child: Center(
      child: Text(
        "#경영",
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w400,
          color: Color(0xff666666),
        ),
      ),
    ),
  );
}

Widget _memo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 26),
        width: 343,
        height: 114,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFFBFBFB),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 20,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 14.0),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 7, right: 4),
                  width: 64,
                  height: 64,
                  child: ImageData(IconsPath.memo_ex),
                ),
                Container(
                  padding: EdgeInsets.all(2.0),
                  width: 258,
                  child: Text(
                    "정당의 목적이나 활동이 민주적 기본질서에 위배될 때에는 정부는 헌법재판소에 그 해산을 제소할 수 있고, 정당은 헌법재판소의 심판에 의하여 해산된다. 대통령이 임시회의 집회를 요구할 때에는 기간과 집회요구의 이유를 명시하여야 한다.",
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff666666),
                      height: 1.55556,
                    ),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(width: 6.0),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  width: 46,
                  height: 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xffFFECA6),
                  ),
                  child: Center(
                    child: Text(
                      "#경영",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  width: 46,
                  height: 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xffFFECA6),
                  ),
                  child: Center(
                    child: Text(
                      "#경영",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "23.12.03",
                  style: TextStyle(
                    fontSize: 6,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffb3b3b3),
                  ),
                ),
                SizedBox(width: 3.0),
                Text(
                  "02:04",
                  style: TextStyle(
                    fontSize: 6,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffb3b3b3),
                  ),
                ),
                SizedBox(width: 12.0),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

*/

/*
  Widget _title() {
    return Container(
        //height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        margin: EdgeInsets.only(bottom: 9),
        child: Row(children: [
          Text(
            memo.title ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.w800, color: black, fontSize: 12),
          ),
          Spacer(),
          ImageData(IconsPath.menu, isSvg: true, width: 13, height: 3)
        ]));
  }


  Widget _image() {
    return Card(
      color: Color(0xffFAF9F7),
      elevation: 0,
      child: Container(
        width: 319,
        height: 270,
        //padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(memo.imageUrl!),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8)),
      ),
    );

    //CachedNetworkImage(imageUrl: memo.imageUrl!);
  }

  Widget _infoDescription() {
    return Container(
      height: 81,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExpandableText(
            memo.content ?? '',
            prefixStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: black,
                fontSize: 12,
                height: 1.5),
            expandText: '더보기',
            collapseText: '접기',
            maxLines: 5,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.grey,
          )
        ],
      ),
    );
  }
*/
 