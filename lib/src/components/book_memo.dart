import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/memo_card.dart';
import 'package:reafy_front/src/models/memo.dart';
import 'package:reafy_front/src/repository/memo_repository.dart';
import 'package:reafy_front/src/utils/constants.dart';

class MemoSection extends StatelessWidget {
  final int bookshelfBookId;

  const MemoSection({
    Key? key,
    required this.bookshelfBookId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getMemoListByBookId(bookshelfBookId, 1), // 페이지 1 고정
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('메모를 불러오는 데 실패했습니다.'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<dynamic> memos = snapshot.data!;
          return Center(
            child: Column(
              children: memos.map((memoJson) {
                Memo memo = Memo.fromJson(memoJson);
                return MemoCard(memo: memo);
              }).toList(),
            ),
          );
        } else {
          return Container(
            height: 120,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageData(IconsPath.character_empty, width: 104, height: 94),
                  Text(
                    "앗, 아직 메모가 없어요!",
                    style: TextStyle(
                      color: gray,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
