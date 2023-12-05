import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/add_book.dart';
import 'package:reafy_front/src/models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;

  BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddDialog(); // 수정된 부분
          },
        );
      },
      child: Card(
          color: Color(0xffFAF9F7),
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 98,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(book.coverImageUrl!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(width: 16),
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
                      Text(
                        book.author.length > 20
                            ? '${book.author.substring(0, 20)}...' // 최대 20자로 제한
                            : book.author,
                        overflow: TextOverflow.ellipsis, // 길이 초과 시 '...'로 표시
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w400,
                        ),
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
