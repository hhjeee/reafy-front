import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/delete_book.dart';
import 'package:reafy_front/src/components/modify_book.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:reafy_front/src/pages/board/newmemo.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';
import 'package:reafy_front/src/utils/constants.dart';

class BookDetailPage extends StatefulWidget {
  final int bookshelfBookId;

  const BookDetailPage({Key? key, required this.bookshelfBookId})
      : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
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
              iconSize: 44,
              padding: EdgeInsets.all(0),
              icon: ImageData(IconsPath.pencil_green, isSvg: true),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ModifyDialog();
                  },
                );
              },
            ),
            IconButton(
              iconSize: 44,
              padding: EdgeInsets.only(right: 10),
              icon: ImageData(IconsPath.trash_can, isSvg: true),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteDialog(bookId: widget.bookshelfBookId);
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
                final BookshelfBookDetailsDto bookDetails = snapshot.data!;
                bool isFavorite = bookDetails.isFavorite == 1 ? true : false;
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
                            child: HillImage(width: size.width),
                          ),
                          Positioned(
                            top: 116,
                            left: 28,
                            child: LeafImage(),
                          ),
                          Positioned(
                            top: 107,
                            left: (size.width - 178) / 2,
                            child: BookImage(bookDetails: bookDetails),
                          ),
                          Positioned(
                            top: 220,
                            left: size.width / 2 + 35,
                            child: PoobaoImage(),
                          ),
                        ],
                      ),
                      //SizedBox(height: 18.0),
                      IconButton(
                        padding: EdgeInsets.only(left: 26),
                        icon: isFavorite
                            ? ImageData(IconsPath.favorite,
                                isSvg: true, width: 22, height: 22)
                            : ImageData(IconsPath.nonFavorite,
                                isSvg: true, width: 22, height: 22),
                        onPressed: () async {
                          try {
                            await updateBookshelfBookFavorite(
                                bookDetails.bookshelfBookId);
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          } catch (e) {
                            print('에러 발생: $e');
                          }
                        },
                      ),
                      _book_info(bookDetails),
                      SizedBox(height: 27.0),
                      ProgressIndicator(),
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
                        //color: yellow,
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
                            ])),
                      ),
                      MemoWidget(),
                      SizedBox(height: 9.0),
                      AddMemoButton(),
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

/*
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
<<<<<<< Updated upstream
      width: 103,
      height: 144,
=======
      width: 123,
      height: 164,
>>>>>>> Stashed changes
      child: ImageData(IconsPath.character),
    );
  }
*/
  Widget _book_info(BookshelfBookDetailsDto bookDetails) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (bookDetails?.title?.length ?? 0) > 20
                ? '${bookDetails.title!.substring(0, 20)}\n${bookDetails.title!.substring(
                    21,
                  )}'
                : '${bookDetails?.title ?? ''}',
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xff333333),
            ),
          ),
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
                (bookDetails?.author?.length ?? 0) > 26
                    ? '${bookDetails.author!.substring(0, 26)}\n${bookDetails.author!.substring(
                        26,
                      )}'
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
                        25,
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
                        25,
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
/*
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

  Widget AddMemoButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAddMemoBottomSheet(context);
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
}*/
}

/////////////////////////////////////////////

class BookImage extends StatelessWidget {
  final BookshelfBookDetailsDto bookDetails;

  const BookImage({Key? key, required this.bookDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: bookDetails.thumbnailURL != null
            ? Image.network(
                bookDetails.thumbnailURL!,
                fit: BoxFit.cover,
              )
            : Placeholder(),
      ),
    );
  }
}

class LeafImage extends StatelessWidget {
  const LeafImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 332.36,
      height: 181.455,
      child: ImageData(IconsPath.book_leaves),
    );
  }
}

class HillImage extends StatelessWidget {
  final double width;

  const HillImage({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 90,
      child: ImageData(IconsPath.hill),
    );
  }
}

class PoobaoImage extends StatelessWidget {
  const PoobaoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 103,
      height: 144,
      child: ImageData(IconsPath.character),
    );
  }
}

/*
class BookInfo extends StatelessWidget {
  final BookshelfBookDetailsDto bookDetails;

  const BookInfo({Key? key, required this.bookDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IconButton for favorite and Text widgets for book details
        ],
      ),
    );
  }
}
*/
class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class AddMemoButton extends StatelessWidget {
  const AddMemoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAddMemoBottomSheet(context);
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

class MemoWidget extends StatelessWidget {
  const MemoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    // Your memo widget implementation
  }
}
