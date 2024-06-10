import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/memo_card.dart';
import 'package:reafy_front/src/components/new_board_memo.dart';
import 'package:reafy_front/src/provider/memo_provider.dart';
import 'package:reafy_front/src/utils/constants.dart';

class Board extends StatefulWidget {
  @override
  const Board({super.key});
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  int currentPage = 1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final memoProvider = Provider.of<MemoProvider>(context, listen: false);
    memoProvider.loadAllMemos(currentPage);
  }

  void _loadPage(int pageNumber) async {
    final memoProvider = Provider.of<MemoProvider>(context, listen: false);
    await memoProvider.loadAllMemos(pageNumber);
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
    final memoProvider = Provider.of<MemoProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff63B865)),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "나의 메모",
          style: TextStyle(
              color: Color(0xff333333),
              fontWeight: FontWeight.w800,
              fontSize: 16),
        ),
        actions: [],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/green_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        width: size.width,
        height: size.height,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: (size.width - 343) / 2),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: memoProvider.memoList.length,
                    itemBuilder: (context, index) {
                      final memo = memoProvider.memoList[index];
                      return MemoCard(
                          key: UniqueKey(), memo: memo, type: 'board');
                    },
                  ),
                ),
                SizedBox(height: 5),
                _buildPageNumbers(memoProvider.totalPages),
                SizedBox(height: 5),
                NewMemoButton(),
                SizedBox(height: 25.0),
              ],
            )),
      ),
    );
  }
}

class NewMemoButton extends StatelessWidget {
  const NewMemoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAddMemoBottomSheet(context);
      },
      child: Container(
        width: double.infinity,
        height: 33,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: yellow,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: ImageData(
            IconsPath.add_memo,
            isSvg: true,
          ),
        ),
      ),
    );
  }
}
