import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/delete_book.dart';
import 'package:reafy_front/src/components/modify_book.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';

class BookDetailPage extends StatefulWidget {
  final int bookshelfBookId;

  const BookDetailPage({Key? key, required this.bookshelfBookId})
      : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  //late BookshelfBookDetailsDto bookDetails = BookshelfBookDetailsDto(bookshelfBookId: widget.bookshelfBookId);

  late Future<BookshelfBookDetailsDto> bookDetailsFuture;

  @override
  void initState() {
    super.initState();
    bookDetailsFuture = getBookshelfBookDetails(widget.bookshelfBookId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xff63B865)),
            onPressed: () {
              Get.back(); // Navigator.pop 대신 Get.back()을 사용합니다.
            },
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.all(0),
              icon: ImageData(IconsPath.pencil_green, isSvg: true, width: 20),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ModifyDialog(); // 수정된 부분
                  },
                );
              },
            ),
            IconButton(
              padding: EdgeInsets.only(right: 21),
              icon: ImageData(IconsPath.trash_can, isSvg: true, width: 20),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteDialog(); // 수정된 부분
                  },
                );
              },
            ),
          ],
        ),
        extendBodyBehindAppBar: true, //appbar, body 겹치기

        body: FutureBuilder<BookshelfBookDetailsDto>(
            future: bookDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('에러: ${snapshot.error}');
              } else {
                print(snapshot.data);
                final BookshelfBookDetailsDto bookDetails = snapshot.data!;
                print(bookDetails);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: <Widget>[
                          Container(
                            width: size.width,
                            height: 397, //442
                            color: Color(0xfffff7da),
                          ),
                          Positioned(
                            top: 310,
                            child: _hill_img(size),
                          ),
                          Positioned(
                            top: 116,
                            left: 28,
                            child: _leaf_img(),
                          ),
                          Positioned(
                            top: 107,
                            left: (size.width - 178) / 2,
                            child: _book_img(bookDetails),
                          ),
                          Positioned(
                            top: 270,
                            left: size.width / 2 + 35,
                            child: _poobao_img(),
                          ),
                        ],
                      ),
                      SizedBox(height: 27.0),
                      _book_info(bookDetails),
                      SizedBox(height: 27.0),
                      _progress(),
                      SizedBox(height: 21.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26),
                        child: Text(
                          "메모",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff333333),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      Container(
                        height: 120,
                        child: Center(
                          child: Text(
                            "앗, 아직 메모가 없어요!",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      _memo(),
                      SizedBox(height: 9.0),
                      _add_memo(context),
                      SizedBox(height: 17.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 23),
                          child: Text(
                            "도서 DB 제공: 알라딘",
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffb3b3b3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }

  Widget _book_img(BookshelfBookDetailsDto bookDetails) {
    return Container(
        //alignment: Alignment.center,
        width: 178,
        height: 259,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2.0, 4.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: bookDetails != null && bookDetails.thumbnailURL != null
              ? Image.network(
                  bookDetails.thumbnailURL!,
                  fit: BoxFit.cover, // BoxFit.fitWidth,
                )
              : Placeholder(),
        ));
  }

  Widget _leaf_img() {
    return Container(
      width: 332.36,
      height: 181.455,
      child: ImageData(IconsPath.book_leaves),
    );
  }

  Widget _hill_img(size) {
    return Container(
      width: size.width, //389
      height: 90, //86.641
      child: ImageData(IconsPath.hill),
    );
  }

  Widget _poobao_img() {
    return Container(
      width: 93.45,
      height: 105.89,
      child: ImageData(IconsPath.character2),
    );
  }

  /*Widget _poobao_shadow() {
    return Container(
      width: 74,
      height: 15,
      child: ImageData(IconsPath.poobao_shadow, isSvg: true),
    );
  }*/

  Widget _book_info(BookshelfBookDetailsDto bookDetails) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${bookDetails.title}',
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xff333333),
            ),
          ), // title - 변경
          SizedBox(height: 11),
          Row(
            children: [
              Text(
                "저자",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: 5),
              Text(
                (bookDetails?.author?.length ?? 0) > 25
                    ? '${bookDetails.author!.substring(0, 25)}\n${bookDetails.author!.substring(
                        26,
                      )}' // 최대 20자로 제한
                    : '${bookDetails?.author ?? ''}',
                overflow: TextOverflow.clip, // 길이 초과 시 '...'로 표시
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff333333),
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Text(
                "출판사",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: 5),
              Text(
                (bookDetails?.publisher?.length ?? 0) > 25
                    ? '${bookDetails.publisher!.substring(0, 25)}\n${bookDetails.publisher!.substring(
                        26,
                      )}'
                    : '${bookDetails?.publisher ?? ''}',
                overflow: TextOverflow.clip, // 길이 초과 시 '...'로 표시
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff333333),
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Text(
                "카테고리",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: 5),
              Text(
                (bookDetails?.category?.length ?? 0) > 25
                    ? '${bookDetails.category!.substring(0, 25)}\n${bookDetails.category!.substring(
                        26,
                      )}'
                    : '${bookDetails?.category ?? ''}',
                overflow: TextOverflow.clip, // 길이 초과 시 '...'로 표시
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff333333),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _progress() {
    return Container(
      padding: EdgeInsets.only(left: 23.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "진행 정도",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: 266.0),
              Text(
                "70%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff333333),
                ),
              ), //변경
            ],
          ),
          Container(
            //나중엔 벡터 단위로 받아와서 조건 따라 색 변경해야 할듯
            width: 344,
            height: 46,
            child: ImageData(IconsPath.bamboo_bar),
          ),
        ],
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

  Widget _add_memo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAddMemoBottomSheet(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 26),
        width: 343,
        height: 33,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffB3B3B3),
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

