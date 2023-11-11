import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:reafy_front/src/pages/book/bookdetail.dart';
import 'package:reafy_front/src/utils/constants.dart';

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
        padding: const EdgeInsets.only(right: 20.0, top: 7),
        child: GestureDetector(
          onTap: () {
            Get.to(() => BookDetailPage(book: book));
          },
          child: Container(
            width: 66,
            height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 15.0),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                book.coverImageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          //child: BookCover3D(imageUrl: book.coverImageUrl),
        ),
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
            width: double.maxFinite,
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/shelf.png'),
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.fitWidth),
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      SizedBox(width: 16),
                      ImageData(
                        IconsPath.left,
                        isSvg: true,
                        width: 10,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Row(
                        children: _buildBookList(context),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      ImageData(
                        IconsPath.right,
                        width: 10,
                        isSvg: true,
                      ),
                      SizedBox(width: 16),
                    ])),
              ],
            ),
          )
        ]));
  }
}
