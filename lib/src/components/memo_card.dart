import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/models/memo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:timeago/timeago.dart' as timeago;

class MemoWidget extends StatelessWidget {
  final Memo memo;
  const MemoWidget({Key? key, required this.memo}) : super(key: key);

  Widget _image() {
    return Card(
      color: Color(0xffFAF9F7),
      elevation: 0,
      margin: EdgeInsets.all(16),
      child: Container(
        width: 50,
        height: 200,
        padding: EdgeInsets.all(16),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExpandableText(
            memo.content ?? '',
            prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
            expandText: '더보기',
            collapseText: '접기',
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.grey,
          )
        ],
      ),
    );
  }

  Widget _replyTextBtn() {
    return GestureDetector(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          '댓글 199개 모두 보기',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ),
    );
  }

  Widget _dateAgo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        "2023년 12월 23일",
        //timeago.format(//memo.createdAt!),
        style: const TextStyle(color: Colors.grey, fontSize: 11),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15),
          _image(),
          const SizedBox(height: 5),
          _infoDescription(),
          const SizedBox(height: 5),
          _replyTextBtn(),
          const SizedBox(height: 5),
          _dateAgo(),
        ],
      ),
    );
  }
}
