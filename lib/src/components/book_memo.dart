import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/memo_card.dart';
import 'package:reafy_front/src/models/memo.dart';
import 'package:reafy_front/src/provider/memo_provider.dart';
import 'package:reafy_front/src/repository/memo_repository.dart';
import 'package:reafy_front/src/utils/constants.dart';

class MemoSection extends StatefulWidget {
  final int bookshelfBookId;

  const MemoSection({Key? key, required this.bookshelfBookId})
      : super(key: key);

  @override
  State<MemoSection> createState() => _MemoSectionState();
}

class _MemoSectionState extends State<MemoSection> {
  int currentPage = 1;

  void _loadPage(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }

  Widget _buildPageNumbers(int totalPages) {
    int pageDisplayLimit = 5;
    int currentPageGroupStart =
        ((currentPage - 1) ~/ pageDisplayLimit) * pageDisplayLimit;

    List<Widget> pageNumbers = List.generate(
      min(pageDisplayLimit, totalPages - currentPageGroupStart),
      (index) {
        int pageNumber = currentPageGroupStart + index + 1;
        return GestureDetector(
          onTap: () => _loadPage(pageNumber),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: currentPage == pageNumber
                  ? Color(0xffFFF7DA)
                  : Colors.transparent,
            ),
            child: Text('$pageNumber'),
          ),
        );
      },
    );

    if (currentPageGroupStart > 0) {
      pageNumbers.insert(
        0,
        IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () => _loadPage(max(currentPageGroupStart, 1)),
        ),
      );
    }

    if (currentPageGroupStart + pageDisplayLimit < totalPages) {
      pageNumbers.add(
        IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: () => _loadPage(
              min(currentPageGroupStart + pageDisplayLimit + 1, totalPages)),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pageNumbers,
    );
  }

  @override
  Widget build(BuildContext context) {
    final memoProvider = Provider.of<MemoProvider>(context, listen: false);

    return FutureBuilder(
      future:
          memoProvider.loadMemosByBookId(widget.bookshelfBookId, currentPage),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('메모를 불러오는 데 실패했습니다.'));
        } else {
          if (memoProvider.memos.isEmpty) {
            return Container(
              height: 120,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageData(IconsPath.character_empty,
                        width: 104, height: 94),
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
          } else {
            return Center(
              child: Column(
                children: [
                  Column(
                    children: memoProvider.memos
                        .map((memo) => MemoCard(memo: memo))
                        .toList(),
                  ),
                  SizedBox(height: 5),
                  _buildPageNumbers(memoProvider.totalPages),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
