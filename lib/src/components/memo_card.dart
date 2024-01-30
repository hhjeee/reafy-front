import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reafy_front/src/components/done.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/models/memo.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:reafy_front/src/pages/board/newmemo.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';

class MemoCard extends StatelessWidget {
  final Memo memo;
  const MemoCard({Key? key, required this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final validHashtags = memo.hashtag.where((tag) => tag.isNotEmpty).toList();

    return FutureBuilder<BookshelfBookTitleDto>(
      future: getBookshelfBookTitle(memo.bookshelfBookId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            print(snapshot.data!.title);
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
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              width: 343,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MemoTitle(title: snapshot.data!.title),
                  if (memo.imageURL != null && memo.imageURL!.isNotEmpty)
                    MemoImage(imageUrl: memo.imageURL!),
                  const SizedBox(height: 10),
                  MemoDescription(content: memo.content),
                  const SizedBox(height: 10),
                  if (validHashtags.isNotEmpty)
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: memo.hashtag
                          .map((tag) => Hashtag(label: "#$tag"))
                          .toList(),
                    ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        DateFormat('yyyy.MM.dd kk:mm').format(memo.updatedAt),
                        style: TextStyle(
                          color: Color(0xffb3b3b3),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('책 제목을 가져오는 데 실패했습니다.');
          }
        }
        // 데이터를 기다리는 동안 로딩 인디케이터를 표시합니다.
        return CircularProgressIndicator();
      },
    );
  }
}

class MemoTitle extends StatelessWidget {
  final String? title;
  const MemoTitle({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        margin: EdgeInsets.only(bottom: 9),
        child: Row(children: [
          Container(
            width: 275,
            child: Text(
              title ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.w800, color: black, fontSize: 12),
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
              width: 30,
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
              )),
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ExpandableText(
        content ?? '',
        prefixStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          color: black,
          fontSize: 12,
          height: 1.5,
        ),
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

class Hashtag extends StatelessWidget {
  final String label;
  const Hashtag({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: label.length > 7 ? 85 : 60,
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xffFFECA6),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
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
