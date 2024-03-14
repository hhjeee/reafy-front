import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/add_book.dart';
import 'package:reafy_front/src/models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final String isbn13;

  BookCard({required this.book, required this.isbn13});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddDialog(isbn13: isbn13);
          },
        );
      },
      child: Card(
          color: Color(0xffFAF9F7),
          elevation: 0,
          margin: EdgeInsets.only(bottom: 5),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 98,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(book.coverImageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "지은이",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff666666),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            book.author.length > 20
                                ? '${book.author.substring(0, 20)}...' // 최대 20자로 제한
                                : book.author,
                            overflow:
                                TextOverflow.ellipsis, // 길이 초과 시 '...'로 표시
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff333333),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
