import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/3dbook.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:reafy_front/src/pages/book/bookdetail.dart';

class BookShelfWidget extends StatefulWidget {
  const BookShelfWidget({super.key});

  @override
  State<BookShelfWidget> createState() => _BookShelfWidgetState();
}

class _BookShelfWidgetState extends State<BookShelfWidget> {
  bool isExpanded = false;

  List<Widget> _buildBookList(BuildContext context) {
    List<Book> books = getMockBooks();

    return books.map((book) {
      return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: GestureDetector(
            onTap: () {
              Get.to(() => BookDetailPage(book: book));
            },
            child: Container(
              decoration: BoxDecoration(
                //color: Color(0xffd9d9d9),
                borderRadius: BorderRadius.circular(30),
              ),
              width: 80,
              height: 120,
              child: BookCover3D(imageUrl: book.coverImageUrl),
            )),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Container(
            width: 100,
            height: 45,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/tag.png'),
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Text('읽는 중',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    //backgroundColor: Color(0xfffaf9f7),
                    fontWeight: FontWeight.w800,
                  )),
            ),
          ),
          SizedBox(height: 10),
          Container(
              width: size.width,
              height: 180,
              decoration: BoxDecoration(
                color: Color(0xffFFFCF3),
                image: DecorationImage(
                    image: AssetImage('assets/images/shelf_bg3.png'),
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.fitWidth),
              ),
              child: Padding(
                  padding:
                      EdgeInsets.only(top: 18, left: 16, right: 0, bottom: 10),
                  child: Column(
                    children: [
                      /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // 등록순 정렬 로직 추가
                        },
                        child: Text(
                          "등록순  |  ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // 이름순 정렬 로직 추가
                        },
                        child: Text(
                          "이름순",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      //SizedBox(width: 8),
                    ],
                  ),
                  */
                      //SizedBox(height: 25),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _buildBookList(context),
                        ),
                      )
                    ],
                  )))
        ]));
  }
}