void _showAddMemoBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(left: 24),
        color: Color(0xffffffff),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 42),
            Row(
              children: [
                Container(
                  width: 13.333,
                  height: 13.333,
                  child: ImageData(
                    IconsPath.memo_date,
                    isSvg: true,
                  ),
                ),
                SizedBox(width: 3.67),
                Text(
                  "생성일",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff666666),
                  ),
                ),
                SizedBox(width: 14),
                Text(
                  "2023년 12월 3일",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff666666),
                  ),
                ),
                Text(
                  "02:04",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff666666),
                  ),
                ),
              ],
            ),
            SizedBox(height: 9.0),
            Row(
              children: [
                Container(
                  width: 13.333,
                  height: 13.333,
                  child: ImageData(
                    IconsPath.memo_tag,
                    isSvg: true,
                  ),
                ),
                SizedBox(width: 4.89),
                Text(
                  "태그",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff666666),
                  ),
                ),
                SizedBox(width: 20),
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
                      border: Border.all(color: Color(0xffb3b3b3), width: 0.8)),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2.0),
                    child: ImageData(
                      IconsPath.add_tag,
                      isSvg: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 26.56),
            Container(
              width: 343,
              height: 179,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xfffbfbfb),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 13),
                    width: 317,
                    height: 128,
                    child: TextField(
                      maxLength: 400,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '메모를 입력해 주세요.',
                        hintStyle: TextStyle(
                          color: Color(0xffb3b3b3),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w500,
                      ),
                      buildCounter: (BuildContext context,
                          {required int currentLength,
                          required bool isFocused,
                          required int? maxLength}) {
                        return Text(
                          '$currentLength/$maxLength자',
                          style: TextStyle(
                            color: Color(0xffb3b3b3),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        width: 14,
                        height: 14,
                        child: ImageData(IconsPath.memo_pic, isSvg: true)),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                //Navigator.pop(context); /
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Color(0xFFFFD747),
                  shadowColor: Colors.black.withOpacity(0.1),
                  elevation: 5,
                  fixedSize: Size(343, 38)),
              child: Text(
                '게시하기',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
